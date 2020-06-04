include "globals.mzn";

%Declaration of variables
var 0..1:LGS;
var 0..1:Pilot_Interface;
0..3:Handle;
array[1..3] of var 0..3:Light;
array[1..3] of var 0..2:Handle_Sensor;

%Flexing constraints from imported models
var int: Flex;
var 0..1: Flex1;
constraint Flex1 = 1 <-> (LGS=1);
var 0..1: Flex2;
constraint Flex2 = 1 <-> (LGS=Pilot_Interface);
var 0..1: Flex3;
constraint Flex3 = 1 <-> (Pilot_Interface=1);
var 0..1: Flex4;
constraint Flex4 = 1 <-> (Pilot_Interface>0 -> Handle >0 /\ (Light[1]>1 /\ Light[2]>1 /\ Light[3]>1));
Flex = Flex1+Flex2+Flex3+Flex4;


%Declaration of composite states and their Hierarchy
var 0..1:LGS_Nominal;
var 0..1:handle;
var 0..1:handle_up;
var 0..1:handle_down;
var 0..1:handle_inactive;

constraint handle_up = 1 -> ((Handle_Sensor [ 1 ]=1 /\ Handle_Sensor [ 2 ]=1 /\ Handle_Sensor [ 3]=1 ) /\(Light [ 1 ]=1 /\ Light [ 2 ]=1 /\ Light [ 3]=1 ));
constraint handle_down = 1 -> ((Handle_Sensor [ 1 ]=2 /\ Handle_Sensor [ 2 ]=2 /\ Handle_Sensor [ 3 ]=2 ) /\(Light [ 1 ]=2 /\ Light [ 2 ]=2 /\ Light [ 3]=2 ));
constraint handle_inactive = 1 -> ((Handle_Sensor [ 1 ]=0 /\ Handle_Sensor [ 2 ]=0 /\ Handle_Sensor [ 3 ]=0 ) /\(Light [ 1 ] + Light [ 2 ] + Light [ 3]=0 ));


%Constraints---------------------------------------------------
	%on the hierarchy

constraint LGS_Nominal = 1 <-> handle = 1;
constraint handle = handle_up + handle_down + handle_inactive  ;
constraint handle =  LGS_Nominal  * ( handle );
	%on full transitions

constraint ((Handle=1) /\ (LGS_Nominal=1 )) -> handle_up = 1;
constraint ((Handle=2) /\ (LGS_Nominal=1 )) -> handle_down = 1;
constraint ((Handle=0) /\ (LGS_Nominal=1 )) -> handle_inactive = 1;
constraint ((Handle=0) /\ (LGS_Nominal=1 )) -> handle_inactive = 1;

	%on start transitions
constraint LGS_Nominal =1; 
constraint LGS_Nominal = 1 -> (handle_up =1 \/ handle_up+handle_down+handle_inactive= 1);

solve maximize Flex;
