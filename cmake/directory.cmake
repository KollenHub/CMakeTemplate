function(get_direct_subdirectories base_dir result_var)
    # 获取当前目录中的所有文件或文件夹
    file(GLOB entries RELATIVE ${base_dir} ${base_dir}/*)

    set(subdirectories "")

    foreach(entry ${entries})
        if(IS_DIRECTORY "${base_dir}/${entry}")
            list(APPEND subdirectories "${base_dir}/${entry}")
        endif()
    endforeach()

    # 返回直接子文件夹
    set(${result_var} ${subdirectories} PARENT_SCOPE)
endfunction()