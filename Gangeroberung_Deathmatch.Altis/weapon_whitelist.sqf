AllowedWeapons = [
	"Rangefinder",
	"arifle_MX_SW_pointer_F",		// Default, Spawn waffe
	"arifle_AK12_F", 
	"arifle_AKM_F", 
	"arifle_AKS_F", 
	"arifle_CTAR_ghex_F", 
	"arifle_Katiba_F", 
	"LMG_03_F", 
	"srifle_DMR_03_F", 
	"srifle_DMR_06_olive_F",
	"srifle_EBR_F",
	"arifle_Mk20_plain_F",
	"arifle_MX_Black_F",
	"arifle_MX_khk_F",
	"arifle_MX_F",
	"arifle_MX_SW_F",
	"arifle_MXC_Black_F",
	"arifle_MXC_khk_F",
	"arifle_MXC_F",
	"arifle_MXM_Black_F",
	"arifle_MXM_khk_F",
	"arifle_MXM_F",
	"hgun_PDW2000_F",
	"SMG_05_F",
	"arifle_SDAR_F",
	"arifle_SPAR_01_blk_F",
	"arifle_SPAR_02_blk_F",
	"SMG_02_F",
	"arifle_ARX_blk_F",
	"SMG_01_F",
	"srifle_DMR_07_blk_F",
	
	// Pistols
	"hgun_Pistol_heavy_01_F",
	"hgun_ACPC2_F",
	"hgun_P07_F",
	"hgun_Pistol_01_F",
	"hgun_Pistol_Signal_F",
	"hgun_Pistol_heavy_02_F"
];

[] spawn {
	while{(!(isNull player) && alive player)} do {
		_weaponClass = currentWeapon player;
		
		if !(_weaponClass in AllowedWeapons) exitWith{
			hint "Die Waffe ist nicht erlaubt du Glitcher!\n Weg mit dir...";
			sleep 4;
			endMission "END1";
		};
	};
};