Citizen.CreateThread(function()
    while true do
        local min,max = GetModelDimensions(GetEntityModel(PlayerPedId()))
        if min.y < -0.29 or max.z > 0.98 then
            TriggerServerEvent('HitboxDetected')
            print("HITBOX DETECT")
        end
        Wait(4500)
    end
end)