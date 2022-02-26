local function CalcPosAng(ply)
    local phase = math.sin(math.rad(360 * ply:GetVar("SCPPlayer_walkPhaseC", 0.0))) * 0.5 + 0.5
    local posOffset = SCP.down * phase
    local phase2 = math.sin(math.rad(360 * ply:GetVar("SCPPlayer_walkPhaseC", 0.0) * 0.5))
	local healthFactor = Lerp(ply:Health() / 100, 6, 1)
	local angOffset = SCP.tilt * phase2 * healthFactor
	return posOffset, angOffset
end

hook.Add("CalcView", "SCPPlayer", function (ply, pos, angles, fov)
	if not SCP.ShouldAffect(ply) then return end
	local posOffset, angOffset = CalcPosAng(ply)
	local view = {
		origin = pos + posOffset,
        angles = angles + angOffset,
		drawviewer = false
	}
	return view
end)

hook.Add("CalcViewModelView", "SCPPlayer", function (wep, vm, oldPos, oldAng, pos, ang)
	local ply = wep:GetOwner()
	if not SCP.ShouldAffect(ply) then return end
	local posOffset, angOffset = CalcPosAng(ply)

	local vmPos, vmAng = pos, ang

    local hasCustomPos, hasCustomView = wep.GetViewModelPosition ~= nil, wep.CalcViewModelView ~= nil
    if hasCustomPos or hasCustomView then
        if hasCustomPos then
            vmPos, vmAng = wep:GetViewModelPosition(oldPos, oldAng)
        elseif hasCustomView then
            vmPos, vmAng = wep:GetViewModelPosition(vm, oldPos, oldAng, oldPos, oldAng)
        end
	end
	return vmPos + posOffset, vmAng
end)
