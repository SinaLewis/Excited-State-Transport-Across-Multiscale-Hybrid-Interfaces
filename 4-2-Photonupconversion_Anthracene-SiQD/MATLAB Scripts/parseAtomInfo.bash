#!/bin/bash

filename=$1
savepath=$3

numAtoms=$(grep -A1 "ITEM: NUMBER OF ATOMS" "$filename" | head -2 | tail -1)

echo "The number of atoms found was: $numAtoms"

grep -A1 "ITEM: TIMESTEP" "$filename" | sed '/--/d' | grep -v "ITEM: TIMESTEP" > "$savepath"/timesteps_for_$2.txt

numTimesteps=$(tail -1 "$savepath"/timesteps_for_$2.txt)

echo "The last timestep found was: $numTimesteps"

## looking for the atom given by argument 2
grep ^"$2 " "$filename" > "$savepath"/data_for_$2.txt
