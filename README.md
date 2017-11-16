# ajafer-Swift-Kaleidoscope
An interpreter written in Swift for the 'toy language' Kaleidoscope (see http://llvm.org/docs/tutorial/LangImpl02.html)

## Example of tokenization

We use our Lexer object in the following way: (With Kaliedoscope code as input)
```swift
        let tokens = Lexer(input: "extern sqrt(n); def foo(n) (n * sqrt(n * 200) + 57 * n % 2);").lex()
        print("Found: \(tokens.count) tokens.")
        print(tokens)
```

Output of Lexer:

```
Found: 28 tokens.
[
SwiftCompiler.Token.extern, 
SwiftCompiler.Token.identifier("sqrt"), 
SwiftCompiler.Token.leftParenthesis, 
SwiftCompiler.Token.identifier("n"), 
SwiftCompiler.Token.rightParenthesis, 
SwiftCompiler.Token.semicolon, 
SwiftCompiler.Token.def, 
SwiftCompiler.Token.identifier("foo"),
SwiftCompiler.Token.leftParenthesis, 
SwiftCompiler.Token.identifier("n"), 
SwiftCompiler.Token.rightParenthesis, 
SwiftCompiler.Token.leftParenthesis, 
SwiftCompiler.Token.identifier("n"), 
SwiftCompiler.Token.´operator´(SwiftCompiler.BinaryOperator.multiply), 
SwiftCompiler.Token.identifier("sqrt"), 
SwiftCompiler.Token.leftParenthesis, SwiftCompiler.Token.identifier("n"), 
SwiftCompiler.Token.´operator´(SwiftCompiler.BinaryOperator.multiply), 
SwiftCompiler.Token.decimalNumber(200.0), 
SwiftCompiler.Token.rightParenthesis, 
SwiftCompiler.Token.´operator´(SwiftCompiler.BinaryOperator.plus), 
SwiftCompiler.Token.decimalNumber(57.0), 
SwiftCompiler.Token.´operator´(SwiftCompiler.BinaryOperator.multiply), 
SwiftCompiler.Token.identifier("n"), 
SwiftCompiler.Token.´operator´(SwiftCompiler.BinaryOperator.modulo), 
SwiftCompiler.Token.decimalNumber(2.0), 
SwiftCompiler.Token.rightParenthesis, 
SwiftCompiler.Token.semicolon]
```
## Parsing external function calls.

If for example we call an external function as follows:

```
extern sqrt(n); extern foo(a); extern randomShit(poop);
```

And our parser interprets this as: 
```
Functions Called: ["sqrt": SwiftCompiler.FuncDefinition(name: "sqrt", parameters: ["n"])]
```

#### MORE TO COME!
