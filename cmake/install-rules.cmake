if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/cmake-experiments-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package cmake-experiments)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT cmake-experiments_Development
)

install(
    TARGETS cmake-experiments_cmake-experiments
    EXPORT cmake-experimentsTargets
    RUNTIME #
    COMPONENT cmake-experiments_Runtime
    LIBRARY #
    COMPONENT cmake-experiments_Runtime
    NAMELINK_COMPONENT cmake-experiments_Development
    ARCHIVE #
    COMPONENT cmake-experiments_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    cmake-experiments_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE cmake-experiments_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(cmake-experiments_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${cmake-experiments_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT cmake-experiments_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${cmake-experiments_INSTALL_CMAKEDIR}"
    COMPONENT cmake-experiments_Development
)

install(
    EXPORT cmake-experimentsTargets
    NAMESPACE cmake-experiments::
    DESTINATION "${cmake-experiments_INSTALL_CMAKEDIR}"
    COMPONENT cmake-experiments_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
