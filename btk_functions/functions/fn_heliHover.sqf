/*
	File: fn_hover.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Makes a helicopter hover perfectly still.

	Parameter(s):
		0: OBJECT - the helicopter

	Returns:
	NIL

	Syntax:
	_hover = [myHeli] spawn BTK_fnc_hover;
*/


private ["_heli","_pitchBank","_pitch","_bank","_newSpeedX","_newSpeedY","_speed","_speedX","_speedY","_speedZ"];


_heli = _this select 0;


if (!(isNil {_heli getVariable "btk_fnc_hover_active"})) exitWith {};


_pitchBank = _heli call BIS_fnc_getPitchBank;
_pitch = _pitchBank select 0;
_bank = _pitchBank select 1;
_damage = damage _heli;


_newSpeedX = 0;
_newSpeedY = 0;


while {!(isNil {_heli getVariable "btk_fnc_hover_active"}) && (alive _heli) && (alive (driver _heli)) && ((damage _heli) < (_damage + 0.2))} do  {

	_speed =  velocity _heli;
	_speedX = _speed select 0;
	_speedY = _speed select 1;
	_speedZ = _speed select 2;

	if (_speedX > 0) then { _newSpeedX = (_speedX / 1.01); };
	if (_speedY > 0) then { _newSpeedY = (_speedY / 1.01); };
	if (_speedZ > 0) then { _newSpeedZ = (_speedZ / 1.0001); };

	[_heli, _Pitch,_Bank] call BIS_fnc_setPitchBank;
	_heli setVelocity [_newSpeedX, _newSpeedY, _speed_z];

	sleep 0.001;

};