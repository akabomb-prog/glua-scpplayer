function SCP.CanSprint(ply)
    local can = (CurTime() > ply:GetVar("SCP_SprintRecoveryEnd", 0)) and (ply:GetNWFloat("SCP_Stamina", 100) > 0)
    ply:SetNWBool("SCP_CanSprint", can)
    return can
end

hook.Add("Tick", "SCP_Stamina", function ()
    for i,ply in ipairs(player.GetAll()) do
        if SCP.ShouldAffect(ply) then
            local moving = SCP.IsMoving(ply)
            local sprinting = ply:KeyDown(IN_SPEED)
            local stamina = ply:GetNWFloat("SCP_Stamina", 100)
            if stamina == 0 then
                ply:SetVar("SCP_SprintRecoveryEnd", CurTime() + SCP.sprintRecoveryTime)
            end

            if moving and sprinting and SCP.CanSprint(ply) then
                stamina = math.Clamp(stamina - (SCP.staminaDrainSpeed * engine.TickInterval()), 0, 100)
            else
                stamina = math.Clamp(stamina + SCP.staminaRecoverSpeed * engine.TickInterval(), 0, 100)
            end
            ply:SetNWFloat("SCP_Stamina", stamina)
        end
    end
end)

hook.Add("StartCommand", "SCP_Stamina", function (ply, ucmd)
    if not SCP.CanSprint(ply) then
        ucmd:RemoveKey(IN_SPEED)
    end
end)
