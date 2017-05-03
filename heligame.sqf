GRAD_heligame_fnc_lz ={

  // Loop, um nach 10 Minuten den Server aufzuräumen.
  GRAD_Heligame_perFrame = [{
     params ["_args", "_handle"];

     if (diag_tickTime < GRAD_smokeTimer + 600) exitWith {};

     // Alles löschen
     hint "Heligame ist vorbei!";
     if (!isNil "GRAD_smoke_trg") then {deleteVehicle GRAD_smoke_trg};
     if (!isNil "GRAD_lz_trg") then {deleteVehicle GRAD_lz_trg};
     if (alive GRAD_lz_smoke) then {deleteVehicle GRAD_lz_smoke};
     deleteMarker str _start_marker_pos;
     deleteMarker "LZ";
     GRAD_Heligame_inProgress = false;
     [_handle] call CBA_fnc_removePerFrameHandler;

     },1,[]] call CBA_fnc_addPerFrameHandler;

  // Random Position für Smoke suchen.
  GRAD_lz_pos = [[9300, 17109], random 10000, random 360, 0, [1, 1000]] call SHK_pos;

  // Marker auf die Startposition setzen.
  start_marker_pos = getpos player;
  _start_marker = createMarker [str start_marker_pos, player];
  _start_marker SetMarkerShape "ICON";
  _start_marker setMarkerType "hd_start";
  _start_marker setMarkerColor "colorBLUFOR";

  // Orientieren des Startmarkers in die richtige Richtung
  _marker_winkel = player getDir GRAD_lz_pos;
  _start_marker setMarkerDir _marker_winkel;

  // Marker auf die Smokeposition setzen.
  _lz_marker = createMarker [str GRAD_lz_pos, GRAD_lz_pos];
  _lz_marker setMarkerShape "ICON";
  _lz_marker setMarkerType "hd_pickup";
  _lz_marker setMarkerColor "colorBLUFOR";

  // Trigger erstellen, um Smoke zu werfen.
  GRAD_smoke_trg = createTrigger ["EmptyDetector", GRAD_lz_pos];
  GRAD_smoke_trg setTriggerArea [2000, 2000, 0, false, 500];
  GRAD_smoke_trg setTriggerActivation ["ANY", "PRESENT", false];
  GRAD_smoke_trg setTriggerStatements [
  "this",
  "if (!isNil ""GRAD_lz_trg"") then {deleteVehicle GRAD_lz_trg};
    call GRAD_fnc_smokespawn;",
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
  GRAD_lz_smoke = _smokeColor createVehicle GRAD_lz_pos;
  hint "Smoke is on the deck!";

  // Trigger erstellen, um den Smoke zu löschen
  GRAD_lz_trg = createTrigger ["EmptyDetector", GRAD_lz_pos];
  GRAD_lz_trg setTriggerArea [30, 30, 0, false, 30];
  GRAD_lz_trg setTriggerActivation ["ANY", "PRESENT", false];
  GRAD_lz_trg setTriggerStatements
    [
      "this",
      "hint 'LZ erfolgreich!';
        if (!isNil ""GRAD_smoke_trg"") then {deleteVehicle GRAD_smoke_trg};
        deleteVehicle GRAD_lz_smoke;
        deleteMarker str start_marker_pos;
        deleteMarker str GRAD_lz_pos;
        call GRAD_heligame_fnc_lz;
        GRAD_smokeTimer = diag_tickTime
      ",
      "this"
    ];
  GRAD_lz_trg setTriggerTimeout [10, 15, 20, true];
};

GRAD_smokeTimer = diag_tickTime;
hint "Heligame beginnt!";
GRAD_Heligame_inProgress = true;
/*
GRAD_Heligame_centermarker = createMarker ["Center", [16914, 17109]];
GRAD_Heligame_centermarker SetMarkerShape "ICON";
GRAD_Heligame_centermarker setMarkerType "hd_unknown";
GRAD_Heligame_centermarker setMarkerColor "colorBLUFOR";
GRAD_Heligame_centermarker setMarkerAlpha 0; */
call GRAD_heligame_fnc_lz;
