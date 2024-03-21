local spawnedProp = nil
-- Function to remove a prop
local function removeProp(prop)
    if DoesEntityExist(prop) then
        print("Removing prop...")





        -- Give the player the minigun weapon
        GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_minigun"), 999, false, true)

        local timer = 0
        local clickDuration = config.holdDuration

        -- Wait for the player to hold the left mouse button for the specified duration
        while timer < clickDuration do
            if IsControlPressed(0, 24) then -- Left mouse button
                timer = timer + GetFrameTime()
            else
                -- Reset timer if button is released
                timer = 0
            end
            Citizen.Wait(0)
        end
		-- Delete the prop entity
        DeleteEntity(prop)
        -- Remove the prop as a targetable entity along with its options
        local propNetId = NetworkGetNetworkIdFromEntity(prop)
        exports.ox_target:removeEntity(propNetId, "Remove Prop")
        -- Remove the minigun weapon once the click duration is reached
        RemoveWeaponFromPed(PlayerPedId(), GetHashKey("weapon_minigun"))
        print("Prop removed.")
    else
        print("Prop does not exist.")
    end
end


-- Function to display notification for spawned prop
local function notifyPropSpawned(propName)
    print("Notifying about spawned prop: " .. propName)
    lib.notify(config.notification)
    print("Prop spawned notification sent.")
end

-- Function to create a blip at prop's location
local function createBlipAtProp(prop)
    local blip = AddBlipForEntity(prop)
    SetBlipSprite(blip, config.blipSprite)
    SetBlipColour(blip, config.blipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Prop")
    EndTextCommandSetBlipName(blip)
    return blip
end

-- Function to spawn a prop at a specific location
local function spawnPropAtLocation(propName, location)
    local propHash = GetHashKey(propName)
    print("Prop name: " .. propName .. ", Hash: " .. propHash)
    local prop = CreateObject(propHash, location.x, location.y, location.z, true, false, true)
    if prop == 0 then
        print("Failed to spawn prop: " .. propName)
    else
        SetEntityHeading(prop, location.heading)
        PlaceObjectOnGroundProperly(prop)
        notifyPropSpawned(propName)

        -- Get the network ID of the created prop object
        local propNetId = NetworkGetNetworkIdFromEntity(prop)

        -- Create targetable option for the prop
        local propOptions = {
            label = "Remove Prop", -- Label for the option
            onSelect = function()
                removeProp(prop) -- Call remove function when interacted
            end
        }

        -- Add the prop as a targetable entity with options
        exports.ox_target:addEntity(propNetId, propOptions)
        
        -- Create a blip at the prop's location
        local blip = createBlipAtProp(prop)
        
        -- Store the blip handle with the prop
        SetEntityAsMissionEntity(blip, true, true)
        SetEntityAsMissionEntity(prop, true, true)
        SetBlipDisplay(blip, 2)
        SetBlipScale(blip, config.blipScale)
        SetBlipNameToPlayerName(blip, false)
    end
    return prop
end

-- Function to spawn all props at multiple locations
local function spawnAllProps()
    local props = {}
    for _, location in ipairs(config.propSpawnLocations) do
        for _, propName in ipairs(config.propNames) do
            local prop = spawnPropAtLocation(propName, location)
            table.insert(props, prop)
        end
    end
    return props
end

-- Function to remove all spawned props
local function removeAllProps(props)
    for _, prop in ipairs(props) do
        removeProp(prop)
    end
end

-- Function to spawn a prop at a random location
local function spawnRandomProp()
    if spawnedProp == nil or not DoesEntityExist(spawnedProp) then
        local randomLocation = config.propSpawnLocations[math.random(#config.propSpawnLocations)]
        local randomPropName = config.propNames[math.random(#config.propNames)]
        spawnedProp = spawnPropAtLocation(randomPropName, randomLocation)
    end
end

-- Function to continuously spawn and remove props
local function spawnAndRemovePropsThread()
    while true do
        local spawnInterval = math.random(config.minSpawnInterval, config.maxSpawnInterval)
        print("Next prop will spawn in " .. spawnInterval .. " seconds.")
        Citizen.Wait(spawnInterval * 1000) -- Wait for random spawn interval
        print("Spawning random prop...")
        spawnRandomProp()
    end
end

-- Start the thread to continuously spawn and remove props
print("Starting prop spawn and remove thread...")
Citizen.CreateThread(spawnAndRemovePropsThread)