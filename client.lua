local showAdminTag = {}
local maxDistance = 50.0 -- Максимальная дистанция видимости текста

RegisterNetEvent('admin:toggleTag')
AddEventHandler('admin:toggleTag', function(playerId)
    showAdminTag[playerId] = not showAdminTag[playerId]
    if playerId == GetPlayerServerId(PlayerId()) then
        if showAdminTag[playerId] then
            TriggerEvent('chat:addMessage', {
                color = {255, 165, 0}, -- Оранжевый цвет
                args = {"Система", "^7Префикс администратора включён."} -- Белый текст
            })
        else
            TriggerEvent('chat:addMessage', {
                color = {255, 165, 0}, -- Оранжевый цвет
                args = {"Система", "^7Префикс администратора отключён."} -- Белый текст
            })
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i = 0, 255 do
            if NetworkIsPlayerActive(i) then
                local serverId = GetPlayerServerId(i)
                if showAdminTag[serverId] then
                    local targetPed = GetPlayerPed(i)
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance <= maxDistance then
                        DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 1.2, "[ADMIN]", 255, 0, 0, 255)
                    end
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text, r, g, b, a)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 75)
end
