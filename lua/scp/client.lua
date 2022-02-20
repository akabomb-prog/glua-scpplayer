LocalPlayer():SetVar("SCPPlayer_walkPhaseC", 0.0)
LocalPlayer():SetVar("SCPPlayer_wSoundPlayed", false)

local function PlayAppropriateStepSound(ply, ucmd)
    local sprint = ucmd:KeyDown(IN_SPEED)
    local tr = util.TraceEntity({
        start = ply:GetPos(),
        endpos = ply:GetPos() + SCP.down,
        filter = ply,
        mask = MASK_SHOT_HULL
    }, ply)
    local prop = util.GetSurfacePropName(tr.SurfaceProps)
    if string.StartWith(prop, "metal") or (prop == "canister") then
        if sprint then ply:EmitSound(SCP.runmetalsound())
        else ply:EmitSound(SCP.stepmetalsound()) end
    elseif (prop == "dirt") or (prop == "grass") then
        ply:EmitSound(SCP.stepforestsound())
    else
        if sprint then ply:EmitSound(SCP.runsound())
        else ply:EmitSound(SCP.stepsound()) end
    end
end

local lastcommand = RealTime()
hook.Add("StartCommand", "SCPPlayer", function (ply, ucmd)
    ucmd:RemoveKey(IN_JUMP)
	local mv = math.abs(ucmd:GetForwardMove()) + math.abs(ucmd:GetSideMove())
	if mv ~= 0 then
		mv = 1
		if ply:OnGround() then
			local phase = mv
            if ucmd:KeyDown(IN_SPEED) then phase = phase * SCP.run_IstepTime
            else phase = phase * SCP.IstepTime end
			ply:SetVar("SCPPlayer_walkPhaseC", ply:GetVar("SCPPlayer_walkPhaseC", 0.0) + phase * (RealTime() - lastcommand))
		end
		if ply:GetVar("SCPPlayer_walkPhaseC", 0.0) >= 2 then
			ply:SetVar("SCPPlayer_walkPhaseC", 0.0)
            ply:SetVar("SCPPlayer_wSoundPlayed", false)
		end
        local wphase = ply:GetVar("SCPPlayer_walkPhaseC", 0.0) % 1
		if (wphase >= 0.25) and (not ply:GetVar("SCPPlayer_wSoundPlayed", false)) then
			PlayAppropriateStepSound(ply, ucmd)
            ply:SetVar("SCPPlayer_wSoundPlayed", true)
        end
		if (ply:GetVar("SCPPlayer_walkPhaseC", 0.0) >= 1) and (wphase < 0.25) then
            ply:SetVar("SCPPlayer_wSoundPlayed", false)
		end
	end
    lastcommand = RealTime()
end)
