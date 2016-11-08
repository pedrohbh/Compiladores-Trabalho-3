#!/bin/bash

DATA=/home/zambon/Teaching/2016-2/CC/laboratorio/tests/
IN=$DATA/in9
OUT=$DATA/out9

EXE=./checker

for infile in `ls $IN/*.tny`; do
    base=$(basename $infile)
    outfile=$OUT/${base/.tny/.out}
    $EXE < $infile > $outfile
done
