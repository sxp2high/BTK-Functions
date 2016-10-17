/*
	Example for class restriction
	
	_vests = switch (typeOf player) do {
		case ("rhsusf_army_ocp_autorifleman") : { ["V_PlateCarrier1_rgr"]; };
		default { ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"]; };
	};

*/


_uniforms = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_CombatUniform_mcam_vest", "U_B_survival_uniform", "U_B_CombatUniform_mcam_worn",
	"U_B_HeliPilotCoveralls", "U_B_PilotCoveralls",
	"U_B_Wetsuit",
	"GLT_Uniform_Ghillie1", "GLT_Uniform_Ghillie2", "GLT_Uniform_Ghillie3", "U_B_GhillieSuit",
	"U_B_FullGhillie_ard", "U_B_FullGhillie_lsh", "U_B_FullGhillie_sard"];

_vests = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_Chestrig_rgr","V_HarnessOGL_brn", "V_PlateCarrierGL_mtp", "V_PlateCarrierSpec_mtp", "V_RebreatherB","V_BandollierB_rgr","V_TacVest_oli","rhsusf_iotv_ocp_teamleader"];

_headgears = ["H_HelmetB_plain_blk", "H_HelmetB_plain_mcamo", "H_HelmetB", "H_HelmetB_black", "H_HelmetB_camo", "H_HelmetB_desert", "H_HelmetB_grass", "H_HelmetB_light", "H_HelmetB_light_black", "H_HelmetB_light_desert", "H_HelmetB_light_grass", "H_HelmetB_light_sand", "H_HelmetB_light_snakeskin", "H_HelmetB_sand", "H_HelmetB_snakeskin", "H_HelmetB_paint", 
	"H_CrewHelmetHeli_B", "H_PilotHelmetHeli_B", "H_PilotHelmetFighter_B", 
	"H_HelmetSpecB", "H_HelmetSpecB_blk", "H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", 
	"H_Booniehat_mcamo", 
	"H_MilCap_mcamo", "H_Cap_oli_hs", "H_Cap_tan_specops_US", "GLT_Cap_MAD_SIN", "GLT_Cap_Major_League_Infidel",
	"H_Bandanna_mcamo",
	"H_Watchcap_blk", "H_Watchcap_camo", "H_Watchcap_khk", "GLT_Woolhat_Fuck_ISIS_Black", "GLT_Woolhat_Fuck_ISIS_Green",
	"H_Beret_02"];

_attachments = ["acc_flashlight", "acc_pointer_IR",
	"optic_AMS_snd", "optic_Arco", "optic_DMS", "optic_KHS_tan", "optic_LRPS", "optic_Holosight", "optic_Holosight_smg", "optic_SOS", "optic_MRCO", "optic_NVS", "optic_Hamr", "optic_tws", "optic_tws_mg",
	"muzzle_snds_93mmg_tan", "muzzle_snds_H", "muzzle_snds_L", "muzzle_snds_B", "muzzle_snds_H_MG", "muzzle_snds_M", "muzzle_snds_338_sand", 
	"muzzle_mas_snds_SVc", "muzzle_mas_snds_SMc", "muzzle_mas_snds_SHc", 
	"muzzle_mas_snds_M", "muzzle_mas_snds_Mc", 
	"bipod_01_F_snd", "bipod_01_F_blk", "bipod_01_F_mtp"];

_glasses = ["G_Spectacles", "G_Spectacles_Tinted", 
	"G_Combat", 
	"G_Lowprofile", 
	"G_Shades_Black", "G_Shades_Green", "G_Shades_Red", 
	"G_Squares", "G_Squares_Tinted",
	"G_Sport_BlackWhite", "G_Sport_Blackyellow", "G_Sport_Greenblack", "G_Sport_Checkered", "G_Sport_Red", "G_Sport_Blackred", 
	"G_Shades_Blue",
	"G_Tactical_Black", "G_mas_wpn_gog", "G_mas_wpn_gog_d", "G_mas_wpn_gog_m", "G_mas_wpn_gog_md", "G_mas_wpn_mask_b", "G_mas_wpn_mask",
	"G_Aviator",
	"G_Diving", 
	"T_HoodTanBlk", "T_HoodTanCLR", "Shemagh_FaceTan", "L_Shemagh_Tan", "LBG_Shemagh_Tan", "LCG_Shemagh_Tan", "LOG_Shemagh_Tan", "T_HoodTanOG", "PU_shemagh_Tan", "PU_shemagh_TanBLK", "PU_shemagh_TanCLR", "PU_shemagh_TanO", "NeckTight_Tan", "NeckTight_TanBLK", "NeckTight_TanCLR", "NeckTight_TanO", "GLT_Balaclava_G",
	"G_mas_wpn_bala_gog_b", "G_mas_wpn_bala_gog_t", "G_mas_wpn_bala_mask_b", "G_mas_wpn_bala_mask_t", "G_mas_wpn_bala_b", "G_mas_wpn_bala_t", 
	"G_Bandanna_khk", "G_Bandanna_tan", 
	"Mask_M40", "Mask_M40_OD", "Mask_M50"];

_Items = ["Binocular", "Laserdesignator", "Rangefinder", "Rangefinder_mas_h", 
	"NVGoggles", "NVGoggles_mas_mask2_t", "NVGoggles_mas_mask3", "NVGoggles_mas_mask_b",
	"ItemGPS", "B_UavTerminal",
	"FirstAidKit", "Medikit", 
	"ToolKit", "MineDetector"];

_itemsSpecial = ["GLT_Item_Bandage", "GLT_Item_Epinephrine", "GLT_Item_Morphine", "GLT_Item_Canteen"];

	
_backpacks = ["B_AssaultPack_rgr", "B_AssaultPack_mcamo", "B_mas_AssaultPack_black", 
	"B_Bergen_mcamo", 
	"B_Carryall_mcamo",
	"GLT_Backpack_Medic_Black", "B_AssaultPack_rgr_Medic", "B_AssaultPack_rgr_Repair", "B_AssaultPack_rgr_LAT",
	"B_Kitbag_mcamo", 
	"B_TacticalPack_mcamo", 
	"B_GMG_01_A_weapon_F", "B_HMG_01_A_weapon_F", "B_HMG_01_support_F",
	"B_Respawn_Sleeping_bag_brown_F", "B_Respawn_TentA_F", "B_Static_Designator_01_weapon_F", "B_UAV_01_backpack_F", "B_Parachute"];

_weapons = ["hgun_P07_F", "hgun_Pistol_heavy_01_F", "hgun_mas_mp7_F", "hgun_mas_mp7p_F", "hgun_mas_acp_F", "hgun_mas_m9_F", 
	"arifle_mas_m4", "arifle_mas_m4_gl_d", "arifle_mas_m4_m203_d", 
	"arifle_Mk20_plain_F", "arifle_Mk20_GL_plain_F", "arifle_Mk20C_plain_F", 
	"arifle_MX_F", "arifle_MX_GL_F", "arifle_MXC_F", "arifle_MXM_F", 
	"arifle_mas_mk17", "arifle_mas_mk17_gl", 
	"arifle_mas_mk16_l", "arifle_mas_mk16_l_gl", "arifle_mas_mk16", "arifle_mas_mk16_gl", 
	"GLT_M32", 
	"arifle_SDAR_F",
	"LMG_mas_m240_F", "LMG_mas_M249a_F", "LMG_mas_M249_F_d", "LMG_mas_m60_F", "LMG_Mk200_F", "LMG_mas_mk48_F_d", "LMG_mas_Mk200_F",
	"MMG_01_tan_F", "MMG_02_sand_F", 
	"srifle_DMR_05_tan_f", "srifle_LRR_F", "srifle_EBR_F", "srifle_mas_m24_d", "srifle_mas_mk17s", "srifle_mas_sr25_d", "srifle_mas_ebr", 
	"srifle_mas_m107_d", "srifle_mas_m110", 
	"mas_launch_M136_F", "mas_launch_maaws_F", "mas_launch_LAW_F", "mas_launch_NLAW_F", "launch_NLAW_F", "mas_launch_smaw_F", "launch_B_Titan_short_F", 
	"mas_launch_Stinger_F", "launch_B_Titan_F"];

_magazines = ["16Rnd_9x21_Mag", "30Rnd_9x21_Mag", "11Rnd_45ACP_Mag", "40Rnd_mas_46x30_mag", "12Rnd_mas_45acp_Mag", "10Rnd_mas_45acp_Mag", "8Rnd_mas_45acp_Mag", "15Rnd_mas_9x21_Mag", "16Rnd_mas_9x21_Mag", "17Rnd_mas_9x21_Mag", "13Rnd_mas_9x21_Mag",
	"30Rnd_mas_556x45_Stanag", "30Rnd_mas_556x45_T_Stanag", "30Rnd_556x45_Stanag", "30Rnd_556x45_Stanag_Tracer_Red", "30Rnd_556x45_Stanag_Tracer_Green", "30Rnd_556x45_Stanag_Tracer_Yellow",
	"30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag_Tracer", 
	"20Rnd_mas_762x51_Stanag", "20Rnd_mas_762x51_T_Stanag", "20Rnd_762x51_Mag",
	"20Rnd_556x45_UW_mag",
	"100Rnd_mas_762x51_Stanag", "100Rnd_mas_762x51_T_Stanag", "150Rnd_762x51_Box", "150Rnd_762x51_Box_Tracer",
	"130Rnd_338_Mag",
	"150Rnd_93x64_Mag", 
	"200Rnd_mas_556x45_Stanag", "200Rnd_mas_556x45_T_Stanag", "200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box_Tracer",
	"10Rnd_93x64_DMR_05_Mag", "7Rnd_408_Mag",
	"5Rnd_mas_762x51_Stanag", "5Rnd_mas_762x51_T_Stanag",
	"5Rnd_mas_127x99_Stanag", "5Rnd_mas_127x99_dem_Stanag", "5Rnd_mas_127x99_T_Stanag", 
	"mas_M136", "mas_M136_HE",
	"mas_MAAWS", "mas_MAAWS_HE",
	"mas_LAW",
	"mas_NLAW", "mas_NLAW_HE", "NLAW_F",
	"mas_SMAW", "mas_SMAW_HE", "mas_SMAW_NE",
	"Titan_AT", "Titan_AP",
	"mas_Stinger", "Titan_AA",
	"HandGrenade", "MiniGrenade", "Laserbatteries",
	"1Rnd_HE_Grenade_shell", "3Rnd_HE_Grenade_shell", 
	"1Rnd_Smoke_Grenade_shell", "1Rnd_SmokeRed_Grenade_shell", "1Rnd_SmokeGreen_Grenade_shell", "1Rnd_SmokeBlue_Grenade_shell", "1Rnd_SmokeYellow_Grenade_shell", "1Rnd_SmokePurple_Grenade_shell", "1Rnd_SmokeOrange_Grenade_shell", 
	"3Rnd_Smoke_Grenade_shell", "3Rnd_SmokeRed_Grenade_shell", "3Rnd_SmokeGreen_Grenade_shell", "3Rnd_SmokeBlue_Grenade_shell", "3Rnd_SmokeYellow_Grenade_shell", "3Rnd_SmokePurple_Grenade_shell", "3Rnd_SmokeOrange_Grenade_shell",
	"GLT_6Rnd_HE_M203", 
	"GLT_6Rnd_Smoke_M203", "GLT_6Rnd_SmokeRed_M203", "GLT_6Rnd_SmokeGreen_M203", "GLT_6Rnd_SmokeYellow_M203", 
	"GLT_6Rnd_FlareWhite_M203", "GLT_6Rnd_FlareGreen_M203", "GLT_6Rnd_FlareRed_M203", "GLT_6Rnd_FlareYellow_M203", 
	"UGL_FlareWhite_F", "UGL_FlareGreen_F", "UGL_FlareRed_F", "UGL_FlareYellow_F", "UGL_FlareCIR_F", 
	"SmokeShell","SmokeShellRed","SmokeShellGreen", "SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange",
	"ATMine_Range_Mag", "APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag", "APERSTripMine_Wire_Mag", "ClaymoreDirectionalMine_Remote_Mag", "SatchelCharge_Remote_Mag", "DemoCharge_Remote_Mag", 
	"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"];


// Init
[
	true,
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