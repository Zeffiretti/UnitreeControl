# Copyright 2024 Zeffiretti. All rights reserved.
# Usage:
# add_proto_definition(target
#   PROTO [A.proto...]
# )
#
# Protocol Buffers (Protobuf) data structures and services are described
# in a proto definition file (.proto) and compiled with protoc. The definition
# files should be grouped under a directory named "proto". The corresponding
# CMakeLists.txt should call the above add_proto_definition() for the .proto
# files directive to create an interface library.
#
# This interface library can then be used to link with other C++ targets.
# path/proto/A.proto is processed into C++ header located in build/path/proto/A.pb.h
# and source located in build/path/proto/A.pb.cc. The header should be included as
# include "path/proto/A.h", and the namespace should be properly defined inside
# the .proto file.
function(add_proto_definition target)
  find_package(Protobuf REQUIRED)

  cmake_parse_arguments("" "" "" "PROTO" ${ARGN})

  foreach(input_proto ${_PROTO})
    get_filename_component(FILE_NAME ${input_proto} NAME_WE)

    set(OUTPUT_CXX_HEADER   "${CMAKE_CURRENT_BINARY_DIR}/${FILE_NAME}.pb.h")
    set(OUTPUT_CXX_SOURCE   "${CMAKE_CURRENT_BINARY_DIR}/${FILE_NAME}.pb.cc")
    set(INPUT_PROTO_FILE    "${CMAKE_CURRENT_LIST_DIR}/${input_proto}")
    list(APPEND OUTPUT_SOURCES_CXX ${OUTPUT_CXX_HEADER} ${OUTPUT_CXX_SOURCE})

    protobuf_generate_cpp(${OUTPUT_CXX_SOURCE} ${OUTPUT_CXX_HEADER} ${INPUT_PROTO_FILE})
  endforeach()

  add_library(${target} STATIC ${OUTPUT_SOURCES_CXX})
  target_link_libraries(${target} PUBLIC ${Protobuf_LIBRARY})
  target_include_directories(${target} PUBLIC ${CMAKE_BINARY_DIR} ${Protobuf_INCLUDE_DIRS})
  set_target_properties(${target} PROPERTIES POSITION_INDEPENDENT_CODE ON)
endfunction()
