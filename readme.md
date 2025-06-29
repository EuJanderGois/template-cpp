# Project

Template de projeto `C++`.

## Requisitos

- MSYS2
- Git
  
## Como usar

1. Clone este repositório:
    ``` bash
    git clone https://github.com/EuJanderGois/template-cpp.git
    ```
2. Abra o `MSYS - MinGW` no diretório atual.
    ``` bash
    cd /path/to/project
    ```
3. Faça o build inicial.
    ``` bash
    make && make run
    ```
4. Caso necessário realize as adaptações necessarias em `Makefile`.

``` makefile
# Compilador - caso o projeto seja em C utilize 'gcc'.
CC = g++

# Flags de inclusão e dependência.
# Utilize o pacman para intalação de dependências.
# pacman -S <pacote>
CFLAGS = -Iinclude
LDFLAGS = -lmingw32

# Build settings
BUILD_DIR = bin # diretório de saída
TARGET = webkit # nome do executável

# Source files
# Arquivos fonte.
# Caso o projeto tenha outras 
# pastas além de src ou dentro de 
# src adicione aqui
# SRC = $(wildcard src/*.cpp) (wildcard src/myLib/*.cpp)
SRC = $(wildcard src/*.cpp)
OBJ = $(patsubst src/%.cpp, $(BUILD_DIR)/%.o, $(SRC))
EXEC = $(BUILD_DIR)/$(TARGET).exe # formato de saída
LIB = $(BUILD_DIR)/$(TARGET).dll # formato para biblioteca dinamica

# Abaixo apenas altere se souber o que está fazendo.

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
	rm -rf $(BUILD_DIR)/*.o $(EXEC) $(LIB)

# Run the application
run: all
	./$(EXEC)

.PHONY: all clean dll

# Build shared library
dll: $(LIB)
```

> Os passos devem funcionar em qualquer plataforma e em caso de problemas registre uma `issue` no repositório.
