(*
 * Returns the define state depending on the string 
 * passed to the function ( GMP232X_STATE_* )
*)
FUNCTION getStateFromString : UDINT
VAR_INPUT
	str : STRING;
END_VAR

(* TODO: make check case insensitive *)
IF matchesString(str := str, str1 := 'RUN',	str2 := 'run', str3 := 'r') THEN
	getStateFromString := GMP232X_STATE_RUN;
	RETURN;
END_IF

IF matchesString(str := str, str1 := 'CONFIGURATION',	str2 := 'configuration', str3 := 'c') THEN
	getStateFromString := GMP232X_STATE_CONFIG;
	RETURN;
END_IF

IF matchesString(str := str, str1 := 'SIMULATION',	str2 := 'simulation', str3 := 's') THEN
	getStateFromString := GMP232X_STATE_SIMULATION;
	RETURN;
END_IF

IF matchesString(str := str, str1 := 'RELAYSIMULATION',	str2 := 'relaissimulation', str3 := 'rs') THEN
	getStateFromString := GMP232X_STATE_FORCERELAY;
	RETURN;
END_IF

END_FUNCTION