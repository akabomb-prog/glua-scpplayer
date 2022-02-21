local ent = ents.Create("prop_physics")

local function ConeOfThoughts(ent)
    ent:SetModel(Model("models/props_junk/TrafficCone001a.mdl"))
    ent:SetVar("SCP_StatusText", "hmm cone")
    ent:SetVar("SCP_UseAnytime", true)
    ent:Spawn()
end

local function DimensionalBust(ent)
    ent:SetModel(Model("models/props_combine/breenbust.mdl"))
    -- ent:SetColor(HSLToColor(math.random(0, 6) * 60, 0.75, 0.75))
    ent:SetColor(Color(255, 255, 0, 255))
    ent:SetMaterial("models/screenspace")
    ent:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    ent:SetVar("SCP_UseAnytime", true)
    ent:SetVar("SCP_StatusText", "You try to touch it, but your hand phases through.")
    ent:Spawn()
    ent:GetPhysicsObject():EnableGravity(false)
end

if IsValid(ent) then
    ent:SetPos(Entity(1):GetEyeTrace().HitPos)
    DimensionalBust(ent)
end
