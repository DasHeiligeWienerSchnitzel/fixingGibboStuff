_ER32_list = [
	[
		"Medical Crate",
		"ACE_medicalSupplyCrate_advanced",
		[
			["kat_vacuum", 5],
			["kat_bloodIV_O_N", 10],
			["kat_bloodIV_O_N_250", 10],
			["kat_bloodIV_O_N_500", 10],
			["kat_larynx", 10],
			["kat_aatKit", 5],
			["kat_chestSeal", 10],
			["kat_IO_FAST", 10],
			["kat_IV_16", 10],
			["kat_amiodarone", 5],
			["kat_atropine", 5],
			["kat_Carbonate", 5],
			["kat_EACA", 10],
			["kat_fentanyl", 3],
			["kat_ketamine", 3],
			["kat_lidocaine", 5],
			["kat_nalbuphine", 3],
			["kat_naloxone", 10],
			["kat_nitroglycerin", 3],
			["kat_norepinephrine", 3],
			["kat_Painkiller", 10],
			["kat_phenylephrine", 3],
			["kat_TXA", 10],
			["kat_etomidate", 3],
			["kat_flumazenil", 3],
			["kat_lorazepam", 3],
			["kat_clamp", 5],
			["kat_plate", 3],
			["kat_retractor", 5],
			["kat_scalpel", 3],
			["ACE_fieldDressing", 20], 
			["ACE_elasticBandage", 40],
			["ACE_packingBandage", 40],
			["ACE_epinephrine", 20],
			["ACE_morphine", 15],
			["ACE_salineIV_250", 3],
			["ACE_tourniquet", 15],
			["kat_handWarmer", 20],
			["kat_ncdKit", 10],
			["kat_nasal", 10],
			["kat_Caffeine", 5],
			["kat_Penthrox", 5],
			["ACE_splint", 10],
			["UK3CB_BAF_SmokeShellPurple", 5]
		]
	],
	[
		"5.56 Ammo",
		"UK3CB_BAF_Box_556_Ammo",
		[
			
		]
	],
	[
		"7.62 Ammo",
		"UK3CB_BAF_Box_762_Ammo",
		[
		
		]
	],
	[
		"40mm Grenades",
		"UK3CB_BAF_Box_40_Ammo",
		[
		
		]
	],
	[
		"NLAW's",
		"UK3CB_BAF_Box_WpsLaunch_NLAW",
		[
			["launch_NLAW_F", 8]
		]
	],
	[
		"ILAW's",
		"UK3CB_BAF_Box_WpsLaunch_ILAW",
		[
		
		]
	],
	[
		"EOD",
		"UK3CB_BAF_Box_WpsSpecial",
		[
			["ACE_VMH3", 3],
			["ace_marker_flags_green", 20],
			["ace_marker_flags_yellow", 20],
			["ace_marker_flags_red", 20],
			["ACE_EntrenchingTool", 3],
			["ACE_DefusalKit", 5],
			["ACE_Clacker", 2],
			["DemoCharge_Remote_Mag", 2],
			["rhs_ec75_sand_mag", 8]
		]
	],
	[
		"Mine Clearing Line Charge",
		"mts_engineer_miclic",
		[
		
		]
	],
	[
		"Fuel Tank",
		"FlexibleTank_01_forest_F",
		[
		
		]s
	],
	[
		"Spare Wheel",
		"ACE_Wheel",
		[
		
		]
	],
	[
		"Spare Track",
		"ACE_Track",
		[
		
		]
	],
	[
		"Water",
		"Box_IDAP_Equip_F",
		[
			["ACE_WaterBottle", 20],
			["ACE_Canteen", 5],
			["ACE_Can_Franta", 10],
			["ACE_Can_Spirit", 10],
			["ACE_Can_RedGull", 10]
		]
	],
	[
		"Food",
		"Box_IDAP_Equip_F",
		[
			["ACE_Humanitarian_Ration", 30],
			["ACE_Banana", 5]
		]
	]
];

/*
--------------------------------------------------------------------------------------------
									DO NOT EDIT BELOW
--------------------------------------------------------------------------------------------
*/

{
	private _container = _x;
	{
		private _name = _x select 0;
		private _class = _x select 1;
		private _inventory = _x select 2;
		
		_container addAction [
			_name,
			{
				params ["_target", "_caller", "_actionId", "_arguments"];
				private _class = _arguments select 0;
				private _inventory = _arguments select 1;
				
				private _spawnPos = player getPos [1, getDir player];
				private _crate = createVehicle [_class, _spawnPos, [], 0, "CAN_COLLIDE"];
				
				if (count _inventory > 0) then {
					clearItemCargoGlobal _crate;
					clearWeaponCargoGlobal _crate;
					clearMagazineCargoGlobal _crate;
					clearBackpackCargoGlobal _crate;
					{
						_ItemClass = _x select 0;
						
						if (isClass (configFile >> "CfgWeapons" >> _ItemClass)) then {
							if (getNumber (configFile >> "CfgWeapons" >> _ItemClass >> "type") == 0) then {
								_crate addItemCargoGlobal _x;
							}else{
								_crate addWeaponCargoGlobal _x;
							};
						}else{
							if (isClass (configFile >> "CfgMagazines" >> _ItemClass)) then {
								_crate addMagazineCargoGlobal _x;
							}else{
								if (isClass (configFile >> "CFGVehicles" >> _ItemClass >> "isBackpack")) then {
									_crate addBackpackCargoGlobal _x;
								};
							};
						};
					}forEach _inventory;
				};
			},
			[_class,_inventory]
		];
	}forEach _ER32_list;
}forEach (vehicles select {typeOf _x isEqualTo "UK3CB_BAF_MAN_HX58_Container_Green"});
