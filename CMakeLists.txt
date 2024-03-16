cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    cmake-experiments
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    cmake-experiments_cmake-experiments
    source/cmake-experiments.cpp
)
add_library(cmake-experiments::cmake-experiments ALIAS cmake-experiments_cmake-experiments)

include(GenerateExportHeader)
generate_export_header(
    cmake-experiments_cmake-experiments
    BASE_NAME cmake-experiments
    EXPORT_FILE_NAME export/cmake-experiments/cmake-experiments_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(cmake-experiments_cmake-experiments PUBLIC CMAKE_EXPERIMENTS_STATIC_DEFINE)
endif()

set_target_properties(
    cmake-experiments_cmake-experiments PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME cmake-experiments
    OUTPUT_NAME cmake-experiments
)

target_include_directories(
    cmake-experiments_cmake-experiments ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    cmake-experiments_cmake-experiments SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(cmake-experiments_cmake-experiments PUBLIC cxx_std_20)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${cmake-experiments_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT cmake-experiments_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of cmake-experiments"
  )
endif()

include(cmake/dev-mode.cmake)
