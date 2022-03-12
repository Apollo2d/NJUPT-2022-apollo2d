#!/bin/bash
# set -x

if [ ! -d log ]; then
    mkdir log
fi
if [ ! -d log/gameLog ]; then
    mkdir log/gameLog
fi

log=./log/$(date +%Y%m%d%H%M%S).log

func_exit() {
    tar -cvzf ./log/gameLog/$(date +%Y%m%d%H%M%S).rcg.tar.gz ./*.rcg --remove-files
    tar -cvzf ./log/gameLog/$(date +%Y%m%d%H%M%S).rcl.tar.gz ./*.rcl --remove-files
    rm *.log
    exit 0

}

run() {
    if [ $# -eq 5 ]; then
        synch=on
        ball_pos_x=$1
        ball_pos_y=$2
        ball_vel_x=$3
        ball_vel_y=$4
        trials=$5
    fi

    func_exit0() {
        kill -2 $(pidof rcssserver) &>/dev/null
        kill -9 $(echo ${monitor} | xargs pidof) &>/dev/null
        while [ $(pidof rcssserver) ]; do
            sleep 1
        done
        # mv *.rcg *.rcl ./log/gameLog
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

Line=$(cat para.csv | wc -l)
let "Line++"
while (($Line > 1)); do
    eval $(awk -F ',' 'NR=="'$Line'"{printf("group=%s; ball_pos_x=%s; ball_pos_y=%s; ball_vel_x=%s; ball_vel_y=%s",$1,$2,$3,$4,$5)}' para.csv)
    let "Line--"
    echo "Running group $group"
    echo "ball_pos_x:$ball_pos_x ball_pos_y:$ball_pos_y ball_vel_x:$ball_vel_x ball_vel_y:$ball_vel_y" >>$log
    run $ball_pos_x $ball_pos_y $ball_vel_x $ball_vel_y 50
    ./parse.sh >>$log
done

func_exit

cat $log

echo -e "Check $log to see the result"
