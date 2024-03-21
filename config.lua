config = {
    propNames = {
        "prop_tree_fallen_02",
    },
    notification = {
        title = "Tree Fallen",
        description = "A tree has fallen nearby!",
        duration = 5000, -- Duration in milliseconds (5 seconds in this case)
        position = 'top-right', -- Display position
        type = 'error', -- Notification type
        icon = 'tree', -- Font Awesome 6 icon name for a tree (adjust if needed)
        iconColor = '#ff0000', -- Icon color (red in this case)
        alignIcon = 'center' -- Icon alignment
    },
    propSpawnLocations = {

        {x = -684.18, y = 5939.76, z = 14.82, heading = 5.67}, -- Location 1
        {x = -405.28, y = 6231.03, z = 33.15, heading = 88.72}, -- Additional Location 2
        {x = 35.30, y = 6391.87, z = 31.37, heading = 131.14} -- Additional Location 3
    },
    minSpawnInterval = 60, -- Minimum time in seconds before next spawn (5 minutes)
    maxSpawnInterval = 120, -- Maximum time in seconds before next spawn (25 minutes)
    holdDuration = 4.0, -- Duration in seconds for the left click hold
    
    -- Blip Configuration
    blipSprite = 836, -- Blip sprite (1 is for default, adjust if needed)
    blipColor = 25, -- Blip color (5 is for purple, adjust if needed)
    blipScale = 1.0 -- Blip scale (adjust if needed)
}
