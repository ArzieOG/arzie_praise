local webhook = "YOUR_WEBHOOK_HERE"
local cooldownHours = 24

local function sendWebhook(data, citizenid, src)
    if not webhook or webhook == "" then return end

    local playerName = GetPlayerName(src) or "Unknown"

    -- ALWAYS show the player's real name in webhook
    local embed = {
        title = "🙏 New Player Praise",
        color = 5763719,
        fields = {
            { name = "From (Always Real Name)", value = data.from or "Unknown", inline = false },
            { name = "Praising", value = data.target or "Unknown", inline = false },
            { name = "Comments", value = data.comments or "None", inline = false },
            { name = "CitizenID", value = citizenid or "Unknown", inline = false },
            { name = "In-Game Player Name", value = playerName, inline = false },
            { name = "Player Allowed Public Posting?", value = data.allow_public == 'yes' and 'Yes' or 'No', inline = false },
        },
        footer = { text = "Praise System - FiveM" },
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ')
    }

    PerformHttpRequest(webhook, function() end, "POST", json.encode({
        username = "Praise System",
        embeds = { embed }
    }), { ["Content-Type"] = "application/json" })
end

RegisterNetEvent('arzie_praise:tryOpen', function()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    if not player then return end

    local citizenid = player.PlayerData.citizenid

    local last = MySQL.scalar.await('SELECT last_praise FROM praise_cooldowns WHERE citizenid = ?', { citizenid })
    if last then
        local now = os.time()
        local diff = now - last
        if diff < cooldownHours * 3600 then
            local remaining = (cooldownHours * 3600) - diff
            local hrs = math.floor(remaining / 3600)
            local mins = math.floor((remaining % 3600) / 60)
            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                title = 'Cooldown',
                description = ('You can praise again in %s hours %s minutes.'):format(hrs, mins)
            })
            return
        end
    end

    TriggerClientEvent('arzie_praise:openUI', src)
end)

RegisterNetEvent('arzie_praise:submit', function(input)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    if not player then return end

    local citizenid = player.PlayerData.citizenid
    if not citizenid then return end

    if not input or type(input) ~= "table" then return end

    local from = tostring(input.from or ""):gsub("^%s*(.-)%s*$", "%1")
    local target = tostring(input.target or ""):gsub("^%s*(.-)%s*$", "%1")
    local comments = tostring(input.comments or ""):gsub("^%s*(.-)%s*$", "%1")
    local allow_public = input.allow_public == 'yes' and 'yes' or 'no'

    if from == "" or target == "" or comments == "" then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            title = 'Error',
            description = 'All fields are required.'
        })
        return
    end

    local now = os.time()

    MySQL.insert.await([[
        INSERT INTO praise_cooldowns (citizenid, last_praise)
        VALUES (?, ?)
        ON DUPLICATE KEY UPDATE last_praise = VALUES(last_praise)
    ]], { citizenid, now })

    sendWebhook({
        from = from,
        target = target,
        comments = comments,
        allow_public = allow_public
    }, citizenid, src)

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'success',
        title = 'Praise Sent',
        description = 'Your praise has been submitted!'
    })
end)
