local QBCore = exports['qb-core']:GetCoreObject()

local accuracy = 800.0 -- higher number is more inaccurate
local nogozone
local nogozone2
local ran = false
local ran2 = false
local isAlarmActive = false
local isExplosionActive = false

Config.Timer = 5000 -- edit this to change the length of the timer for users to exit the area, timer in MS. 10000 = 10 seconds

local function ApplyInaccuracy(targetCoords)
    local offset = math.random(-accuracy, accuracy) / 100
    local xOffset = offset
    local yOffset = offset
    local zOffset = offset
    return vector3(targetCoords.x + xOffset, targetCoords.y + yOffset, targetCoords.z + zOffset)
end

CreateThread(function()
    while true do
        Wait(math.random(1, 2) * 1000)
        local ped = PlayerPedId()
        local dist = #(GetEntityCoords(ped) - vector3(1689.49, 2602.64, 45.56))
        local PlayerData = QBCore.Functions.GetPlayerData()
        
        if dist < 300 and GetEntityHeightAboveGround(ped) > 5.0 and IsPedInFlyingVehicle(ped) and (PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance') then
            local count = 0
            local random = math.random(1, 5)

            if not ran then
                ran = true
                nogozone = AddBlipForRadius(1689.49, 2602.64, 45.56, 300.0)
                SetBlipColour(nogozone, 1)
                SetBlipAlpha(nogozone, 128)
            end
            
            while count < random do
                if not isAlarmActive then
                    QBCore.Functions.Notify('You are entering restricted airspace! Please leave in the next '..(Config.Timer / 1000)..' seconds!', 'error')     
                    isAlarmActive = true
                    Wait(Config.Timer) -- Wait for 10 seconds before explosions
                    QBCore.Functions.Notify('Air defense systems have been activated! Get out of here!', 'error')
                    isExplosionActive = true
                end
                
                while isExplosionActive do
                    local ped = PlayerPedId()
                    local pCoords = GetEntityCoords(ped)
                    local targetCoords = ApplyInaccuracy(pCoords)
                    AddExplosion(targetCoords.x, targetCoords.y, targetCoords.z, 18, 2.0, true, false, 1.0)
                    count = count + 1
                    Wait(math.random(200, 500))

                    -- Check if the player is still within the zone, if not, deactivate explosions
                    local dist = #(pCoords - vector3(1689.49, 2602.64, 45.56))
                    if dist >= 300 then
                        isExplosionActive = false
                        break
                    end
                end
            end 
        elseif dist > 300 then
            if ran then
                RemoveBlip(nogozone)
                ran = false
                isAlarmActive = false
                isExplosionActive = false
            end
        end

        local isPlayerDead = IsEntityDead(ped)
        if isPlayerDead then 
            RemoveBlip(nogozone)
            ran = false
            isAlarmActive = false
            isExplosionActive = false
            Wait(1000)
        end
    end
end)


CreateThread(function()
    while true do
        Wait(math.random(1, 2) * 1000)
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local dist = #(pCoords - vector3(-2243.77, 3141.49, 32.81))
        local PlayerData = QBCore.Functions.GetPlayerData()
        
        if dist < 700 and GetEntityHeightAboveGround(ped) > 5.0 and IsPedInFlyingVehicle(ped) and (PlayerData.job.name ~= 'police') and (PlayerData.job.name ~= 'ambulance') then
            local count = 0
            local random = math.random(1, 5)

            if not ran2 then
                ran2 = true
                nogozone2 = AddBlipForRadius(-2243.77, 3141.49, 32.81, 700.0)
                SetBlipColour(nogozone2, 1)
                SetBlipAlpha(nogozone2, 128)
            end
            
            while count < random do
                if not isAlarmActive then
                    QBCore.Functions.Notify('You are entering restricted airspace! Please leave in the next '..(Config.Timer / 1000)..' seconds!', 'error')                    
                    isAlarmActive = true
                    Wait(Config.Timer) -- Wait for 10 seconds before explosions
                    QBCore.Functions.Notify('Air defense systems have been activated! Get out of here!', 'error')
                    isExplosionActive = true
                end
                
                while isExplosionActive do
                    local ped = PlayerPedId()
                    local pCoords = GetEntityCoords(ped)
                    local targetCoords = ApplyInaccuracy(pCoords)
                    AddExplosion(targetCoords.x, targetCoords.y, targetCoords.z, 18, 2.0, true, false, 1.0)
                    count = count + 1
                    Wait(math.random(200, 500))

                    -- Check if the player is still within the zone, if not, deactivate explosions
                    local dist = #(pCoords - vector3(-2243.77, 3141.49, 32.81))
                    if dist >= 700 then
                        isExplosionActive = false
                        break
                    end
                end
            end 
        elseif dist > 700 then
            if ran2 then
                RemoveBlip(nogozone2)
                ran2 = false
                isAlarmActive = false
                isExplosionActive = false
            end
        end

        local isPlayerDead = IsEntityDead(ped)
        if isPlayerDead then 
            RemoveBlip(nogozone2)
            ran2 = false
            isAlarmActive = false
            isExplosionActive = false
            Wait(1000)
        end
    end
end)
