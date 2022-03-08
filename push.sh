name=

# 下方内容请不要随意修改
if [ $name ]; then
    git add .
    git commit -m 'commit'
    git push origin master:$name
else
    echo "Please input your name in push.sh"
fi
