
local path = mod_loader.mods[modApi.currentMod].resourcePath
local achvApi = require(path .."scripts/achievements/api")
local imgs = {
	"ach_noicon",
	"ach_2clear",
	"ach_3clear",
	"ach_4clear",
	"ach_perfect",
	"ach_harpoon",
	"ach_kickoff",
	"ach_vortex",
}

for _, img in ipairs(imgs) do
	modApi:appendAsset("img/achievements/xen_".. img ..".png", path .."img/".. img ..".png")
	modApi:appendAsset("img/achievements/xen_".. img .."_gray.png", path .."img/".. img .."_gray.png")
end
	modApi:appendAsset("img/achievements/xen_ach_prize.png", path .."img/ach_prize.png")

achvApi:AddChievo{
		id = "xen_riptide_harpoon",
		name = "Reeled In",
		tip = "Kill an Alpha Vek by pulling them into the water with the Harpoon.",
		img = "img/achievements/xen_ach_harpoon.png"
}

achvApi:AddChievo{
		id = "xen_riptide_kickoff",
		name = "Launchpad",
		tip = "Kick off a building to do 5 damage in a single charge.",
		img = "img/achievements/xen_ach_kickoff.png",
}

achvApi:AddChievo{
		id = "xen_riptide_whirlpool",
		name = "Eye of the Storm",
		tip = "Hit 4 Vek in a single attack.",
		img = "img/achievements/xen_ach_vortex.png",
}

achvApi:AddChievo{
		id = "xen_riptide_complete",
		name = "Riptide Master",
		tip = "Obtain all the squad achievements and win the game at least once.\n\nVictory: $win\nReeled In: $prime\nLaunchpad: $brute\nEye of the Storm: $ranged\n\nReward: $reward",
		img = "img/achievements/Global_Victory_Complete.png",
		objective = {
			prime = true,
			brute = true,
			ranged = true,
			win = true,
			reward = "?|Force Amp Mode"
		}
		
}

achvApi:AddChievo{
		id = "xen_riptide_2clear",
		name = "Riptide 2 Island Victory",
		tip = "Complete 2 corporate islands then win the game.\n\nEasy: $easy\nNormal: $normal\nHard: $hard",
		img = "img/achievements/xen_ach_2clear.png",
		objective = {
			easy = true,
			normal = true,
			hard = true,
		}
}

achvApi:AddChievo{
		id = "xen_riptide_3clear",
		name = "Riptide 3 Island Victory",
		tip = "Complete 3 corporate islands then win the game.\n\nEasy: $easy\nNormal: $normal\nHard: $hard",
		img = "img/achievements/xen_ach_3clear.png",
		objective = {
			easy = true,
			normal = true,
			hard = true,
		}
}

achvApi:AddChievo{
		id = "xen_riptide_4clear",
		name = "Riptide 4 Island Victory",
		tip = "Complete 4 corporate islands then win the game.\n\nEasy: $easy\nNormal: $normal\nHard: $hard",
		img = "img/achievements/xen_ach_4clear.png",
		objective = {
			easy = true,
			normal = true,
			hard = true,
		}
}

achvApi:AddChievo{
		id = "xen_riptide_perfect",
		name = "Riptide Perfect",
		tip = "Win the game and obtain the highest possible score.",
		img = "img/achievements/xen_ach_perfect.png"
}
