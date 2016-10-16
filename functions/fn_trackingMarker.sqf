/*
	File: fn_trackingMarker.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Creates and attaches a marker to a group, for tracking their movement on the map.

	Parameter(s):
		0: GROUP - group to track

	Returns:
	STRING - created marker

	Syntax:
	_marker = [_group] call BTK_fnc_trackingMarker;
*/


private ["_group","_showId","_showCount","_side","_markerName","_leader","_marker"];


// Server only
if (!isServer) exitWith {};


// Parameter
_group = _this select 0;
_showId = if ((count _this) > 1) then { _this select 1; } else { false; };
_showCount = if ((count _this) > 2) then { _this select 2; } else { false; };
_side = (toLower(str(side _group)));
_markerName = ("btk_tracking_marker_" + str(_group));
_leader = (leader _group);


// Already exists
if (_markerName in allMapMarkers) exitWith {};


// Create marker
_marker = [false, _markerName, (getPosATL (vehicle (leader _group))), "ICON", ["mil_box", "ColorWhite", 1, [1.0, 1.0], 0, ""]] call BTK_fnc_createMarker;


// Marker flow
[_group, _marker, _side, _showId, _showCount] spawn {

	// Parameter
	_group = _this select 0;
	_marker = _this select 1;
	_side = _this select 2;
	_showId = _this select 3;
	_showCount = _this select 4;

	while {(({alive _x} count (units _group)) > 0)} do {

		// Update vehicle
		_vehicle = (vehicle (leader _group));

		// Prefix (side)
		_prefix = switch (_side) do {
			case ("west") : { "b_"; };
			case ("east") : { "o_"; };
			case ("guer") : { "n_"; };
			case ("civ") : { "n_"; };
			default { "n_"; };
		};

		// Suffix (type)
		_suffix = switch (true) do {
			case (_vehicle isKindOf "Man") : { "inf"; };
			case (_vehicle isKindOf "Car") : { "motor_inf"; };
			case (_vehicle isKindOf "Plane") : { "plane"; };
			case (_vehicle isKindOf "Helicopter") : { "air"; };
			case (_vehicle isKindOf "Tank") : { "armor"; };
			case (_vehicle isKindOf "Wheeled_APC") : { "mech_inf"; };
			case (_vehicle isKindOf "Ship") : { "naval"; };
			default { "unknown"; };
		};

		// Compile type
		_type = _prefix + _suffix;

		// Color (side)
		_color = switch (_side) do {
			case ("west") : { "ColorWEST"; };
			case ("east") : { "ColorEAST"; };
			case ("guer") : { "ColorGUER"; };
			case ("civ") : { "ColorCIV"; };
			default { "ColorUNKNOWN"; };
		};

		// Text
		_text = switch (true) do {
			case (_showId && !_showCount) : { format["%1", (groupID _group)]; };
			case (!_showId && _showCount) : { format["%1", (count (units _group))]; };
			case (_showId && _showCount) : { format["%1 (%2)", (groupID _group), (count (units _group))]; };
			default { ""; };
		};

		// Update
		_marker setMarkerText _text;
		_marker setMarkerType _type;
		_marker setMarkerColor _color;
		_marker setMarkerPos (getPos (vehicle (leader _group)));

		// Delay
		sleep 1.438;

	};

	sleep 5;

	_marker setMarkerColor "ColorUNKNOWN";
	_marker setMarkerAlpha 0.5;
	_marker setMarkerText "";

	sleep 60;

	deleteMarker _marker;

};


_marker