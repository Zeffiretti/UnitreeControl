# Copyright 2024 Zeffiretti. All rights reserved.
# Usage:
# generate_resource_files(target
#   FILES
#     my_data.dat
#     data/my_data2.dat
# )
#
# Generates headers:
#   my_data.h,
#   data/my_data2.h,
# which contain:
#   static constexpr std::string_view my_data;
#   static constexpr std::string_view my_data2;
function(generate_resource_files target)
  cmake_parse_arguments("" "" "" "FILES" ${ARGN})
  add_library(${target} INTERFACE)
  foreach(file ${_FILES})
    get_filename_component(dir ${file} DIRECTORY)
    get_filename_component(var ${file} NAME_WE)
    if(dir)
      set(dst ${dir}/${var}.h)
    else()
      set(dst ${var}.h)
    endif()
    set(src ${CMAKE_CURRENT_LIST_DIR}/${file})
    add_custom_command(
      OUTPUT ${dst}
      COMMAND mkdir -p ./${dir}
      COMMAND sh -c "echo '#include <string_view>' >${dst}"
      COMMAND sh -c "echo static constexpr char ${var}_data[] = { >>${dst}"
      COMMAND sh -c "od -v -An -tx1 ${src} | sed -r 's/[^ ]+/0x&,/g' >>${dst}"
      COMMAND sh -c "echo '};' >>${dst}"
      COMMAND sh -c "echo 'static constexpr std::string_view ${var} = {${var}_data, sizeof(${var}_data)};' >>${dst}"
      DEPENDS ${src}
      VERBATIM
    )
    add_custom_target(${target}_${var} DEPENDS ${dst})
    add_dependencies(${target} ${target}_${var})
  endforeach()
  target_include_directories(${target} INTERFACE ${CMAKE_BINARY_DIR})
endfunction()
