hook.Add("HUDPaint", "SCPPlayer", function ()
    surface.SetDrawColor(SCP.HUDColor)
	surface.SetMaterial(SCP.HUD.hand)
    -- local pos = Vector(-350, 1184, 110):ToScreen()
    if not IsValid(SCP.GetUseEntity()) then return end
    local pos = SCP.GetUsePos()
    pos = pos:ToScreen()
    local iX, iY = pos.x - SCP.HUDHalfImgSize, pos.y - SCP.HUDHalfImgSize
    surface.DrawTexturedRect(math.Clamp(iX, 0, ScrW() - SCP.HUDImgSize), math.Clamp(iY, 0, ScrH() - SCP.HUDImgSize), SCP.HUDImgSize, SCP.HUDImgSize)
end)