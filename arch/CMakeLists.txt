if(${CMAKE_SYSTEM_PROCESSOR} MATCHES "^x86(_64)?$")
    # If we're building for an x86 compatible PC, add the x86 related libraries
    add_subdirectory(x86)
else()
    message(FATAL_ERROR "Unsupported architecture set for CMAKE_SYSTEM_PROCESSOR(${CMAKE_SYSTEM_PROCESSOR})")
endif()