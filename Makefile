# Commands:
# ---------------------------------------------------------------
# 	build 		: build lib objects and test file for testing 
# 	release 	: build lib objects, archive and organize the lib files for use in the 'dist/' folder
# 	dist 		: dist just organizes the lib files for use in the 'dist/' folder
# 	clear 		: clear compiled executables
# 	install  	: installs binaries, includes and libs to the specified "INSTALL_" path variables
# 	label  		: update the author, year and version using sed in the specified files 
# 	mem  		: runs valgrind on the test binary 
# 	doc  		: runs doxygen and generate output on /docs folder 

# Configuration -------------------------------------------------

CC=gcc
C_FLAGS=-fpic -Wall -Wpedantic
C_FLAGS_RELEASE=-O2
C_FLAGS_DEBUG=-g
I_FLAGS=-Isrc
L_FLAGS=
L_FLAGS=-lpq

AR=ar
AR_FLAGS=-rcs
SRC_DIR=src
BUILD_DIR=build
DIST_DIR=dist
DOC_DIR=docs

PROGRAM=test

AUTHOR=João Peterson Scheffer
YEAR=2024
VERSION=1.0.0

# Sources -------------------------------------------------------

SRCS:=
SRCS+=tests.c
SRCS+=src/hash.c
SRCS+=src/flood_fill.c
SRCS+=src/matrix.c
SRCS+=src/string+.c
SRCS+=src/number.c
SRCS+=src/db.c
SRCS+=src/data.c
SRCS+=src/linalg.c

# File recipes --------------------------------------------------

OBJS:=$(SRCS:.c=.o);

.PHONY : build clear build_dir dist_dir dist

build : C_FLAGS += $(C_FLAGS_DEBUG)
build : build_dir $(PROGRAM)

release : C_FLAGS += $(C_FLAGS_RELEASE)
release : build_dir $(PROGRAM) dist doc

# tests : test.o $(STCLIB)
# 	$(CC) $(L_FLAGS) $(addprefix $(BUILD_DIR)/, $(notdir $^)) -o $@

# dist : 
# 	@mkdir -p $(DIST_DIR)
# 	@cp -vr $(BUILD_DIR)/*.so $(DIST_DIR)/ 
# 	@cp -vr $(BUILD_DIR)/*.a $(DIST_DIR)/ 
# 	@cp -vr $(SRC_DIR)/*.h $(DIST_DIR)/ 

$(PROGRAM) : $(OBJS)
	$(CC) $(L_FLAGS) $(addprefix $(BUILD_DIR)/, $(notdir $^)) -o $@ 

%.o : %.c
	$(CC) $(C_FLAGS) $(I_FLAGS) -c $^ -o $(addprefix $(BUILD_DIR)/, $(notdir $@))

build_dir : 
	@mkdir -p $(BUILD_DIR)

clear : 
	@rm -vrdf $(BUILD_DIR)
	@rm -vrdf $(DIST_DIR)
	@rm -vf *.exe
	@rm -vf *.o
	@rm -vf tests

mem :
	valgrind -s --leak-check=full --show-leak-kinds=all --track-origins=yes ./tests
# valgrind --tool=callgrind $(TEST_EXE)

doc : dist
	doxygen -q $(DOC_DIR)/Doxyfile
 
