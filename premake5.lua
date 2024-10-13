project "rlImGui"
    kind "StaticLib"
    location "vendor/rlimgui"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    language "C++"
    cppdialect "C++20"

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        dependson {"raylib"}
        links {"raylib.lib"}
        characterset ("Unicode")
        buildoptions { "/Zc:__cplusplus" }

    filter "system:windows"
        defines{"_WIN32"}
        links {"winmm", "gdi32"}
        libdirs {"bin/" .. outputdir  .. "/**"}

    links { "raylib" }

    includedirs {
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.rlImGui}"
    }
    includedirs {IncludeDir.raylib .. "/src"}
    includedirs {IncludeDir.raylib .. "/src/external"}
    includedirs {IncludeDir.raylib .. "/src/external/glfw/include"}

    vpaths 
    {
        ["Header Files"] = { "*.h"},
        ["Source Files"] = {"*.cpp"},
        ["ImGui Files"] = { 
            IncludeDir.ImGui .. "/*.h", 
            IncludeDir.ImGui ..  "/*.cpp", 
        },
    }
    files {
        IncludeDir.ImGui .. "/*.h", 
        IncludeDir.ImGui ..  "/*.cpp", 
        IncludeDir.rlImGui ..  "/*.cpp", 
        IncludeDir.rlImGui .. "/*.h", 
        IncludeDir.rlImGui .. "/extras/**.h"
    }

    defines {"IMGUI_DISABLE_OBSOLETE_FUNCTIONS","IMGUI_DISABLE_OBSOLETE_KEYIO"}
