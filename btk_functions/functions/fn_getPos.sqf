/*
	File: fn_getPos.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Converts anything into a position.

	Parameter(s):
		0: ANY - currently supported: position, group, location, object, string (marker), task (task destination)

	Returns:
	POSITION - the position

	Syntax:
	_groupPos = [(group player)] call BTK_fnc_getPos;
*/


private ["_center","_pos"];


// Parameter
_center = _this select 0;


// Convert
_pos = switch (typeName _center) do {

	case ("ARRAY") : { _center; };
	case ("POSITION") : { _center; };

	case ("GROUP") : {

		if (surfaceIsWater (getPos (leader _center))) then {
			(getPosASL (vehicle (leader _center)));
		} else {
			(getPosATL (vehicle (leader _center)));
		};

	};

	case ("LOCATION") : { (position _center); };

	case ("OBJECT") : {

		if (surfaceIsWater (getPos _center)) then {
			(getPosASL _center);
		} else {
			(getPosATL _center);
		};

	};

	case ("STRING") : { (getMarkerPos _center); };

	case ("TASK") : { (taskDestination _center); };

	default { [0, 0, 0]; };

};


_pos