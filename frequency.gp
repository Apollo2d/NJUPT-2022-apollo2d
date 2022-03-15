set term pngcairo size 4000 ,4000
set output "frequency.png"
set multiplot layout 3,3
set ylabel "times"
set xlabel "cycle"
set style fill transparent solid 0.5
# set boxwidth 0.5
set grid
set yrange [1:]
set xrange [5:]
set palette rgbformulae 33,13,10

Lines=system("ls -d */")
do for [Line in Lines]{
    cd Line
    files=system("ls")
    set title Line
    plot for [file in files] file using 2:(1) "%lf@%lf" smooth frequency with filledcurves y1=0 title file
    cd ".."
}
cd ".."

