util.AddNetworkString("SCPUseEntity")
util.AddNetworkString("SCPUsePos")
function SCP.SendUse(ply)
    local ent = SCP.GetUseEntity(ply)
    net.Start("SCPUseEntity")
        net.WriteEntity(ent)
    net.Send(ply)
    if not IsValid(ent) then return end
    local pos = ent:WorldSpaceCenter()
    net.Start("SCPUsePos")
        net.WriteFloat(pos.x)
        net.WriteFloat(pos.y)
        net.WriteFloat(pos.z)
    net.Send(ply)
end

hook.Add("PlayerTick", "SCPUseEntity", function (ply)
    SCP.SendUse(ply)
end)
