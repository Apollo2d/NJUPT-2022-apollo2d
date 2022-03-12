#!/bin/bash
# set -x

monitor=soccerwindow2
default_trials=100

if [ ! -d log ]; then
    mkdir log
fi
if [ ! -d log/gameLog ]; then
    mkdir log/gameLog
fi

log=./log/$(date +%Y%m%d%H%M%S).log
raw_log=./log/$(date +%Y%m%d%H%M%S).raw.log

func_exit() {
    kill -9 $(echo ${monitor} | xargs pidof) &>/dev/null
    tar -cvzf ./log/gameLog/$(date +%Y%m%d%H%M%S).rcg.tar.gz ./*.rcg --remove-files &>/dev/null
    tar -cvzf ./log/gameLog/$(date +%Y%m%d%H%M%S).rcl.tar.gz ./*.rcl --remove-files &>/dev/null
    rm *.log
    echo -e "Train Done----------------------------------------"
    cat $log | grep Average -B 1 --color=auto
    echo -e "Check $log to see the result again"
    exit 0
}

run() {
    if [ $# -eq 6 ]; then
        ball_pos_x=$1
        ball_pos_y=$2
        ball_vel_x=$3
        ball_vel_y=$4
        trials=$5
        synch=$6
    fi

    func_exit0() {
        kill -2 $(pidof rcssserver) &>/dev/null
        kill -9 $(echo ${monitor} | xargs pidof) &>/dev/null
        while [ $(pidof rcssserver) ]; do
            sleep 1
        done
        echo "#$ball_pos_x#$ball_pos_y#$ball_vel_x#$ball_vel_y" >>$raw_log
        grep @ ./raw_result.log >>$raw_log
        echo "Game Done"
    }

    trap "func_exit" SIGINT SIGTERM SIGHUP

    opt="--ball-pos-x=${ball_pos_x} --ball-pos-y=${ball_pos_y}"
    opt="${opt} --ball-vel-x=${ball_vel_x} --ball-vel-y=${ball_vel_y}"
    opt="${opt} --player-pos-x=${player_pos_x} --player-pos-y=${player_pos_y}"
    if [ ${trials} -gt 0 ]; then
        opt="${opt} --trials=${trials}"
    fi

    rcssserver server::coach=on server::synch_mode=${synch} &>/dev/null &
    if [ ! $(pidof ${monitor}) ]; then
        $monitor -c &>/dev/null &
    fi
    sleep 1
    ./build/helios-base_hfo_trainer ${opt} &>./raw_result.log &
    sleep 1
    ./build/src/sample_player --config_dir=./build/src/formations-dt &>/dev/null &

    # echo "Running..."
    # echo "Use [Ctrl]+c to stop at any time"
    while true; do
        if [ ! $(pidof helios-base_hfo_trainer) ]; then
            func_exit0
            return 0
        fi
        echo -en "$(grep -c @ raw_result.log)/${trials}\r"
        sleep 0.1
    done

}

trap "func_exit" SIGINT SIGTERM SIGHUP

if [ $# -eq 2 ]; then
    Line=$1
    let "Line++"
    eval $(awk -F ',' 'NR=="'$Line'"{printf("group=%s; ball_pos_x=%s; ball_pos_y=%s; ball_vel_x=%s; ball_vel_y=%s",$1,$2,$3,$4,$5)}' para.csv)
    let "Line--"
    echo "Running group $group"
    echo "ball_pos_x:$ball_pos_x ball_pos_y:$ball_pos_y ball_vel_x:$ball_vel_x ball_vel_y:$ball_vel_y" >>$log
    run $ball_pos_x $ball_pos_y $ball_vel_x $ball_vel_y $default_trials $2
    ./parse.sh >>$log
    func_exit
fi

Line=$(cat para.csv | wc -l)
let "Line++"
while (($Line > 1)); do
    eval $(awk -F ',' 'NR=="'$Line'"{printf("group=%s; ball_pos_x=%s; ball_pos_y=%s; ball_vel_x=%s; ball_vel_y=%s",$1,$2,$3,$4,$5)}' para.csv)
    let "Line--"
    echo "Running group $group"
    echo "ball_pos_x:$ball_pos_x ball_pos_y:$ball_pos_y ball_vel_x:$ball_vel_x ball_vel_y:$ball_vel_y" >>$log
    run $ball_pos_x $ball_pos_y $ball_vel_x $ball_vel_y $default_trials on
    ./parse.sh >>$log
done

func_exit
