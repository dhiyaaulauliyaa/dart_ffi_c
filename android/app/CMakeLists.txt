cmake_minimum_required(VERSION 3.4.1)  
project(monocypher VERSION 1.0.0 LANGUAGES C)
 
add_library( 
            weather
            SHARED
            ../../src/weather.c
)

add_library(monocypher
        SHARED
        ../../monocypher/crypto.c
        ../../monocypher/monocypher.c
        ../../monocypher/monocypher-ed25519.c
        )

set_target_properties(monocypher PROPERTIES
        PUBLIC_HEADER crypto.h monocypher.h monocypher-ed25519.h
        VERSION ${PROJECT_VERSION}
        SOVERSION 1
        OUTPUT_NAME "monocypher"
        )