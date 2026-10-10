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
            default = { ppu = 100, pivot = { x = 0.4, y = 0.05 } },
            movement = {
                frames = {
                    { t = 0, sprite = 29 },
                    { t = 1 / 60, sprite = 28 },
                    { t = 2 / 60, sprite = 27 },
                    { t = 3 / 60, sprite = 26 },
                    { t = 4 / 60, sprite = 25 },
                    { t = 5 / 60, sprite = 24 },
                    { t = 29 / 60, sprite = 15 },
                    { t = 30 / 60, sprite = 0 },
                    { t = 31 / 60, sprite = 1 },
                    { t = 32 / 60, sprite = 2 },
                    { t = 33 / 60, sprite = 3 },
                    { t = 34 / 60, sprite = 4 },
                    { t = 35 / 60, sprite = 5 },
                    { t = 59 / 60, sprite = 15 },
                },
                scales = {
                    { t = 0, x = 0.19, y = 0.15 },
                    { t = 15 / 60, x = 0.18, y = 0.16 },
                    { t = 29 / 60 },
                    { t = 30 / 60, x = 0.15, y = 0.19 },
                    { t = 45 / 60, x = 0.16, y = 0.18 },
                    { t = 59 / 60 },
                },
                positions = {
                    { t = 15 / 60, x = 0, y = 0 },
                    { t = 50 / 60 },
                    { t = 55 / 60, x = 0, y = 0.15 },
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
