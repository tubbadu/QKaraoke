# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.27

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/tubbadu/code/Qt/QKaraoke

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tubbadu/code/Qt/QKaraoke/build

# Utility rule file for appQKaraoke_qmllint_module.

# Include any custom commands dependencies for this target.
include CMakeFiles/appQKaraoke_qmllint_module.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appQKaraoke_qmllint_module.dir/progress.make

CMakeFiles/appQKaraoke_qmllint_module: /usr/lib/qt6/bin/qmllint
CMakeFiles/appQKaraoke_qmllint_module: /home/tubbadu/code/Qt/QKaraoke/Main.qml
	cd /home/tubbadu/code/Qt/QKaraoke && /usr/lib/qt6/bin/qmllint -I /home/tubbadu/code/Qt/QKaraoke/build -I /usr/lib/qt6/qml --resource /home/tubbadu/code/Qt/QKaraoke/build/.rcc/qmake_QKaraoke.qrc --resource /home/tubbadu/code/Qt/QKaraoke/build/.rcc/appQKaraoke_raw_qml_0.qrc --module QKaraoke

appQKaraoke_qmllint_module: CMakeFiles/appQKaraoke_qmllint_module
appQKaraoke_qmllint_module: CMakeFiles/appQKaraoke_qmllint_module.dir/build.make
.PHONY : appQKaraoke_qmllint_module

# Rule to build all files generated by this target.
CMakeFiles/appQKaraoke_qmllint_module.dir/build: appQKaraoke_qmllint_module
.PHONY : CMakeFiles/appQKaraoke_qmllint_module.dir/build

CMakeFiles/appQKaraoke_qmllint_module.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appQKaraoke_qmllint_module.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appQKaraoke_qmllint_module.dir/clean

CMakeFiles/appQKaraoke_qmllint_module.dir/depend:
	cd /home/tubbadu/code/Qt/QKaraoke/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tubbadu/code/Qt/QKaraoke /home/tubbadu/code/Qt/QKaraoke /home/tubbadu/code/Qt/QKaraoke/build /home/tubbadu/code/Qt/QKaraoke/build /home/tubbadu/code/Qt/QKaraoke/build/CMakeFiles/appQKaraoke_qmllint_module.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/appQKaraoke_qmllint_module.dir/depend
