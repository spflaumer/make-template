.ONESHELL:
.DELETE_ON_ERROR:

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

OBJ_DIR ?= obj
SRC_DIR ?= src
INC_DIR ?= $(SRC_DIR)/include
EXE ?= main

CC ?= clang
LD ?= ld.lld
CFLAGS += -I$(INC_DIR)
#CFLAGS +=  # uncomment this line and add your own flags here
LDFLAGS +=  # add needed libraries here

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

all: $(EXE)
	@-chmod a+x ./$(EXE)
	@-./$(EXE)

$(EXE): $(OBJS)
	@-echo "creating $@"
	@$(CC) $(LDFLAGS) $^ -o $@  # Create the target '$@' ('EXE') by linking the prerequisites '$^' (all prerequisites; 'OBJS')

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@-echo "creating object $<"
	@$(CC) $(CFLAGS) -c $< -o $@  # Create the target '$@' ('OBJS') by compiling the prerequisites '$<' (file-by-file; 'SRCS')

$(OBJ_DIR):
	@-mkdir -p $(OBJ_DIR)
