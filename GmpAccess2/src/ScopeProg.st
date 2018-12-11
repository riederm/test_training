(* program to handle scope recordings *)
PROGRAM ScopeProg
VAR
	pLockHandle : UDINT;
	retVal 		: GMP232X_RETVAL;
END_VAR

updateScopeState();

IF triggerScope THEN
	triggerScopeIfPossible();
END_IF

IF exportScope THEN
	exportScopeIfReady();
END_IF

END_PROGRAM

ACTIONS
	
	(* reset scope trigger flag and trigger scope if possible *)
	ACTION triggerScopeIfPossible
		triggerScope := FALSE;
		IF scopeState.State = GMP232X_SCOPE_STATE_NOTTRIGGERED OR
				scopeState.State = GMP232X_SCOPE_STATE_READY THEN
			GMP232X_TRIGGERSCOPE(MODULE_NUMBER, 0);
		END_IF
	END_ACTION
	
	(* reset export scope flag and export scope to path if recording is ready *)
	ACTION exportScopeIfReady
		exportScope := FALSE;
		IF (UDINT_TO_DWORD(scopeState.State) AND GMP232X_SCOPE_STATE_NEWDATA) = GMP232X_SCOPE_STATE_NEWDATA THEN
			retVal := GMP232X_TAKESCOPELOCK(MODULE_NUMBER, 0, 3, ADR(pLockHandle));
			Util_LogWrn('Take Lock');
			Util_LogWrn(UDINT_TO_STRING(pLockHandle));
			logError(retVal);
			retVal := GMP232X_EXPORTSCOPE(MODULE_NUMBER, 0, pLockHandle, 'myScopeRecording', 0);
			logError(retVal);
			Util_LogWrn('Give Lock');
			Util_LogWrn(UDINT_TO_STRING(pLockHandle));
			retVal := GMP232X_GIVESCOPELOCK(MODULE_NUMBER, 0, pLockHandle);
			logError(retVal);
		END_IF
	END_ACTION
	
	(* update scope state *)
	ACTION updateScopeState
		GMP232X_GETSCOPESTATE(MODULE_NUMBER, 0, ADR(scopeState));
	END_ACTION

END_ACTIONS