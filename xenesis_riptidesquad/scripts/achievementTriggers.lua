
local path = mod_loader.mods[modApi.currentMod].scriptPath
local achvApi = require(path .."achievements/api")
local getModUtils = require(path .."getModUtils")

local this = {}

local function IsTipImage()
	return Board:GetSize() == Point(6,6)
end

function this:init(options)
	local oldMissionEnd = Mission_Final_Cave.MissionEnd
	
function Mission_Final_Cave:MissionEnd()
	oldMissionEnd()
	
	--Win the Game Achievements
	if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Riptide" then return end
	--LOG("Game end achievment trigger code")
	xen_riptide_achievmentTriggers:Victory()
	xen_riptide_achievmentTriggers:Highscore()
end
	
end

function this:load(self,fmode)
	local modUtils = getModUtils()
	--xen_harpoon
	modUtils:addSkillStartHook(function(mission, pawn, weaponId, p1, p2)
		local lastpawn = pawn:GetType() or nil
		local lastweapon = weaponId or nil
		if not mission then return end
		mission.xen_Rip_LastPawn = lastpawn or nil
		mission.xen_Rip_LastWeapon = lastweapon or nil
	end
	)
		
	modUtils:addPawnUntrackedHook(function(mission, pawn)
		if IsTipImage() then return end
		if not mission then return end
		local lastpawn = mission.xen_Rip_LastPawn
		local lastweapon = mission.xen_Rip_LastWeapon
		if lastpawn ~= "xen_PSHarpoonMech" then return end
		if lastweapon == "xen_Prime_Harpoon" or lastweapon == "xen_Prime_Harpoon_A" or lastweapon == "xen_Prime_Harpoon_B" or lastweapon == "xen_Prime_Harpoon_AB" then
			if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Riptide" then return end
			if _G[pawn:GetType()].Massive then return end
			if pawn:IsFlying() ~= true and _G[pawn:GetType()].Tier == TIER_ALPHA then
				local terrain = Board:GetTerrain(pawn:GetSpace())
				if terrain == TERRAIN_WATER or terrain == TERRAIN_LAVA or terrain == TERRAIN_ACID then
					xen_riptide_achievmentTriggers:Prime()					
				end
			end
		end
	end
	)
	modApi:addNextTurnHook(function(mission)
		if IsTipImage() then return end
		if not mission then return end
		mission.xen_Rip_LastPawn = nil
		mission.xen_Rip_LastWeapon = nil	
	end
	)

xen_riptide_achievmentTriggers = Skill:new{}

function xen_riptide_achievmentTriggers:Prime()
	if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Riptide" then return end
	achvApi:TriggerChievo("xen_riptide_harpoon")
	achvApi:TriggerChievo("xen_riptide_complete", {prime = true})
	self:Complete()	
end

function xen_riptide_achievmentTriggers:Brute(damage)
	if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Riptide" then return end
	if damage < 5 then return end
	achvApi:TriggerChievo("xen_riptide_kickoff")
	achvApi:TriggerChievo("xen_riptide_complete", {brute = true})
	self:Complete()	
end

function xen_riptide_achievmentTriggers:Ranged(damagecount)
	if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Riptide" then return end
	if damagecount < 4 then return end
	achvApi:TriggerChievo("xen_riptide_whirlpool")
	achvApi:TriggerChievo("xen_riptide_complete", {ranged = true})
	self:Complete()	
end

function xen_riptide_achievmentTriggers:Victory(mode)
	if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Riptide" then return end
	local difficulty = GetRealDifficulty()
	local islands = 0
	for i = 0, 3 do
		if RegionData["island" .. i]["secured"] then
			islands = islands +1
		end
	end
	--LOG("Riptide Victory! Diff: " .. difficulty .. " Isl: " .. islands)
	if islands < 2 then return end
	achvApi:TriggerChievo("xen_riptide_complete", {win = true})		
	for i = 0, difficulty do
		if i == 0 then
			if islands == 2 then
				achvApi:TriggerChievo("xen_riptide_2clear", {easy = true})				
			elseif islands == 3 then
				achvApi:TriggerChievo("xen_riptide_3clear", {easy = true})				
			elseif islands == 4 then
				achvApi:TriggerChievo("xen_riptide_4clear", {easy = true})
			end
		elseif i == 1 then
			if islands == 2 then
				achvApi:TriggerChievo("xen_riptide_2clear", {normal = true})				
			elseif islands == 3 then
				achvApi:TriggerChievo("xen_riptide_3clear", {normal = true})				
			elseif islands == 4 then
				achvApi:TriggerChievo("xen_riptide_4clear", {normal = true})
			end
		elseif i == 2 then
			if islands == 2 then
				achvApi:TriggerChievo("xen_riptide_2clear", {hard = true})				
			elseif islands == 3 then
				achvApi:TriggerChievo("xen_riptide_3clear", {hard = true})				
			elseif islands == 4 then
				achvApi:TriggerChievo("xen_riptide_4clear", {hard = true})
			end
		end
	end	
	self:Complete()	
end

function xen_riptide_achievmentTriggers:Highscore()
	if GAME.squadTitles["TipTitle_"..GameData.ach_info.squad] ~= "Riptide" then return end
	if fmode then
			--LOG("Force Mode On!")
	return end

	local highscore = GameData["current"]["score"]
	if highscore == 30000 then
		achvApi:TriggerChievo("xen_riptide_perfect")
	end
	
end

function xen_riptide_achievmentTriggers:Complete()
	--Don't re-trigger the toast if already cleared
	if achvApi:IsChievoProgress("xen_riptide_complete", {reward = true })	then return end
	if achvApi:IsChievoProgress("xen_riptide_complete", {prime = true, brute = true, ranged = true,	win = true,})	then
		local completetoast = {
			unlockTitle = "Option Unlocked!",
			name = "Force Amp Mode",
			tip = "You unlocked Force Amp mode for Riptide. Access from Mod Options!",
			img = "img/achievements/xen_ach_prize.png"	
		}
			achvApi:TriggerChievo("xen_riptide_complete", { reward = true } )
			achvApi:ToastUnlock(completetoast)
	end	

end	
end

return this