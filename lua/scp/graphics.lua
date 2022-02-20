hook.Add("HUDPaint", "SCPPlayer", function ()
    surface.SetDrawColor(SCP.HUDColor)
	surface.SetMaterial(SCP.HUD.hand)
    -- local pos = Vector(-350, 1184, 110):ToScreen()
    if IsValid(SCP.GetUseEntity()) then
        local pos = SCP.GetUsePos()
        pos = pos:ToScreen()
        local iX, iY = pos.x - SCP.HUDHalfImgSize, pos.y - SCP.HUDHalfImgSize
        surface.DrawTexturedRect(math.Clamp(iX, 0, ScrW() - SCP.HUDImgSize), math.Clamp(iY, 0, ScrH() - SCP.HUDImgSize), SCP.HUDImgSize, SCP.HUDImgSize)
    end

    if SCP.ShouldShowText() then
        local x, y = ScrW() * SCP.StatusTextXMult, ScrH() * SCP.StatusTextYMult
        draw.DrawText(SCP.StatusTextString, SCP.StatusTextFont, x - 1, y + 1, SCP.HUDTextColorO, TEXT_ALIGN_CENTER)
        surface.SetAlphaMultiplier(SCP.GetStatusAlphaMultiplier())
        draw.DrawText(SCP.StatusTextString, SCP.StatusTextFont, x, y, SCP.HUDTextColor, TEXT_ALIGN_CENTER)
        surface.SetAlphaMultiplier(1)
    end
end)
