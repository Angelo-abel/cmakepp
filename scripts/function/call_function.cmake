function(call_function func)
	check_function("${func}")
	import_function("${func}" as function_to_call REDEFINE )
	scope_begin_watch()
	function_to_call(${ARGN})
	scope_end_watch(returned_values)
	#map_print(${returned_values})
	scope_elevate_values(${returned_values})
	map_delete(${returned_values})
	#check_function("${func}")
	#import_function("${func}" as function_to_call REDEFINE )
	#function_to_call(${ARGN})
endfunction()