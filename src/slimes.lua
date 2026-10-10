local Color = require "system.utils.Color"
local RiftSound = require "rift.schema.RiftSound"
local Enemy = require "rex.src.enemy"
local RiftEvent = require "rift.event.RiftEvent"
local RiftStep = require "rift.game.RiftStep"
local RiftSchema = require "rift.schema.RiftSchema"

local field = RiftSchema.field

RiftSchema.components {
    rex_knockback = {
        field.float("delay"),
    },
}

RiftEvent.ObjectHit.add("knockbackDelay", {order = "knockback", filter = "rex_knockback"}, function (ev)
    ev.entity.subDelayOverride = { steps = RiftStep.SUBDIV * ev.entity.rex_knockback.delay }
end)

local function Slime(slime)
    local entity = {
        name = slime.name,
        friendlyName = { name = slime.friendlyName },
        health = { health = slime.hits },
        totalHitCount = { count = slime.hits },
        facingMirrorOnBeat = {},
        rex_knockback = { delay = slime.delay or 1 },
        editorLine = { color = slime.color },
        soundAttack = { sound = RiftSound.ID.SLIME_ATTACK },
        soundDeath = { sound = RiftSound.ID.SLIME_DEATH },
        soundHit = { sound = RiftSound.ID.SLIME_HURT },
        
        rex_customAssets = {
            name = slime.spriteName,
            default = { ppu = 100, pivot = { x = 0.5, y = 0.28 } },
            movement = {
                frames = {
                    { t = 0, sprite = 3},
                    { t = 0.46666667, sprite = 2},
                    { t = 0.5, sprite = 0 },
                },
                scales = Enemy.DEFAULT_SCALE
            },
            hit = {
                duration = slime.delay or 1,
                frames = {
                    { t = 0, sprite = 3},
                    { t = 0.46666667, sprite = 2},
                    { t = 0.5, sprite = 0 },
                },
                scales = Enemy.DEFAULT_SCALE
            },
            death = Enemy.DEFAULT_DEATH
        },
    }
    Enemy.new(entity)
end

Slime {
    name = "EnemySlimeTricky",
    friendlyName = "Red Slime",
    spriteName = "slime_red",
    hits = 2,
    delay = 1.5,
    color = Color.hex(0xFF4D17)
}

Slime {
    name = "EnemySlimeSuperStrong",
    friendlyName = "Pink Slime",
    spriteName = "slime_pink",
    hits = 4,
    color = Color.hex(0xFF4DAE)
}
