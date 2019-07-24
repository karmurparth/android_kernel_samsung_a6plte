#!/bin/bash
out_dir=out/current
ncpus=$(nproc --all)
export CROSS_COMPILE=aarch64-linux-gnu-
export ARCH=arm64
export KBUILD_OUTPUT=$out_dir
mkdir -p $out_dir
if [[ "$@" =~ .*config ]]
then
	make $@
else
	time make -j $((ncpus * 2 + 1)) O=$out_dir "$@" 2>&1 | tee $out_dir/build.log
fi
