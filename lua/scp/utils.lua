function SCP.GetNearestEnt(pos, filter, limit)
    local ents = ents.FindByClass(filter)
    local dist = (limit*limit) or -1
    local nearest = NULL
    for _,e in ipairs(ents) do
        local epos = e:WorldSpaceCenter()
        if (dist == -1) or (epos:DistToSqr(pos) < dist) then
            nearest = e
            dist = epos:DistToSqr(pos)
        end
    end
    return nearest, dist
end

function SCP.GetNearestEntT(pos, ents, limit)
    local dist = (limit*limit) or -1
    local nearest = NULL
    for _,e in ipairs(ents) do
        local epos = e:WorldSpaceCenter()
        if (dist == -1) or (epos:DistToSqr(pos) < dist) then
            nearest = e
            dist = epos:DistToSqr(pos)
        end
    end
    return nearest, dist
end

function SCP.ShouldAffect(ply)
	if ply:InVehicle() then return false end
	if not ply:Alive() then return false end
    return true
end

local moveThreshold = 48
moveThreshold = moveThreshold*moveThreshold

function SCP.IsMoving(ply)
    local fb, rl = 0, 0
    if ply:KeyDown(IN_FORWARD) then fb = 1 end
    if ply:KeyDown(IN_BACK) then fb = fb - 1 end
    if ply:KeyDown(IN_MOVERIGHT) then rl = 1 end
    if ply:KeyDown(IN_MOVELEFT) then rl = rl - 1 end
    local vel = ply:GetAbsVelocity():Length2DSqr()
    return ((fb ~= 0) or (rl ~= 0)) and (vel > moveThreshold)
end

function SCP.InPickupRange(ply, item)
    return item:GetPos():DistToSqr(ply:WorldSpaceCenter()) < 72
end

function SCP.WhatItem(ent)
    local pObj = ent:GetPhysicsObject()
    local class = ent:GetClass()
    if class:StartWith("item_") then
        if class:match("charger") or class:match("crate") then
            return "staticitem"
        end
        if IsValid(pObj) and (pObj:GetVolume() < 10000) then
            return "physitem"
        end
        return "item"
    end
    if ent:IsWeapon() then return "weapon" end
    if IsValid(pObj) or class:StartWith("prop_") then return "prop" end
    return "other" 
end

if SERVER then
function SCP.GetUseEntity(ply)
    local usableEnts = {}
    for _,e in ipairs(ents.FindByClass("prop_physics")) do
        local pObj = e:GetPhysicsObject()
        if (IsValid(pObj) and (pObj:GetVolume() < 10000)) and pObj:IsMotionEnabled() or (e:GetVar("SCP_UseAnytime", false)) then
            table.insert(usableEnts, e)
        end
    end
    for _,e in ipairs(ents.FindByClass("item_*")) do
        table.insert(usableEnts, e)
    end
    for _,e in ipairs(ents.FindByClass("func*button")) do
        table.insert(usableEnts, e)
    end
    for _,e in ipairs(ents.FindByClass("func_door*")) do
        table.insert(usableEnts, e)
    end
    for _,e in ipairs(ents.FindByClass("prop_door*")) do
        table.insert(usableEnts, e)
    end
    for _,e in ipairs(ents.GetAll()) do
        if e:IsWeapon() then
            if not IsValid(e:GetOwner()) then
                table.insert(usableEnts, e)
            end
        end
    end
    return SCP.GetNearestEntT(ply:EyePos(), usableEnts, ply:GetViewOffset().z + 16)
end
elseif CLIENT then
SCP.UseEntity = NULL
SCP.UsePos = Vector(0, 0, 1024)
function SCP.GetUseEntity()
    return SCP.UseEntity
end
function SCP.GetUsePos()
    --local mins, maxs = SCP.UseEntity:GetCollisionBounds()
    --local rel = maxs - mins
    return SCP.UsePos -- + Vector(0, 0, rel.z * 0.25)
end
end
