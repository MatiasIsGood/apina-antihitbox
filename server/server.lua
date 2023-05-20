local discord_webhook = {
    url = "https://discord.com/api/webhooks/1109441728420774022/VNsZeITe5Tb7HF7YfQNnnqvW3orZUz7bJR0a4YXryMpe3-eiP38x6jiEGhhYvm-sXMdd",
    image = "https://cdn.discordapp.com/attachments/1078674346232528987/1108740882955505824/2E617206-254A-4649-9965-D790669EA8D1-1.png"
}

function ExtractIdentifiers(source)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function sendToDiscordText(name, message)
  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(discord_webhook.url, function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end


function sendToDiscord(color, name, message, footer)
  local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

  PerformHttpRequest(discord_webhook.url, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

--MAIN SHIT
RegisterServerEvent('HitboxDetected')
AddEventHandler('HitboxDetected', function()
    local identifiers = ExtractIdentifiers(source)
    message = "Pelaaja kikattu isompien hitboxien takia.\n ID: ".. source .. "\nsteam: " ..identifiers.steam .. "\nip: " .. identifiers.ip .. "\ndiscord: " .. identifiers.discord

    sendToDiscord(946883, "Hitbox muokkas huomattu", message, "Tehnyt Matias")
    sendToDiscordText("Ilmotus", "@everyone")
    DropPlayer(source, "ok1")
    print("Dropped player ID:" .. source)  
end)