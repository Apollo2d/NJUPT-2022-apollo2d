#!/bin/bash

monitor="rcssmonitor" # "soccerwindow2"

ball_pos_x="20.0"
ball_pos_y="10.0"
ball_vel_x="1.0"
ball_vel_y="-1.0"
player_pos_x="10.0"
player_pos_y="-30.0"

opt="--ball-pos-x=${ball_pos_x} --ball-pos-y=${ball_pos_y}"
opt="${opt} --ball-vel-x=${ball_vel_x} --ball-vel-y=${ball_vel_y}"
opt="${opt} --player-pos-x=${player_pos_x} --player-pos-y=${player_pos_y}"
# opt="-on=2"

rcssserver server::coach=on &>/dev/null &
if [ ! $(pidof ${monitor}) ]; then
    $monitor &>/dev/null &
fi
sleep 2
./build/helios-base_hfo_trainer ${opt} &>/dev/null &
sleep 2
./build/src/sample_player --config_dir=./build/src/formations-dt &>./player.log &
