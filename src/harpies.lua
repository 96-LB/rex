local Color = require "system.utils.Color"
local Enemy = require "rex.src.enemy"
local RiftSound = require "rift.schema.RiftSound"
local RiftStep = require "rift.game.RiftStep"


local function Harpy(harpy)
    local MOVE = {
        duration = 2,
        frames = {
            { t = 0, sprite = "s01" },
            { t = 3 / 120, sprite = 0 },
            { t = 6 / 120, sprite = 1 },
            { t = 10 / 120, sprite = 2 },
            { t = 15 / 120, sprite = 3 },
            { t = 58 / 120, sprite = 4 },
            { t = 59 / 120, sprite = 5 },
            { t = 60 / 120, sprite = 0 },
            { t = 63 / 120, sprite = 6 },
            { t = 67 / 120, sprite = 9 },
            { t = 71 / 120, sprite = 11 },
            { t = 75 / 120, sprite = 15 },
            { t = 118 / 120, sprite = "s00" },
            { t = 119 / 120, sprite = "s01" },
        },
        scales = {
            { t = 0, x = 0.25, y = 0.11 },
            { t = 5 / 120, x = 0.18, y = 0.18 },
            { t = 58 / 120 },
            { t = 59 / 120, x = 0.13, y = 0.22 },
            { t = 60 / 120, x = 0.25, y = 0.11 },
            { t = 70 / 120, x = 0.18, y = 0.18 },
            { t = 118 / 120 },
            { t = 119 / 120, x = 0.13, y = 0.22 },
            { t = 120 / 120},
        },
        positions = {
            { t = 0, x = 0, y = 0, right_handle = 2/3 }, -- handle is unused for now
            { t = 10 / 120, x = 0, y = 0.223 + -0.011, right_handle = 0 },
            { t = 58 / 120, x = 0, y = 0.223 + 0.009, left_handle = 2/3 },
            { t = 60 / 120, x = 0, y = 0, right_handle = 2/3 },
            { t = 70 / 120, x = 0, y = 0.223 + 0.179, right_handle = 0 },
            { t = 118 / 120, x = 0, y = 0.423, left_handle = 2/3 },
        }
    }
    
    local HIT = {
        duration = 2,
        frames = {
            { t = 0, sprite = "h00" },
            { t = 12 / 120, sprite = "s01" },
            { t = 15 / 120, sprite = 0 },
            { t = 18 / 120, sprite = 1 },
            { t = 22 / 120, sprite = 2 },
            { t = 27 / 120, sprite = 3 },
            { t = 70 / 120, sprite = 4 },
            { t = 71 / 120, sprite = 5 },
            { t = 72 / 120, sprite = 0 },
            { t = 75 / 120, sprite = 6 },
            { t = 79 / 120, sprite = 9 },
            { t = 83 / 120, sprite = 11 },
            { t = 87 / 120, sprite = 15 },
        },
        scales = {
            { t = 0, x = 0.18, y = 0.34 },
            { t = 8 / 120, x = 0.18, y = 0.285 },
            { t = 11 / 120, x = 0.18, y = 0.18 },
            { t = 12 / 120, x = 0.25, y = 0.11 },
            { t = 17 / 120, x = 0.18, y = 0.18 },
            { t = 70 / 120 },
            { t = 71 / 120, x = 0.13, y = 0.22 },
            { t = 72 / 120, x = 0.25, y = 0.11 },
            { t = 82 / 120, x = 0.18, y = 0.18 },
            { t = 120 / 120 },
        },
        positions = {
            { t = 11 / 120, x = 0, y = 0.223 + -0.157 },
            { t = 12 / 120, x = 0, y = 0, right_handle = 2/3 }, -- handle is unused for now
            { t = 22 / 120, x = 0, y = 0.223 + -0.011, right_handle = 0 },
            { t = 70 / 120, x = 0, y = 0.223 + 0.009, left_handle = 2/3 },
            { t = 72 / 120, x = 0, y = 0, right_handle = 2/3 },
            { t = 82 / 120, x = 0, y = 0.223 + 0.179, right_handle = 0 },
            { t = 120 / 120, x = 0, y = 0.423, left_handle = 2/3 },
        }
    }
    
    local WRAP = {
        duration = 2,
        frames = HIT.frames,
        scales = HIT.scales,
        positions = HIT.positions,
        colors = Enemy.DEFAULT_FADE,
    }
    
    local entity = {
        name = harpy.name,
        friendlyName = { name = harpy.friendlyName },
        health = { health = harpy.hits },
        totalHitCount = { count = harpy.hits },
        autoMove = { dy = -2 },
        subDelay = { interval = RiftStep.SUBDIV * 2 },
        trappable = false,
        knockbackOnHit = { dy = 2 },
        solid = false,
        
        editorLine = { color = harpy.color },
        editorIdleFrame = { time = 1.5 },
        soundAttack = { sound = RiftSound.ID.HARPY_ATTACK },
        soundDeath = { sound = RiftSound.ID.HARPY_DEATH },
        soundHit = { sound = RiftSound.ID.HARPY_HURT },
        
        rex_customAssets = {
            name = harpy.spriteName,
            default = { ppu = 92.5, pivot = { x = 0.5, y = 0.17 } },
            sprites = {
                [6] = { pivot = { x = 0.5, y = 0.5 } },
                [9] = { pivot = { x = 0.5, y = 0.5 } },
                [11] = { pivot = { x = 0.5, y = 0.5 } },
                [15] = { pivot = { x = 0.5, y = 0.5 } },
                h00 = { pivot = { x = 0.5, y = 0.6485 } },
            },
            movement = MOVE,
            hit = HIT,
            death = Enemy.DEFAULT_DEATH,
            wrap = WRAP,
            portal = WRAP,
        },
    }
    Enemy.new(entity)
end

Harpy {
    name = "EnemyHarpyStrong",
    friendlyName = "Yellow Harpy",
    spriteName = "harpy_yellow",
    hits = 3,
    color = Color.hex(0xFFAE4D),
}

Harpy {
    name = "EnemyHarpySuperStrong",
    friendlyName = "Pink Harpy",
    spriteName = "harpy_pink",
    hits = 4,
    color = Color.hex(0xFF4DAE)
}
