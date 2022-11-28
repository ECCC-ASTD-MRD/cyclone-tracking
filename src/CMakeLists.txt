add_library(tracks STATIC libtracks.F)
add_dependencies(tracks ${PROJECT_NAME}_build_info)
set_target_properties(tracks PROPERTIES
   VERSION ${PROJECT_VERSION}
   POSITION_INDEPENDENT_CODE ON)

add_library(tracks_tools STATIC libtracks_tools.F)
add_dependencies(tracks_tools ${PROJECT_NAME}_build_info)
set_target_properties(tracks_tools PROPERTIES
   VERSION ${PROJECT_VERSION}
   POSITION_INDEPENDENT_CODE ON)
  
add_executable(make_tracks make_tracks.F)
add_dependencies(make_tracks ${PROJECT_NAME}_build_info)
target_link_libraries(make_tracks PRIVATE tracks tracks_tools rmn)
    
install(TARGETS tracks tracks_tools make_tracks
  PUBLIC_HEADER DESTINATION include
  LIBRARY       DESTINATION lib
  ARCHIVE       DESTINATION lib
  RUNTIME       DESTINATION bin)
