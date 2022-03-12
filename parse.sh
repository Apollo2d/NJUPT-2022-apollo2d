grep -E '@' ./raw_result.log | awk -F "@" 'BEGIN {max=0;min=65536} NR!=1{sum+=$2;if($2>max)max=$2;if($2<min)min=$2} END {print "Times: " NR-1 "\tAverage: " sum/(NR-1) "\tMax: " max "\tMin: " min}'
