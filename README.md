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
1. 打开[本仓库](https://gitlab.com/Apollo-2d/apollo2d-2022/njupt-2022-apollo-2-d),然后clone至本地

2. cd至本文档所在目录（下面这条请不要直接复制粘贴！）
```bash
cd /path/to/this/README.md
```

3. 本工程提供了三个脚本，分别提供了构建代码，运行代码，分析数据三个功能。
```bash
./build.sh
./run.sh
./parse.sh
```

## 如何修改代码

1. 本比赛的所有修改均应当在`src`目录下的`bhv_go_to_moving_ball.cpp/.h`两个文件中进行，若检测到其他文件有修改，视为违规，给予一定的扣分处罚。
2. 球员会且只会执行该文件中的execute函数，所以请不要随意更改该函数名。
3. 本程序会调用librcsc库，而librcsc库已经在第一步比赛环境中安装到系统中，如果需要参考librcsc库中的内容，请前往[gitlab](https://gitlab.com/Apollo-2d/apollo-material/librcsc-2022)下载查看
4. 修改完成之后，请记得使用`./build.sh`来更新二进制程序。

## 如何调试代码
在脚本`run.sh`中，有一系列的值可以修改，可用于定义开始时，球的位置与运动的方向和速度，以及球员开场时的位置等，修改完成后即可运行。

运行后，球员的输出会导入到`player.log`中，比赛结果的原本输出会导入到`raw_result.log`中。

运行后，可以随时按下`[Ctrl+c]`结束比赛，也可以等待比赛自动结束。

~~如果你在`run.sh`中指定了`trials`，那就无需手动使用`kill.sh`。使用`kill.sh`之后，`result.log`中会生成每次接球的数据，分别为接球次数、接到球的时间，以`@`进行分割。~~ 现在`run.sh`会自动结束比赛，无需手动执行`kill.sh`

执行`./parse.sh`可以获得从`./raw_result.log`中读取比赛结果并分析数据，同时初步分析的数据会导出至`./result.log`。

**注意**第一次接球是无效的。

## 如何上传代码
首先在脚本`push.sh`中的第一行`name=`后面写上自己的名字的缩写，如lyb。

然后执行`./push.sh`即可

## 如何测试代码
在`para.sh`中按照格式写入参数，然后运行`autotest.sh`，在`log`文件夹中查看运行结果。

如果想要查看某个数据的运行情况，可以运行`autotest.sh [group number] [on|off]`。如，想要以不开启同步的方式查看第2组数据，只需`autotest.sh 2 off`。

**注意**：两个参数缺一不可。