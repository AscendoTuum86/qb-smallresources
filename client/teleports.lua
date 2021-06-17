Teleports = Teleports or {}
Teleports.Locations = {
    [1] = { -- Humane Labs
        [1] = {x = 3540.74, y = 3675.59, z = 20.99, h = 167.5, r = 1.0},
        [2] = {x = 3540.74, y = 3675.59, z = 28.11, h = 172.5, r = 1.0},
    },
    [2] = { -- Integrity Elevator 1
        [1] = {x = 284.53, y = -641.26, z = 42.01, h = 163.5, r = 1.0},
        [2] = {x = 270.34, y = -649.95, z = 4.64, h = 248.5, r = 1.0},
    },
    [3] = { -- Integrity Elevator 2
        [1] = {x = 288.15, y = -642.75, z = 62.01, h = 170.5, r = 1.0},
        [2] = {x = 271.8, y = -646.33, z = 4.64, h = 253.5, r = 1.0},
    },
    [4] = { -- Integrity Elevator 3
        [1] = {x = 291.81, y = -644.14, z = 42.01, h = 168.5, r = 1.0},
        [2] = {x = 273.2, y = -642.66, z = 4.64, h = 264.5, r = 1.0},
    },
    [5] = { -- Integrity Elevator 4
        [1] = {x = 280.77, y = -652.0, z = 42.01, h = 338.5, r = 1.0},
        [2] = {x = 270.34, y = -649.95, z = 4.64, h = 248.5, r = 1.0},
    },
    [6] = { -- Integrity Elevator 5
        [1] = {x = 284.37, y = -653.29, z = 42.01, h = 334.5, r = 1.0},
        [2] = {x = 271.8, y = -646.33, z = 4.64, h = 253.5, r = 1.0},
    },
    [7] = { -- Integrity Elevator 6
        [1] = {x = 288.1, y = -654.76, z = 42.01, h = 335.5, r = 1.0},
        [2] = {x = 273.2, y = -642.66, z = 4.64, h = 264.5, r = 1.0},
    },
    [8] = { -- Penthouse
        [1] = {x = -305.05, y = -720.95, z = 28.02, h = 160.5, r = 1.0},
        [2] = {x = -288.22, y = -722.57, z = 125.47, h = 249.5, r = 1.0},
    },
    [9] = { -- Merryweather
        [1] = {x = 2475.6, y = -384.1, z = 94.39, h = 87.5, r = 1.0},
        [2] = {x = 460.59, y = 4815.5, z = -59.01, h = 193.5, r = 1.0},
    },
}

JustTeleported = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local inRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for loc,_ in pairs(Teleports.Locations) do
            for k, v in pairs(Teleports.Locations[loc]) do
                local dist = #(pos - vector3(v.x, v.y, v.z))
                if dist < 2 then
                    inRange = true
                    DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)

                    if dist < 1 then
                        DrawText3Ds(v.x, v.y, v.z, '[E] To take the Elevator')
                        if IsControlJustReleased(0, 51) then
                            if k == 1 then
                                SetEntityCoords(ped, Teleports.Locations[loc][2].x, Teleports.Locations[loc][2].y, Teleports.Locations[loc][2].z)
                            elseif k == 2 then
                                SetEntityCoords(ped, Teleports.Locations[loc][1].x, Teleports.Locations[loc][1].y, Teleports.Locations[loc][1].z)
                            end
                            ResetTeleport()
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)

ResetTeleport = function()
    SetTimeout(1000, function()
        JustTeleported = false
    end)
end