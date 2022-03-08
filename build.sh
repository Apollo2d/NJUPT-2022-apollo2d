if [ ! -d build ]; then
    mkdir build
fi
cd build
cmake ..
core=$(cat /proc/cpuinfo | grep -c processor)
make -j$core
