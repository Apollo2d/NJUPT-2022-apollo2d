awk -F "@" 'BEGIN {} NR!=1{sum+=$3-$2} END {print "Catch times: " NR-1 "\nAverage cycle: " sum/(NR-1)}' result.log
