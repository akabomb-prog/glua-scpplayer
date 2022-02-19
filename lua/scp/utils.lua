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

if SERVER then
function SCP.GetUseEntity(ply)
    local usableEnts = {}
    for _,e in ipairs(ents.FindByClass("prop_physics")) do
        table.insert(usableEnts, e)
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
            if not e:GetOwner():IsPlayer() then
                table.insert(usableEnts, e)
            end
        end
    end
    return SCP.GetNearestEntT(ply:EyePos(), usableEnts, 64)
end
elseif CLIENT then
SCP.UseEntity = NULL
SCP.UsePos = Vector(0, 0, 1024)
function SCP.GetUseEntity()
    return SCP.UseEntity
end
function SCP.GetUsePos()
    local mins, maxs = SCP.UseEntity:GetCollisionBounds()
    local rel = maxs - mins
    return SCP.UsePos + Vector(0, 0, rel.z * 0.25)
end
end
