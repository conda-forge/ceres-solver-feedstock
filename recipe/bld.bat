COPY "%RECIPE_DIR%\FindSuiteSparse.cmake" cmake

set EXTRA_CMAKE_ARGS=""
if NOT "%cuda_compiler_version%"=="None" (
    set EXTRA_CMAKE_ARGS="-DCMAKE_CUDA_ARCHITECTURES=all"
    set CUDA_ENABLED=ON
) else (
    set CUDA_ENABLED=OFF
)

cmake -G "NMake Makefiles" ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DUSE_CUDA=%CUDA_ENABLED% ^
    -DBLA_VENDOR=Generic ^
    -DSUITESPARSE=OFF ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_EXAMPLES=OFF ^
    -DBUILD_TESTING=OFF ^
    %EXTRA_CMAKE_ARGS% ^
    -B build_ .
if errorlevel 1 exit 1

cmake --build build_ --config Release --target install
if errorlevel 1 exit 1
