this = player;

removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;
this forceAddUniform "ARC_GER_Tropentarn_Uniform";
this addItemToUniform "ACE_MapTools";
this addItemToUniform "ACE_DefusalKit";
for "_i" from 1 to 2 do {this addItemToUniform "ACE_CableTie";};
this addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 8 do {this addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 4 do {this addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {this addItemToUniform "ACE_epinephrine";};
this addItemToUniform "ACE_bloodIV_500";
this addItemToUniform "16Rnd_9x21_Mag";
this addVest "ARC_GER_Tropentarn_Plate_Carrier";
for "_i" from 1 to 2 do {this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {this addItemToVest "SmokeShell";};
this addItemToVest "SmokeShellBlue";
this addItemToVest "SmokeShellRed";
for "_i" from 1 to 8 do {this addItemToVest "SMA_30Rnd_556x45_M855A1_Tracer";};
for "_i" from 1 to 5 do {this addItemToVest "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {this addItemToVest "1Rnd_Smoke_Grenade_shell";};
this addItemToVest "1Rnd_SmokeRed_Grenade_shell";
this addItemToVest "1Rnd_SmokeBlue_Grenade_shell";
this addHeadgear "ARC_GER_Tropentarn_Mich";
this addWeapon "SMA_HK416GL";
this addPrimaryWeaponItem "FHQ_optic_HWS";
this addWeapon "hgun_P07_F";
this addWeapon "Binocular";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "tf_anprc152";
this linkItem "ItemGPS";