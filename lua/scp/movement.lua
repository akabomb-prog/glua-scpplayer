local function SCPPlayerSpawn(ply, transition)
	ply:SetNWFloat("SCPPlayer_walkPhase", 0.0)
	ply:SetWalkSpeed(SCP.speed)
	ply:SetSlowWalkSpeed(SCP.speed / 1.5)
	ply:SetRunSpeed(SCP.speed * 2)
end

hook.Add("PlayerStepSoundTime", "SCPPlayer", function (ply, type, walking)
	if walking then
		return SCP.stepTime
	elseif ply:IsSprinting() then
		return SCP.run_stepTime
	else
		return SCP.stepTime
	end
end)

hook.Add("PlayerFootstep", "SCPPlayer", function (ply, pos, foot, sound, volume, rf)
	rf:RemovePlayer(ply) -- player won't hear own footsteps
	local s = CreateSound(ply, SCP.stepsound(), rf)
	s:Play()
	return true -- Don't allow default footsteps, or other addon footsteps
end)

for i,ply in ipairs(player.GetAll()) do
	SCPPlayerSpawn(ply, true)
end

hook.Add("PlayerSpawn", "SCPPlayer", SCPPlayerSpawn)
