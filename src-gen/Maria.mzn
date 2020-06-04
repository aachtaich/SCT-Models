include "globals.mzn";

%Declaration of variables
var 0..1:SIS;
var 0..1:Irrigator;
var 0..1:Sensor;
var 0..1:Dripline;
array[1..3] of float:Battery_Life;
array[1..6] of var 0..1:Sprinkler;
array[1..6] of var 0..1:Rotor;
array[1..6] of var 0..1:Head;
array[1..6] of var 0..1:Spray;
array[1..6] of var 0..60:Pressure;
array[1..6] of var {0, 90, 180, 240, 360}:Rotation;
array[1..3] of var 0..1:HS;
array[1..3] of var 0..1:Master;
array[1..3] of var 0..1:Slave;
array[1..3] of var 0..1:Alarm;
float:Consumption;
float:Op_consumption;
float:Max_consumption;
0..1:Power_Failure;

%Flexing constraints from imported models
var int: Flex;
var 0..1: Flex1;
constraint Flex1 = 1 <-> (SIS = 1);
var 0..1: Flex2;
constraint Flex2 = 1 <-> (SIS >= Sensor);
var 0..1: Flex3;
constraint Flex3 = 1 <-> (SIS >= Irrigator);
var 0..1: Flex4;
constraint Flex4 = 1 <-> ((Irrigator >= Dripline) /\ (2*Irrigator >= Sprinkler[1]+Sprinkler[2]) /\ ((Dripline + (Sprinkler[1]+Sprinkler[2]))=Irrigator*1 \/ (Dripline + (Sprinkler[1]+Sprinkler[2])=Irrigator*2)) /\((Dripline * (Sprinkler[1]+Sprinkler[2])=0)));
Flex = Flex1+Flex2+Flex3+Flex4;


%Declaration of composite states and their Hierarchy
var 0..1:Year2;
var 0..1:Year2_Global;
var 0..1:Year2_Global_State;
var 0..1:Specific_For_Year2;
var 0..1:Accuracy_Mode;
var 0..1:Global_Accuracy;
var 0..1:Globlal_Accuracy_State;
var 0..1:Irrigation_Accuracy;
var 0..1:Eco_Irrigation_Mode;
var 0..1:Normal_Irrigation_Mode;
var 0..1:Sensing_Accuracy;
var 0..1:Full_Charge_Mode;
var 0..1:Medium_Charge_Mode;
var 0..1:Efficiency_Mode;
var 0..1:Global_Efficiency;
var 0..1:Global_Efficiency_State;
var 0..1:Irrigation_Efficiency;
var 0..1:Max_Eco_Irrigation;
var 0..1:Survival_Irrigation;
var 0..1:Sensing_Efficiency;
var 0..1:One_Master_Mode;

constraint Year2_Global_State = 1 -> ((Irrigator = 1 /\ (Irrigator >= Dripline) /\ (Dripline >0 \/ (Sprinkler[1] + Sprinkler[2] + Sprinkler[3] + Sprinkler[4] + Sprinkler[5] + Sprinkler[6]) >0) ) /\(Irrigator=1 -> ((Sprinkler[1] + Sprinkler[2] + Sprinkler[3] + Sprinkler[4] + Sprinkler[5] + Sprinkler[6] = 0) \/ (Sprinkler[1] + Sprinkler[2] + Sprinkler[3] + Sprinkler[4] + Sprinkler[5] + Sprinkler[6])=2 \/ (Sprinkler[1] + Sprinkler[2] + Sprinkler[3] + Sprinkler[4] + Sprinkler[5] + Sprinkler[6])=4 \/ (Sprinkler[1] + Sprinkler[2] + Sprinkler[3] + Sprinkler[4] + Sprinkler[5] + Sprinkler[6])=6) ) /\((Sprinkler[1] + Sprinkler[2] + Sprinkler[3] + Sprinkler[4] + Sprinkler[5] + Sprinkler[6])*Dripline = 0 ) /\(Sprinkler[1] >= 1 <-> Head[1] >= 1 ) /\(Sprinkler[2] >= 1 <-> Head[2] >= 1 ) /\(Sprinkler[3] >= 1 <-> Head[3] >= 1 ) /\(Sprinkler[4] >= 1 <-> Head[4] >= 1 ) /\(Sprinkler[5] >= 1 <-> Head[5] >= 1 ) /\(Sprinkler[6] >= 1 <-> Head[6] >= 1 ) /\(Sprinkler[1] >= 1 <-> Pressure[1] >= 1 ) /\(Sprinkler[2] >= 1 <-> Pressure[2] >= 1 ) /\(Sprinkler[3] >= 1 <-> Pressure[3] >= 1 ) /\(Sprinkler[4] >= 1 <-> Pressure[4] >= 1 ) /\(Sprinkler[5] >= 1 <-> Pressure[5] >= 1 ) /\(Sprinkler[6] >= 1 <-> Pressure[6] >= 1 ) /\(Sprinkler[1] >= 1 <-> Rotation[1] >= 1 ) /\(Sprinkler[2] >= 1 <-> Rotation[2] >= 1 ) /\(Sprinkler[3] >= 1 <-> Rotation[3] >= 1 ) /\(Sprinkler[4] >= 1 <-> Rotation[4] >= 1 ) /\(Sprinkler[5] >= 1 <-> Rotation[5] >= 1 ) /\(Sprinkler[6] >= 1 <-> Rotation[6] >= 1 ) /\(Head[1] >= 1 <-> Rotor[1] >= 1 ) /\(Head[2] >= 1 <-> Rotor[2] >= 1 ) /\(Head[3] >= 1 <-> Rotor[3] >= 1 \/ Spray[3] >= 1 ) /\(Head[4] >= 1 <-> Rotor[4] >= 1 \/ Spray[4] >= 1 ) /\(Head[5] >= 1 <-> Rotor[5] >= 1 \/ Spray[5] >= 1 ) /\(Head[6] >= 1 <-> Rotor[6] >= 1 \/ Spray[6] >= 1 ) /\(Rotor[3] * Spray[3] = 0 ) /\(Rotor[4] * Spray[4] = 0 ) /\(Rotor[5] * Spray[5] = 0 ) /\(Rotor[6] * Spray[6] = 0 ) /\(Sensor*3 >= HS[1]+HS[2]+HS[3] ) /\(HS[1] >= 1 <-> (Master[1]= 1 \/ Slave[1]= 1 ) ) /\(HS[2] >= 1 <-> (Master[2]= 1 \/ Slave[2]= 1 ) ) /\(HS[3] >= 1 <-> (Master[3]= 1 \/ Slave[3]= 1 ) ) /\(Master[1] * Slave[1] = 0 ) /\(Master[2] * Slave[2] = 0 ) /\(Master[3] * Slave[3] = 0 ) /\(Master[1]+Master[2]+Master[3]>=1 ) /\(Master[1]=1 -> Alarm[1]=1 ) /\(Master[2]=1 -> Alarm[2]=1 ) /\(Master[3]=1 -> Alarm[3]=1 ));
constraint Globlal_Accuracy_State = 1 -> ((Sprinkler[1]+Sprinkler[2]+Sprinkler[3]+Sprinkler[4]+Sprinkler[5]+Sprinkler[6]>=4 ));
constraint Eco_Irrigation_Mode = 1 -> ((Sprinkler[1]+Sprinkler[2]=0 ) /\((Rotation[3]=90) /\ (Rotation[4]=90) /\ (Rotation[5]=90) /\ (Rotation[6]=90) ) /\((Pressure[3]=50) /\ (Pressure[4]=50) /\ (Pressure[5]=50) /\ (Pressure[6]=50) ) /\(Spray[3]+Spray[4]+Spray[5]+Spray[6]=4 ));
constraint Normal_Irrigation_Mode = 1 -> ((Sprinkler[1]+Sprinkler[2]+Sprinkler[3]+Sprinkler[4]+Sprinkler[5]+Sprinkler[6]=6 ) /\(Rotation[1] = 180 /\ Rotation[2]=180 ) /\(Pressure[1]=40 /\ Pressure[2]=40 ) /\((Rotation[3]=90) /\ (Rotation[4]=90) /\ (Rotation[5]=90) /\ (Rotation[6]=90) ) /\((Pressure[3]=30) /\ (Pressure[4]=30) /\ (Pressure[5]=30) /\ (Pressure[6]=30) ) /\(Rotor[1]+Rotor[2]+Rotor[3]+Rotor[4]+Rotor[5]+Rotor[6]=6 ));
constraint Full_Charge_Mode = 1 -> ((Battery_Life[1]>=60 -> Master[1]=1 ) /\(Battery_Life[2]>=60 -> Master[2]=1 ) /\(Battery_Life[3]>=60 -> Master[3]=1 ) /\(Battery_Life[1]<60 -> Slave[1]=1 ) /\(Battery_Life[2]<60 -> Slave[2]=1 ) /\(Battery_Life[3]<60 -> Slave[3]=1 ));
constraint Medium_Charge_Mode = 1 -> ((Battery_Life[1]>=40 -> Master[1]=1 ) /\(Battery_Life[2]>=40 -> Master[2]=1 ) /\(Battery_Life[3]>=40 -> Master[3]=1 ) /\(Battery_Life[1]<40 -> Slave[1]=1 ) /\(Battery_Life[2]<40 -> Slave[2]=1 ) /\(Battery_Life[3]<40 -> Slave[3]=1 ));
constraint Global_Efficiency_State = 1 -> ((Master[1]+Master[2]+Master[3]=1 ) /\(Alarm[1]+Alarm[2]+Alarm[3]=0 ));
constraint Max_Eco_Irrigation = 1 -> ((Sprinkler[1] + Sprinkler[2] = 2 ) /\(Sprinkler[1]+Sprinkler[2]+Sprinkler[3]+Sprinkler[4]+Sprinkler[5]+Sprinkler[6]<=2 ) /\(Rotation[1]=360 ) /\(Rotation[2]=360 ) /\(Pressure[1]=60 ) /\(Pressure[2]=60 ));
constraint Survival_Irrigation = 1 -> ((Dripline = 1 ));
constraint One_Master_Mode = 1 -> (((Battery_Life[1]>Battery_Life[2] /\ Battery_Life[1]>Battery_Life[3]) -> Master[1]=1 ) /\((Battery_Life[2]>Battery_Life[1] /\ Battery_Life[2]>Battery_Life[3]) -> Master[2]=1 ) /\((Battery_Life[3]>Battery_Life[1] /\ Battery_Life[3]>Battery_Life[2]) -> Master[3]=1 ));


%Constraints---------------------------------------------------
	%on the hierarchy

constraint Year2 = 1 <-> Year2_Global = 1;
constraint Year2_Global = Year2_Global_State ;
constraint Year2 = 1 <-> Specific_For_Year2 = 1;
constraint Specific_For_Year2 = Accuracy_Mode + Efficiency_Mode  ;
constraint Accuracy_Mode = 1 <-> Global_Accuracy = 1;
constraint Global_Accuracy = Globlal_Accuracy_State ;
constraint Accuracy_Mode = 1 <-> Irrigation_Accuracy = 1;
constraint Irrigation_Accuracy = Eco_Irrigation_Mode + Normal_Irrigation_Mode  ;
constraint Accuracy_Mode = 1 <-> Sensing_Accuracy = 1;
constraint Sensing_Accuracy = Full_Charge_Mode + Medium_Charge_Mode  ;
constraint Global_Accuracy + Irrigation_Accuracy + Sensing_Accuracy  =  Accuracy_Mode  * ( Global_Accuracy + Irrigation_Accuracy + Sensing_Accuracy  );
constraint Efficiency_Mode = 1 <-> Global_Efficiency = 1;
constraint Global_Efficiency = Global_Efficiency_State ;
constraint Efficiency_Mode = 1 <-> Irrigation_Efficiency = 1;
constraint Irrigation_Efficiency = Max_Eco_Irrigation + Survival_Irrigation  ;
constraint Efficiency_Mode = 1 <-> Sensing_Efficiency = 1;
constraint Sensing_Efficiency = One_Master_Mode ;
constraint Global_Efficiency + Irrigation_Efficiency + Sensing_Efficiency  =  Efficiency_Mode  * ( Global_Efficiency + Irrigation_Efficiency + Sensing_Efficiency  );
constraint Year2_Global + Specific_For_Year2  =  Year2  * ( Year2_Global + Specific_For_Year2  );
	%on full transitions

constraint (((Power_Failure=1)) /\ (Efficiency_Mode=1 )) -> Survival_Irrigation = 1;
constraint (((Power_Failure=0)) /\ (Efficiency_Mode=1 )) -> Max_Eco_Irrigation = 1;
constraint (((Power_Failure=1 \/ Consumption > Max_consumption)) /\ (Year2=1 )) -> Efficiency_Mode = 1;
constraint (((Power_Failure = 0 /\ Consumption < Max_consumption)) /\ (Year2=1 )) -> Accuracy_Mode = 1;
constraint (((Consumption < Op_consumption )) /\ (Accuracy_Mode=1 )) -> Normal_Irrigation_Mode = 1;
constraint (((Consumption > Op_consumption)) /\ (Accuracy_Mode=1 )) -> Eco_Irrigation_Mode = 1;
constraint (((Battery_Life[1]>=40 /\ Battery_Life[2]>=40 /\ Battery_Life[2]>=40)) /\ (Accuracy_Mode=1 )) -> Full_Charge_Mode = 1;
constraint (((Battery_Life[1]>=20 /\ Battery_Life[2]>=20 /\ Battery_Life[2]>=20) /\ (Battery_Life[1]<40 \/ Battery_Life[2]<40 \/ Battery_Life[2]<40)) /\ (Accuracy_Mode=1 )) -> Medium_Charge_Mode = 1;

	%on start transitions
constraint Year2 =1; 
constraint Year2 = 1 -> (Year2_Global_State =1 );
constraint Year2 = 1 -> (Accuracy_Mode =1 \/ Accuracy_Mode+Efficiency_Mode= 1);
constraint Accuracy_Mode = 1 -> (Globlal_Accuracy_State =1 );
constraint Accuracy_Mode = 1 -> (Normal_Irrigation_Mode =1 \/ Eco_Irrigation_Mode+Normal_Irrigation_Mode= 1);
constraint Accuracy_Mode = 1 -> (Full_Charge_Mode =1 \/ Full_Charge_Mode+Medium_Charge_Mode= 1);
constraint Efficiency_Mode = 1 -> (Global_Efficiency_State =1 );
constraint Efficiency_Mode = 1 -> (Max_Eco_Irrigation =1 \/ Max_Eco_Irrigation+Survival_Irrigation= 1);

solve maximize Flex;
