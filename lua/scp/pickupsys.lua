hook.Add("PlayerCanPickupItem", "SCPPlayer", function (ply, item)
	if not SCP.ShouldAffect(ply) then return end
    return (ply:KeyDown(IN_USE) and (not ply:KeyDownLast(IN_USE))) and SCP.InPickupRange(ply, item)
end)

hook.Add("PlayerCanPickupWeapon", "SCPPlayer", function (ply, weapon)
	if not SCP.ShouldAffect(ply) then return end
    return (ply:KeyDown(IN_USE) and (not ply:KeyDownLast(IN_USE))) and SCP.InPickupRange(ply, weapon)
end)

hook.Add("AllowPlayerPickup", "SCPPlayer", function (ply, ent)
	if not SCP.ShouldAffect(ply) then return end
    return false
end)

local b_nonSCPDisallow = CreateConVar("scp_limit_nonlisted_item_use", '1', bit.bor(FCVAR_LUA_SERVER, FCVAR_REPLICATED), "Disallow usage of \"Non-SCP\" objects? (doors, buttons, items, etc.)", 0, 1)

hook.Add("FindUseEntity", "SCPPlayer", function (ply, defaultEnt)
	if not SCP.ShouldAffect(ply) then return end
    local ent = SCP.GetUseEntity(ply)
    local pickup = ply:KeyDown(IN_USE) and (not ply:KeyDownLast(IN_USE))
    if not (IsValid(ent) and pickup) then
        if b_nonSCPDisallow:GetBool() then
            return NULL
        else
            return
        end
    end
    if pickup then
        if ent:GetVar("SCP_StatusText") ~= nil then
            SCP.SendStatusText(ply, ent:GetVar("SCP_StatusText", ''))
        end
        if ent:GetClass():match("item_") then
            ply:EmitSound("scp/interact/PickItem2.ogg")
        elseif ent:IsWeapon() then
            ply:EmitSound("scp/interact/PickItem1.ogg")
        end
    end
    if ent:IsWeapon() then ply:PickupWeapon(ent) end
    local whatItem = SCP.WhatItem(ent)
    if (whatItem == "item") or (whatItem == "physitem") or (whatItem == "weapon") then
        ent:SetPos(ply:WorldSpaceCenter())
        ent:PhysWake()
    end
    ent:Use(ply)
    return ent
end)
