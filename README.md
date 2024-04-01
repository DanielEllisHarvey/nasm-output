# nasm-output
A group of nasm code snippets for outputting numbers in different formats

Feel free to use this in any projects if it seems useful!

## Build and run (Linux)
hex64:
```
nasm -f elf64 hex64.asm
ld hex64.o -o hex64
./hex64
```

bin64:
```
nasm -f elf64 bin64.asm
ld bin64.o -o bin64
./bin64
```
This code is specific to Linux
