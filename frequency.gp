set term pngcairo size 4000 ,4000
set output "frequency.png"
set multiplot layout 3,3
set xlabel "tries"
set ylabel "time(cycle)"
set style fill solid
set grid
set yrange [10:100]
set xrange [2:]
set palette rgbformulae 33,13,10
set origin 0,0

cd "logs"
Lines=system("ls")
do for [Line in Lines]{
    cd Line
    files=system("ls")
    set title Line
    plot for [file in files] file using 1:2 "%lf@%lf" with lines title file
    cd ".."
}
cd ".."

