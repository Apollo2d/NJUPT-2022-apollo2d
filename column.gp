set term pngcairo size 4000,4000
set output "column.png"
set multiplot layout 3,3
set palette rgbformulae 33,13,10
set style data histogram
set style fill solid 0.4 border
set style histogram rowstacked
set grid front
# set boxwidth 0.6 relative
# set xtics rotate by -45
set yrange [0:120]
set xrange [:]


cd "logs"
Lines=system("ls")
do for [Line in Lines]{
    cd Line
    set title Line
    plot "result.log" using ($2):xticlabels(1) title "Min",\
    '' using (($3)-($2)):xticlabels(1) title "Average",\
    '' using (($4)-($3)):xticlabels(1) title "Max" ,\
    '' using 0:2:2 with labels notitle,\
    '' using 0:3:3 with labels notitle,\
    '' using 0:4:4 with labels notitle,\
    # '' using ($5-($2-($3-$4))):xticlabels(1) title "Variance"
    # '' using 5:xticlabels(1) title "variance"
    cd ".."
}
cd ".."




