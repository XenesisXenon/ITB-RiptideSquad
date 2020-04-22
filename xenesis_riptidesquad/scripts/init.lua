--INIT.LUA--

local description = "A rough riding squad built with Pinnacle Grav tech that stops the Vek by crushing them on themselves. A force as unstoppable as the ocean currents."
local icon = "img/mod_icon2.png"

local function getModOptions(mod)
    return mod_loader:getModConfig()[mod.id].options
end

local function init(self)
	local scriptPath = self.scriptPath
	require(self.scriptPath.."FURL")(self, {
	 {
    		Type = "color",
    		Name = "RiptideSquad",
    		PawnLocation = self.scriptPath.."pawns",

			PlateHighlight =	{0, 255, 210},	--lights
			PlateLight =		{198, 246, 250},	--main highlight
			PlateMid =			{125, 161, 165},	--main light
			PlateDark =			{73, 88, 98},	--main mid
			PlateOutline =		{24, 25, 33},	--main dark
			BodyHighlight =		{126, 128, 126},	--metal light
			BodyColor =			{85, 89, 93},	--metal mid
			PlateShadow =		{46, 50, 57},	--metal dark	
		
    },
	{
			Type = "mech",
			Name = "xen_HarpoonMech",
			Filename = "harpoon",
			Path = "img", 
			ResourcePath = "units/player",

			Default =           {},
			Animated =          { PosX = -18, PosY = -15, NumFrames = 6, Frames = {0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 4, 5, 4}, Lengths = {1,1,1,1,1,1,1,1,1,1,1,1,1,0.1,0.04,0.1}},
			Broken =            { PosX = -18, PosY = -18 },
			Submerged =         { PosX = -16, PosY = 0 },
			SubmergedBroken =   { PosX = -16, PosY = 0 },
			Icon =              {},
	},
	{
			Type = "mech",
			Name = "xen_LaunchMech",
			Filename = "launch",
			Path = "img", 
			ResourcePath = "units/player",

			Default =           {},
			Animated =          { PosX = -24, PosY = -8, NumFrames = 4},
			Broken =            { PosX = -24, PosY = -8 },
			Submerged =         { PosX = -25, PosY = 0 },
			SubmergedBroken =   { PosX = -25, PosY = 0 },
			Icon =              {},
	},
	{
			Type = "mech",
			Name = "xen_WhirlpoolMech",
			Filename = "whirlpool",
			Path = "img", 
			ResourcePath = "units/player",

			Default =           {},
			Animated =          { PosX = -18, PosY = -10, NumFrames = 4},
			Broken =            { PosX = -19, PosY = -10 },
			Submerged =         { PosX = -24, PosY = 0 },
			SubmergedBroken =   { PosX = -24, PosY = 0 },
			Icon =              {},
	}
});
	modApi:appendAsset("img/weapons/xen_weapon_prime_harpoon.png",self.resourcePath.."img/weapon_prime_harpoon.png")
	modApi:appendAsset("img/weapons/xen_weapon_brute_kickoff.png",self.resourcePath.."img/weapon_brute_kickoff.png")
	modApi:appendAsset("img/weapons/xen_weapon_ranged_vortex.png",self.resourcePath.."img/weapon_ranged_vortex.png")
	modApi:appendAsset("img/weapons/xen_weapon_ranged_vortex_counter.png",self.resourcePath.."img/weapon_ranged_vortex_counter.png")
	modApi:appendAsset("img/weapons/xen_weapon_ranged_crush.png",self.resourcePath.."img/weapon_ranged_crush.png")
	modApi:appendAsset("img/effects/xen_shotup_vortex.png",self.resourcePath.."img/shotup_vortex.png")
	modApi:appendAsset("img/effects/xen_shotup_vortex_counter.png",self.resourcePath.."img/shotup_vortex_counter.png")
	modApi:appendAsset("img/effects/xen_explopulse_vortex.png",self.resourcePath.."img/explo_pulse_vortex.png")
	
	require(self.scriptPath.."pawns")
	require(self.scriptPath.."weapons")
	
	if modApiExt then
        -- modApiExt already defined. This means that the user has the complete
        -- ModUtils package installed. Use that instead of loading our own one.
        	xen_riptide_ModApiExt = modApiExt
        else
        -- modApiExt was not found. Load our inbuilt version
        	local extDir = self.scriptPath.."modApiExt/"
        	xen_riptide_ModApiExt = require(extDir.."modApiExt")
        	xen_riptide_ModApiExt:init(extDir)
        end
	
	require(scriptPath .."achievements/init")
	require(scriptPath .."achievements")
	require(scriptPath .."achievementTriggers"):init(options)	
	local achvApi = require(scriptPath .."/achievements/api")	
	if require(scriptPath .."achievements/api"):GetChievoStatus("xen_riptide_complete") then
		modApi:addGenerationOption(
			"xen_ForceEnable",
			"Force Amp Mode",
			"Adds the Force Amp passive to the squad, which applies when you start a new game. Very overpowered, but fun!\n\nDisables the Riptide Perfect achievement.",
			{enabled = false}
		)
	else
		modApi:addGenerationOption(
			"xen_ForceEnable",
			"????",
			"Complete the 'Riptide Complete' achievement to unlock!\n\nGame restart may be required after unlocking for the option to appear.",
			{enabled = false}
		)	
	end	
	modApi:addGenerationOption(
		"xen_VortexDirection",
		"Vortex Artillery Weapon",
		"Pick the weapon of the Whirlpool Mech, which applies when you start a new game.\n\nExperimental crush artillery is from earlier versions of the squad, may work strangely and does not trigger the ranged achievement.\n\nDefault: Vortex Artillery - Clockwise. ",
		{
			strings = { "Vortex Artillery - Clockwise","Vortex Artillery - Anti-clockwise", "Experimental Crush Artillery"},
			values = {1,2,3},
			value = 1,
		}
	)
	
	local shop = require(self.scriptPath .."shop")
	shop:addWeapon({
		id = "xen_Prime_Harpoon",
		name = xen_Prime_Harpoon.Name .. " can be found",
		desc = "Adds Prime Harpoon to the store and equipment drop pool.",
	})
	shop:addWeapon({
		id = "xen_Kickoff_Charge",
		name = xen_Kickoff_Charge.Name .. " can be found",
		desc = "Adds Kick-off Charge to the store and equipment drop pool.",
	})
	shop:addWeapon({
		id = "xen_Vortex_Artillery",
		name = xen_Vortex_Artillery.Name .. " can be found",
		desc = "Adds Vortex Artillery to the store and equipment drop pool.",
	})
	shop:addWeapon({
		id = "xen_Vortex_Artillery_Counter",
		name = xen_Vortex_Artillery.Name .. " (Anti-clockwise) can be found",
		desc = "Adds Vortex Artillery (Anti-clockwise) to the store and equipment drop pool.",
		default = false,
	})
	shop:addWeapon({
		id = "xen_Crush_Artillery",
		name = xen_Crush_Artillery.Name .. " can be found",
		desc = "Adds the experimental Crush Artillery to the store and equipment drop pool.",
	})

end


local function load(self, options, version)
	xen_riptide_ModApiExt:load(self, options, version)
	local scriptPath = self.scriptPath
	local SquadBrute = "xen_PSDeployMech"
	local SquadRanged = "xen_PSShoveMech"
	local fmode = false

	if require(scriptPath .."achievements/api"):GetChievoStatus("xen_riptide_complete") and options["xen_ForceEnable"].enabled then
			fmode = options["xen_ForceEnable"].enabled
			SquadBrute = "xen_PSDeployMech_Force"
	end
	if options["xen_VortexDirection"].value == 2 then
		SquadRanged = "xen_PSShoveMech_Counter"
	elseif options["xen_VortexDirection"].value == 3 then
		SquadRanged = "xen_PSShoveMech_Crush"
	end
	modApi:addSquadTrue({"Riptide","xen_PSHarpoonMech", SquadBrute, SquadRanged}, "Riptide", description, self.resourcePath .. icon)
	require(self.scriptPath .."shop"):load(options)
	require(scriptPath .."achievementTriggers"):load(self,fmode)	
end


return {
	id = "xen_PushSquad",
	name = "Riptide Squad",
	version = "1.0.3",
	modApiVersion = "2.5.1",
	description = "A rough riding squad built with Pinnacle Grav tech that stops the Vek by crushing them on themselves.",
	requirements = {"kf_ModUtils"},--Not a list of mods needed for our mod to function, but rather the mods that we need to load before ours to maintain compability 
	init = init,
	load = load,
	icon = "img/mod_icon.png",
}