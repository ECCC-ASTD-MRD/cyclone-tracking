# Note: The setup below follows the one used on
#       https://meteocentre.com/cyclone-tracking/index_e.html

add_test(NAME Fiona 
   COMMAND make_tracks -i inputs/cmc-gdps_2022091700-000-240-atl.fst -o ${CMAKE_CURRENT_BINARY_DIR}/track_cmc-gdps-2022091700 -silent -tropic -relocp 
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/test/tropical)
      
add_test(NAME MSLP-based 
   COMMAND make_tracks -i inputs/cmc-gdps-2022112312-000-120-na.fst -o ${CMAKE_CURRENT_BINARY_DIR}/track_cmc-gdps-2022112312_mslp -silent 
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/test/extratrop)
add_test(NAME 1000-hPa_vorticity 
   COMMAND make_tracks -i inputs/cmc-gdps-2022112312-000-120-na.fst -o ${CMAKE_CURRENT_BINARY_DIR}/track_cmc-gdps-2022112312_1000hPaVort -silent -vortcnt -vc 0.75 
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/test/extratrop)
add_test(NAME 500-hPa_vorticity 
   COMMAND make_tracks -i inputs/cmc-gdps-2022112312-000-120-na.fst -o ${CMAKE_CURRENT_BINARY_DIR}/track_cmc-gdps-2022112312_500hPaVort -silent -vortcnt -vc 1.5 -level 500 
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/test/extratrop)
