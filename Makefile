# Compiler
CC = g++

# librares and flags
CFLAGS = -Iinclude
LDFLAGS = -lmingw32

# Build settings
BUILD_DIR = bin
TARGET = webkit

# Source files
SRC = $(wildcard src/*.cpp)
OBJ = $(patsubst src/%.cpp, $(BUILD_DIR)/%.o, $(SRC))
EXEC = $(BUILD_DIR)/$(TARGET).exe
LIB = $(BUILD_DIR)/$(TARGET).dll

# Default target
all: $(EXEC)

# Create build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build executable
$(EXEC): $(BUILD_DIR) $(OBJ)
	$(CC) $(OBJ) -o $@ $(LDFLAGS)

# Build shared library
$(LIB): $(BUILD_DIR) $(OBJ)
	$(CC) -shared -o $@ $(OBJ) $(LDFLAGS)

# Compile source files to object files
$(BUILD_DIR)/%.o: src/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@

# Compile core source files to object files
$(BUILD_DIR)/core/%.o: src/core/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up build files
clean:
	rm -rf $(BUILD_DIR)/*.o $(BUILD_DIR)/core/*.o $(EXEC) $(LIB)

# Run the application
run: all
	./$(EXEC)

.PHONY: all clean dll

# Build shared library
dll: $(LIB)