#include <string>

#include "cmake-experiments/cmake-experiments.hpp"

exported_class::exported_class()
    : m_name {"cmake-experiments"}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
