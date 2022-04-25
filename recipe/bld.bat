mkdir build_ && cd build_

set CL=/DNOMINMAX=1 %CL%

cmake -G "NMake Makefiles" ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_EXAMPLES=OFF ^
    -DBUILD_TESTING=OFF ^
    ..
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1
