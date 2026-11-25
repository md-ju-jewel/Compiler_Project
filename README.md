# Roman Numeral Calculator Compiler

## Project Overview
A small Roman Numeral Calculator Compiler built for the Compiler Design Lab using Flex, Bison, and C. It accepts arithmetic expressions with Roman numeral operands, evaluates the expression, and prints the result as both an integer and a Roman numeral.

## Implemented Features
- Roman numeral operands (I, V, X, L, C, D, M) with standard-form validation
- Arithmetic operations: addition (+), subtraction (-), multiplication (*)
- Parentheses for grouping expressions
- Operator precedence: multiplication is evaluated before addition/subtraction
- Token listing mode using the `-tokens` option
- Syntax and lexical error reporting

## Requirements / Tools
- GCC (MinGW)
- Flex
- Bison
- Windows Command Prompt (CMD)

## Files
- `lexer.l` — Flex lexer: recognizes tokens and validates Roman numeral strings
- `parser.y` — Bison grammar and arithmetic evaluation rules
- `main.c` — Program entry point and command-line option handling
- `roman.c` — Roman numeral conversion functions
- `roman.h` — Function declarations for Roman numeral conversion
- `input.txt` — Input expression file (create this file to run a calculation)

## Build Instructions (Windows CMD)
Run the following commands from the project folder:

```cmd
bison -d parser.y
flex lexer.l
gcc parser.tab.c lex.yy.c main.c roman.c -o compiler.exe
```

If Bison needs the package data path in your current setup, set it first in that CMD session:

```cmd
set BISON_PKGDATADIR=C:/PROGRA~2/GnuWin32/share/bison
```

## Run a Calculation
1. Create or edit `input.txt` and enter one expression, for example: `X + IV * II`
2. Save the file.
3. Run:

```cmd
compiler.exe input.txt
```

Expected calculation: `10 + (4 * 2) = 18`, Roman result `XVIII`.

## Token Listing
Run:

```cmd
compiler.exe -tokens input.txt
```

This prints the token names and their lexemes.

## Current Limitations
- The current grammar accepts one expression (or one `print` expression ending in a semicolon) per input.
- Supported arithmetic operators are `+`, `-`, and `*`; division is not implemented.
- Variables, assignments, arrays, functions, and symbol-table handling are not implemented yet.
- Roman numeral results must be within 1–3999 to be represented; other results are printed as `Invalid` in Roman form.

## Team
Add your group members' names and IDs here before submission.


## Course
Compiler Design Lab — Roman Numeral Calculator Compiler
