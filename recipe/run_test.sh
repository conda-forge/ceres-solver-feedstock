set -ex

cp examples/helloworld.cc tests/
pushd tests/
mkdir _build
pushd _build
cmake ${CMAKE_ARGS} ..
cmake --build .
./helloworld
