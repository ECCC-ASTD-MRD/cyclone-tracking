#!/bin/bash

make_tracks=../../build/src/make_tracks

# Note: The setup below follows the one used on
#       https://meteocentre.com/cyclone-tracking/index_e.html

nwpForecast=cmc-gdps_2022091700-000-240-atl.fst # contains hurricane Fiona (https://en.wikipedia.org/wiki/Hurricane_Fiona)

rm -f track_cmc-gdps-2022091700.*
$make_tracks -i $nwpForecast  -o track_cmc-gdps-2022091700 -silent -tropic -relocp
