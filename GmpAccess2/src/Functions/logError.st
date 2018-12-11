(* 
 * Logs an error to console if return value is negative
 *)
FUNCTION logError : BOOL
VAR_INPUT
	retVal : GMP232X_RETVAL;
END_VAR

IF retVal.MioErr < 0 THEN
	Util_LogErr(DINT_TO_STRING(retVal.MioErr));
END_IF

END_FUNCTION