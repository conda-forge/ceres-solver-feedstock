# simpler FindSuiteSparse using SuiteSparse's own cmake config
# ceres has to deal with a lot we don't,
# specifically old versions and static libraries.

find_package(SuiteSparse_config REQUIRED)
find_package(CHOLMOD REQUIRED)
find_package(SPQR REQUIRED)

set(SuiteSparse_FOUND TRUE)
set(SuiteSparse_VERSION ${SuiteSparse_config_VERSION})

# look for suitesparse metis link
# skip? this is always True on conda-forge
include (CheckSymbolExists)
include (CMakePushCheckState)

cmake_push_check_state (RESET)
set (CMAKE_REQUIRED_LIBRARIES SuiteSparse::CHOLMOD)
check_symbol_exists (cholmod_metis cholmod.h SuiteSparse_CHOLMOD_USES_METIS)
cmake_pop_check_state ()

if (SuiteSparse_CHOLMOD_USES_METIS)
  add_library(SuiteSparse::Partition IMPORTED INTERFACE)
  set(SuiteSparse_Partition_FOUND TRUE)
else()
  set(SuiteSparse_Partition_FOUND FALSE)
endif()
