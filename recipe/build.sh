#!/bin/sh
set -ex

# use our simpler FindSuiteSparse
cp -v "${RECIPE_DIR}/FindSuiteSparse.cmake" cmake/

mkdir build_ && cd build_

cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON -DCMAKE_MACOSX_RPATH=ON \
  -DBLA_VENDOR="Generic" \
  -DACCELERATESPARSE=OFF \
  -DBUILD_SHARED_LIBS=ON \
  -DBUILD_EXAMPLES=OFF \
  -DBUILD_TESTING=OFF \
  -DLIB_SUFFIX="" \
  ..
make install -j${CPU_COUNT}
