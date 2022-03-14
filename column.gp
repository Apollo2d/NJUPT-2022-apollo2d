set term pngcairo size 2000,4000
set output "column.png"
set multiplot layout 3,3
set style data histogram
set style fill solid 0.4 border
# set style histogram clustered gap 1
set style histogram rowstacked
set grid
# set boxwidth 0.6 relative
# set xtics rotate by -45
set yrange [0:102]
set xrange [:]
set palette rgbformulae 33,13,10

cd "logs"
Lines=system("ls")
do for [Line in Lines]{
    cd Line
    set title Line
    plot "result.log" using ($2):xticlabels(1) title "Min",\
    '' using (($3)-($2)):xticlabels(1) title "Average",\
    '' using (($4)-($3)):xticlabels(1) title "Max" ,\
    # '' using ($5-($2-($3-$4))):xticlabels(1) title "Variance"
    # '' using 5:xticlabels(1) title "variance"
    cd ".."
}
cd ".."




