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

RiftEvent.ObjectHit.add("knockbackDelay", { order = "knockback", filter = "rex_knockback" }, function (ev)
    ev.entity.subDelayOverride = { steps = RiftStep.SUBDIV * ev.entity.rex_knockback.delay }
end)

RiftEvent.ObjectHit.add("facingMirrorOnBeatFix", { order = "knockback", filter = "facingMirrorOnBeat" }, function (ev)
    ev.entity.facing = { x = -ev.entity.facing.x }
    ev.entity.facingMirrorOnBeat = false
    ev.entity.facingMirrorOnHit = {}
end)

local function Slime(slime)
    local MOVE = {
        frames = {
            { t = 0, sprite = 3 },
            { t = 28 / 60, sprite = 2 },
            { t = 30 / 60, sprite = 0 },
        },
        scales = Enemy.DEFAULT_SCALE
    }
    
    local HIT = {
        duration = slime.delay or 1,
        frames = MOVE.frames,
        scales = MOVE.scales
    }
    
    local WRAP = {
        frames = MOVE.frames,
        scales = MOVE.scales,
        colors = Enemy.DEFAULT_FADE
    }
    
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
            movement = MOVE,
            hit = HIT,
            death = Enemy.DEFAULT_DEATH,
            wrap = WRAP,
            portal = WRAP,
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
