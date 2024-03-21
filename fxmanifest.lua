author "TheStoicBear"
description "Stoic-FallenTrees"
version "1.0.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

client_scripts {
    "src/client.lua",
}

-- server_scripts {
--     --"source/skinning/server.lua"
-- }

shared_scripts {
    "@ox_lib/init.lua",
	"config.lua"
    -- "@ND_Core/init.lua"
}

escrow_ignore {
    "config.lua"
}

-- dependency "ND_Core"
