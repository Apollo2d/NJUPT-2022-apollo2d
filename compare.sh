#!/bin/bash
# set -x

default_trials=100

cur_dir=$(dirname $(readlink -f $0))
src_dir=$cur_dir/FinalTest
teams_dir=$cur_dir/teams
log_dir=$cur_dir/logs

trap "exit" SIGINT SIGTERM SIGHUP

update() {
    if [ ! -d $src_dir ]; then
        git clone git@gitlab.com:Apollo-2d/apollo2d-2022/njupt-2022-apollo-2-d.git $src_dir
    fi
    cd $src_dir
    git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
    git fetch --all
    git pull --all
}

build() {
    if [ ! -d $src_dir ]; then
        echo "Can't find directory: $src_dir"
        exit
    fi
    if [ ! -d $teams_dir ]; then
        mkdir $teams_dir
    fi
    if [ ! -d $log_dir ]; then
        mkdir $log_dir
    fi
    if [ $1 ]; then
        cd $src_dir
        git checkout $1
        ./build.sh
        cp -rf build/src/ $teams_dir/$branch
        exit
    fi

    ./build.sh
    cd $src_dir
    branches=$(ls .git/refs/heads)
    for branch in $branches; do
        git checkout $branch
        ./build.sh
        cp -rf build/src/ $teams_dir/$branch
    done
}

test() {
    run() {
        local ball_pos_x=$1
        local ball_pos_y=$2
        local ball_vel_x=$3
        local ball_vel_y=$4
        local trials=$5
        local team=$6
        local line=$7

        func_exit0() {
            kill -2 $(pidof rcssserver) &>/dev/null
            while [ $(pidof rcssserver) ]; do
                sleep 1
            done
            touch $log_dir/$line/$team.log
            grep @ $cur_dir/raw_result.log >$log_dir/$line/$team.log
            echo "$team Done"
        }

        trap "func_exit0" SIGINT SIGTERM SIGHUP

        opt="--ball-pos-x=${ball_pos_x} --ball-pos-y=${ball_pos_y}"
        opt="${opt} --ball-vel-x=${ball_vel_x} --ball-vel-y=${ball_vel_y}"
        opt="${opt} --player-pos-x=${player_pos_x} --player-pos-y=${player_pos_y}"
        opt="${opt} --trials=${trials}"

        rcssserver server::coach=on server::synch_mode=on &>/dev/null &
        sleep 1
        $cur_dir/build/helios-base_hfo_trainer ${opt} &>./raw_result.log &
        sleep 1
        $teams_dir/$team/sample_player --config_dir=$teams_dir/$team/formations-dt &>/dev/null &

        echo "Testing $team"
        while true; do
            if [ ! $(pidof helios-base_hfo_trainer) ]; then
                func_exit0
                return 0
            fi
            echo -en "$(grep -c @ raw_result.log)/${trials}\r"
            sleep 0.1
        done
    }

    cd $cur_dir
    i=0
    # for team in $(ls .git/refs/heads); do
    #     teams[i]=$team
    #     ((i++))
    # done
    teams=(jmh lxy master ysy)
    Lines=1
    if [ $1 ]; then
        Lines=$1
    else
        i=$(grep -c , para.csv)
        while [ $i -gt 1 ]; do
            Lines[i]=$i
            ((i--))
        done
    fi
    if [ ! -d $log_dir ]; then
        mkdir $log_dir
    fi

    for Line in ${Lines[*]}; do
        if [ ! -d $log_dir/$Line ]; then
            mkdir $log_dir/$Line
        fi
        let "Line++"
        eval $(awk -F ',' 'NR=="'$Line'"{printf("group=%s; ball_pos_x=%s; ball_pos_y=%s; ball_vel_x=%s; ball_vel_y=%s",$1,$2,$3,$4,$5)}' para.csv)
        let "Line--"
        echo "Begin testing $Line with:"
        echo "ball_pos_x:$ball_pos_x ball_pos_y:$ball_pos_y ball_vel_x:$ball_vel_x ball_vel_y:$ball_vel_y"
        for team in ${teams[*]}; do
            run $ball_pos_x $ball_pos_y $ball_vel_x $ball_vel_y $default_trials $team $Line
        done
    done
    rm $cur_dir/*rcg $cur_dir/*rcl
}

draw() {
    cd $cur_dir
    gnuplog parse.gp
    gnuplot column.gp
}

clean_result() {
    cd $log_dir
    for dir in $(ls); do
        cd $dir
        rm result.log
        cd ..
    done
    cd ..
}

parse() {
    cd $log_dir
    for dir in $(ls); do
        cd $dir
        for log in $(ls); do
            awk -F "@" 'BEGIN {max=0;min=65536} NR!=1{a[++i]=$2;sum+=$2;if($2>max)max=$2;if($2<min)min=$2} END {for(i in a)sum += a[i];ave=sum/NR;for(i in a) delta += (a[i]-ave)*(a[i]-ave);print "'$log'" " " max " " sum/(NR-1) " " min " " delta/NR}' $log >>./result.log
        done
        cd ..
    done
    cd $cur_dir
    gnuplot column.gp
    clean_result
    gnuplot frequency.gp
}

if [ $1 ]; then
    $1 $2 $3
    exit
fi

test
