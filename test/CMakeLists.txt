cmake_minimum_required(VERSION 3.14)

project(cryptonicTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)
include(../cmake/windows-set-path.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(cryptonic REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(cryptonic_test source/cryptonic_test.cpp)
target_link_libraries(cryptonic_test PRIVATE cryptonic::cryptonic)
target_compile_features(cryptonic_test PRIVATE cxx_std_17)

add_test(NAME cryptonic_test COMMAND cryptonic_test)
windows_set_path(cryptonic_test cryptonic::cryptonic)

# ---- End-of-file commands ----

add_folders(Test)
