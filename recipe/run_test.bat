copy examples/helloworld.cc tests/
cd tests
mkdir build_
cd build_

cmake -G "NMake Makefiles" ^
    %CMAKE_ARGS% ^
    ..
if errorlevel 1 exit 1

cmake --build .
if errorlevel 1 exit 1

.\helloworld
if errorlevel 1 exit 1
