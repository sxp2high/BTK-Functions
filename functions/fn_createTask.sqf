/*
	File: fn_createTask.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Creates a task. More reliable and flexible than BIS_fnc_taskCreate.

	Parameter(s):
		0: ARRAY - target units
		1: STRING - unique task id
		2: STRING - task title
		3: STRING - task descrition
		4: STRING - task hud/wp text (usually a shorter version of the title)
		5: POSITION - task position (If you dont wish for the task to have a position, use an empty array [])
		6: BOOLEAN - show task hint/notification?
		7: BOOLEAN - make this task the current?

	Returns:
	BOOLEAN - true when task created

	Syntax:
	_taskCreated = [[player], "uniqueid", "do something", "bla bla bla ...", "do", (getPosATL player), true, true] call BTK_fnc_createTask;
*/


private ["_units","_taskId","_taskTitle","_taskDescription","_hudText","_taskPos","_showHint","_makeCurrrent","_hasStatus","_status","_taskUpdated"];


// Parameter
_units = _this select 0;
_taskId = _this select 1;
_taskTitle = _this select 2;
_taskDescription = _this select 3;
_hudText = _this select 4;
_taskPos = _this select 5;
_showHint = _this select 6;
_makeCurrrent = _this select 7;
_hasStatus = if (!(isNil {missionNameSpace getVariable ("btk_task_status_" + _taskId)})) then { true; } else { false; };


// Add
{

	private ["_unit","_task"];

	_unit = _x;

	if (local _unit) then {

		_task = _unit createSimpleTask ["obj1"];
		_task setSimpleTaskDescription [_taskDescription, _taskTitle, _hudText];

		if ((count _taskPos) > 0) then { _task setSimpleTaskDestination _taskPos; };

		if (isNil {_unit getVariable _taskId}) then {
			_unit setVariable [_taskId, [_task, _taskTitle, _taskDescription, _hudText, _taskPos]];
		};

		// Make current/show notification?
		if (_makeCurrrent && !(_hasStatus)) then { _task setTaskState "Assigned"; _unit setCurrentTask _task; } else { _task setTaskState "Created"; };
		if (_showHint && (_unit == player) && !(_hasStatus)) then { ["TaskCreated", ["", _taskTitle]] call BIS_fnc_showNotification; };

		// Has been updated?
		if (_hasStatus) then {
			_status = missionNameSpace getVariable ("btk_task_status_" + _taskId);
			_taskUpdated = [[_x], _taskId, _status, false] call BTK_fnc_setTaskState;
		};

	};

} forEach _units;


true