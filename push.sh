name=ysy

# 下方内容请不要随意修改
if [ $name ]; then
    git add ./src/bhv_go_to_moving_ball.h ./src/bhv_go_to_moving_ball.cpp
    git commit -m 'commit'
    git push origin master:$name
else
    echo "Please input your name in push.sh"
fi
