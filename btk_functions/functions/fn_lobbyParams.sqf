/*
	File: fn_lobbyParams.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Convert lobby parameter into missionNamespace variables.

	Parameter(s):
		-

	Returns:
	BOOLEAN - true when done

	Syntax:
	_done = [] call BTK_fnc_lobbyParams;
*/


// Convert
for "_j" from 0 to ((count paramsArray) - 1) do {

	private ["_name","_value","_values","_texts","_selected"];

	_name = (configName ((missionConfigFile >> "Params") select _j));
	_value = (paramsArray select _j);
	_values = getArray (missionConfigFile >> "Params" >> _name >> "values");
	_texts = getArray (missionConfigFile >> "Params" >> _name >> "texts");
	_selected = str(_texts select (_values find _value));

	missionNamespace setVariable [_name, _value];
	missionNamespace setVariable [(_name + "_str"), _value];

};


true