Config = {
	-- **** IMPORTANT ****
	-- UseTarget should only be set to true when using qb-target
	UseTarget = GetConvar('UseTarget', 'false') == 'true',

	OutsideLocation 	= vector4(-787.8712, -599.5935, 30.2763, 164.2777),
	InsideLocation 		= vector4(1087.4033, -3099.3574, -38.9999, 270.9207),
	InsideLocation2 	= vector4(1173.6866, -3196.5161, -39.0080, 277.9637),
    ComputerLocation    = vector3(1169.5267, -3196.9692, -38.1788),
	ComputerLocation2    = vector3(1087.7355, -3101.2209, -39.9463),
	DutyLocation 		= vector4(1048.7, -3100.62, -38.2, 88.02),
	DropLocation 		= vector4(1048.224, -3097.071, -38.999, 274.810),

}

Config.startLocations = {
	[1]		= vector4(935.6484, -3042.9055, 5.9020, 89.7595),
	[2] 	= vector4(1158.2869, -790.1605, 57.5931, 184.3109),
}

Config.deliverLocations = {
	[1]		= vector4(488.7594, -631.1025, 24.9786, 142.1206),
	[2] 	= vector4(485.8798, -1505.2036, 29.2905, 206.4710),
}

Config.competitionOfficeLocation = {
	[1]		= vector4(-829.9786, -1255.4607, 6.5840, 328.8414),
	[2] 	= vector3(-319.9172, -1389.5624, 36.5001),
}

Config.competitionInteriors = {
	[1]		= vector4(1087.3844, -3099.5034, -39.0000, 263.8305)

}

Config.deliverPeds = {
	[1]		= `cs_chengsr`,
	[2]		= `cs_siemonyetarian`,
	[3]		= `cs_terry`,
	[4]		= `csb_vagspeak`,
}

Config.PickupLocations = {
	[1] 	= vector4(262.8323, -999.8816, -99.0086, 154.6194),
	[2] 	= vector4(261.3694, -1002.5590, -99.0086, 354.5618),
	[3] 	= vector4(263.9515, -995.4774, -99.0086, 356.0900),
	[4] 	= vector4(265.7586, -996.0966, -99.0086, 307.2726),
	[5] 	= vector4(257.0023, -997.6859, -99.0086, 265.1907),
	[6] 	= vector4(258.9318, -1001.1884, -99.0086, 355.2417),
}
Config.WarehouseObjects = {
	[1] = `Hooker02SFY`,
	[2] = `Stripper01Cutscene`,
	[3] = `Topless01AFY`,
	[4] = `Hooker01SFY`,
	[5] = `Hooker03SFY`,
	[6] = "prop_boxpile_05a",
}