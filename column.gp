set term pngcairo size 2000,2000
set output "column.png"
set multiplot layout 3,3
set style data histogram
set style fill solid 0.4 border
set style histogram clustered gap 1
# set style histogram errorbars gap 1
set grid
# set boxwidth 0.6 relative
set xtics rotate by -45
set yrange [0:1000]
set xrange [:]
set palette rgbformulae 33,13,10
set origin 0,0

cd "logs"
Lines=system("ls")
do for [Line in Lines]{
    cd Line
    set title Line
    plot "result.log" using 2:xticlabels(1) title "Max",\
    '' using 3:xticlabels(1) title "Average",\
    '' using 4:xticlabels(1) title "Min" ,\
    '' using 5:xticlabels(1) title "variance"
    cd ".."
}
cd ".."




