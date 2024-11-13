cmake_minimum_required(VERSION 3.27)

project(CeresTest LANGUAGES C CXX)

find_package(Ceres REQUIRED)

add_executable(helloworld helloworld.cc)
target_link_libraries(helloworld PRIVATE Ceres::ceres)
