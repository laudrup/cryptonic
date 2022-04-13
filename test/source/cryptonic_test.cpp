#include <string>

#include "cryptonic/cryptonic.hpp"

auto main() -> int
{
  exported_class e;

  return std::string("cryptonic") == e.name() ? 0 : 1;
}
