set xlabel "times"
set ylabel "time(cycle)"
set style fill solid
set title "log/20220312011732.raw.log"
set multiplot
# set output 'runtime.png'

file="log/20220312042536.raw.log"
# file="./result.log"
# file="log/20220312011629.raw.log"

# plot sin(x) lt rgb "#FF00FF"



plot for [i=1:10] [:] file index i using 1:2 "%lf@%lf" with lines title sprintf("%d",i)

# do for [i=1:3] {
#   plot [:] file index i using 1:2 "%lf@%lf" with lines title "123",
# }