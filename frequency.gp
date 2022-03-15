if(!exist("dir_name"))print("need dir_name");exit
if(!exist("out_file"))print("need out_file");exit

set term pngcairo size 1000 ,1000
set output out_file
set ylabel "times"
set xlabel "cycle"
set style fill transparent solid 0.5
# set boxwidth 0.5
set grid
set yrange [1:]
set xrange [5:]
set palette rgbformulae 33,13,10

files=system("ls")
set title dir_name
plot for [file in files] file using 2:(1) "%lf@%lf" smooth frequency with filledcurves y1=0 title file

