
 function(template_cmakepp_function_list )
    set(function_list)
    foreach(file ${ARGN})
      cmake_script_parse_file(${file} --first-function-header)
      ans(function_def)
      assign(function_name = function_def.function_args[0])
      set(function_list "${function_list}\n* [${function_name}](#${function_name})")
    endforeach()
    return_ref(function_list)
 endfunction()

 function(template_cmakepp_function_descriptions)
    set(res)
    foreach(template_path ${ARGN})
        fread("${template_path}")
        ans(content)
        cmake_script_comment_header("${content}")
        ans(comments)
        cmake_script_parse("${content}" --first-function-header)
        ans(function_def)
        assign(function_name = function_def.function_args[0])
        get_filename_component(template_dir "${template_path}" PATH)
        pushd("${template_dir}")
          template_eval("${comments}")
          ans(comments)
        popd()
        set(res "${res}## <a name=\"${function_name}\"></a> `${function_name}`\n\n${comments}\n\n\n\n")
    endforeach()

    return_ref(res)
 endfunction()