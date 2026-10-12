local Color = require "system.utils.Color"
local RiftSound = require "rift.schema.RiftSound"
local Enemy = require "rex.src.enemy"


local function Spider(spider)
    local entity = {
        name = spider.name,
        friendlyName = { name = spider.friendlyName },
        health = { health = spider.hits },
        totalHitCount = { count = spider.hits },
        facingMirrorOnBeat = {},
        sidestep = {},
        editorFlippable = {},
        editorLine = { color = spider.color },
        soundAttack = { sound = RiftSound.ID.SLIME_ATTACK },
        soundDeath = { sound = RiftSound.ID.SLIME_DEATH },
        soundHit = { sound = RiftSound.ID.SLIME_HURT },
        
        rex_customAssets = {
            name = spider.spriteName,
            default = { ppu = 110, pivot = { x = 0.4, y = 0.05 } },
            movement = {
                frames = {
                    { t = 0, sprite = 29 },
                    { t = 29 / 60, sprite = 15 },
                    { t = 30 / 60, sprite = 0 },
                    { t = 59 / 60, sprite = 15 },
                },
                scales = Enemy.DEFAULT_SCALE,
                positions = {
                    { t = 28 / 60, x = 0, y = 0 },
                    { t = 30 / 60, x = 0, y = 0.15 },
                    { t = 55 / 60 },
                }
            },
            death = Enemy.DEFAULT_DEATH
        },
    }
    Enemy.new(entity)
end

Spider {
    name = "EnemySpider",
    friendlyName = "Green Spider",
    spriteName = "spider_green",
    hits = 1,
    color = Color.hex(0x4DFFAE),
}

Spider {
    name = "EnemySpiderMedium",
    friendlyName = "Blue Spider",
    spriteName = "spider_blue",
    hits = 2,
    color = Color.hex(0x4DAEFF),
}

Spider {
    name = "EnemySpiderStrong",
    friendlyName = "Yellow Spider",
    spriteName = "spider_yellow",
    hits = 3,
    color = Color.hex(0xFFAE4D),
}

Spider {
    name = "EnemySpiderSuper",
    friendlyName = "Pink Spider",
    spriteName = "spider_pink",
    hits = 4,
    color = Color.hex(0xFF4DAE),
}
