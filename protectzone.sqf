//protection zone approx radius 50m, will overlap
_pos1 = (getMarkerPos "pzone1");
_pzone1 = "ProtectionZone_Ep1" createVehicleLocal (_pos1);
//following makes it invisible
_pzone1 setObjectTexture [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];