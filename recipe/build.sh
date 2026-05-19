#!/bin/sh
set -ex

# use our simpler FindSuiteSparse
cp -v "${RECIPE_DIR}/FindSuiteSparse.cmake" cmake/

if [[ ! -z "${cuda_compiler_version+x}" && "${cuda_compiler_version}" != "None" ]]
  then
    EXTRA_CMAKE_ARGS="-DCMAKE_CUDA_ARCHITECTURES=all -DUSE_CUDA=ON"
  else
    EXTRA_CMAKE_ARGS="-DUSE_CUDA=OFF"
fi

if [[ "${dep_license_family}" == "gpl" ]]; 
  then
    EXTRA_CMAKE_ARGS="${EXTRA_CMAKE_ARGS} -DSUITESPARSE=ON"
  else
    EXTRA_CMAKE_ARGS="${EXTRA_CMAKE_ARGS} -DSUITESPARSE=OFF"
fi

cmake ${CMAKE_ARGS} -G Ninja -LAH \
  -DBLA_VENDOR="Generic" \
  -DACCELERATESPARSE=OFF \
  -DBUILD_SHARED_LIBS=ON \
  -DBUILD_EXAMPLES=OFF \
  -DBUILD_TESTING=OFF \
  ${EXTRA_CMAKE_ARGS} \
  -DCMAKE_UNITY_BUILD=ON \
  -B build_ .
cmake --build build_ --target install --parallel ${CPU_COUNT}
