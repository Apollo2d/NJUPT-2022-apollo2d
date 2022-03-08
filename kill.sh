kill -9 $(pidof rcssserver)
rm *.rcg *.rcl
grep -E '@' ./raw_result.log >./result.log

