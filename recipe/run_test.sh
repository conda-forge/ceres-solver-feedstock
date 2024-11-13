set -ex

# cross-compile emulated env can't build
if [[ "${target_platform}" == "${build_platform}" ]]; then
cp examples/helloworld.cc tests/
pushd tests/
mkdir _build
pushd _build
cmake ${CMAKE_ARGS} ..
cmake --build .
./helloworld
fi
