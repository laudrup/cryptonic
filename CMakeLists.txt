cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    cryptonic
    VERSION 0.1.0
    DESCRIPTION "Cross platform C++ crypto wrapper library"
    HOMEPAGE_URL "https://github.com/laudrup/cryptonic"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    cryptonic_cryptonic
    source/cryptonic.cpp
)
add_library(cryptonic::cryptonic ALIAS cryptonic_cryptonic)

include(GenerateExportHeader)
generate_export_header(
    cryptonic_cryptonic
    BASE_NAME cryptonic
    EXPORT_FILE_NAME export/cryptonic/cryptonic_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(cryptonic_cryptonic PUBLIC CRYPTONIC_STATIC_DEFINE)
endif()

set_target_properties(
    cryptonic_cryptonic PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME cryptonic
    OUTPUT_NAME cryptonic
)

target_include_directories(
    cryptonic_cryptonic ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    cryptonic_cryptonic SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(cryptonic_cryptonic PUBLIC cxx_std_17)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT cryptonic_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of cryptonic"
  )
endif()

include(cmake/dev-mode.cmake)
