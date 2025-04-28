local isRagdoll = false


function PlayGetUpAnimation(ped)
    local dict = "get_up@standard"
    local anim = "front"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(1000) 
    ClearPedTasks(ped) 
end


function ToggleRagdoll(playerPed)
    if not isRagdoll then
        isRagdoll = true
        SetPedToRagdoll(playerPed, -1, -1, 0, true, true, false) 
    else
        isRagdoll = false
        ClearPedTasksImmediately(playerPed) 
        PlayGetUpAnimation(playerPed) 
    end
end


RegisterCommand("rag", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    ToggleRagdoll(playerPed)
end, false)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, ragdollKey) then
            local playerPed = PlayerPedId()
            ToggleRagdoll(playerPed)
        end
    end
end)


RegisterKeyMapping('toggle_ragdoll', 'Prepnout ragdoll', 'keyboard', 'U') 


RegisterCommand('toggle_ragdoll', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    ToggleRagdoll(playerPed)
end, false)