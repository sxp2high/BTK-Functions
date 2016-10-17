/*
	Example for class restriction
	
	_vests = switch (typeOf player) do {
		case ("rhsusf_army_ocp_autorifleman") : { ["V_PlateCarrier1_rgr"]; };
		default { ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"]; };
	};

*/


_uniforms = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt"];

_vests = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_Chestrig_rgr","V_HarnessOGL_brn", "V_PlateCarrierGL_mtp", "V_PlateCarrierSpec_mtp", "V_RebreatherB","V_BandollierB_rgr","V_TacVest_oli"];

_headgears = ["H_HelmetB_plain_blk", "H_HelmetB_plain_mcamo", "H_HelmetB", "H_HelmetB_black", "H_HelmetB_camo", "H_HelmetB_desert", "H_HelmetB_grass", "H_HelmetB_light", "H_HelmetB_light_black", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_sand", "H_HelmetB_light_snakeskin", "H_HelmetB_sand", "H_HelmetB_snakeskin", "H_HelmetB_paint", 
	"H_CrewHelmetHeli_B", "H_PilotHelmetHeli_B", "H_PilotHelmetFighter_B", 
	"H_HelmetSpecB", "H_HelmetSpecB_blk", "H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", 
	"H_Booniehat_mcamo", 
	"H_MilCap_mcamo", "H_Cap_oli_hs", "H_Cap_tan_specops_US",
	"H_Bandanna_mcamo",
	"H_Watchcap_blk", "H_Watchcap_camo", "H_Watchcap_khk", "H_Beret_02"];

_attachments = ["acc_flashlight", "acc_pointer_IR",
	"optic_AMS_snd", "optic_Arco", "optic_DMS", "optic_KHS_tan", "optic_LRPS", "optic_Holosight", "optic_Holosight_smg", "optic_SOS", "optic_MRCO", "optic_NVS", "optic_Hamr", "optic_tws", "optic_tws_mg",
	"muzzle_snds_93mmg_tan", "muzzle_snds_H", "muzzle_snds_L", "muzzle_snds_B", "muzzle_snds_H_MG", "muzzle_snds_M", "muzzle_snds_338_sand", 
	"bipod_01_F_snd", "bipod_01_F_blk", "bipod_01_F_mtp"];

_glasses = ["G_Spectacles", "G_Spectacles_Tinted", 
	"G_Combat", 
	"G_Lowprofile", 
	"G_Shades_Black", "G_Shades_Green", "G_Shades_Red", 
	"G_Squares", "G_Squares_Tinted",
	"G_Sport_BlackWhite", "G_Sport_Blackyellow", "G_Sport_Greenblack", "G_Sport_Checkered", "G_Sport_Red", "G_Sport_Blackred", 
	"G_Shades_Blue",
	"G_Tactical_Black",
	"G_Aviator",
	"G_Diving", 
	"T_HoodTanBlk", "T_HoodTanCLR", "Shemagh_FaceTan", "L_Shemagh_Tan", "LBG_Shemagh_Tan", "LCG_Shemagh_Tan", "LOG_Shemagh_Tan", "T_HoodTanOG", "PU_shemagh_Tan", "PU_shemagh_TanBLK", "PU_shemagh_TanCLR", "PU_shemagh_TanO", "NeckTight_Tan", "NeckTight_TanBLK", "NeckTight_TanCLR", "NeckTight_TanO",
	"G_Bandanna_khk", "G_Bandanna_tan", 
	"Mask_M40", "Mask_M40_OD", "Mask_M50"];

_Items = ["Binocular", "Laserdesignator", "Rangefinder",
	"NVGoggles",
	"ItemGPS", "B_UavTerminal",
	"FirstAidKit", "Medikit", 
	"ToolKit", "MineDetector"];

//_itemsSpecial = ["GLT_Item_Bandage", "GLT_Item_Epinephrine", "GLT_Item_Morphine", "GLT_Item_Canteen"];
_itemsSpecial = [];

	
_backpacks = ["B_AssaultPack_rgr", "B_AssaultPack_mcamo",
	"B_Bergen_mcamo", 
	"B_Carryall_mcamo",
	"B_AssaultPack_rgr_Medic", "B_AssaultPack_rgr_Repair", "B_AssaultPack_rgr_LAT",
	"B_Kitbag_mcamo", 
	"B_TacticalPack_mcamo", 
	"B_GMG_01_A_weapon_F", "B_HMG_01_A_weapon_F", "B_HMG_01_support_F",
	"B_Respawn_Sleeping_bag_brown_F", "B_Respawn_TentA_F", "B_Static_Designator_01_weapon_F", "B_UAV_01_backpack_F", "B_Parachute"];

_weapons = ["hgun_P07_F", "hgun_Pistol_heavy_01_F",
	"arifle_Mk20_plain_F", "arifle_Mk20_GL_plain_F", "arifle_Mk20C_plain_F", 
	"arifle_MX_F", "arifle_MX_GL_F", "arifle_MXC_F", "arifle_MXM_F", 
	"arifle_SDAR_F",
	"LMG_Mk200_F",
	"MMG_01_tan_F", "MMG_02_sand_F", 
	"srifle_DMR_05_tan_f", "srifle_LRR_F", "srifle_EBR_F",
	"launch_NLAW_F", "launch_B_Titan_short_F", 
	"launch_B_Titan_F"];

_magazines = ["16Rnd_9x21_Mag", "30Rnd_9x21_Mag", "11Rnd_45ACP_Mag",
	"30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Red", "30Rnd_556x45_Stanag_Tracer_Green", "30Rnd_556x45_Stanag_Tracer_Yellow",
	"30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag_Tracer", 
	"20Rnd_762x51_Mag",
	"20Rnd_556x45_UW_mag",
	"150Rnd_762x51_Box", "150Rnd_762x51_Box_Tracer",
	"130Rnd_338_Mag",
	"150Rnd_93x64_Mag", 
	"200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box_Tracer",
	"10Rnd_93x64_DMR_05_Mag", "7Rnd_408_Mag",
	"NLAW_F",
	"Titan_AT", "Titan_AP",
	"Titan_AA",
	"HandGrenade", "MiniGrenade", "Laserbatteries",
	"1Rnd_HE_Grenade_shell", "3Rnd_HE_Grenade_shell", 
	"1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeRed_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell", "1Rnd_SmokeYellow_Grenade_shell", "1Rnd_SmokePurple_Grenade_shell", "1Rnd_SmokeOrange_Grenade_shell", 
	"3Rnd_Smoke_Grenade_shell", "3Rnd_SmokeRed_Grenade_shell", "3Rnd_SmokeGreen_Grenade_shell", "3Rnd_SmokeBlue_Grenade_shell", "3Rnd_SmokeYellow_Grenade_shell", "3Rnd_SmokePurple_Grenade_shell", "3Rnd_SmokeOrange_Grenade_shell",
	"UGL_FlareWhite_F", "UGL_FlareGreen_F", "UGL_FlareRed_F", "UGL_FlareYellow_F", "UGL_FlareCIR_F", 
	"SmokeShell","SmokeShellRed","SmokeShellGreen", "SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange",
	"ATMine_Range_Mag", "APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag", "APERSTripMine_Wire_Mag", "ClaymoreDirectionalMine_Remote_Mag", "SatchelCharge_Remote_Mag", "DemoCharge_Remote_Mag", 
	"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"];


// Init
[
	false,
	(_uniforms + _vests + _headgears + _attachments + _glasses + _items),
	_itemsSpecial,
	_backpacks,
	_weapons,
	_magazines
] call BTK_fnc_arsenalInit;


// Availability conditions for mission (Arsenal is always only available when player is not in vehicle)
[] spawn {

	
	while {true} do {

		waitUntil {(player distance btk_arsenal_center) < 5};
		btk_arsenal_available = true;

		waitUntil {(player distance btk_arsenal_center) > 5};
		btk_arsenal_available = nil;

	};

};