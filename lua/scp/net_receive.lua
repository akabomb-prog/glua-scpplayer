net.Receive("SCPUseEntity", function (len, ply)
    SCP.UseEntity = net.ReadEntity()
end)
net.Receive("SCPUsePos", function (len, ply)
    SCP.UsePos = net.ReadVector()
end)
net.Receive("SCPStatusText", function (len, ply)
    SCP.StatusText(net.ReadString())
end)
