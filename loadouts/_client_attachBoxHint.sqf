[_this select 0, _this select 1] spawn {
	while {true} do {
	_obj = _this select 0;
	_name = _this select 1;
		waitUntil {
		  // code...
		
		  sleep 0.5; player distance _obj < 2
		};
		hintSilent parseText format ["%1",_name];
		sleep 0.5;
	};
	
};