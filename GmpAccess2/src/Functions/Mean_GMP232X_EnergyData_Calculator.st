(*
 * calculates the mean value of energy values TRMS and FRMS 
 *)
FUNCTION_BLOCK Mean_GMP232X_EnergyData_Calculator
VAR_INPUT
	trmsEnergy : GMP232X_ENERGY;
	frmsEnergy : GMP232X_ENERGY;	
END_VAR

VAR_OUTPUT
	meanEnergy : GMP232X_ENERGY;
END_VAR

	meanEnergy.ActiveEnergyDel_xRMS_xCS := 
		(trmsEnergy.ActiveEnergyDel_xRMS_xCS + frmsEnergy.ActiveEnergyDel_xRMS_xCS) / 2.0;
		
	meanEnergy.ActiveEnergyRcv_xRMS_xCS := 
		(trmsEnergy.ActiveEnergyRcv_xRMS_xCS + frmsEnergy.ActiveEnergyRcv_xRMS_xCS) / 2.0;
		
	meanEnergy.ReactiveEnergyDel_xRMS_xCS := 
		(trmsEnergy.ReactiveEnergyDel_xRMS_xCS + frmsEnergy.ReactiveEnergyDel_xRMS_xCS) / 2.0;
		
	meanEnergy.ReactiveEnergyRcv_xRMS_xCS := 
		(trmsEnergy.ReactiveEnergyRcv_xRMS_xCS + frmsEnergy.ReactiveEnergyRcv_xRMS_xCS) / 2.0;
	
END_FUNCTION_BLOCK