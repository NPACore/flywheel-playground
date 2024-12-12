#!/usr/bin/env bash
# 20241212WF - init. make single dicom symlink versions of an example session and upload to flywheel
#  initially tried all MR* files in a single directory. FW uploaded each of the 10 as a duplicate session!
#  each acq should be in it's own directory
mkdir -p short
eg_acqdirs=(/Volumes/Hera/Raw/MRprojects/Habit/2023.11.04-13.07.55/11967_20231104/{Habit,Resting,Reward,ABCD*MPR_vNav_256x256}*)
for d in "${eg_acqdirs[@]}"; do
  short_dest="short/$(ld8 "$d")/$(basename "$d")"
  dryrun mkdir -p "$short_dest"
  find "$d" -type f -iname 'MR.*' | head -n 1 | xargs -I{} dryrun ln -sf  {} "$short_dest"
  dryrun fw ingest dicom -y --include 'MR.*' -vd "$short_dest" mrrc playground
done
