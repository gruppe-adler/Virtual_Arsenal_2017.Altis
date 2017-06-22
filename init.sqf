call compile preprocessfilelinenumbers "SHK_pos\shk_pos_init.sqf";

[] execVM "grenadeStop.sqf";
[] execvm "protectzone.sqf";
setviewdistance 4000;

/*
// needed for automatic mousewheel loadouts
if (isServer) then {
	call compile preprocessfile "SHK_pos\shk_pos_init.sqf";
	0 = [getpos loadout_fahne] execVM "loadouts\createAutomaticLoadoutsBoxes.sqf";
};
// needed for automatic mousewheel loadouts
if (hasInterface) then {
	grad_addactionMP = {
		private["_object","_name","_scriptToCall"];

		_object = _this select 0;
		_name = _this select 1;
		_scriptToCall = _this select 2;

		if(isNull _object) exitWith {};

		_object addaction [_name, _scriptToCall, _Args, 10, false, true, "",""];
	};
};
*/


AR3PLAY_ENABLE_REPLAY = false;
