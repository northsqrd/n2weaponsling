local attached = {}
local attachPositions = {}

local function LoadModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end
end

local function ListKeys(t)
    local keys = {}
    for k, v in pairs(t) do
        table.insert(keys, k)
    end
    return keys
end

local function AttachWeapon(ped, weapon)
    local coords = GetEntityCoords(ped)
    local data = cfg.attachables[weapon]
    attached[weapon] = { obj = nil, components = {} }
    LoadModel(data.model)
    local weaponObj = CreateObject(data.model, coords, true, false, false)

    local loc = data.defaultLoc
    if attachPositions[weapon] then
        loc = attachPositions[weapon]
    end


    AttachEntityToEntity(weaponObj, ped, GetPedBoneIndex(ped, data.attachBone), data.loc[loc].pos, data.loc[loc].rot, 0, 1, 0, 0, 2, 1)
    attached[weapon].obj = weaponObj

    for k, v in pairs(data.components) do
        if HasPedGotWeaponComponent(ped, weapon, k) then
            LoadModel(v.model)
            local componentObj = CreateObject(v.model, coords, true, false, false)
            AttachEntityToEntity(componentObj, weaponObj, GetEntityBoneIndexByName(weaponObj, v.attachBone), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 0, 0, 2, 1)
            table.insert(attached[weapon].components, componentObj)
        end
    end
end

local function DetachWeapon(ped, weapon)
    DeleteObject(attached[weapon].obj)

    for _, v in pairs(attached[weapon].components) do
        DeleteObject(v)
    end

    attached[weapon] = nil
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        for k, _ in pairs(cfg.attachables) do
            if HasPedGotWeapon(ped, k, false) then
                local _, currentWeapon = GetCurrentPedWeapon(ped)
                if attached[k] and currentWeapon == k then
                    DetachWeapon(ped, k)
                elseif currentWeapon ~= k and not attached[k] then
                    AttachWeapon(ped, k)
                end
            elseif attached[k] then
                DetachWeapon(ped, k)
            end
        end
        Wait(250)
    end
end)

RegisterCommand('sling', function(src, args)
    if #args < 1 then
        TriggerEvent('chat:addMessage', {
            args = { '^6[Sling]', 'Usage: /slingpos [pos|list]' },
        })
        return
    end

    local ped = PlayerPedId()
    local action = string.lower(tostring(args[1]))

    local _, currentWeapon = GetCurrentPedWeapon(ped)
    if not cfg.attachables[currentWeapon] then
        TriggerEvent('chat:addMessage', {
            args = { '^6[Sling]', 'Current weapon is not supported.' },
        })
    end

    if action == 'list' then
        TriggerEvent('chat:addMessage', {
            args = { '^6[Sling]', 'Available positions: ' .. table.concat(ListKeys(cfg.attachables[currentWeapon].loc), ', ') .. '.' },
        })
        return
    end

    if not cfg.attachables[currentWeapon].loc[action] then
        TriggerEvent('chat:addMessage', {
            args = { '^6[Sling]', 'Invalid position. Valid positions: ' .. table.concat(ListKeys(cfg.attachables[currentWeapon].loc), ', ') .. '.' },
        })
        return
    end

    attachPositions[currentWeapon] = action
    TriggerEvent('chat:addMessage', {
        args = { '^6[Sling]', "Position for current weapon set to '" .. action .. "'." },
    })
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(attached) do
            DetachWeapon(PlayerPedId(), k)
        end
    end
end)
