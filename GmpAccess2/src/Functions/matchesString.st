(*
 * Function StringMatcher:
 * 
 * Returns true if the given string matches on of the
 * three strings passed to the function
*)
FUNCTION matchesString : BOOL
VAR_INPUT
	str : STRING;
	str1 : STRING;
	str2 : STRING;
	str3 : STRING;
END_VAR

IF str = str1 OR str = str2 OR str = str3 THEN
	matchesString := TRUE;
ELSE 
	matchesString := FALSE;
END_IF

END_FUNCTION