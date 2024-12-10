# Copyright 2024 Zeffiretti. All rights reserved.
list(APPEND OPTIMKIT_GCC_FLAGS
  "-Wall"
  "-Wextra"
  "-Wcast-qual"
  "-Wconversion-null"
  "-Wformat-security"
  "-Wmissing-declarations"
  "-Woverlength-strings"
  "-Wpointer-arith"
  "-Wundef"
  "-Wunused-local-typedefs"
  "-Wunused-result"
  "-Wvarargs"
  "-Wvla"
  "-Wwrite-strings"
  "-DNOMINMAX"
  "-fvisibility=hidden"
  "-fvisibility-inlines-hidden"
)

list(APPEND OPTIMKIT_LLVM_FLAGS
  "-Wall"
  "-Wextra"
  "-Wcast-qual"
  "-Wconversion"
  "-Wfloat-overflow-conversion"
  "-Wfloat-zero-conversion"
  "-Wfor-loop-analysis"
  "-Wformat-security"
  "-Wgnu-redeclared-enum"
  "-Winfinite-recursion"
  "-Winvalid-constexpr"
  "-Wliteral-conversion"
  "-Wmissing-declarations"
  "-Woverlength-strings"
  "-Wpointer-arith"
  "-Wself-assign"
  "-Wshadow-all"
  "-Wstring-conversion"
  "-Wtautological-overlap-compare"
  "-Wundef"
  "-Wuninitialized"
  "-Wunreachable-code"
  "-Wunused-comparison"
  "-Wunused-local-typedefs"
  "-Wunused-result"
  "-Wvla"
  "-Wwrite-strings"
  "-Wno-float-conversion"
  "-Wno-implicit-float-conversion"
  "-Wno-implicit-int-float-conversion"
  "-Wno-implicit-int-conversion"
  "-Wno-shorten-64-to-32"
  "-Wno-sign-conversion"
  "-Wno-unknown-warning-option"
  "-DNOMINMAX"
  "-fvisibility=hidden"
  "-fvisibility-inlines-hidden"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  set(OPTIMKIT_DEFAULT_COPTS "${OPTIMKIT_GCC_FLAGS}")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set(OPTIMKIT_DEFAULT_COPTS "${OPTIMKIT_LLVM_FLAGS}")
endif()

