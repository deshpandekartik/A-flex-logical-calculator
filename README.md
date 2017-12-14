
Lex program 


Sample input / output

```
➜  pl-assignment2 git:(master) bash execute-flex          


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
