/*
	File: fn_spawnComposition.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Spawn composition saved by BTK_fnc_getComposition.

	Parameter(s):
		0: POSITION - center position
		1: NUMBER - direction
		2: ARRAY - objects (composition)

	Returns:
	ARRAY - objects spawned

	Syntax:
	[(getPosATL player), (getDir player), [["Land_BagFenceLong",[-0.0991211,1.8042,-0.028245],359.928,1,0,false],["Land_BagFenceLong",[2.87744,1.83008,-0.0295877],359.923,1,0,false],["Land_BagFenceLong",[-3.06006,1.76318,-0.0251417],359.937,1,0,false],["Land_Photos_V1_F",[-0.0473633,3.56641,0.81],359.946,1,0,false],["FoldTable",[-0.141113,3.62207,0.00106096],359.946,1,0,false],["FoldChair",[-0.115234,4.53955,0.00149822],359.936,1,0,false]]] call BTK_fnc_spawnComposition;
*/


private ["_pos","_azi","_objects","_newObjs","_file","_posX","_posY"];


_pos = _this select 0;
_azi = _this select 1;
_objects = _this select 2;


_newObjs = [];

_posX = _pos select 0;
_posY = _pos select 1;


_multiplyMatrixFunc = {

	private ["_array1","_array2","_result"];

	_array1 = _this select 0;
	_array2 = _this select 1;

	_result = [(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)), (((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))];

	_result

};


{

	private ["_type","_pos","_dir","_fuel","_damage","_simulation","_rotMatrix","_newRelPos","_newPos","_object"];
	
	_type = _x select 0;
	_pos = _x select 1;
	_dir = _x select 2;
	_fuel = _x select 3;
	_damage = _x select 4;
	_simulation = _x select 5;

	_rotMatrix = [[cos _azi, sin _azi], [-(sin _azi), cos _azi]];	
	_newRelPos = [_rotMatrix, _pos] call _multiplyMatrixFunc;
	_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), (_pos select 2)];

	//_object = createVehicle [_type, _newPos, [], 0, "NONE"];
	_object = createVehicle [_type, _newPos, [], 0, "CAN_COLLIDE"];
	_object setDir (_azi + _dir);
	_object setPosATL _newPos;
	_object setFuel _fuel;
	if (_damage != 0) then { _object setDamage _damage; };
	if (!_simulation) then { if (isMultiplayer) then { _object enableSimulationGlobal false; } else {  _object enableSimulation false; }; };

	_newObjs pushBack _object;

} forEach _objects;


_newObjs