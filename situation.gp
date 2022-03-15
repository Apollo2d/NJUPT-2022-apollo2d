set term pngcairo size 1500 ,1000 font "Times,12"
set output "situation.png"
set size ratio -1

set arrow from 0,-34 to 0,34 nohead lw 1
set object 1 rectangle from -52.5,-34 to 52.5,34 lw 1
set object 2 circle at 0,0 size 9.15 fillcolor rgb "black" lw 1
set object 3 circle at -52.5+11.0,0 size 9.15 arc [-53:53] fillcolor rgb "black" lw 1
set object 4 circle at -52.5+11.0,0 front size 9.13 arc [-54:54] fc rgb 'white'
set object 5 circle at 52.5-11.0,0 size 9.15 arc [-53+180:53+180] fillcolor rgb "black" lw 1
set object 6 circle at 52.5-11.0,0 front size 9.13 arc [-54+180:54+180] fc rgb 'white'
set object 7 rectangle from -52.5,-20.16 to -52.5+16.5,20.16 lw 1
set object 8 rectangle from 52.5-16.5,-20.16 to 52.5,20.16 lw 1
set object 9 rectangle from -52.5,-9.16 to -52.5+5.5,9.16 lw 1
set object 10 rectangle from 52.5-5.5,-9.16 to 52.5,9.16 lw 1
set object 11 circle at -52.5+11.0,0 size 0.1
set object 12 circle at 52.5-11.0,0 size 0.1
set object 13 rectangle from -52.5-2.44,-7.01 to -52.5,7.01 lw 10 fc rgb 'black'
set object 14 rectangle from 52.5,-7.01 to 52.5+2.44,7.01 lw 10 fc rgb 'black'


if(!exist("file"))file='para.csv'
set datafile separator ',' 
plot [-55:55][-36.5:36.5] 0 notitle,\
file using 2:3:($4*5):($5*5)  with vectors filled lw 4 notitle,\
'' using ($2+$4*2.5):($3+$5*2.5):(sprintf("   %d",$1)) with labels notitle,\
'' using ($2-$4):($3-$5):(sprintf("(%2.1f,%2.1f)",$2,$3)) with labels notitle,\
'' using ($2+$4*6):($3+$5*6):(sprintf("(%2.1f,%2.1f)",$4,$5)) with labels notitle

