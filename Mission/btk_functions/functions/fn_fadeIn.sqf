/*
	File: fn_fadeIn.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Fade in from black screen.

	Parameter(s):
		0: NUMBER - delay
		1: NUMBER - fade in time
		2 (Optional): NUMBER - fade out time at start

	Returns:
	NIL

	Syntax:
	[5, 3] spawn BTK_fnc_fadeIn; // 5 sec. black, then fade in over 3 sec.
*/


// Parameter
_delay = _this select 0;
_fade = _this select 1;
_fadeOut = if (count _this > 2) then { _this select 2; } else { 0.001; };


// Register layer
if (isNil "btk_fadein_layer") then { btk_fadein_layer = ["btk_fadein_layer"] call BIS_fnc_rscLayer; };
waitUntil {!(isNil "btk_fadein_layer")};


// Black out
btk_fadein_layer cutText ["", "BLACK OUT", _fadeOut];


// Black out
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [5];
"dynamicBlur" ppEffectCommit 0;


// Delay
sleep _delay;


// Blur in
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit _fade;
sleep 0.1;


// Black in
btk_fadein_layer cutText ["", "BLACK IN", _fade];