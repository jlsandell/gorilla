-- This is a very hacky premake3 script to build Gorilla's examples on Linux based systems.

-- Some global defaults for all packages.

-- Defines for debug builds
debug_defines = { "DEBUG", "_DEBUG" }

-- Where to stick the debug object files
debug_objdir = "obj/debug"

-- Where to stick release object files
release_objdir = "obj/release"

-- Global default build options
buildoptions = {
    "`pkg-config OGRE --cflags`" ..
    "`pkg-config OIS --cflags`" 
}

-- Global default link options
linkoptions = {
    "`pkg-config OGRE --libs`" ..
    "`pkg-config OIS --libs`" 
}

-- Debug specific build options
debug_buildoptions  = { "-O0", "-Wall" }

-- Release specific build options
release_buildoptions = { "-O3", "-Wall" }


includepaths = {
    --"./include",
    "../",
    "../extensions/"
}

-- paths to find libraries
libpaths = {}

-- libraries to link to
links = {}

-- Configurations to use
package_configs = { "Release", "Debug"}

dejavu_gorilla = "dejavu.gorilla"
dejavu_png = "dejavu.png"

-- commands to be run after building a package.
postbuildcommands = {"test -e " .. dejavu_gorilla .. " || ln -s ../dejavu.gorilla", "test -e " .. dejavu_png .. " || ln -s ../dejavu.png" }


project.name = "gorilla"
project.bindir = "bin"

-- Package configuration for ogreconsole example.

ogreconsole = newpackage()

ogreconsole.name = "gorilla_ogreconsole"
ogreconsole.kind = "exe"
ogreconsole.language = "c++"
ogreconsole.configs = package_configs
ogreconsole.postbuildcommands = postbuildcommands

ogreconsole.includepaths = includepaths
ogreconsole.libpaths = libpaths
ogreconsole.links = links

-- pkg-configable build data.
if (linux) then
    ogreconsole.buildoptions = buildoptions
    ogreconsole.linkoptions = linkoptions
end


-- Files to compile
ogreconsole.files = {
    matchfiles("../extentions/*.h", "../extensions/*.cpp"),
    matchfiles("gorilla_ogreconsole.*"),
    matchfiles("../*.h", "../*.cpp")
}

-- Debug configuration
ogreconsole_debug = ogreconsole.config["Debug"]
ogreconsole_debug.defines = debug_defines
ogreconsole_debug.objdir = debug_objdir
ogreconsole_debug.target = "debug/" .. ogreconsole.name .. "_d"
ogreconsole_debug.buildoptions = debug_buildoptions

-- Release configuration
ogreconsole_release = ogreconsole.config["Release"]
ogreconsole_release.objdir = release_objdir
ogreconsole_release.target = "release/" .. ogreconsole.name
ogreconsole_release.buildoptions = release_buildoptions




-- Package configuration for 3d example.
gorilla_3d = newpackage()
gorilla_3d.name = "gorilla_3d"
gorilla_3d.kind = "exe"
gorilla_3d.language = "c++"
gorilla_3d.configs = package_configs
gorilla_3d.postbuildcommands = postbuildcommands

gorilla_3d.includepaths = includepaths
gorilla_3d.libpaths = libpaths
gorilla_3d.links = links

if (linux) then
    gorilla_3d.buildoptions = buildoptions
    gorilla_3d.linkoptions = linkoptions
end


gorilla_3d.files = {
    matchfiles("../extentions/*.h", "../extensions/*.cpp"),
    matchfiles("gorilla_3d.*"),
    matchfiles("../*.h", "../*.cpp")
}


gorilla_3d_debug = gorilla_3d.config["Debug"]
gorilla_3d_debug.defines = debug_defines
gorilla_3d_debug.objdir = debug_objdir
gorilla_3d_debug.target = "debug/" .. gorilla_3d.name .. "_d"

gorilla_3d_release = gorilla_3d.config["Release"]
gorilla_3d_release.objdir = release_objdir
gorilla_3d_release.target = "release/" .. gorilla_3d.name
gorilla_3d_release.buildoptions = release_buildoptions


-- Package configuration for playpen example.
--playpen = newpackage()
--playpen.name = "gorilla_playpen"
--playpen.kind = "exe"
--playpen.language = "c++"
--playpen.configs = package_configs
--
--playpen.postbuildcommands = postbuildcommands
--playpen.includepaths = includepaths
--playpen.libpaths = libpaths
--playpen.links = links
--
--if (linux) then
--    -- being lazy here and just copying the first example's options
--    playpen.buildoptions = buildoptions
--    playpen.linkoptions = linkoptions 
--end
--
--playpen.files = {
--    matchfiles("../extentions/*.h", "../extensions/*.cpp"),
--    matchfiles("gorilla_playpen.*"),
--    matchfiles("../*.h", "../*.cpp")
--}
--
--
--playpen_debug = playpen.config["Debug"]
--playpen_debug.defines = debug_defines
--playpen_debug.objdir = debug_objdir
--playpen_debug.target = "debug/" .. playpen.name .. "_d"
--
--playpen_release = playpen.config["Release"]
--playpen_release.objdir = release_objdir
--playpen_release.target = "release/" .. playpen.name
--playpen_release.buildoptions = release_buildoptions
