%{
	/*
	##################################################
	# /\ \/ and -> ( Conjuction, disjunction, implication ) given highest and equal precedence
	# not given lowest precedence
	# 3 stacks used 
        # Operator stack : To maintain operators
        # Operand stack : To append postfix expression 
        # Final stack : Used to evaluate the postfix expression	
	###################################################
	*/

	#include<stdio.h>
	char *result ;

	int operator_top = -1 , output_top = -1 ,final_top = -1, valid = 0;
	const char *operator_stack[1000], *output_stack[1000], *final_stack[1000];
	int expression_status_flag = 0,bracket_count = 0;

	int no_of_operands = 0 , no_of_operators = 0, invalid_char = 0;
%}


%%
"(" { 
        operator_top++;
        operator_stack[operator_top]="(" ;
	bracket_count++;
    }
")" {
	int temp_operator_top = operator_top;
	int check_start_parenthesis = 0;
	if ( operator_top >= 0 )
	{
		// while the operator at the top of the operator stack is not a left bracket: pop operators from the operator stack onto the output queue.
		// pop the left bracket from the stack.
		for ( int i = temp_operator_top; i>=0 ; i-- )
		{
			operator_top--;
			if ( operator_stack[i] == "(" )
			{
				check_start_parenthesis = 1;
				bracket_count--;
				break;
			}
			output_top++;
                        output_stack[output_top] = operator_stack[i] ;
		}
		
	}
	else
	{
		valid = 1;
		bracket_count--;
	}
	
	if ( bracket_count < 0 || valid == 1 || check_start_parenthesis == 0)
	{
		valid = 1;
	}
	check_start_parenthesis = 0;


    }
"True" {
	no_of_operands ++ ; 
	output_top++; 
	output_stack[output_top]="True" ; 
	}
"False" { 
	no_of_operands ++;
	output_top++; 
	output_stack[output_top]="False" ; 
	}

"not \\/" { valid = 1; }
"not ->"  { valid = 1; }
"not not" { valid = 1; }

"( \\/" { valid = 1; }
"( ->"  { valid = 1; }
"( /\\" { valid = 1; }

"\\/ )" { valid = 1; }
"-> )"  { valid = 1; }
"/\\ )" { valid = 1; }


"not" {
        int temp_operator_top = operator_top;

	//while there is an operator at the top of the operator stack with greater or equal precedence and operator is not a "("
	// pop operators from the operator stack, onto the output queue.
     	for ( int i = temp_operator_top; i>=0 ; i-- )
     	{
		if ( operator_stack[i] != "(" && operator_stack[i] != "/\\" && operator_stack[i] != "\\/" && operator_stack[i] != "->"  )
		{
      			output_top++;
            		output_stack[output_top] = operator_stack[i] ;
            		operator_top--;
		}
		else
		{
			break;
		}
     	}
	operator_top++;
     	operator_stack[operator_top] = "not" ;

      }

"/\\" {


	no_of_operators++; 
        int temp_operator_top = operator_top;

	//while there is an operator at the top of the operator stack with greater or equal precedence and operator is not a "("
        // pop operators from the operator stack, onto the output queue.
        for ( int i = temp_operator_top; i>=0 ; i-- ) 
        {
                if ( operator_stack[i] != "(" )
                {
                        output_top++;
                        output_stack[output_top] = operator_stack[i] ;
                        operator_top--;
                }
                else
                {
                        break;
                }
        }
        operator_top++;
        operator_stack[operator_top] = "/\\" ;


      }
"\\/" {
	no_of_operators++;
        int temp_operator_top = operator_top;
	
	//while there is an operator at the top of the operator stack with greater or equal precedence and operator is not a "("
        // pop operators from the operator stack, onto the output queue.
        for ( int i = temp_operator_top; i>=0 ; i-- )
        {
                if ( operator_stack[i] != "(")
                {
                        output_top++;
                        output_stack[output_top] = operator_stack[i] ;
                        operator_top--;
                }
                else
                {
                        break;
                }
        }
        operator_top++;
        operator_stack[operator_top] = "\\/" ;
      }
"->" {
	no_of_operators++;
        int temp_operator_top = operator_top;

	//while there is an operator at the top of the operator stack with greater or equal precedence and operator is not a "("
        // pop operators from the operator stack, onto the output queue.
        for ( int i = temp_operator_top; i>=0 ; i-- )
        {
                if ( operator_stack[i] != "(")
                {
                        output_top++;
                        output_stack[output_top] = operator_stack[i] ;
                        operator_top--;
                }
                else
                {
                        break;
                }
        }
        operator_top++;
        operator_stack[operator_top] = "->" ;
      }


" " {}

. 	{ invalid_char = 1; }

<<EOF>>  { printf("Exiting on user request ( Control + D ) \n"); exit(0);}

\n 	{
		int temp_operator_top = operator_top;

		// while there are still operator tokens on the stack 
		// pop the operator onto the output queue
		for ( int i = temp_operator_top; i>=0 ; i-- )
                {
			if ( operator_stack[i] != "(" )
                        {
                                output_top++;
                                output_stack[output_top] = operator_stack[i] ;
                        }
			operator_top--;
                }

		// if invalid bit set 
		if ( valid == 1 || invalid_char == 1)
		{
			return 0;
		}

		expression_status_flag = 0;

	        // final_stack
                for ( int i=0; i<=output_top ; i++ )
                {
			expression_status_flag = 1;
                        // if scanned i/p is operand
                        if ( output_stack[i] == "/\\" || output_stack[i] == "\\/" || output_stack[i] == "->" || output_stack[i] == "not")
                        {
                                const char *operator = output_stack[i];

				if ( output_stack[i] == "not" ) 
				{
					// pop one element		
					const char *operand1 = final_stack[final_top];
					final_top = final_top - 1;

					if ( operand1 == "False" )
					{
						result = "True";
					}
					else
					{
						result = "False";
					}
				}
				else
				{
                                	//pop two elements
                                	const char *operand1 = final_stack[final_top-1];
                                	const char *operand2 = final_stack[final_top];

                                	final_top = final_top - 2;

                                	if ( operator == "/\\" )
                                	{
                                	        //Conjunction
                                	        if ( operand1 == "True" && operand2 == "True" )
                                	        {
                                	                result = "True";
                                	        }
                                	        else
                                	        {
                                	                result = "False";
                                        	}

                                	}
                                	else if ( operator == "\\/" )
                                	{
                                	        //disjuntion
                                	        if ( operand1 == "False" && operand2 == "False" )
                                	        {
                                	                result = "False";
                                	        }
                                	        else
                                	        {
                                	                result = "True";
                                	        }
                                	}
                                	else if ( operator == "->" )
                                	{
                                	        //implication
                                	        if ( operand1 == "True" && operand2 == "False")
                                	        {
                                	                result = "False";
                                	        }
                                        	else
                                        	{
                                        	        result = "True";
                                        	}
                                	}
				}
                                final_top = final_top + 1;
                                final_stack[final_top] = result;
                        }
                        else
                        {
                                final_top++;
                                final_stack[final_top] = output_stack[i];
			}

                }
		return 0;
   	}
%%

void main()
{
	//  /\ (for conjunction), \/ (for disjunction), -> (for implication), and not (for negation)

	while(1)
	{
		printf("\n\nEnter a expression\n");
		yylex();

		if ( valid == 1 || bracket_count != 0 || invalid_char == 1 || ( (no_of_operands - no_of_operators) != 1 && no_of_operands != 0 && no_of_operators != 0 ) )
		{
			//ERROR : Redirect to sderr
			if ( invalid_char == 1 )
			{
				fprintf(stderr, "%s", "Output -: Invalid Character \n");
			}
			else
			{
				fprintf(stderr, "%s", "Output -: Invalid expression\n");
			}
		}
		else
		{
			if ( expression_status_flag == 1 )
			{
				printf("Output -: %s",final_stack[final_top]);	
			}
		}
		operator_top = -1 ;
             	output_top = -1 ;
             	final_top = -1;
        	expression_status_flag = 0;
            	valid = 0;
		bracket_count = 0;
		no_of_operands = 0;
		no_of_operators = 0;
		invalid_char = 0;
	}
}
