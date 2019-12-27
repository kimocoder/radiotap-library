CMAKE_MINIMUM_REQUIRED( VERSION 2.6 )

PROJECT( radiotap )

ADD_DEFINITIONS( "-D_BSD_SOURCE -DRADIOTAP_SUPPORT_OVERRIDES" )

SET( CMAKE_MACOSX_RPATH 1 )

# use, i.e. don't skip the full RPATH for the build tree
#SET( CMAKE_SKIP_BUILD_RPATH FALSE )

# when building, don't use the install RPATH already
# (but later on when installing)
#SET( CMAKE_BUILD_WITH_INSTALL_RPATH FALSE )
#SET( CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib" )

# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
#SET( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE )

# the RPATH to be used when installing, but only if it's not a system directory
#LIST(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
#IF("${isSystemDir}" STREQUAL "-1")
#	SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
#ENDIF("${isSystemDir}" STREQUAL "-1")

ADD_LIBRARY( radiotap SHARED radiotap.c )
SET_TARGET_PROPERTIES( radiotap PROPERTIES
        COMPILE_FLAGS "-Wall -Wextra" )

INSTALL( TARGETS radiotap DESTINATION lib )
INSTALL( FILES radiotap.h radiotap_iter.h DESTINATION include )

ADD_EXECUTABLE( parse parse.c )
SET_TARGET_PROPERTIES( parse PROPERTIES
        COMPILE_FLAGS "-Wall -Wextra" )
TARGET_LINK_LIBRARIES( parse radiotap )


ADD_CUSTOM_TARGET( radiotap_check ALL
        COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/check/check.sh ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/check/*
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/check/
        COMMENT "Check examples" )

ADD_DEPENDENCIES( radiotap_check parse )
