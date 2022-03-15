#!/bin/bash
# set -x

default_trials=10
teams=(master jmh lc lxy yhw ysy zk)
git_url=git@gitlab.com:Apollo-2d/apollo2d-2022/njupt-2022-apollo-2-d.git

cur_dir=$(dirname $(readlink -f $0))
src_dir=$cur_dir/FinalTest
teams_dir=$cur_dir/teams
log_dir=$cur_dir/logs/$(date +%Y%m%d%H%M%S)

default_para=$cur_dir/para.csv

trap "exit" SIGINT SIGTERM SIGHUP

Apollo_prompt() {
    printf '%-50s\n' "--------------------------------------------------------------------------------"
    printf '\033[34m%-50s\033[0m %-30s\n' "Apollo2D@copyright."
    printf '\033[34m%-50s\033[0m %-30s\n' "Contact me with kawhicurry@foxmail.com if there's any problem"
    printf '%3s \033[32m%11s\033[0m %25s\n' "Try " "./compare help" " to check more information"
    printf '%-50s\n' "--------------------------------------------------------------------------------"
}

help() {
    echo -e "update : update branch from remote"
    echo -e "         update          \t: update all branches"
    echo -e "build  : build teams with git branches"
    echo -e "         build           \t: build all teams from all branch"
    echo -e "         build [name]    \t: build specific team from branch"
    echo -e "data   : check data set in picture"
    echo -e "         data            \t: check default data set: $cur_dir/$default_para"
    echo -e "         date [file]     \t: specify data set"
    echo -e "test   : test code and get effection from it"
    echo -e "test   : test            \t: test all data with all data set"
    echo -e "         test [Line]     \t: test specific data set for all teams"
    echo -e "         E.g. test 1"
    echo -e "parse  : parse the result and get png files to analyse"
    echo -e "         parse [log_dir] \t: parse logs in specific log directory"
    echo -e "         E.g. parse logs/2"
    echo -e "rank   : rank from logs"
    echo -e "         rank [log_dir] [para] \t: 'para' includes 'min','ave','max','var'"
    echo -e "         E.g. rank logs/3/2 ave"
}

update() {
    if [ ! -d $src_dir ]; then
        git clone $git_url $src_dir
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
        mkdir -p $teams_dir
    fi
    if [ $1 ]; then
        cd $src_dir
        git checkout $1
        ./build.sh
        cp -rf build/src/ $teams_dir/$1
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

data() {
    cd $cur_dir
    if [ $1 ]; then
        gnuplot -e "file='$1'" situation.gp
    else
        gnuplot -e "file='$default_para'" situation.gp
    fi
}

parse() {
    if [ $1 ]; then
        log_dir=$(readlink -f $1)
    fi
    cd $log_dir
    log_name=${log_dir##*/}
    result=$(find . -name result*.log)
    if [ $result ]; then
        rm $result
    fi
    for dir in $(ls -d */); do
        cd $dir
        dir_name=${dir%*/}
        gnuplot -e "dir_name='$dir';out_file='../freq_${log_name}_${dir_name}.png'" $cur_dir/frequency.gp
        for log in $(ls); do
            awk -F "@" 'BEGIN {max=0;min=65536} NR!=1{a[++i]=$2;if($2>max)max=$2;if($2<min)min=$2}\
             END {for(i in a)sum += a[i];ave=sum/NR;for(i in a) delta += (a[i]-ave)*(a[i]-ave);\
             print "'$log'" " " min " " sum/(NR-1) " " max " " delta/NR}' $log >>../result_${log_name}_${dir_name}.log
        done
        cd ..
        for result in $(ls result*); do
            gnuplot -e "rst_file='$result';out_file='col_${log_name}_${dir_name}.png'" $cur_dir/column.gp
        done
    done
}

rank() {
    if [ $# -ne 2 ]; then
        echo "need two argument"
    fi
    cd $cur_dir/$1
    cd ..
    cd $cur_dir/$1
    order=1
    if [ x$2 = x"min" ]; then
        order=2n
        echo "Rank by Minimum Cycle"
    fi
    if [ x$2 = x"ave" ]; then
        order=3n
        echo "Rank by Average Cycle"
    fi
    if [ x$2 = x"max" ]; then
        order=4n
        echo "Rank by Maxminum Cycle"
    fi
    if [ x$2 = x"var" ]; then
        order=4n
        echo "Rank by Variance Cycle"
    fi
    sort -k $order result.log | sed "s/ /   \t/g" | nl | sed '1i\Rank\tName    \tMin\tAverage\tMax\tVariance'
}

test() {
    clean
    Apollo_prompt
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
            echo "Finish  $team"
        }

        # trap "func_exit0" SIGINT SIGTERM SIGHUP

        opt="--ball-pos-x=${ball_pos_x} --ball-pos-y=${ball_pos_y}"
        opt="${opt} --ball-vel-x=${ball_vel_x} --ball-vel-y=${ball_vel_y}"
        opt="${opt} --player-pos-x=${player_pos_x} --player-pos-y=${player_pos_y}"
        opt="${opt} --trials=${trials}"

        rcssserver server::coach=on server::synch_mode=on &>/dev/null &
        sleep 1
        $cur_dir/build/helios-base_hfo_trainer ${opt} &>./raw_result.log &
        sleep 1
        chmod +x $teams_dir/$team/sample_player
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

    i=0
    if [ x$teams = x ]; then
        for team in $(ls .git/refs/heads); do
            teams[i]=$team
            ((i++))
        done
    fi

    if [ $1 ]; then
        Lines=$1
    else
        i=$(grep -c , $default_para)
        while [ $i -gt 1 ]; do
            ((i--))
            Lines[i]=$i
        done
    fi
    if [ ! -d $log_dir ]; then
        mkdir -p $log_dir
        cd $log_dir
        cd ..
        i=1
        while [ -e $i ]; do
            ((i++))
        done
        ln -s $log_dir $log_dir/../$i
    fi

    cd $cur_dir
    echo "Repetition Maximum: $default_trials"
    for Line in ${Lines[*]}; do
        if [ ! -d $log_dir/$Line ]; then
            mkdir -p $log_dir/$Line
        fi
        let "Line++"
        eval $(awk -F ',' 'NR=="'$Line'"{printf("group=%s; ball_pos_x=%s; ball_pos_y=%s; ball_vel_x=%s; ball_vel_y=%s",$1,$2,$3,$4,$5)}' "$default_para")
        let "Line--"
        echo -e "\033[36m====================Begin test Line:$Line==============================\033[0m"
        echo -e "ball_pos_x:$ball_pos_x ball_pos_y:$ball_pos_y ball_vel_x:$ball_vel_x ball_vel_y:$ball_vel_y"
        for team in ${teams[*]}; do
            run $ball_pos_x $ball_pos_y $ball_vel_x $ball_vel_y $default_trials $team $Line
        done
        echo -e "\033[32m====================End test Line:$Line================================\033[0m"
    done
    cd $cur_dir
    rm $cur_dir/*rcg $cur_dir/*rcl
    parse 2>/dev/null
}

clean() {
    rm $cur_dir/*rcg
    rm $cur_dir/*rcl
    rm $cur_dir/*log
}

if [ $1 ]; then
    $1 $2 $3 #2>/dev/null
    exit
else
    test 2>/dev/null
fi
