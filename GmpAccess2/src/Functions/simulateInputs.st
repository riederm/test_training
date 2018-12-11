(* 
 * simulate voltage1 - increase value by 1% per cycle
 *)
FUNCTION simulateInputs : BOOL

VAR
	pSimData	: GMP232X_SIMDATA;
END_VAR

GMP232X_GETSIMDATA(MODULE_NUMBER, 0, ADR(pSimData));

IF pSimData.U_L1 > 1000 THEN
	pSimData.U_L1 := 150;
END_IF

pSimData.U_L1 := pSimData.U_L1 + 100;
GMP232X_SETSIMDATA(MODULE_NUMBER, 0, ADR(pSimData));

END_FUNCTION