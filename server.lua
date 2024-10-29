local admins = {
    "fivem:1234567890", -- Указывать все id через запятую
}

RegisterCommand('toggleadmin', function(source, args, rawCommand)
    local playerId = source
    local identifier = getFiveMIdentifier(playerId)

    if isAdmin(identifier) then
        -- Отправляем событие всем игрокам с указанием того, чей префикс нужно изменить
        TriggerClientEvent('admin:toggleTag', -1, playerId)
    else
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 165, 0}, -- Оранжевый цвет
            args = {"Система", "^7У вас нет прав для использования этой команды."} -- Белый текст
        })
    end
end, false)

function getFiveMIdentifier(playerId)
    for _, id in ipairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(id, 1, 6) == "fivem:" then
            return id
        end
    end
    return nil
end

function isAdmin(identifier)
    for _, admin in ipairs(admins) do
        if identifier == admin then
            return true
        end
    end
    return false
end