hook.Add("PlayerStepSoundTime", "SCPPlayer", function (ply, type, walking)
	if not SCP.ShouldAffect(ply) then return end
	if walking then
		return SCP.stepTime
	elseif ply:IsSprinting() and SCP.CanSprint(ply) then
		return SCP.run_stepTime
	else
		return SCP.stepTime
	end
end)

hook.Add("PlayerFootstep", "SCPPlayer", function (ply, pos, foot, sound, volume, rf)
	if SCP.ShouldAffect(ply) then
		rf:RemovePlayer(ply) -- player won't hear own footsteps
		local s = CreateSound(ply, SCP.stepsound(), rf)
		s:Play()
		return true -- Don't allow default footsteps, or other addon footsteps
	end
end)

hook.Add("StartCommand", "SCPPlayer", function (ply, ucmd)
	if not SCP.ShouldAffect(ply) then return end
    ucmd:RemoveKey(IN_JUMP)
end)

local function SCPPlayerSpawn(ply, transition)
	if not SCP.ShouldAffect(ply) then return end
	ply:SetNWFloat("SCP_Stamina", 100)
	ply:SetNWFloat("SCP_SprintRecoveryEnd", 0)
	ply:SetNWFloat("SCPPlayer_walkPhase", 0.0)
	ply:SetWalkSpeed(SCP.speed)
	ply:SetSlowWalkSpeed(SCP.speed / 1.5)
	ply:SetRunSpeed(SCP.runSpeed)
end

hook.Add("PlayerLoadout", "SCPPlayer", SCPPlayerSpawn) -- player speed seems to be overriden in PlayerSpawn

for i,ply in ipairs(player.GetAll()) do
	SCPPlayerSpawn(ply, true)
end
