#!/bin/bash
# set -x

echo "Preparing..."

# 监控参数
monitor="rcssmonitor" # "soccerwindow2" or "rcssmonitor"
synch=off             # 启用加速功能 off为关闭
trials=100            # 最大训练次数,0为不开启,注意第一次是无效的

# 球和球员的参数
ball_pos_x="-20.0"
ball_pos_y="20.0"
ball_vel_x="0.0"
ball_vel_y="-2.0"
# player_pos_x="0.0" # 现在不建议修改球员的位置
# player_pos_y="0.0"

# 执行部分，不建议修改----------------------------------------------------

if [ $# -eq 5 ]; then
    synch=on
    ball_pos_x=$1
    ball_pos_y=$2
    ball_vel_x=$3
    ball_vel_y=$4
    # player_pos_x=$5
    # player_pos_y=$6
    trials=$5
fi

func_exit() {
    kill -2 $(pidof rcssserver) &>/dev/null
    kill -9 $(echo ${monitor} | xargs pidof) &>/dev/null
    sleep 1
    rm *.rcg *.rcl
    ./parse.sh
    echo "Game Done"
    exit
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
./build/src/sample_player --config_dir=./build/src/formations-dt &>./player.log &

echo "Running..."
echo "Use [Ctrl]+c to stop at any time"
while true; do
    if [ ! $(pidof helios-base_hfo_trainer) ]; then
        func_exit
    fi
    echo -en "$(grep -c @ raw_result.log)/${trials}\r"
    sleep 0.1
done
