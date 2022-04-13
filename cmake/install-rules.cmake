if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/cryptonic CACHE PATH "")
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package cryptonic)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT cryptonic_Development
)

install(
    TARGETS cryptonic_cryptonic
    EXPORT cryptonicTargets
    RUNTIME #
    COMPONENT cryptonic_Runtime
    LIBRARY #
    COMPONENT cryptonic_Runtime
    NAMELINK_COMPONENT cryptonic_Development
    ARCHIVE #
    COMPONENT cryptonic_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    cryptonic_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(cryptonic_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${cryptonic_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT cryptonic_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${cryptonic_INSTALL_CMAKEDIR}"
    COMPONENT cryptonic_Development
)

install(
    EXPORT cryptonicTargets
    NAMESPACE cryptonic::
    DESTINATION "${cryptonic_INSTALL_CMAKEDIR}"
    COMPONENT cryptonic_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
