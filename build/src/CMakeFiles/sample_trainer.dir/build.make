# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kawhicurry/Desktop/robocup/helios-base

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kawhicurry/Desktop/robocup/helios-base/build

# Include any dependencies generated for this target.
include src/CMakeFiles/sample_trainer.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/sample_trainer.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/sample_trainer.dir/flags.make

src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o: src/CMakeFiles/sample_trainer.dir/flags.make
src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o: ../src/sample_trainer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kawhicurry/Desktop/robocup/helios-base/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o"
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o -c /home/kawhicurry/Desktop/robocup/helios-base/src/sample_trainer.cpp

src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_trainer.dir/sample_trainer.cpp.i"
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kawhicurry/Desktop/robocup/helios-base/src/sample_trainer.cpp > CMakeFiles/sample_trainer.dir/sample_trainer.cpp.i

src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_trainer.dir/sample_trainer.cpp.s"
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kawhicurry/Desktop/robocup/helios-base/src/sample_trainer.cpp -o CMakeFiles/sample_trainer.dir/sample_trainer.cpp.s

src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.requires:

.PHONY : src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.requires

src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.provides: src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.requires
	$(MAKE) -f src/CMakeFiles/sample_trainer.dir/build.make src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.provides.build
.PHONY : src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.provides

src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.provides.build: src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o


src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o: src/CMakeFiles/sample_trainer.dir/flags.make
src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o: ../src/main_trainer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kawhicurry/Desktop/robocup/helios-base/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o"
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/sample_trainer.dir/main_trainer.cpp.o -c /home/kawhicurry/Desktop/robocup/helios-base/src/main_trainer.cpp

src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_trainer.dir/main_trainer.cpp.i"
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kawhicurry/Desktop/robocup/helios-base/src/main_trainer.cpp > CMakeFiles/sample_trainer.dir/main_trainer.cpp.i

src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_trainer.dir/main_trainer.cpp.s"
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kawhicurry/Desktop/robocup/helios-base/src/main_trainer.cpp -o CMakeFiles/sample_trainer.dir/main_trainer.cpp.s

src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.requires:

.PHONY : src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.requires

src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.provides: src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.requires
	$(MAKE) -f src/CMakeFiles/sample_trainer.dir/build.make src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.provides.build
.PHONY : src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.provides

src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.provides.build: src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o


# Object files for target sample_trainer
sample_trainer_OBJECTS = \
"CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o" \
"CMakeFiles/sample_trainer.dir/main_trainer.cpp.o"

# External object files for target sample_trainer
sample_trainer_EXTERNAL_OBJECTS =

src/sample_trainer: src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o
src/sample_trainer: src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o
src/sample_trainer: src/CMakeFiles/sample_trainer.dir/build.make
src/sample_trainer: /usr/local/lib/librcsc.so
src/sample_trainer: /usr/lib/x86_64-linux-gnu/libboost_system.so
src/sample_trainer: /usr/lib/x86_64-linux-gnu/libz.so
src/sample_trainer: src/CMakeFiles/sample_trainer.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/kawhicurry/Desktop/robocup/helios-base/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable sample_trainer"
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sample_trainer.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/sample_trainer.dir/build: src/sample_trainer

.PHONY : src/CMakeFiles/sample_trainer.dir/build

src/CMakeFiles/sample_trainer.dir/requires: src/CMakeFiles/sample_trainer.dir/sample_trainer.cpp.o.requires
src/CMakeFiles/sample_trainer.dir/requires: src/CMakeFiles/sample_trainer.dir/main_trainer.cpp.o.requires

.PHONY : src/CMakeFiles/sample_trainer.dir/requires

src/CMakeFiles/sample_trainer.dir/clean:
	cd /home/kawhicurry/Desktop/robocup/helios-base/build/src && $(CMAKE_COMMAND) -P CMakeFiles/sample_trainer.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/sample_trainer.dir/clean

src/CMakeFiles/sample_trainer.dir/depend:
	cd /home/kawhicurry/Desktop/robocup/helios-base/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kawhicurry/Desktop/robocup/helios-base /home/kawhicurry/Desktop/robocup/helios-base/src /home/kawhicurry/Desktop/robocup/helios-base/build /home/kawhicurry/Desktop/robocup/helios-base/build/src /home/kawhicurry/Desktop/robocup/helios-base/build/src/CMakeFiles/sample_trainer.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/sample_trainer.dir/depend
