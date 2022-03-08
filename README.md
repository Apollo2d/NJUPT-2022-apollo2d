# Apollo2D 2022 校赛选拔指导

## 比赛环境
使用ubuntu18.04，安装以下软件
- cmake
- boost
- zlib
- librcsc
- rcssserver16.1
- soccerwindow2(option)

推荐使用[脚本安装](https://gitee.com/apollo-2d/Apollo_env_install)

## 如何开始
1. 首先点击gitlab右上角的fork按钮，然后在命名空间（namespace）中选择你自己的账号名，其余随意，然后点击确定。这将复制一份本仓库的代码到你自己的账号中，然后打开你在ubuntu本地的终端，使用git clone 你自己仓库的url。

2. cd至本文档所在目录（下面这条请不要直接复制粘贴！）
```bash
cd /path/to/this/README.md
```

3. 本工程提供了三个脚本，分别提供了构建代码，运行代码，终止比赛三个功能。
```bash
./build.sh
./run.sh
./kill.sh
```

4. 修改完成后，首先在本地进行commit操作（推荐多次commit来记录你的修改过程），然后push到你自己的远程仓库后，点击左侧合并请求（merge requests），然后new merge requests。在右侧的target branch中将分支名（可能为master）改为你自己的名字，若没有你的名字，请联系管理员新建一个。

## 如何修改代码

1. 本比赛的所有修改均应当在`src`目录下的`bhv_go_to_moving_ball.cpp/.h`两个文件中进行，若检测到其他文件有修改，视为违规，给予一定的扣分处罚。
2. 球员会且只会执行该文件中的execute函数，所以请不要随意更改该函数名。
3. 本程序会调用librcsc库，而librcsc库已经在第一步比赛环境中安装到系统中，如果需要参考librcsc库中的内容，请前往[gitlab](https://gitlab.com/Apollo-2d/apollo-material/librcsc-2022)下载查看

