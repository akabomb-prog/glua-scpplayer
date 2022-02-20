local ent = ents.Create("prop_physics")

if IsValid(ent) then
    ent:SetModel("models/props_junk/TrafficCone001a.mdl")
    ent:SetPos(Entity(1):GetEyeTrace().HitPos)
    ent:SetVar("SCP_StatusText", "hmm cone")
    ent:SetVar("SCP_UseAnytime", true)
    ent:Spawn()
end
