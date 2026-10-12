local Color = require "system.utils.Color"
local Enemy = require "rex.src.enemy"
local RiftSound = require "rift.schema.RiftSound"
local RiftStep = require "rift.game.RiftStep"


local function Devil(devil)
    local entity = {
        name = devil.name,
        friendlyName = { name = devil.friendlyName },
        health = { health = 1 },
        shield = { hits = devil.hits - 1 },
        totalHitCount = { count = devil.hits },
        shieldHitDelay = { steps = RiftStep.SUBDIV * devil.delay },
        editorLine = { color = devil.color },
        soundAttack = { sound = RiftSound.ID.ARMADILLO_ATTACK },
        soundDeath = { sound = RiftSound.ID.ARMADILLO_DEATH },
        soundHit = { sound = RiftSound.ID.SKULL_HURT },
        
        rex_customAssets = {
            name = devil.spriteName,
            default = { ppu = 110, pivot = { x = 0.5, y = 0 } },
            movement = {
                scales = Enemy.DEFAULT_SCALE
            },
            hit = {
                duration = devil.delay,
                frames = {
                    { t = 0, sprite = "h00" }
                },
                positions = {
                    { t = 0, x = 0, y = 0 },
                    { t = 0.2, x = 0, y = 0.75 }
                },
                scales = Enemy.DEFAULT_SCALE
            },
            death = Enemy.DEFAULT_DEATH,
            wrap = {
                scales = Enemy.DEFAULT_SCALE,
                colors = Enemy.DEFAULT_FADE,
            },
            portal = {
                scales = Enemy.DEFAULT_SCALE,
                colors = Enemy.DEFAULT_FADE,
            }
        },
    }
    Enemy.new(entity)
end

Devil {
    name = "DevilledEgg",
    friendlyName = "Green Devil",
    spriteName = "devil_green",
    hits = 1,
    delay = 0.25,
    color = Color.hex(0xFFFFFF)
}

Devil {
    name = "TrickyDevilledEgg",
    friendlyName = "Red Devil",
    spriteName = "devil_red",
    hits = 2,
    delay = 0.75,
    color = Color.hex(0xFF4D17)
}

Devil {
    name = "MediumDevilledEgg",
    friendlyName = "Blue Devil",
    spriteName = "devil_blue",
    hits = 2,
    delay = 0.25,
    color = Color.hex(0x4DAEFF)
}

Devil {
    name = "StrongDevilledEgg",
    friendlyName = "Yellow Devil",
    spriteName = "devil_yellow",
    hits = 3,
    delay = 0.25,
    color = Color.hex(0xFFAE4D)
}

Devil {
    name = "SuperDevilledEgg",
    friendlyName = "Pink Devil",
    spriteName = "devil_pink",
    hits = 4,
    delay = 0.25,
    color = Color.hex(0xFF4DAE)
}
