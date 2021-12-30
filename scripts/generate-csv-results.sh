#!/bin/bash

# Copy this script in the same directory with the results and run it from there
# Directories 

INPUT=$1
INPUT_TIME=$1-sempb

mkdir -p temp
mkdir -p csv

###########
# Timedout
###########

# Keep ids that timed-out, with their times
grep ";-1" $INPUT | awk -F ";" '{ print $1 }' | xargs -I{} grep "{} " $INPUT_TIME | awk '{ print $10 }' | xargs -I{} grep {} $INPUT_TIME | grep Sources | grep -v Execution | awk '{seen[$10]++; line[$10]=$0};END{for (x in seen) {if (seen[x]==1) print line[x]}}' | colrm 1 68 | sed -e 's/Source Selection Time\: //g' | sed -e 's/Compile Time\: //g' | sed -e 's/Sources\: //g' > temp/$INPUT-timedout-id-time

# Keep ids that timed-out, with their queries and runs
grep ";-1" $INPUT | awk -F ";" '{ print $1 }' | xargs -I{} grep "{} " $INPUT_TIME | awk '{ print $10,"-",$23,"-",$26 }' | awk '{seen[$1]++; line[$1]=$0}END{for (x in seen) if (seen[x]==1) print line[x]}' > temp/$INPUT-timedout-id-query

# Keep queries that timed-out, with their runs and times
# (combine two previous files)

awk 'FNR==NR { a[$1]=$3 FS $4 FS $5; next } { print a[$1], $2, $3, $4, $5, $6, $7 }' temp/$INPUT-timedout-id-query temp/$INPUT-timedout-id-time > temp/$INPUT-timedout


###########
# Executed
###########

# Keep ids that executed, with their queries and times 

# grep "Execution" $INPUT_TIME | colrm 1 147 | sed -e 's/Run\: //g' | sed -e 's/Source Selection Time\: //g' | sed -e 's/Compile Time\: //g' | sed -e 's/Sources\: //g' | sed -e 's/Execution time\: //g' > temp/$INPUT-exec

grep "Execution" $INPUT_TIME | awk '{ print $21, $22, $24, $25, $29, $30, $33, $34, $40, $37, $36 }' | grep -v ":" > temp/$INPUT-exec


# Keep ids that executed, with their queries, total time and number of results

# grep "Results" $INPUT | grep -v "Results: -1" | colrm 1 144 | sed -e 's/Run\: //g' | sed -e 's/Query Evaluation Time\: //g' | sed -e 's/Results\: //g' > temp/$INPUT-res

grep "Results" $INPUT | grep -v "Results: -1" | colrm 1 47 | awk '{ print $13, $14, $16, $17, $21, $22, $24 }' > temp/$INPUT-res


# Keep queries, with their times and number of results, that executed  
# (combine the two previous files)

awk 'FNR==NR { a[$1,$3]=$4 FS $5 FS $6 FS $7 FS $8; next } { print $0, a[$1,$3] }' temp/$INPUT-res temp/$INPUT-exec > temp/$INPUT-executed


###########
# All
###########

# Unite all runs (executed and timed-out)
cat temp/$INPUT-executed > csv/$INPUT.csv
cat temp/$INPUT-timedout >> csv/$INPUT.csv
