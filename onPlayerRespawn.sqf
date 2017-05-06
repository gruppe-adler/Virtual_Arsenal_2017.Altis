// initPlayerlocal für Heligame
[] spawn
{
    waitUntil {!isNull player && !isNil "SHK_pos" && !isNull (findDisplay 46)};
    player addAction ["Heligame!", "heligame.sqf", nil, 1.5, true, true, "", "!GRAD_Heligame_inProgress && (vehicle _target) isKindOf 'Air'"];
};
