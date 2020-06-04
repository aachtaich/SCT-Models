include "globals.mzn";

%Declaration of variables
var 0..1:PredictFlooding;
var 0..1:TransmitData;
var 0..1:OrganizeNetwork;
var 0..1:CalculateFlowRate;
var 0..1:MeasureDepth;
var 0..1:WiFi;
var 0..1:Bluetooth;
var 0..1:SPTopology;
var 0..1:FHTopology;
var 0..1:DistributedProcessing;
var 0..1:SingleNodeProcessing;
float:Batterylevel;
0..2:StateOfRiver;

%Flexing constraints from imported models
var int: Flex;
var 0..1: Flex1;
constraint Flex1 = 1 <-> (PredictFlooding = 1);
var 0..1: Flex2;
constraint Flex2 = 1 <-> (PredictFlooding * 4 = TransmitData + OrganizeNetwork + CalculateFlowRate + MeasureDepth);
var 0..1: Flex3;
constraint Flex3 = 1 <-> (TransmitData = Bluetooth + WiFi);
var 0..1: Flex4;
constraint Flex4 = 1 <-> (OrganizeNetwork = FHTopology + SPTopology);
var 0..1: Flex5;
constraint Flex5 = 1 <-> (CalculateFlowRate = DistributedProcessing + SingleNodeProcessing);
var 0..1: Flex6;
constraint Flex6 = 1 <-> (Bluetooth + DistributedProcessing <= 1);
Flex = Flex1+Flex2+Flex3+Flex4+Flex5+Flex6;


%Declaration of composite states and their Hierarchy
var 0..1:Gridstix_State;
var 0..1:Energy;
var 0..1:No_Efficiency;
var 0..1:Yes_Efficiency;
var 0..1:FaultTolerence;
var 0..1:No_FaultTolerence;
var 0..1:Yes_FaultTolerence;
var 0..1:Accuracy;
var 0..1:No_Accuracy;
var 0..1:Yes_Accuracy;

constraint No_Efficiency = 1 -> ((PredictFlooding = 1 ));
constraint Yes_Efficiency = 1 -> ((Bluetooth=1 ) /\(SingleNodeProcessing=1 ));
constraint No_FaultTolerence = 1 -> ((PredictFlooding = 1 ));
constraint Yes_FaultTolerence = 1 -> ((WiFi=1 ) /\(FHTopology=1 ));
constraint No_Accuracy = 1 -> ((PredictFlooding = 1 ));
constraint Yes_Accuracy = 1 -> ((DistributedProcessing=1 ));


%Constraints---------------------------------------------------
	%on the hierarchy

constraint Gridstix_State = 1 <-> Energy = 1;
constraint Energy = No_Efficiency + Yes_Efficiency  ;
constraint Gridstix_State = 1 <-> FaultTolerence = 1;
constraint FaultTolerence = No_FaultTolerence + Yes_FaultTolerence  ;
constraint Gridstix_State = 1 <-> Accuracy = 1;
constraint Accuracy = No_Accuracy + Yes_Accuracy  ;
constraint Energy + FaultTolerence + Accuracy  =  Gridstix_State  * ( Energy + FaultTolerence + Accuracy  );
	%on full transitions

constraint (((Batterylevel<40)) /\ (Gridstix_State=1 )) -> Yes_Efficiency = 1;
constraint (((StateOfRiver=0)) /\ (Gridstix_State=1 )) -> Yes_Efficiency = 1;
constraint (((StateOfRiver=1 \/ StateOfRiver=2 )) /\ (Gridstix_State=1 )) -> Yes_Accuracy = 1;
constraint (((StateOfRiver=2)) /\ (Gridstix_State=1 )) -> Yes_FaultTolerence = 1;
constraint (((Batterylevel>=40)) /\ (Gridstix_State=1 )) -> No_Efficiency = 1;
constraint (((StateOfRiver>0)) /\ (Gridstix_State=1 )) -> No_Efficiency = 1;
constraint (((StateOfRiver=0 )) /\ (Gridstix_State=1 )) -> No_Accuracy = 1;
constraint (((StateOfRiver<2)) /\ (Gridstix_State=1 )) -> No_FaultTolerence = 1;

	%on start transitions
constraint Gridstix_State =1; 
constraint Gridstix_State = 1 -> (No_Accuracy =1 \/ No_Accuracy+Yes_Accuracy= 1);
constraint Gridstix_State = 1 -> (No_Efficiency =1 \/ No_Efficiency+Yes_Efficiency= 1);
constraint Gridstix_State = 1 -> (No_FaultTolerence =1 \/ No_FaultTolerence+Yes_FaultTolerence= 1);

solve maximize Flex;
