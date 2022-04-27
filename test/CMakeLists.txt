cmake_minimum_required(VERSION 3.14)

project(cryptonicTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)
include(../cmake/windows-set-path.cmake)

include(FetchContent)

if(PROJECT_IS_TOP_LEVEL)
  find_package(cryptonic REQUIRED)
  enable_testing()
endif()

# ---- Tests ----
FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        v2.13.9
)

FetchContent_MakeAvailable(Catch2)

add_executable(cryptonic_test
  source/cryptonic_test.cpp
)

target_link_libraries(cryptonic_test PRIVATE
  cryptonic::cryptonic
  Catch2::Catch2
)

target_compile_features(cryptonic_test PRIVATE cxx_std_17)

add_test(NAME cryptonic_test COMMAND cryptonic_test)
windows_set_path(cryptonic_test cryptonic::cryptonic)

# ---- End-of-file commands ----

add_folders(Test)
