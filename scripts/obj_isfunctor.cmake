# returns true if passed ref is a functor
# that means ref is an object, has the member __call__
# and __call__ is a function
function(obj_isfunctor result ref)
	is_object(res ${ref})
	if(NOT res)
		return_value(false)
	endif()
	obj_has(${ref} res "__call__")
	if(NOT res)
		return_value(false)
	endif()
	obj_get(${ref} res "__call__")
	is_function(res "${res}")
	if(NOT res)
		return_value(false)
	endif()
	return_value(true)
endfunction()