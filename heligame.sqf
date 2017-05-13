
// Loop, um nach 10 Minuten den Server aufzuräumen.
GRAD_heligame_fnc_cleanUp = {
    params ["_waitTime","_objects"];
    [{
        {
            if (_x isEqualType objNull && {!isNull _x}) then {
                deleteVehicle _x;
            } else {
                if (_x isEqualType "") then {
                    deleteMarker _x;
                };
            };
        } forEach _this;
    }, _objects, _waitTime] call CBA_fnc_waitAndExecute;
};

GRAD_heligame_fnc_start = {
    GRAD_heligame_inProgress = true;
    hint "Heligame beginnt!";
    [] call GRAD_heligame_fnc_lz;

    [{CBA_missionTime - GRAD_heligame_startTime > 600}, {
        GRAD_heligame_inProgress = false;
        hint "Heligame zu Ende!";
    }, []] call CBA_fnc_waitUntilAndExecute;
};

GRAD_heligame_fnc_lz ={
    GRAD_heligame_startTime = CBA_missionTime;

  // Random Position für Smoke suchen.
  _GRAD_lz_pos = [[9300, 17109], random 5000, random 360, 0, [1, 1000]] call SHK_pos;

  // Marker auf die Startposition setzen.
  _start_marker_pos = getpos player;
  _start_marker = createMarker [str _start_marker_pos, player];
  _start_marker SetMarkerShape "ICON";
  _start_marker setMarkerType "hd_start";
  _start_marker setMarkerColor "colorBLUFOR";

  // Orientieren des Startmarkers in die richtige Richtung
  _marker_winkel = player getDir _GRAD_lz_pos;
  _start_marker setMarkerDir _marker_winkel;

  // Marker auf die Smokeposition setzen.
  _lz_marker = createMarker [str _GRAD_lz_pos, _GRAD_lz_pos];
  _lz_marker setMarkerShape "ICON";
  _lz_marker setMarkerType "hd_pickup";
  _lz_marker setMarkerColor "colorBLUFOR";

  // Trigger erstellen, um Smoke zu werfen.
  _GRAD_smoke_trg = createTrigger ["EmptyDetector", _GRAD_lz_pos];
  _GRAD_smoke_trg setTriggerArea [1000, 1000, 0, false, 500];
  _GRAD_smoke_trg setTriggerActivation ["ANY", "PRESENT", false];
  _GRAD_smoke_trg setVariable ["_GRAD_localtemp", _GRAD_lz_trg];
  _GRAD_smoke_trg setTriggerStatements
  [
    "this",
    format ["
       [%1, '%2', '%3'] call GRAD_heligame_fnc_smokespawn;
       deleteVehicle thisTrigger;
    ",_GRAD_lz_pos, _start_marker, _lz_marker],
    "this"
  ];

  [600,[_GRAD_smoke_trg,_start_marker,_lz_marker]] remoteExec ["GRAD_heligame_fnc_cleanUp",2,false];
};

GRAD_heligame_fnc_smokespawn ={
  params ["_GRAD_lz_pos", "_start_marker", "_lz_marker"];

  // Zufällige Smokefarbe wählen.
  _smokeColor = selectRandom
    [
      "SmokeShellBlue",
      "SmokeShellOrange",
      "SmokeShellYellow",
      "SmokeShellRed",
      "SmokeShellPurple",
      "SmokeShellGreen"
    ];

  // Smoke spawnen.
  _GRAD_lz_smoke = _smokeColor createVehicle _GRAD_lz_pos;
  hint "Smoke is on the deck!";
  // Trigger erstellen, um den Smoke zu löschen
  _GRAD_lz_trg = createTrigger ["EmptyDetector", _GRAD_lz_pos];
  _GRAD_lz_trg setTriggerArea [30, 30, 0, false, 30];
  _GRAD_lz_trg setTriggerActivation ["ANY", "PRESENT", false];
  _GRAD_lz_trg setVariable ["GRAD_local_start_marker", _start_marker];
  _GRAD_lz_trg setVariable ["GRAD_local_lz_marker", _lz_marker];
  _GRAD_lz_trg setTriggerTimeout [10, 15, 20, true];
  _GRAD_lz_trg setTriggerStatements
    [
      "this",
      "
        hint 'LZ erfolgreich!';
        deleteMarker (thisTrigger getVariable 'GRAD_local_start_marker');
        deleteMarker (thisTrigger getVariable 'GRAD_local_lz_marker');
        [] call GRAD_heligame_fnc_lz;
        deleteVehicle thisTrigger;
      ",
      "this"
    ];

  [600,[_GRAD_lz_trg]] remoteExec ["GRAD_heligame_fnc_cleanUp",2,false];
};
