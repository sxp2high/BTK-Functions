/*
	File: fn_usercolor.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Return user GUI color in HTML or RGB.

	Parameter(s):
		0: BOOLEAN - true for thml, false for RGBA

	Returns:
	ARRAY - html code / RGBA array

	Syntax:
	_colorHTML = [true] call BTK_fnc_usercolor;
	_colorRGB = [false] call BTK_fnc_usercolor;
*/


// Parameter
_html = _this select 0;


// Convert to html?
_return = if (_html) then {

	[(profileNamespace getVariable ["GUI_BCG_RGB_R", 0.3843]), (profileNamespace getVariable ["GUI_BCG_RGB_G", 0.7019]), (profileNamespace getVariable ["GUI_BCG_RGB_B", 0.8862]), (profileNamespace getVariable ["GUI_BCG_RGB_A", 0.7])] call BIS_fnc_colorRGBAtoHTML;

} else {

	[(profileNamespace getVariable ["GUI_BCG_RGB_R", 0.3843]), (profileNamespace getVariable ["GUI_BCG_RGB_G", 0.7019]), (profileNamespace getVariable ["GUI_BCG_RGB_B", 0.8862]), (profileNamespace getVariable ["GUI_BCG_RGB_A", 0.7])];

};


_return