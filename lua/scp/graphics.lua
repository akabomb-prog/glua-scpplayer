local b_drawHUD = CreateClientConVar("scp_hud", '1', FCVAR_NONE, "Draw SCP HUD?", 0, 1)
local b_useRestriction = GetConVar("scp_item_only_use")

hook.Add("HUDPaint", "SCPPlayer", function ()
    if not b_drawHUD:GetBool() then return end
    surface.SetDrawColor(SCP.HUDColor)

    if b_useRestriction:GetBool() then
        if IsValid(SCP.GetUseEntity()) then
            local whatItem = SCP.WhatItem(SCP.GetUseEntity())
            if (whatItem ~= "other") and (whatItem ~= "charger") then
                surface.SetMaterial(SCP.HUD.hand2)
            else
                surface.SetMaterial(SCP.HUD.hand)
            end
            
            local pos = SCP.GetUsePos()
            pos = pos:ToScreen()
            local iX, iY = pos.x - SCP.HUDHalfImgSize, pos.y - SCP.HUDHalfImgSize
            surface.DrawTexturedRect(math.Clamp(iX, 0, ScrW() - SCP.HUDImgSize), math.Clamp(iY, 0, ScrH() - SCP.HUDImgSize), SCP.HUDImgSize, SCP.HUDImgSize)
        end
    end

    local stamina = LocalPlayer():GetNWFloat("SCP_Stamina", 100)

    SCP.HUD.menuX = 16
    SCP.HUD.menuY = ScrH() - SCP.HUDIconSize - SCP.HUDIconSize - 16 - 16
    
    surface.DrawRect(SCP.HUD.menuX - SCP.HUD.meterOutline, SCP.HUD.menuY - SCP.HUD.meterOutline, SCP.HUDIconSize + SCP.HUD.meterOutline + SCP.HUD.meterOutline, SCP.HUDIconSize + SCP.HUD.meterOutline + SCP.HUD.meterOutline)
    surface.SetMaterial(SCP.HUD.sprint)
    surface.DrawTexturedRect(SCP.HUD.menuX, SCP.HUD.menuY, SCP.HUDIconSize, SCP.HUDIconSize)
    -- 20 bars
    surface.SetMaterial(SCP.HUD.sprintbar)
    local barW, barH = SCP.HUDIconSize / 15 * 4 * 1.5, SCP.HUDIconSize / 15 * 7 * 1.5
    local bars = math.floor(stamina / 5)
    local staminaX, staminaY = SCP.HUD.menuX + SCP.HUDIconSize + 16, SCP.HUD.menuY
    surface.DrawRect(staminaX - SCP.HUD.meterOutline, staminaY - SCP.HUD.meterOutline, barW * 20 + SCP.HUD.meterOutline + SCP.HUD.meterOutline, barH + SCP.HUD.meterOutline + SCP.HUD.meterOutline)
    surface.SetDrawColor(SCP.HUD.meterBackColor)
    surface.DrawRect(staminaX, staminaY, barW * 20, barH)
    surface.SetDrawColor(SCP.HUDColor)
    for i=1,bars do
        surface.DrawTexturedRect(staminaX + (i - 1) * barW, staminaY, barW, barH)
    end

    draw.DrawText("SCP_Stamina:" .. stamina, SCP.StatusTextFont, 16, 512, SCP.HUDTextColor)

    if SCP.ShouldShowText() then
        local x, y = ScrW() * SCP.StatusTextXMult, ScrH() * SCP.StatusTextYMult
        draw.DrawText(SCP.StatusTextString, SCP.StatusTextFont, x - 1, y + 1, SCP.HUDTextColorO, TEXT_ALIGN_CENTER)
        surface.SetAlphaMultiplier(SCP.GetStatusAlphaMultiplier())
        draw.DrawText(SCP.StatusTextString, SCP.StatusTextFont, x, y, SCP.HUDTextColor, TEXT_ALIGN_CENTER)
        surface.SetAlphaMultiplier(1)
    end
end)

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true
}

hook.Add("HUDShouldDraw", "SCPPlayer", function (name)
    if not b_drawHUD:GetBool() then return end
    
	if hide[name] then
		return false
	end

	-- Don't return anything here, it may break other addons that rely on this hook.
end)
