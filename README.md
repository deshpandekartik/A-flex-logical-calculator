
# A-flex-logical-calculator

A propositional logic evaluator which reads in-fix logic expressions from standard input and writes the computed
result on standard output. 

## Summary 

- The calculator terminates when control-D is pressed
- Constants are True and False
- Boolean connectives are /\ (for conjunction), \/ (for disjunction), -> (for
implication), and not (for negation)
- Parentheses are possible in the input. If parentheses are not used, all operators are left
associative
- White spaces, tabs or new lines, are possible
- If any character other than those listed above is seen in the input, e.g. #, the calculator
responds with an error message: "Invalid character: #". Error messages should be sent to
stderr. If parentheses are not matched, you also need to print out an error message


## Setup 

```
make clean
make all

```

## Sample input / output

```
➜  A-flex-logical-calculator git:(master) ./a.out


Enter a expression
( not True -> ( not True -> True ) )
Output -: True

Enter a expression
( not True -> ( not True -> True ) 
Output -: Invalid expression


Enter a expression
( not True -> ( /\ False )  
Output -: Invalid expression


Enter a expression
( not True -> ( /\ False ) )
Output -: Invalid expression


Enter a expression
True /\ ( not True -> ( False ) ) -> False
Output -: False

Enter a expression
True /\ ( not True -> ( False ) -> False \/ True )
Output -: True

Enter a expression
( not True -> ( False ) -> False \/ True )
Output -: True

Enter a expression
True /\ ( not True -> ( False ) -> False \/ False 
Output -: Invalid expression


Enter a expression
True /\ ( not True -> ( False ) -> False \/ False )
Output -: False

Enter a expression
True /\ ( -> )
Output -: Invalid expression


Enter a expression
not True ( )
Output -: False

Enter a expression
not True ( * )
Output -: Invalid Character 


Enter a expression
&
Output -: Invalid Character 


Enter a expression
not False -> False /\ not ( False \/ False )
Output -: False

Enter a expression
Exiting on user request ( Control + D )

```

## References
- Shunting yard algorithm - https://en.wikipedia.org/wiki/Shunting-yard_algorithm
- Postfix expression evaluation - http://btechsmartclass.com/DS/U2_T6.html

### Contact

[Kartik Deshpande](https://www.linkedin.com/in/kartik-deshpande/)
