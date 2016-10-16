/*
	File: fn_arsenalInit.sqf
	Author: sxp2high (BTK) (btk@arma3.cc)

	Description:
	Initialize arsenal for mission.

	Parameter(s):
		0: BOOLEAN - clear all items from player on opening arsenal for the first time?
		1: ARRAY - items uniforms, vests, headgears, attachments, glasses, items, etc.
		2: ARRAY - items special, items that don't show up in the lists can be force added with this
		3: ARRAY - backpacks
		4: ARRAY - weapons
		5: ARRAY - magazines

	Returns:
	BOOLEAN - true when initialized

	Syntax:
	_done = [true, ["U_B_CombatUniform_mcam"], ["GLT_Item_Bandage"], ["B_AssaultPack_rgr"], ["hgun_P07_F"], ["16Rnd_9x21_Mag"]] call BTK_fnc_arsenalInit;
*/


// Parameter
_clear = _this select 0;
_items = _this select 1;
_itemsSpecial = _this select 2;
_backpacks = _this select 3;
_weapons = _this select 4;
_magazines = _this select 5;


// Server add items global
if (isServer) then {

	// Items
	if ((count _items) > 0) then {
		{
			[missionNamespace, [_x], true, false] call BIS_fnc_addVirtualItemCargo;
		} forEach _items;
	};

	// Backpacks
	if ((count _backpacks) > 0) then {
		{
			[missionNamespace, [_x], true, false] call BIS_fnc_addVirtualBackpackCargo;
		} forEach _backpacks;
	};

	// Weapons
	if ((count _weapons) > 0) then {
		{
			[missionNamespace, [_x], true, false] call BIS_fnc_addVirtualWeaponCargo;
		} forEach _weapons;
	};

	// Magazines
	if ((count _magazines) > 0) then {
		{
			[missionNamespace, [_x], true, false] call BIS_fnc_addVirtualMagazineCargo;
		} forEach _magazines;
	};
	
};


// Exit dedciated here
if (isDedicated) exitWith {};


// Keys, variables
btk_arsenal_keys = [29, ((actionKeys "Gear") select 0)];
btk_arsenal_key_gear_name = [((actionKeys "Gear") select 0)] call BTK_fnc_keyNames;
btk_arsenal_key_gear_name_ctrl = [29] call BTK_fnc_keyNames;
btk_arsenal_text_layer = ["btk_arsenal_text_layer"] call BIS_fnc_rscLayer;
btk_arsenal_key_combination = btk_arsenal_key_gear_name_ctrl + " + " + btk_arsenal_key_gear_name;


// Add note
player createDiarySubject ["Arsenal", "Arsenal"];
player createDiaryRecord ["Arsenal", [format["Arsenal"], format["<br />This mission has Arsenal enabled for loadout selection.<br /><br />You will be notified by an on-screen message whenever it is available. (This might be only in certain locations or at certain times.)<br /><br />When available, press <font color='%1'>%2</font> to open the Arsenal.", ([true] call BTK_fnc_usercolor), btk_arsenal_key_combination]]];


// Clear?
if (_clear && (isNil "btk_arsenal_cleared")) then {

	// Flag
	btk_arsenal_cleared = true;

	// Clear
	removeAllAssignedItems player;
	removeBackpack player;
	removeUniform player;
	removeVest player;
	removeHeadgear player;
	//removeGoggles player;
	player removeWeapon (primaryWeapon player);
	player removeWeapon (handgunWeapon player);
	player removeWeapon (secondaryWeapon player);
	removeAllPrimaryWeaponItems player;
	removeAllHandgunItems player;

};


// Dialog flow
[] spawn {

	// Loop
	while {true} do {

		// Keys match
		waitUntil {(btk_arsenal_keys call BTK_fnc_keyCheck)};

		// Dialog open?
		if ((isNil "btk_arsenal_open") && !(isNil "btk_arsenal_available") && ((vehicle player) == player) && (alive player)) then {

			// Open
			btk_arsenal_open = true;
			[] spawn BTK_fnc_arsenal;

		} else {

			// Reset/close
			btk_arsenal_open = nil;

		};

		// Keys free or dead
		waitUntil {!(alive player) || !(btk_arsenal_keys call BTK_fnc_keyCheck)};

	};

};


// Available message
[] spawn {

	// Loop
	while {true} do {

		// Available, not open, player alive and on foot
		waitUntil {sleep 0.303; !(isNil "btk_arsenal_available") && (isNil "btk_arsenal_open") && ((vehicle player) == player) && (alive player)};

		// Show notification
		_text = format["<t align='left' shadow='2' shadowColor='#979797' color='%4'><t size='0.5'><t color='%3'>Arsenal Available</t></t><br /><t size='0.55'>Press <t color='%3'>%2</t> + <t color='%3'>%1</t> to select your loadout</t>", btk_arsenal_key_gear_name, btk_arsenal_key_gear_name_ctrl, "#ff8000", "#ffffff"];
		[_text, (safezoneY - 0.1 * safezoneH), (safezoneY + 0.55 * safezoneW), 9999, 0.5, 0, btk_arsenal_text_layer] spawn BIS_fnc_dynamicText;
		playSound "HintExpand";

		// While available, not open, player alive and on foot
		while {!(isNil "btk_arsenal_available") && (isNil "btk_arsenal_open") && ((vehicle player) == player) && (alive player)} do {
			sleep 0.1;
		};

		// Not available anymore
		sleep 1.1;
		playSound "HintCollapse";
		btk_arsenal_text_layer cutText ["", "PLAIN", 0.1];

	};

};


// Force add special items
_itemsSpecial spawn {

	_itemsSpecial = _this;

	// Loop
	while {true} do {

		// Arsenal open
		waitUntil {!(isNull (uiNamespace getvariable ["BIS_fnc_arsenal_cam", objnull]))};

		// Get arsenal display
		disableSerialization;
		_display = (uiNamespace getVariable "RscDisplayArsenal");
		_buttonSave = (_display displayCtrl 44146);
		_buttonLoad = (_display displayCtrl 44147);
		_buttonExport = (_display displayCtrl 44148);
		_buttonImport = (_display displayCtrl 44149);
		_buttonRandom = (_display displayCtrl 44150);
		_list = (_display displayCtrl 984);

		// Disable buttons for MP
		{
			_x ctrlEnable false;
			_x ctrlSetTooltip "Not available in multiplayer";
		} forEach [_buttonSave,_buttonLoad,_buttonLoad,_buttonExport,_buttonImport];

		//_buttonSave
		/*_buttonSave spawn {
			disableSerialization;
			sleep 1;
			buttonSetAction [44146, "hint 'ok?!';"];
			//buttonSetAction [_this, "hint 'ok?!';"];
		};*/

		// Add special items to items list
		if ((count _itemsSpecial) > 0) then {
			{

				_xCfg = configfile >> "cfgweapons" >> _x;
				_lbAdd = _list lnbaddrow ["",gettext (_xCfg >> "displayName"),str 0];
				_list lnbsetdata [[_lbAdd,0],_x];
				_list lnbsetpicture [[_lbAdd,0],gettext (_xCfg >> "picture")];
				_list lnbsetvalue [[_lbAdd,0],getnumber (_xCfg >> "itemInfo" >> "mass")];

			} forEach _itemsSpecial;
			
			
		};

		// While arsenal open
		while {!(isNull (uiNamespace getvariable ["BIS_fnc_arsenal_cam", objnull]))} do {

			// Anim
			if (((primaryWeapon player) == "")) then {
				if ((animationState player) != "amovpercmstpsnonwnondnon") then { player switchMove "amovpercmstpsnonwnondnon"; };
			} else {
				if ((animationState player) != "amovpercmstpslowwrfldnon") then { player switchMove "amovpercmstpslowwrfldnon"; };
			};

			sleep 0.971;

		};

		// Reset
		btk_arsenal_open = nil;

	};

};


true