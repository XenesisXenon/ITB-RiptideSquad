
xen_PSHarpoonMech = {
	Name = "Harpoon Mech",
	Class = "Prime",
	Image = "xen_HarpoonMech",
	ImageOffset = FURL_COLORS.RiptideSquad,
	Health = 3,
	MoveSpeed = 3,
	SkillList = { "xen_Prime_Harpoon" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}

AddPawn("xen_PSHarpoonMech")

xen_PSDeployMech = {
	Name = "Launch Mech",
	Class = "Brute",
	Image = "xen_LaunchMech",
	ImageOffset = FURL_COLORS.RiptideSquad,
	Health = 2,
	MoveSpeed = 3,
	SkillList = {"xen_Kickoff_Charge"},
	SoundLocation = "/mech/brute/tank/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}

AddPawn("xen_PSDeployMech")

xen_PSShoveMech = {
	Name = "Whirlpool Mech",
	Class = "Ranged",
	Image = "xen_WhirlpoolMech",
	ImageOffset = FURL_COLORS.RiptideSquad,
	MoveSpeed = 3,
	SkillList = {"xen_Vortex_Artillery"},
	SoundLocation = "/mech/science/science_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}

AddPawn("xen_PSShoveMech")

--For Mod Option compatibility

xen_PSShoveMech_Counter = {
	Name = "Whirlpool Mech",
	Class = "Ranged",
	Image = "xen_WhirlpoolMech",
	ImageOffset = FURL_COLORS.RiptideSquad,
	MoveSpeed = 3,
	SkillList = {"xen_Vortex_Artillery_Counter"},
	SoundLocation = "/mech/science/science_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("xen_PSShoveMech_Counter")

xen_PSShoveMech_Crush = {
	Name = "Whirlpool Mech",
	Class = "Ranged",
	Image = "xen_WhirlpoolMech",
	ImageOffset = FURL_COLORS.RiptideSquad,
	MoveSpeed = 3,
	SkillList = {"xen_Crush_Artillery"},
	SoundLocation = "/mech/science/science_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}

AddPawn("xen_PSShoveMech_Crush")

xen_PSDeployMech_Force = {
	Name = "Launch Mech",
	Class = "Brute",
	Image = "xen_LaunchMech",
	ImageOffset = FURL_COLORS.RiptideSquad,
	Health = 2,
	MoveSpeed = 3,
	SkillList = {"xen_Kickoff_Charge","Passive_ForceAmp"},
	SoundLocation = "/mech/brute/tank/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("xen_PSDeployMech_Force")
