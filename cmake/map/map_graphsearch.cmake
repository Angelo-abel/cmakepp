function(map_graphsearch)
	set(options)
  	set(oneValueArgs SUCCESSORS VISIT PUSH POP)
  	set(multiValueArgs)
  	set(prefix)
  	cmake_parse_arguments("${prefix}" "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  	#_UNPARSED_ARGUMENTS
  	# setup functions




  	if(NOT _SUCCESSORS)		
		function(gs_successors result node)
			#ref_isvalid(${node} isref)
			map_isvalid( ${node} ismap)
			list_isvalid(${node} islist )
			set(res)
			if(ismap)
				map_keys(${node} keys)
				map_values(${node} res ${keys})
			elseif(islist)
				list_values(${node} values)
			endif()
			set(${result} "${res}" PARENT_SCOPE)
		endfunction()
	else()
		import_function("${_SUCCESSORS}" as gs_successors)
	endif()
	
	if(NOT _VISIT)
		function(gs_visit cancel value)
		endfunction()
	else()
		import_function("${_VISIT}" as gs_visit)
	endif()

	if(NOT _POP)
		function(gs_pop result)
			set(node)
			peek_back(__gs node)
			if(NOT node)
				set(${result} PARENT_SCOPE)
				return()
			endif()
			pop_back(__gs node)
			set(${result} "${node}" PARENT_SCOPE)
		endfunction()
	else()
		import_function("${_POP}" as gs_pop)
	endif()

	if(NOT _PUSH)
		function(gs_push node)
			push_back(__gs ${node})
		endfunction()
	else()
		import_function("${_PUSH}" as gs_push)
	endif()

	# start of algorithm

	# add initial nodes to container
	foreach(node ${_UNPARSED_ARGUMENTS})
		gs_push(${node})
	endforeach()

	# iterate as long as there are nodes to visit
	while(true)
		set(current)
		# get first node
		gs_pop(current)
		if(NOT current)
			break()
		endif()

		set(cancel false)
		# visit node 
		# if cancel is set to true do not add successors
		gs_visit(cancel ${current})
		if(NOT cancel)
			gs_successors(successors ${current})
			foreach(successor ${successors})
				gs_push(${successor})
			endforeach()
		endif()
	endwhile()
endfunction()