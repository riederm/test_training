(*
 * <pre>Main program called by a cyclic task
 * 
 * <strong>Features:</strong>
 * <li>updating state according to global variable</li>
 * <li>loading energy data from GMP module</li>
 * <img src="http://iconizer.net/files/Dark_Glass/orig/laptop_power.png"/>
 * </pre>
 *)
PROGRAM MAIN
(* simple variables *)
VAR
	setStateInt	: UDINT; (* parsed state *)
	actState	: UDINT; (* actual state read from module *)
	voltage1	: DWORD;
	voltage2 AT %ID24.2	: DWORD; (* änderung *)
END_VAR
(* structures *)
VAR
	pFrmsEnergyData	: GMP232X_ENERGY; (* container for energy data *)
	pTrmsEnergyData	: GMP232X_ENERGY; (* container for energy data *)
	pMeanEnergyData	: GMP232X_ENERGY; (* container for energy data *)
	retVal	: GMP232X_RETVAL; (* container for return value of RPC call *)
	meanCalc	: Mean_GMP232X_EnergyData_Calculator; (* mean values of FRMS and TRMS *)
	value	: MIO_RETVALUE;
END_VAR

updateStateIfNecessary();

loadEnergyValues();

voltage1 := VoltageL1x_TRMS_HCC;
(* call voltage2 to update the process image *)
voltage2;

value := Mio_GetValue(Mio_GetIdToCard(MODULE_NUMBER), 3);

IF (actState = SIMULATION OR actState = TEST) THEN
	simulateInputs();
END_IF
 
END_PROGRAM

ACTIONS
	(* updates GMP state if necessary*)
	ACTION updateStateIfNecessary
		setStateInt := getStateFromString(gSetState);
		retVal := GMP232X_GETSTATE(MODULE_NUMBER, 0, ADR(actState));
		IF actState <> setStateInt THEN
			GMP232X_SETSTATE(MODULE_NUMBER, 0, setStateInt);
		END_IF
	END_ACTION
	(* loads the energy values for TRMS to local field pFrmsEnergyData *)
	ACTION loadEnergyValues
		retVal := GMP232X_GETENERGY(MODULE_NUMBER, 0, ADR(pFrmsEnergyData), GMP232X_SOURCE_FRMS);
		retVal := GMP232X_GETENERGY(MODULE_NUMBER, 0, ADR(pTrmsEnergyData), GMP232X_SOURCE_TRMS);
		meanCalc(
			trmsEnergy := pFrmsEnergyData,
			frmsEnergy := pTrmsEnergyData,
			meanEnergy => pMeanEnergyData
		);
	END_ACTION

END_ACTIONS