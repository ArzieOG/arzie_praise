RegisterCommand('praiseplayer', function()
    TriggerServerEvent('arzie_praise:tryOpen')
end, false)

RegisterNetEvent('arzie_praise:openUI', function()
    local dialog = lib.inputDialog('🙏 Submit Praise', {
        { type = 'input', label = 'Your Name', placeholder = 'John Doe', required = true },
        { type = 'input', label = 'Player / Character You Are Praising', placeholder = 'Jane Doe', required = true },
        { type = 'textarea', label = 'Comments', placeholder = 'Explain why you are praising this person...', required = true },
        { type = 'select', label = 'Are you okay with this praise being public?', options = {
            { value = 'yes', label = 'Yes - You may share it publicly' },
            { value = 'no', label = 'No - Keep it private' },
        }, required = true }
    })

    if not dialog then return end

    TriggerServerEvent('arzie_praise:submit', {
        from = dialog[1],
        target = dialog[2],
        comments = dialog[3],
        allow_public = dialog[4]
    })
end)
