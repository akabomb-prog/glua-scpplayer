hook.Add("PlayerCanPickupItem", "SCPPlayer", function (ply, item)
    return (ply:KeyDown(IN_USE) and (not ply:KeyDownLast(IN_USE))) and (item:GetPos():DistToSqr(ply:WorldSpaceCenter()) < 72)
end)

hook.Add("PlayerCanPickupWeapon", "SCPPlayer", function (ply, weapon)
    return false
end)

hook.Add("AllowPlayerPickup", "SCPPlayer", function (ply, ent)
    return false
end)

hook.Add("FindUseEntity", "SCPPlayer", function (ply, defaultEnt)
    local ent = SCP.GetUseEntity(ply)
    local pickup = ply:KeyDown(IN_USE) and (not ply:KeyDownLast(IN_USE))
    if not (IsValid(ent) and pickup) then return NULL end
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
    if ent:GetClass():StartWith("item_") then
        local pObj = ent:GetPhysicsObject()
        if IsValid(pObj) and (pObj:GetVolume() < 10000) then
            ent:SetPos(ply:WorldSpaceCenter())
            ent:PhysWake()
        elseif not IsValid(pObj) then
            ent:SetPos(ply:WorldSpaceCenter())
        end
    end
    ent:Use(ply)
    return ent
end)
