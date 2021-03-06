include "scp/config.lua"
include "scp/utils.lua"
if SERVER then
    include "scp/net.lua"
    include "scp/movement.lua"
    include "scp/pickupsys.lua"
    include "scp/stamina.lua"
elseif CLIENT then
    include "scp/net_receive.lua"
    include "scp/client.lua"
    include "scp/camera.lua"
    include "scp/statustext.lua"
    include "scp/graphics.lua"
end