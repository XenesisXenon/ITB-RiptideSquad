--WEAPONS.LUA--
--Push Squad Weapon Definitions--
local path = mod_loader.mods[modApi.currentMod].resourcePath
local achvApi = require(path .."scripts/achievements/api")

local function IsTipImage()
	return Board:GetSize() == Point(6,6)
end

--Prime Harpoon (Prime)--
xen_Prime_Harpoon = Skill:new{
	Name = "Prime Harpoon",
	Class = "Prime",
	Icon = "weapons/xen_weapon_prime_harpoon.png",
	Description = "Stab multiple tiles and pull the furthest hit tile.",
	Explosion = "",
	Range = 2, 
	PathSize = 2,
	Damage = 1,
	Push = 1,
	Acid = 0,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = { 2 , 3 },
	LaunchSound = "/weapons/sword",
	Rarity = 2,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Enemy3 = Point(1,3),
		Target = Point(2,1),
		Second_Origin = Point(2,3),
		Second_Target = Point(1,3),
	}
}

function xen_Prime_Harpoon:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if not Board:IsValid(curr) then --or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN then
				break
			end
		end
	end
	
	return ret
end
				
function xen_Prime_Harpoon:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local pull = GetDirection(p1 - p2)
	local distance = p1:Manhattan(p2)
	
	local damage = SpaceDamage(p1 + DIR_VECTORS[direction],0)
	damage.sAnimation = "xen_exploharpoon"..distance.."_"..direction
	ret:AddDamage(damage)
	ret:AddDelay(0.1)
	
	damage = SpaceDamage(p2,0)
	damage.sAnimation = "xen_exploharpoon_hit"..direction
	ret:AddDamage(damage)
	ret:AddDelay(0.2)
	
	damage = SpaceDamage(p2,0,pull)
	damage.sAnimation = "xen_exploharpoon_slow1".."_"..pull
	ret:AddDamage(damage)
	ret:AddDelay(0.5)
	
	for i = 1, distance do
		damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i,self.Damage)
		ret:AddDamage(damage)
	end

	return ret
end	

xen_Prime_Harpoon_B = xen_Prime_Harpoon:new{
	UpgradeDescription = "Increase damage by 2.",
	Damage = 3,
}

xen_Prime_Harpoon_A = xen_Prime_Harpoon:new{
	UpgradeDescription = "Increase range by 1.",
	PathSize = 3, 
	Range = 3,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(2,0),
		Enemy3 = Point(1,3),
		Enemy4 = Point(2,2),
		Target = Point(2,0),
		Second_Origin = Point(2,3),
		Second_Target = Point(1,3),
	}
}

xen_Prime_Harpoon_AB = xen_Prime_Harpoon:new{
	PathSize = 3, 
	Range = 3,
	Damage = 3,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(2,0),
		Enemy3 = Point(1,3),
		Enemy4 = Point(2,2),
		Target = Point(2,0),
		Second_Origin = Point(2,3),
		Second_Target = Point(1,3),
	}	
}

Weapon_Texts.xen_Prime_Harpoon_Upgrade1 = "+1 Range"
Weapon_Texts.xen_Prime_Harpoon_Upgrade2 = "+2 Damage"

ANIMS.xen_exploharpoon1_0 = ANIMS.explospear1_0:new{	Time = 0.03, }
ANIMS.xen_exploharpoon2_0 = ANIMS.xen_exploharpoon1_0:new{ 	Image = "effects/spear2_U.png", }
ANIMS.xen_exploharpoon3_0 = ANIMS.xen_exploharpoon1_0:new{	Image = "effects/spear3_U.png", }
ANIMS.xen_exploharpoon1_1 = ANIMS.explospear1_1:new{	Time = 0.03, }
ANIMS.xen_exploharpoon2_1 = ANIMS.xen_exploharpoon1_1:new{ 	Image = "effects/spear2_R.png", }
ANIMS.xen_exploharpoon3_1 = ANIMS.xen_exploharpoon1_1:new{	Image = "effects/spear3_R.png", }
ANIMS.xen_exploharpoon1_2 = ANIMS.explospear1_2:new{	Time = 0.03, }
ANIMS.xen_exploharpoon2_2 = ANIMS.xen_exploharpoon1_2:new{ 	Image = "effects/spear2_D.png", }
ANIMS.xen_exploharpoon3_2 = ANIMS.xen_exploharpoon1_2:new{	Image = "effects/spear3_D.png", }
ANIMS.xen_exploharpoon1_3 = ANIMS.explospear1_3:new{	Time = 0.03, }
ANIMS.xen_exploharpoon2_3 = ANIMS.xen_exploharpoon1_3:new{ 	Image = "effects/spear2_L.png", }
ANIMS.xen_exploharpoon3_3 = ANIMS.xen_exploharpoon1_3:new{	Image = "effects/spear3_L.png", }

ANIMS.xen_exploharpoon_slow1_0 = ANIMS.explospear1_0:new{	Time = 0.06, }
ANIMS.xen_exploharpoon_slow1_1 = ANIMS.explospear1_1:new{	Time = 0.06, }
ANIMS.xen_exploharpoon_slow1_2 = ANIMS.explospear1_2:new{	Time = 0.06, }
ANIMS.xen_exploharpoon_slow1_3 = ANIMS.explospear1_3:new{	Time = 0.06, }

ANIMS.xen_exploharpoon_hit0 = ANIMS.ExploAir1:new{
	Time = 0.03, 
	PosX = 0,
	PosY = 0	
	}
ANIMS.xen_exploharpoon_hit1 = ANIMS.xen_exploharpoon_hit0:new{
	PosX = 9,
	PosY = 25	
	}
ANIMS.xen_exploharpoon_hit2 = ANIMS.xen_exploharpoon_hit0:new{
	PosX = -30,
	PosY = 20	
	}
ANIMS.xen_exploharpoon_hit3 = ANIMS.xen_exploharpoon_hit0:new{
	PosX = -25,
	PosY = 0	
	}

--Kick Off Charge (Brute)--
xen_Kickoff_Charge = Brute_Beetle:new{
	Name = "Kick-off Charge",
	Class = "Brute",
	Portrait = "",
	Icon = "weapons/xen_weapon_brute_kickoff.png",
	Description = "Fly in a line and slam into the target, pushing it. Kick-off from the target behind you to do extra damage.",
	Rarity = 3,
	Explosion = "",
	Push = 1,--TOOLTIP HELPER
	Fly = 1,
	Damage = 1,
	BuildingDamage = true,
	SelfDamage = 0,
	DamageKick = 1,
	DamageBuilding = 0,
	PathSize = INT_MAX,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {1,3},
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	Rarity = 2,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(4,2),
		Enemy2 = Point(1,2),
		Enemy3 = Point(3,1),
		Target = Point(4,2),
		Second_Origin = Point(3,2),
		Second_Target = Point(3,1),
	}
}

function xen_Kickoff_Charge:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local reverse = GetDirection(p1 - p2)

	local pathing = PATH_PROJECTILE
	if self.Fly == 0 then pathing = Pawn:GetPathProf() end

	local doDamage = true
	local target = GetProjectileEnd(p1,p2,pathing)
	local distance = p1:Manhattan(target)
	local kickoff = 0
	local buildingkickoff = 0	
	local targetpawn = Board:GetPawn(target) or nil
	
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end
	
	local smoke = SpaceDamage(p1 - DIR_VECTORS[direction], self.Damage, reverse)
	
	if not self.BuildingDamage and Board:IsBuilding(p1 - DIR_VECTORS[direction]) then	
		smoke.iDamage = 0
	end	
	if Board:IsBuilding(p1 - DIR_VECTORS[direction]) then	
		buildingkickoff = self.DamageBuilding + self.DamageKick
	end
	if Board:GetPawn(p1 - DIR_VECTORS[direction]) then
		kickoff = self.DamageKick
	end
	if Board:GetTerrain(p1 - DIR_VECTORS[direction]) == TERRAIN_MOUNTAIN then
		kickoff = self.DamageKick
	end

	ret:AddDamage(smoke)
	
	local damage = SpaceDamage(target, self.Damage + kickoff + buildingkickoff, direction)
	damage.sAnimation = "ExploAir2"
	damage.sSound = self.ImpactSound
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
		if doDamage then ret:AddDamage(SpaceDamage( target - DIR_VECTORS[direction] , self.SelfDamage)) end
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			ret:AddBounce(temp,-3)
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		
		if doDamage then
			ret:AddDamage(damage)
			ret:AddDamage(SpaceDamage( target - DIR_VECTORS[direction] , self.SelfDamage))
		end
	
	end
	--Achivement
	if not IsTipImage() then
		if targetpawn ~= nil and targetpawn:GetTeam() == TEAM_ENEMY and Board:IsBuilding(p1 - DIR_VECTORS[direction]) then	
		ret:AddScript([[
			local damage = ]].. damage.iDamage .. [[;
			xen_riptide_achievmentTriggers:Brute(damage);
		]])
		end
	end
	return ret
end

xen_Kickoff_Charge_A = xen_Kickoff_Charge:new{
	UpgradeDescription = "Kick off a building to do extra damage. Buildings are no longer damaged by a kick off.",
	BuildingDamage = false,
	DamageBuilding = 1,
	TipImage = {
		Unit = Point(1,2),
		Enemy = Point(3,2),
		Enemy2 = Point(2,1),
		Enemy3 = Point(2,3),
		Building = Point(0,2),
		Target = Point(3,2),
		Second_Origin = Point(2,2),
		Second_Target = Point(2,1),
	}
}

xen_Kickoff_Charge_B = xen_Kickoff_Charge:new{
	UpgradeDescription = "Increase kick-off damage by 2.",
	DamageKick = 3	
}

xen_Kickoff_Charge_AB = xen_Kickoff_Charge:new{
	BuildingDamage = false,
	DamageBuilding = 1,
	DamageKick = 3,
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(4,2),
		Enemy2 = Point(1,2),
		Enemy3 = Point(3,1),
		Target = Point(4,2),
		Second_Origin = Point(3,2),
		Second_Target = Point(3,1),
	}	
}

Weapon_Texts.xen_Kickoff_Charge_Upgrade1 = "Building Kick-Off"
Weapon_Texts.xen_Kickoff_Charge_Upgrade2 = "+2 Kick Damage"

--Vortex Artillery (Ranged)--
xen_Vortex_Artillery = LineArtillery:new{
	Name = "Vortex Artillery",
	Class = "Ranged",
	Icon = "weapons/xen_weapon_ranged_vortex.png",
	Description = "Pull adjacent targets clockwise around the centre target.",
	Sound = "",
	Explosion = "xen_VortexBlast",
	UpShot = "effects/xen_shotup_vortex.png",
	PowerCost = 1,
	BounceAmount = 1,
	Damage = 1,
	Direction = 1,
	DamageCentre = 1,
	DamageOuter = 0,
	CentreSmoke = false,
	LaunchSound = "/weapons/gravwell",
	Upgrades = 2,
	UpgradeCost = {2,2},
	Rarity = 2,
	TipImage = {
		Unit = Point(2,4),
		Target = Point(2,2),
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Enemy3 = Point(3,2),
		Enemy4 = Point(1,2),
		Enemy5 = Point(2,3)
	}
}

function xen_Vortex_Artillery:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damagecount = 0

	local damage = SpaceDamage(p2, self.DamageCentre)
	if self.CentreSmoke then
		damage.iSmoke = EFFECT_CREATE
	end
	--Centre--
	ret:AddBounce(p1, -2)
	damage.sAnimation = self.Explosion
	ret:AddArtillery(damage,self.UpShot)
	ret:AddBounce(p2, self.BounceAmount)
	--Achievment
	if Board:GetPawn(damage.loc) ~= nil and Board:GetPawn(damage.loc):GetTeam() == TEAM_ENEMY then
		damagecount = damagecount + 1
	end

	for dir = DIR_START,DIR_END do
		damage = SpaceDamage(p2 + DIR_VECTORS[dir], self.DamageOuter)
		damage.iPush = (dir+self.Direction)%4
		damage.sAnimation = "airpush_".. ((dir+self.Direction)%4)
		ret:AddDamage(damage)
		--Achievment
		if Board:GetPawn(damage.loc) ~= nil and Board:GetPawn(damage.loc):GetTeam() == TEAM_ENEMY then
			damagecount = damagecount + 1
		end		
	end
	
	--LOG("Vortex Target Counter: " .. damagecount)
	if not IsTipImage() then
		if damagecount > 3 then	
		ret:AddScript([[
			local damagecount = ]].. damagecount .. [[;
			xen_riptide_achievmentTriggers:Ranged(damagecount);
		]])
		end
	end
	return ret
end

xen_Vortex_Artillery_A = xen_Vortex_Artillery:new{
	UpgradeDescription = "Creates smoke on the centre tile instead of damage.",
	Damage = 0,
	DamageCentre = 0,
	CentreSmoke = true
}

xen_Vortex_Artillery_B = xen_Vortex_Artillery:new{
	UpgradeDescription = "Increases the outer ring damage by 2.",
	Damage = 2,
	DamageOuter = 2
}

xen_Vortex_Artillery_AB = xen_Vortex_Artillery:new{
	Damage = 2,
	DamageCentre = 0,
	DamageOuter = 2,
	CentreSmoke = true
}

xen_Vortex_Artillery_Counter = xen_Vortex_Artillery:new{
	Icon = "weapons/xen_weapon_ranged_vortex_counter.png",
	UpShot = "effects/xen_shotup_vortex_counter.png",
	Description = "Pull adjacent targets anti-clockwise around the centre target.",
	Direction = -1,
}
xen_Vortex_Artillery_Counter_A = xen_Vortex_Artillery_A:new{
	Icon = "weapons/xen_weapon_ranged_vortex_counter.png",
	UpShot = "effects/xen_shotup_vortex_counter.png",
	Direction = -1,
}
xen_Vortex_Artillery_Counter_B = xen_Vortex_Artillery_B:new{
	Icon = "weapons/xen_weapon_ranged_vortex_counter.png",
	UpShot = "effects/xen_shotup_vortex_counter.png",
	Direction = -1,
}
xen_Vortex_Artillery_Counter_AB = xen_Vortex_Artillery_AB:new{
	Icon = "weapons/xen_weapon_ranged_vortex_counter.png",
	UpShot = "effects/xen_shotup_vortex_counter.png",
	Direction = -1,
}

Weapon_Texts.xen_Vortex_Artillery_Upgrade1 = "Centre Smoke"
Weapon_Texts.xen_Vortex_Artillery_Upgrade2 = "+2 Outer Damage"
Weapon_Texts.xen_Vortex_Artillery_Counter_Upgrade1 = Weapon_Texts.xen_Vortex_Artillery_Upgrade1
Weapon_Texts.xen_Vortex_Artillery_Counter_Upgrade2 = Weapon_Texts.xen_Vortex_Artillery_Upgrade2

ANIMS.xen_VortexBlast = ANIMS.PulseBlast:new{
	Image = "effects/xen_explopulse_vortex.png",
	Time = 0.035,
	PosX = -39,
	PosY = -10
}
--Crush Artillery (Ranged)--
--WIP1 Vortex Artillery--
xen_Crush_Artillery = LineArtillery:new{
	Name = "Crush Artillery",
	Class = "Ranged",
	Icon = "weapons/xen_weapon_ranged_crush.png",
	Description = "Pull adjacent targets into the centre. Targets are pulled clock-wise from the back.",
	Sound = "",
	Explosion = "",
	PowerCost = 1,
	BounceAmount = 1,
	BigSize = 0,
	Damage = 0,
		ArtilleryStart = 2,
		ArtillerySize = 8,
	BigSize = 0,
	LaunchSound = "/weapons/gravwell",
	Upgrades = 2,
	UpgradeCost = {2,2},
	Rarity = 3,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Enemy3 = Point(1,1),
		Target = Point(2,1)
	}
}
					
function xen_Crush_Artillery:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local dir2 = GetDirection(p1 - p2)
	local damage = SpaceDamage(p2, self.Damage)
	local damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], 0, (dir-1)%4)
	
	ret:AddBounce(p1, -2)
	damage.sAnimation = "xen_VortexBlast"
	ret:AddArtillery(damage,"effects/shot_pull_U.png")
	ret:AddBounce(p2, self.BounceAmount)

	if self.BigSize == 1 then
		--North--
		damagepush = SpaceDamage(p2 + DIR_VECTORS[dir], 0, dir2)
		damagepush.sAnimation = "airpush_"..dir2
		ret:AddDamage(damagepush)		
		ret:AddDelay(0.2)
	end
	--East--
	damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir+1)%4], 0, (dir-1)%4)
	damagepush.sAnimation = "airpush_"..((dir-1)%4)
	ret:AddDamage(damagepush)
	ret:AddDelay(0.2)
	
	if self.BigSize == 1 then
		--South--
		damagepush = SpaceDamage(p2 - DIR_VECTORS[dir], 0, dir)
		damagepush.sAnimation = "airpush_"..dir
		ret:AddDamage(damagepush)	
		ret:AddDelay(0.2)
	end
	
	--West--
	damagepush = SpaceDamage(p2 + DIR_VECTORS[(dir-1)%4], 0, (dir+1)%4)
	damagepush.sAnimation = "airpush_"..((dir+1)%4)
	ret:AddDamage(damagepush)	
	
	
	return ret
end

xen_Crush_Artillery_A = xen_Crush_Artillery:new{
	UpgradeDescription = "Increases area by 2 tiles.",
	BigSize = 1,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Enemy3 = Point(1,1),
		Enemy4 = Point(2,2),
		Enemy5 = Point(2,0),
		Target = Point(2,1)
	}
}

xen_Crush_Artillery_B = xen_Crush_Artillery:new{
	UpgradeDescription = "Increases damage by 2.",
	Damage = 2,
}

xen_Crush_Artillery_AB = xen_Crush_Artillery:new{
	BigSize = 1,
	Damage = 2,
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Enemy2 = Point(3,1),
		Enemy3 = Point(1,1),
		Enemy4 = Point(2,2),
		Enemy5 = Point(2,0),
		Target = Point(2,1)
	}
}

Weapon_Texts.xen_Crush_Artillery_Upgrade1 = "+2 Area"
Weapon_Texts.xen_Crush_Artillery_Upgrade2 = "+2 Damage"
