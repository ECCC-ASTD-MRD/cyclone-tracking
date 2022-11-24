add_library(tracks STATIC libtracks.F)
add_dependencies(tracks ${PROJECT_NAME}_build_info)
set_target_properties(tracks PROPERTIES
   VERSION ${PROJECT_VERSION}
   POSITION_INDEPENDENT_CODE ON)

add_library(tracks_tools STATIC libtracks_tools.F gdadgd.f gdadcn.f gdmpgd.f)
add_dependencies(tracks_tools ${PROJECT_NAME}_build_info)
set_target_properties(tracks_tools PROPERTIES
   VERSION ${PROJECT_VERSION}
   POSITION_INDEPENDENT_CODE ON)
  
add_executable(make_tracks make_tracks.F)
add_dependencies(make_tracks ${PROJECT_NAME}_build_info)
target_link_libraries(make_tracks PRIVATE tracks tracks_tools rmn)
#set_target_properties(make_tracks PROPERTIES VERSION ${PROJECT_VERSION})
    
add_executable(mt2gmt5 mt2gmt5.F)
add_dependencies(mt2gmt5 ${PROJECT_NAME}_build_info)
target_link_libraries(mt2gmt5 PRIVATE tracks rmn)
#set_target_properties(mt2gmt5 PROPERTIES VERSION ${PROJECT_VERSION})
    
install(TARGETS tracks tracks_tools mt2gmt5 make_tracks
  PUBLIC_HEADER DESTINATION include
  LIBRARY       DESTINATION lib
  ARCHIVE       DESTINATION lib
  RUNTIME       DESTINATION bin)
