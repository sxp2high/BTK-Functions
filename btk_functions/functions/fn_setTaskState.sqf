/*
	File: fn_setTaskState.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Change task state. More reliable and flexible than BIS_fnc_setTaskState.

	Parameter(s):
		0: ARRAY - target
		1: STRING - unique task id
		2: STRING - new state (can be: "Succeeded","Failed","Canceled","Created","Assigned")
		3: BOOLEAN - show task hint/notification

	Returns:
	BOOLEAN - true when task updated

	Syntax:
	_taskUpdated = [[_units], "uniqueid", "Succeeded", true] call BTK_fnc_setTaskState;
*/


private ["_units","_taskId","_status","_hint"];


// Parameter
_units = _this select 0;
_taskId = _this select 1;
_status = _this select 2;
_hint = _this select 3;


// Make status persistent
if (isNil {missionNameSpace getVariable ("btk_task_status_" + _taskId)}) then {
	missionNameSpace setVariable [("btk_task_status_" + _taskId), _status]; publicVariable ("btk_task_status_" + _taskId);
};


// Update all units
{

	private ["_unit","_taskVar","_task","_taskTitle"];

	_unit = _x;

	// Local only
	if (local _unit) then {

		// Doesnt have this task
		if (isNil {_unit getVariable _taskId}) exitWith {};

		// Get task
		_taskVar = _unit getVariable _taskId;
		_task = _taskVar select 0;
		_taskTitle = _taskVar select 1;

		// Set state
		_task setTaskState _status;

		// Show notification?
		if (_hint && (_unit == player)) then { [("Task" + _status), ["", _taskTitle]] call BIS_fnc_showNotification; };

	};

} forEach _units;


true