#include <string>

#include "cmake-experiments/cmake-experiments.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("cmake-experiments") == exported.name() ? 0 : 1;
}
