set(CONFIG_FILE "${CMAKE_SOURCE_DIR}/PackagePath.config")
file(READ "${CONFIG_FILE}" CONFIG_CONTENT)

# 解析配置文件内容
string(REGEX MATCHALL "([^\n]+)" CONFIG_LINES "${CONFIG_CONTENT}")
foreach(LINE ${CONFIG_LINES})
    string(REGEX MATCH "([^=]+)=(.*)" _ ${LINE})
    set(${CMAKE_MATCH_1} ${CMAKE_MATCH_2})
endforeach()

#搜索pc
function(find_package_by_pkgconfig _pkgconfig_path _lib_target)
    if(NOT PKG_CONFIG_EXECUTABLE)
        set(PKG_CONFIG_EXECUTABLE $ENV{PKG_CONFIG_EXECUTABLE})
        find_package(PkgConfig MODULE REQUIRED)
    endif()
    #获取文件路径
    get_filename_component(PKG_DIRECTORY_PATH ${_pkgconfig_path} DIRECTORY)
    set(ENV{PKG_CONFIG_PATH} "${PKG_DIRECTORY_PATH}")
    get_filename_component(_real_lib_name ${_pkgconfig_path} NAME_WE)
    pkg_search_module(${_lib_target} REQUIRED ${_real_lib_name})
    if(${_lib_target}_FOUND)
        message(STATUS ${_lib_target}_FOUND)
        message(STATUS ${_lib_target}_INCLUDE_DIRS:${${_lib_target}_INCLUDE_DIRS})
        message(STATUS ${_lib_target}_LIBRARIES:${${_lib_target}_LIBRARIES})
    endif()
endfunction()
