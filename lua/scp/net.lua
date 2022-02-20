util.AddNetworkString("SCPUseEntity")
util.AddNetworkString("SCPUsePos")
util.AddNetworkString("SCPStatusText")
function SCP.SendUse(ply)
    local ent = SCP.GetUseEntity(ply)
    net.Start("SCPUseEntity")
        net.WriteEntity(ent)
    net.Send(ply)
    if not IsValid(ent) then return end
    local pos = ent:WorldSpaceCenter()
    net.Start("SCPUsePos")
        net.WriteVector(pos)
    net.Send(ply)
end

function SCP.SendStatusText(ply, text)
    net.Start("SCPStatusText")
        net.WriteString(text)
    net.Send(ply)
end

hook.Add("PlayerTick", "SCPUseEntity", function (ply)
    SCP.SendUse(ply)
end)
