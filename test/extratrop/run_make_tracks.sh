#!/bin/bash

make_tracks=../../build/src/make_tracks

# Note: The setup below follows the one used on
#       https://meteocentre.com/cyclone-tracking/index_e.html

nwpForecast=inputs/cmc-gdps-2022112312-000-120-na.fst

# MSLP-based tracking
rm -f track_cmc-gdps-2022112312_mslp.*
$make_tracks -i $nwpForecast -o track_cmc-gdps-2022112312_mslp -silent

# 1000-hPa vorticity tracking
rm -f track_cmc-gdps-2022112312_1000hPaVort.*
$make_tracks -i $nwpForecast -o track_cmc-gdps-2022112312_1000hPaVort -silent -vortcnt -vc 0.75

# 500-hPa vorticity tracking
rm -f track_cmc-gdps-2022112312_500hPaVort.*
$make_tracks -i $nwpForecast -o track_cmc-gdps-2022112312_500hPaVort -silent -vortcnt -vc 1.5 -level 500
