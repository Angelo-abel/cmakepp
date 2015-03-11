function(test)

  macro(project_cmake_constants)
    set(project_cmake_module_dir "cmake")
    set(project_cmake_module_include_dir "include")
  endmacro()
  



  mock_package_source(mock "A {cmake:{module:{include_dirs:'include',add_as_subdirectory:'true'}}}" B "A=>B")
  ans(package_source)
  project_open()
  ans(project)
  assign(!project.project_descriptor.package_source = package_source)


  project_install(${project} A)


  assert(EXISTS "${test_dir}/cmake/FindA.cmake")
  fread(cmake/FindA.cmake)
  ans(dta)
  _message("${dta}")

endfunction()