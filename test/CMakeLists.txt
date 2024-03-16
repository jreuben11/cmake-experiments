cmake_minimum_required(VERSION 3.14)

project(cmake-experimentsTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(cmake-experiments REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(cmake-experiments_test source/cmake-experiments_test.cpp)
target_link_libraries(cmake-experiments_test PRIVATE cmake-experiments::cmake-experiments)
target_compile_features(cmake-experiments_test PRIVATE cxx_std_20)

add_test(NAME cmake-experiments_test COMMAND cmake-experiments_test)

# ---- End-of-file commands ----

add_folders(Test)
