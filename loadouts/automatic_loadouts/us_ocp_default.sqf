this = player;

removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;
this forceAddUniform "rhs_uniform_cu_ocp";
this addItemToUniform "ACE_MapTools";
this addItemToUniform "ACE_EarPlugs";
this addItemToUniform "ACE_DefusalKit";
for "_i" from 1 to 2 do {this addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 4 do {this addItemToUniform "ACE_morphine";};
for "_i" from 1 to 8 do {this addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {this addItemToUniform "ACE_epinephrine";};
this addItemToUniform "ACE_bloodIV_250";
this addItemToUniform "ACE_microDAGR";
this addItemToUniform "ACE_Flashlight_XL50";
this addItemToUniform "rhsusf_mag_15Rnd_9x19_JHP";
this addVest "rhsusf_iotv_ocp_Rifleman";
for "_i" from 1 to 2 do {this addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {this addItemToVest "HandGrenade";};
this addItemToVest "SmokeShellRed";
this addItemToVest "SmokeShellBlue";
this addBackpack "rhsusf_assault_eagleaiii_ocp";
this addHeadgear "rhsusf_ach_helmet_ocp";
this addWeapon "rhsusf_weap_m9";
this addWeapon "Binocular";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "tf_anprc152";
this linkItem "ItemGPS";