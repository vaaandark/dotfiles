#!/bin/sh
dir=cpu-view
if [ ! -d $dir ]; then
	mkdir $dir
fi
perf record -F 200 -g -o $dir/cpu.data -- $1
perf script -i $dir/cpu.data > $dir/cpu.perf
stackcollapse-perf.pl $dir/cpu.perf > $dir/cpu.folded
flamegraph.pl $dir/cpu.folded > $dir/cpu.svg
