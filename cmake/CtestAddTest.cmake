# Copyright 2024 Zeffiretti. All rights reserved.
# Convenience function for adding tests.
# ctest_add_test(<target>
#   SRCS <source1> [<source2>...]
#   DEPS <lib1> [<lib2>...]
# )
#
# Usage:
# ctest_add_test(fan_control_test SRCS fan_control_test.cc fan_control.cc DEPS gtest_main)
function(ctest_add_test target)
  if(NOT BUILD_TESTING)
    return()
  endif()

  cmake_parse_arguments(TEST "" "" "SRCS;DEPS" ${ARGN})
  if(NOT target)
    message(FATAL_ERROR "You must provide a target!")
  endif()
  if(NOT TEST_SRCS)
    message(FATAL_ERROR "You must provide sources!")
  endif()
  if(NOT TEST_DEPS)
    message(FATAL_ERROR "You must provide dependencies, at least gtest_main!")
  endif()

  add_executable(${target} "")
  target_sources(${target} PRIVATE ${TEST_SRCS})
  target_include_directories(${target} PRIVATE ${ROBOTICS_INCLUDE_DIR})
  target_link_libraries(${target} PRIVATE ${TEST_DEPS})
  add_test(${target} ${target})
endfunction(ctest_add_test)

