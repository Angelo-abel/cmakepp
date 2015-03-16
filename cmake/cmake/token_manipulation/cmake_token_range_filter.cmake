
function(cmake_token_range_filter range )
  arguments_encoded_list2(1 ${ARGC})
  ans(args)
  
  cmake_token_range("${range}")
  ans_extract(current end)
  list_extract_labelled_value(args --skip)
  ans(skip)
  list_extract_labelled_value(args --take)
  ans(take)
  if("${take}_" STREQUAL "_")
    set(take -1)
  endif()
  set(result)
  while(take AND current AND NOT "${current}" STREQUAL "${end}")
    map_tryget("${current}" literal_value)
    ans(value)
    map_tryget("${current}" type)
    ans(type)

    eval_predicate(${args})
    ans(predicate_holds)

    #string(REPLACE "{type}" "${type}" current_predicate "${args}")
    #string(REPLACE "{value}" "${value}" current_predicate "${current_predicate}")
    if(predicate_holds)

      if(skip)
        math(EXPR skip "${skip} - 1")
      else()
        list(APPEND result ${current})
        if(${take} GREATER 0)
          math(EXPR take "${take} - 1")
        endif()
      endif()
    else()

    endif()
    cmake_token_advance(current)
  endwhile()
  return_ref(result)
endfunction() 


