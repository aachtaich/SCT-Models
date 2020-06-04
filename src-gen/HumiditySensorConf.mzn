include "globals.mzn";

%Declaration of variables
array[1..7] of var 0..1:humiditySensor;
array[1..7] of var 0..1:notifier;
array[1..7] of var 0..1:mode;
array[1..7] of var 0..1:sensors;
array[1..7] of var 0..1:alarm;
array[1..7] of var 0..1:contact;
array[1..7] of var 0..1:bulb;
array[1..7] of var 0..1:slave;
array[1..7] of var 0..1:master;
array[1..7] of var 0..1:airSensor;
array[1..7] of var 0..1:soilSensor;
array[1..7] of float:battery_level;

%Flexing constraints from imported models
var int: Flex;
var 0..1: Flex1;
constraint Flex1 = 1 <-> (humiditySensor[1] >= notifier[1]);
var 0..1: Flex2;
constraint Flex2 = 1 <-> (humiditySensor[1] = mode[1]);
var 0..1: Flex3;
constraint Flex3 = 1 <-> (humiditySensor[1]= sensors[1]);
var 0..1: Flex4;
constraint Flex4 = 1 <-> (sensors[1] = soilSensor[1]);
var 0..1: Flex5;
constraint Flex5 = 1 <-> (sensors[1] >= airSensor[1]);
var 0..1: Flex6;
constraint Flex6 = 1 <-> (notifier[1] * 3 >= alarm[1] + contact[1] + bulb[1]);
var 0..1: Flex7;
constraint Flex7 = 1 <-> (mode[1]= slave[1] + master[1]);
var 0..1: Flex8;
constraint Flex8 = 1 <-> (humiditySensor[2] >= notifier[2]);
var 0..1: Flex9;
constraint Flex9 = 1 <-> (humiditySensor[2] = mode[2]);
var 0..1: Flex10;
constraint Flex10 = 1 <-> (humiditySensor[2]= sensors[2]);
var 0..1: Flex11;
constraint Flex11 = 1 <-> (sensors[2] = soilSensor[2]);
var 0..1: Flex12;
constraint Flex12 = 1 <-> (sensors[2] >= airSensor[2]);
var 0..1: Flex13;
constraint Flex13 = 1 <-> (notifier[2] * 3 >= alarm[2] + contact[2] + bulb[2]);
var 0..1: Flex14;
constraint Flex14 = 1 <-> (mode[2]= slave[2] + master[2]);
var 0..1: Flex15;
constraint Flex15 = 1 <-> (humiditySensor[3] >= notifier[3]);
var 0..1: Flex16;
constraint Flex16 = 1 <-> (humiditySensor[3] = mode[3]);
var 0..1: Flex17;
constraint Flex17 = 1 <-> (humiditySensor[3]= sensors[3]);
var 0..1: Flex18;
constraint Flex18 = 1 <-> (sensors[3] = soilSensor[3]);
var 0..1: Flex19;
constraint Flex19 = 1 <-> (sensors[3] >= airSensor[3]);
var 0..1: Flex20;
constraint Flex20 = 1 <-> (notifier[3] * 3 >= alarm[3] + contact[3] + bulb[3]);
var 0..1: Flex21;
constraint Flex21 = 1 <-> (mode[3]= slave[3] + master[3]);
var 0..1: Flex22;
constraint Flex22 = 1 <-> (humiditySensor[4] >= notifier[4]);
var 0..1: Flex23;
constraint Flex23 = 1 <-> (humiditySensor[4] = mode[4]);
var 0..1: Flex24;
constraint Flex24 = 1 <-> (humiditySensor[4]= sensors[4]);
var 0..1: Flex25;
constraint Flex25 = 1 <-> (sensors[4] = soilSensor[4]);
var 0..1: Flex26;
constraint Flex26 = 1 <-> (sensors[4] >= airSensor[4]);
var 0..1: Flex27;
constraint Flex27 = 1 <-> (notifier[4] * 3 >= alarm[4] + contact[4] + bulb[4]);
var 0..1: Flex28;
constraint Flex28 = 1 <-> (mode[4]= slave[4] + master[4]);
var 0..1: Flex29;
constraint Flex29 = 1 <-> (humiditySensor[5] >= notifier[5]);
var 0..1: Flex30;
constraint Flex30 = 1 <-> (humiditySensor[5] = mode[5]);
var 0..1: Flex31;
constraint Flex31 = 1 <-> (humiditySensor[5]= sensors[5]);
var 0..1: Flex32;
constraint Flex32 = 1 <-> (sensors[5] = soilSensor[5]);
var 0..1: Flex33;
constraint Flex33 = 1 <-> (sensors[5] >= airSensor[5]);
var 0..1: Flex34;
constraint Flex34 = 1 <-> (notifier[5] * 3 >= alarm[5] + contact[5] + bulb[5]);
var 0..1: Flex35;
constraint Flex35 = 1 <-> (mode[5]= slave[5] + master[5]);
var 0..1: Flex36;
constraint Flex36 = 1 <-> (humiditySensor[6] >= notifier[6]);
var 0..1: Flex37;
constraint Flex37 = 1 <-> (humiditySensor[6] = mode[6]);
var 0..1: Flex38;
constraint Flex38 = 1 <-> (humiditySensor[6]= sensors[6]);
var 0..1: Flex39;
constraint Flex39 = 1 <-> (sensors[6] = soilSensor[6]);
var 0..1: Flex40;
constraint Flex40 = 1 <-> (sensors[6] >= airSensor[6]);
var 0..1: Flex41;
constraint Flex41 = 1 <-> (notifier[6] * 3 >= alarm[6] + contact[6] + bulb[6]);
var 0..1: Flex42;
constraint Flex42 = 1 <-> (mode[6]= slave[6] + master[6]);
var 0..1: Flex43;
constraint Flex43 = 1 <-> (humiditySensor[7] >= notifier[7]);
var 0..1: Flex44;
constraint Flex44 = 1 <-> (humiditySensor[7] = mode[7]);
var 0..1: Flex45;
constraint Flex45 = 1 <-> (humiditySensor[7]= sensors[7]);
var 0..1: Flex46;
constraint Flex46 = 1 <-> (sensors[7] = soilSensor[7]);
var 0..1: Flex47;
constraint Flex47 = 1 <-> (sensors[7] >= airSensor[7]);
var 0..1: Flex48;
constraint Flex48 = 1 <-> (notifier[7] * 3 >= alarm[7] + contact[7] + bulb[7]);
var 0..1: Flex49;
constraint Flex49 = 1 <-> (mode[7]= slave[7] + master[7]);
Flex = Flex1+Flex2+Flex3+Flex4+Flex5+Flex6+Flex7+Flex8+Flex9+Flex10+Flex11+Flex12+Flex13+Flex14+Flex15+Flex16+Flex17+Flex18+Flex19+Flex20+Flex21+Flex22+Flex23+Flex24+Flex25+Flex26+Flex27+Flex28+Flex29+Flex30+Flex31+Flex32+Flex33+Flex34+Flex35+Flex36+Flex37+Flex38+Flex39+Flex40+Flex41+Flex42+Flex43+Flex44+Flex45+Flex46+Flex47+Flex48+Flex49;


%Declaration of composite states and their Hierarchy
var 0..1:SS;
var 0..1:SS_Sensor_battery;
var 0..1:SS_accurate_Sensing;
var 0..1:SS_efficient_Sensing;
var 0..1:AW;
var 0..1:AW_Sensor_battery;
var 0..1:AW_accurate_Sensing;
var 0..1:AW_efficient_Sensing;
var 0..1:NoE;
var 0..1:NoE_Sensor_battery;
var 0..1:NoE_Sensing;

constraint SS_accurate_Sensing = 1 -> ((master[1]+master[2]+master[4]+master[4]+master[5]+master[6]+master[7]=3 ));
constraint SS_efficient_Sensing = 1 -> ((master[1]+master[2]+master[4]+master[4]+master[5]+master[6]+master[7]=1 ) /\(battery_level[1]<=20 -> master[1]=0 ) /\(battery_level[2]<=20 -> master[2]=0 ) /\(battery_level[3]<=20 -> master[3]=0 ) /\(battery_level[4]<=20 -> master[4]=0 ) /\(battery_level[5]<=20 -> master[5]=0 ) /\(battery_level[6]<=20 -> master[6]=0 ) /\(battery_level[7]<=20 -> master[7]=0 ));
constraint AW_accurate_Sensing = 1 -> ((master[1]+master[2]+master[4]+master[4]+master[5]+master[6]+master[7]=7 ));
constraint AW_efficient_Sensing = 1 -> ((master[1]+master[2]+master[4]+master[4]+master[5]+master[6]+master[7]=3 ) /\(battery_level[1]<=20 -> master[1]=0 ) /\(battery_level[2]<=20 -> master[2]=0 ) /\(battery_level[3]<=20 -> master[3]=0 ) /\(battery_level[4]<=20 -> master[4]=0 ) /\(battery_level[5]<=20 -> master[5]=0 ) /\(battery_level[6]<=20 -> master[6]=0 ) /\(battery_level[7]<=20 -> master[7]=0 ));
constraint NoE_Sensing = 1 -> ((master[1]+master[2]+master[4]+master[4]+master[5]+master[6]+master[7]=1 ));


%Constraints---------------------------------------------------
	%on the hierarchy

constraint SS = 1 <-> SS_Sensor_battery = 1;
constraint SS_Sensor_battery = SS_accurate_Sensing + SS_efficient_Sensing  ;
constraint SS_Sensor_battery =  SS  * ( SS_Sensor_battery );
constraint AW = 1 <-> AW_Sensor_battery = 1;
constraint AW_Sensor_battery = AW_accurate_Sensing + AW_efficient_Sensing  ;
constraint AW_Sensor_battery =  AW  * ( AW_Sensor_battery );
constraint NoE = 1 <-> NoE_Sensor_battery = 1;
constraint NoE_Sensor_battery = NoE_Sensing ;
constraint NoE_Sensor_battery =  NoE  * ( NoE_Sensor_battery );
	%on full transitions

constraint (((battery_level[1]<60 \/ battery_level[2] <60 \/ battery_level[3] <60 \/ battery_level[4] <60 \/ battery_level[5] <60 \/ battery_level[6] <60 \/ battery_level[7] <60)) /\ (SS=1 )) -> SS_efficient_Sensing = 1;

	%on start transitions

solve maximize Flex;
