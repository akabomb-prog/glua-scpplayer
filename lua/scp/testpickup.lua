--[[
local ent = ents.Create("prop_physics")

if IsValid(ent) then
    ent:SetModel("models/props_junk/TrafficCone001a.mdl")
    ent:SetPos(Entity(1):GetEyeTrace().HitPos)
    ent:Spawn()
end
]]

local ent = SCP.GetUseEntity(Entity(1):EyePos(), "prop_physics", 128)
if IsValid(ent) then
    Entity(1):EmitSound("scp/interact/PickItem2.ogg")
    ent:Remove()
end
