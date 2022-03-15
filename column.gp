if(!exist("rst_file"))print("need rst_file");exit
if(!exist("out_file"))print("need out_file");exit

set term pngcairo size 1000,1000
set output out_file
set palette rgbformulae 33,13,10
set style data histogram
set style fill solid 0.4 border
set style histogram rowstacked
set grid front
# set boxwidth 0.6 relative
# set xtics rotate by -45
set yrange [0:120]
set xrange [:]


set title rst_file
plot rst_file using ($2):xticlabels(1) title "Min",\
'' using (($3)-($2)):xticlabels(1) title "Average",\
'' using (($4)-($3)):xticlabels(1) title "Max" ,\
'' using 0:2:2 with labels notitle,\
'' using 0:3:3 with labels notitle,\
'' using 0:4:4 with labels notitle,\


