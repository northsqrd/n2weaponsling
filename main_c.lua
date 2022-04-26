local attached = {}

local function AttachWeapon(ped, weapon)
    local coords = GetEntityCoords(ped)
    local data = cfg.attachables[weapon]
    attached[weapon] = {obj = nil, components = {}}

    local weaponObj = CreateObject(data.model, coords, true, false, false)
    AttachEntityToEntity(weaponObj, ped, GetPedBoneIndex(ped, data.attachBone), data.pos.x, data.pos.y, data.pos.z, data.rot.x, data.rot.y, data.rot.z, 0, 1, 0, 0, 2, 1)
    attached[weapon].obj = weaponObj

    for k, v in pairs(data.components) do
        if HasPedGotWeaponComponent(ped, weapon, k) then
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

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(attached) do
            DetachWeapon(PlayerPedId(), k)
        end
    end
end)