#include <string>

#include "cryptonic/cryptonic.hpp"

exported_class::exported_class()
    : m_name("cryptonic") {
}

auto exported_class::name() const -> const char* {
  return m_name.c_str();
}
