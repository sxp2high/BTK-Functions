/*
	File: fn_error.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Show errors message and/or logs it.
	(Based on BIS_fnc_error)

	Parameter(s):
		0: STRING - title text
		1: STRING - error message
		2 (Optional): BOOLEAN - true to log
		3 (Optional): BOOLEAN - true to show gui message

	Returns:
	BOOLEAN - true when done

	Syntax:
	_done = ["ERROR", "Hello World!", true, true] call BTK_fnc_error;
*/


private ["_text","_log","_message","_messageText"];


_title = _this select 0;
_text = _this select 1;
_log = if ((count _this) > 2) then { _this select 2; } else { true; };
_message = if ((count _this) > 3) then { _this select 3; } else { true; };


if (_log) then {

	[_title + ": " + _text] call BTK_fnc_log;

};


if (_message) then {

	_messageText = parseText (format["<t font='PuristaMedium' size='2.0'><t size='1.6' color='%2'>%3  </t>%1</t>", _text, ([true] call BTK_fnc_usercolor), _title]);

	("BIS_fnc_error" call (uiNamespace getVariable "bis_fnc_rscLayer")) cutRsc ["RscFunctionError", "PLAIN"];
	((uiNamespace getVariable ["RscFunctionError", displayNull]) displayCtrl 1100) ctrlSetStructuredText _messageText;

	playSound "Hint";

};


true