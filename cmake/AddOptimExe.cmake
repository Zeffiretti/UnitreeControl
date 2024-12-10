# Copyright 2023 Zeffiretti. All rights reserved.
macro(add_optim_eigen_exe name)
  message(STATUE "add_optim_exe ${name} with ${ARGN}")
  add_executable(${name} ${ARGN})
  target_include_directories(${name} PUBLIC
    ${OPTIMKIT_INCLUDE_DIRS}
  )
  target_link_libraries(${name} PUBLIC
    eigen
    optim
  )
  target_compile_definitions(${name} PRIVATE
    OPTIM_ENABLE_EIGEN_WRAPPERS=1
  )
endmacro(add_optim_eigen_exe)

macro(add_optim_arma_exe name)
  message(STATUE "add_optim_exe ${name} with ${ARGN}")
  add_executable(${name} ${ARGN})

  if (APPLE OR UNIX)
    set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:$ENV{HOME}/.local/lib/pkgconfig")
    list(APPEND CMAKE_PREFIX_PATH "$ENV{HOME}/.local")
  endif()
  find_package(Armadillo REQUIRED)
  find_package(BLAS REQUIRED)
  target_link_libraries(${name} PUBLIC
    ${ARMADILLO_LIBRARIES})
  target_include_directories(${name} PUBLIC
    ${ARMADILLO_INCLUDE_DIRS}
  )
  target_include_directories(${name} PUBLIC
    ${OPTIMKIT_INCLUDE_DIRS}
  )
  target_link_libraries(${name} PUBLIC
    optim
    ${ARMADILLO_LIBRARIES}
    ${BLAS_LIBRARIES}
  )
  target_compile_definitions(${name} PRIVATE
    OPTIM_ENABLE_ARMA_WRAPPERS=1
  )
endmacro(add_optim_arma_exe)

