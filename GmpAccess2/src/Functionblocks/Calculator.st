FUNCTION_BLOCK Calculator
VAR_INPUT
	in1 : REAL;
	in2 : REAL;
END_VAR

VAR_OUTPUT
	out : REAL;
END_VAR

VAR

END_VAR

add1;
sub1;
mul1;
div1;

END_FUNCTION_BLOCK

ACTIONS

ACTION add1
	out := in1 + in2;
END_ACTION

ACTION sub1
	out := in1 - in2;
END_ACTION

ACTION mul1
	out := in1 * in2;
END_ACTION

ACTION div1
	out := in1 / in2;
END_ACTION

END_ACTIONS
