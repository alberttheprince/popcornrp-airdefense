local accuracy = 800.0 -- higher number is more inaccurate
local nogozone
local nogozone2
local ran = false
local ran2 = false

local function ApplyInaccuracy(targetCoords)
    local xOffset = math.random(-accuracy, accuracy) / 100
    local yOffset = math.random(-accuracy, accuracy) / 100
    local zOffset = math.random(-accuracy, accuracy) / 100
    return vector3(targetCoords.x + xOffset, targetCoords.y + yOffset, targetCoords.z + zOffset)
end


CreateThread(function()
    while true do
        Wait(math.random(1, 2)*1000)
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local dist = #(pCoords - vector3(1689.49, 2602.64, 45.56))
        PlayerData = QBCore.Functions.GetPlayerData() -- remove PlayerData = QBCore.Functions.GetPlayerData() if you want this to be standalone or change for your framework
        if dist < 250 and GetEntityHeightAboveGround(PlayerPedId()) > 5.0 and IsPedInFlyingVehicle(ped) and (PlayerData.job ~= 'police' or 'ambulance') then -- remove (PlayerData.job ~= 'police' or 'ambulance') if you want this to be standalone or change for your framework
            local count = 0
            local random = math.random(1,5)
            if not ran then
                ran = true
                nogozone = AddBlipForRadius(1689.49, 2602.64, 45.56, 250.0)
                SetBlipColour(nogozone, 1)
                SetBlipAlpha(nogozone, 128)
            end
            while count < random do
                local targetCoords = ApplyInaccuracy(pCoords)
                AddExplosion(targetCoords.x, targetCoords.y, targetCoords.z, 18, 2.0, true, false, 1.0)
                count = count + 1
                Wait(math.random(250, 500))
            end
        elseif dist > 250 and ran then
            RemoveBlip(nogozone)
            ran = false
        end
    end
end)

CreateThread(function()
    while true do
        Wait(math.random(1, 2)*1000)
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local dist = #(pCoords - vector3(-2243.77, 3141.49, 32.81))
        PlayerData = QBCore.Functions.GetPlayerData() -- remove PlayerData = QBCore.Functions.GetPlayerData() if you want this to be standalone or change for your framework
        if dist < 700 and GetEntityHeightAboveGround(PlayerPedId()) > 5.0 and IsPedInFlyingVehicle(ped) and (PlayerData.job ~= 'police' or 'ambulance') then -- remove (PlayerData.job ~= 'police' or 'ambulance') if you want this to be standalone or change for your framework
            local count = 0
            local random = math.random(1,5)
            if not ran2 then
                ran2 = true
                nogozone2 = AddBlipForRadius(-2243.77, 3141.49, 32.81, 700.0)
                SetBlipColour(nogozone2, 1)
                SetBlipAlpha(nogozone2, 128)
            end
            while count < random do
                local targetCoords = ApplyInaccuracy(pCoords)
                AddExplosion(targetCoords.x, targetCoords.y, targetCoords.z, 18, 2.0, true, false, 1.0)
                count = count + 1
                Wait(math.random(250, 500))
            end
        elseif dist > 700 and ran2 then
            RemoveBlip(nogozone2)
            ran = false
        end
    end
end)
