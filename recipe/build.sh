#!/bin/sh
set -ex

# use our simpler FindSuiteSparse
cp -v "${RECIPE_DIR}/FindSuiteSparse.cmake" cmake/

mkdir build_ && cd build_

if [[ ! -z "${cuda_compiler_version+x}" && "${cuda_compiler_version}" != "None" ]]
  then
    EXTRA_CMAKE_ARGS="-DCMAKE_CUDA_ARCHITECTURES=all -DUSE_CUDA=ON"
  else
    EXTRA_CMAKE_ARGS="-DUSE_CUDA=OFF"
fi

cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBLA_VENDOR="Generic" \
  -DACCELERATESPARSE=OFF \
  -DSUITESPARSE=OFF \
  -DBUILD_SHARED_LIBS=ON \
  -DBUILD_EXAMPLES=OFF \
  -DBUILD_TESTING=OFF \
  ${EXTRA_CMAKE_ARGS} \
  ..
make install -j${CPU_COUNT}
