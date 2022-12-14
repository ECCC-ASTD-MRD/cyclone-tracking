# This must be repeated in each CMake file; having it in an included file is not
# sufficient
cmake_minimum_required(VERSION 3.16)

#----- Append EC specific module path
list(APPEND CMAKE_MODULE_PATH $ENV{EC_CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake_rpn/modules)

include(ec_init)           # Initialise compilers and ec specific functions
ec_git_version()           # Get version from git state
ec_parse_manifest()        # Parse MANIFEST file

# Given our wacky compiler setups, languages must be activated after the compiler has been configured
project(${NAME} DESCRIPTION "${DESCRIPTION}")
set(PROJECT_VERSION ${VERSION}${STATE})
set(${NAME}_VERSION ${PROJECT_VERSION} CACHE INTERNAL "${NAME} version" FORCE) # Needed for cascaded version identification

enable_language(C Fortran)
include(ec_compiler_presets)
include(ec_doxygen)
ec_build_info()            # Generate build include file (optional)

include(CTest)
add_custom_target(check COMMAND CTEST_OUTPUT_ON_FAILURE=true ${CMAKE_CTEST_COMMAND})

if (NOT rmn_FOUND)
   find_package(rmn ${rmn_REQ_VERSION} COMPONENTS shared REQUIRED)
endif()

# Need to extend line length     gfortran            ifort
set(CMAKE_Fortran_FLAGS "-ffixed-line-length-none -extend-source ${CMAKE_Fortran_FLAGS} ")

add_subdirectory(src)
add_subdirectory(test)

#----- Generate the config file for the project to be usable via cmake's find_package command
set(INCLUDE_INSTALL_DIR include)
set(LIB_INSTALL_DIR     lib)
set(CONFIG_INSTALL_DIR  "${LIB_INSTALL_DIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION}")

include(CMakePackageConfigHelpers)
configure_package_config_file(
    "Config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION "${CONFIG_INSTALL_DIR}"
    PATH_VARS           INCLUDE_INSTALL_DIR LIB_INSTALL_DIR
)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)
install(FILES   "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
                "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION "${CONFIG_INSTALL_DIR}"
)

#----- Packaging
ec_package_name()                # Define package prefix  
ec_build_config()                # Create build configuration script
ec_prepare_ssm()                 # Prepare ssm packaging files

set(CPACK_GENERATOR "TGZ")
set(CPACK_PACKAGE_VENDOR "ECCC")
set(CPACK_PACKAGE_CONTACT "${MAINTAINER}")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.org")
set(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/package")
set(CPACK_PACKAGE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
set(CPACK_PACKAGE_FILE_NAME "${PACKAGE_NAME}")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${NAME}_${PROJECT_VERSION}")
include(CPack)
