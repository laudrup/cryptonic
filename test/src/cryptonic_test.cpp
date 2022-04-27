#include "cryptonic/cryptonic.hpp"

#include <catch2/catch.hpp>

#include <string>

TEST_CASE("cryptonic") {
  exported_class e;
  CHECK(e.name() == std::string("cryptonic"));
}
