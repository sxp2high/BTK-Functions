/*
	File: fn_createMarker.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Creates a map marker.

	Parameter(s):
		0: BOOLEAN - create marker local or global (true for local)
		1: STRING - marker name
		2: ARRAY - marker position
		3: STRING - marker shape ("ICON", "ELLIPSE" or "RECTANGLE")
		4: ARRAY - marker parameters (type, color, alpha, size, dir, text)
		5 (Optional): SCALAR - timeout in seconds, after which the marker will be deleted

	Returns:
	STRING - the created marker

	Syntax:
	[true, "player_icon", (getPosATL player), "ICON", ["mil_triangle", "ColorRed", 1, [1,1], 45, "Text"]] call BTK_fnc_createMarker; // Create icon marker local
	[false, "player_marker", (getPosATL player), "ELLIPSE", ["Solid", "ColorBlue", 1, [500,500]]] call BTK_fnc_createMarker; // Create area marker global
*/


private ["_local","_markerName","_pos","_type","_parameter","_timeout","_marker"];


// Parameter
_local = _this select 0;
_markerName = _this select 1;
_pos = _this select 2;
_type = _this select 3;
_parameter = _this select 4;
_timeout = if ((count _this) > 5) then { _this select 5; } else { 0; };


// Already exists
if (_markerName in allMapMarkers) exitWith {};


// Local?
if (_local) then {

	_marker = createMarkerLocal [_markerName, _pos];
	_marker setMarkerShapeLocal _type;

	if (_type == "ICON") then {
		_marker setMarkerTypeLocal (_parameter select 0);
	} else {
		_marker setMarkerBrushLocal (_parameter select 0);
	};

	if ((_parameter select 1) != "") then { _marker setMarkerColorLocal (_parameter select 1); };
	_marker setMarkerAlphaLocal (_parameter select 2);
	_marker setMarkerSizeLocal (_parameter select 3);
	_marker setMarkerDirLocal (_parameter select 4);
	if ((count _parameter) > 5) then { _marker setMarkerTextLocal (_parameter select 5); };
	_marker setMarkerPosLocal _pos;

} else {

	_marker = createMarker [_markerName, _pos];
	_marker setMarkerShape _type;

	if (_type == "ICON") then {
		_marker setMarkerType (_parameter select 0);
	} else {
		_marker setMarkerBrush (_parameter select 0);
	};

	if ((_parameter select 1) != "") then { _marker setMarkerColor (_parameter select 1); };
	_marker setMarkerAlpha (_parameter select 2);
	_marker setMarkerSize (_parameter select 3);
	_marker setMarkerDir (_parameter select 4);
	if ((count _parameter) > 5) then { _marker setMarkerText (_parameter select 5); };
	_marker setMarkerPos _pos;

};


// Timeout?
if (_timeout > 0) then {

	// Schedule removal
	[_marker,_timeout,_local] spawn {
		sleep (_this select 1);
		if (_this select 2) then { deleteMarkerLocal (_this select 0); } else { deleteMarker (_this select 0); };
	};

};


_marker