GRAD_smokeTimer = diag_tickTime;
hint "Heligame beginnt!";
GRAD_Heligame_inProgress = true;
_GRAD_lz_pos = "";
_start_marker_pos = "";
_GRAD_smoke_trg = "";
_GRAD_lz_trg = "";
_GRAD_lz_smoke = "";

// Loop, um nach 10 Minuten den Server aufzuräumen.
[
  {
  if (diag_tickTime < GRAD_smokeTimer + 600) exitWith {};

  // Alles löschen
  hint "Heligame ist vorbei!";
  if (!isNil "_GRAD_smoke_trg") then {deleteVehicle _GRAD_smoke_trg};
  if (!isNil "_GRAD_lz_trg") then {deleteVehicle _GRAD_lz_trg};
  if (alive _GRAD_lz_smoke) then {deleteVehicle _GRAD_lz_smoke};
  deleteMarker str _start_marker_pos;
  deleteMarker str _GRAD_lz_pos;
  GRAD_Heligame_inProgress = false;
  [_handle] call CBA_fnc_removePerFrameHandler;

  },1,[]] remoteExec ["CBA_fnc_addPerFrameHandler", -2
];

GRAD_heligame_fnc_lz ={

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
  _GRAD_smoke_trg setTriggerStatements [
  "this",
  format ["if (!isNil ""_GRAD_lz_trg"") then (deleteVehicle _GRAD_lz_trg);
  [%1, %2, %3, %4] call GRAD_fnc_smokespawn", _GRAD_lz_pos, _GRAD_smoke_trg, _start_marker_pos, _start_marker_pos],
  /*
  "format ["if (!isNil ""_GRAD_lz_trg"") then {deleteVehicle _GRAD_lz_trg};
    [%1, %2, %3, %4] call GRAD_fnc_smokespawn;"],
    _GRAD_lz_pos, _GRAD_smoke_trg, _start_marker_pos, _start_marker_pos",
  */
  "this"
  ];
};

GRAD_fnc_smokespawn ={

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
  _GRAD_lz_trg setTriggerStatements
    [
      "this", "this",
      "hint 'LZ erfolgreich!';
        if (!isNil ""_GRAD_smoke_trg"") then {deleteVehicle _GRAD_smoke_trg};
        deleteVehicle _GRAD_lz_smoke;
        deleteMarker str _start_marker_pos;
        deleteMarker str _GRAD_lz_pos;
        forman[_GRAD_lz_trg] call GRAD_heligame_fnc_lz;
        GRAD_smokeTimer = diag_tickTime
      ",
      "this"
    ];
  _GRAD_lz_trg setTriggerTimeout [10, 15, 20, true];
};

call GRAD_heligame_fnc_lz;
