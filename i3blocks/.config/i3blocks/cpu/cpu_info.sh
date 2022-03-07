#!/bin/sh
#CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')
CPU_USAGE=$(mpstat 1 1 | grep -A 5 "%idle" | tail -n 1 | awk -F " " '{print 100 -  $ 12}'a)
echo "$CPU_USAGE" | awk '{ printf("%5.2f% \n"), $1 }'

