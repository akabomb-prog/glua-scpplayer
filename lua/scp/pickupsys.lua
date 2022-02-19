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
    if not (IsValid(ent) and pickup) then return end
    if pickup and IsValid(ent:GetPhysicsObject()) and (not ent:GetClass():StartWith("func_")) then
        ply:EmitSound("scp/interact/PickItem2.ogg")
    end
    if ent:IsWeapon() then ply:PickupWeapon(ent) end
    if ent:GetClass():StartWith("item_") then
        ent:SetPos(ply:WorldSpaceCenter())
        ent:PhysWake()
    end
    ent:Use(ply)
    return ent
end)
