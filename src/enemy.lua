local Enum = require "system.utils.Enum"
local RiftStep = require "rift.game.RiftStep"
local RiftexCategory = require "Riftex.schema.RiftexCategory"
local RiftCommonEnemy = require "rift.schema.RiftCommonEnemy"


local MOD_ASSETS_PREFIX = "mods/rex/assets/"

RiftexCategory.Type.extend("enemies", Enum.data {
    name = L("REX Enemies", "type.rex"),
    order = 192,
})

---@param sprite number|string
---@return string
local function formatNumber(sprite)
    if type(sprite) == "number" then
        return string.format("%02d", sprite)
    else
        return sprite
    end
end

---@param name string
---@param sprite number|string
---@return string
local function spriteName(name, sprite)
    return "rex_" .. name .. "_" .. formatNumber(sprite)
end

---@param name string
---@param sprite number|string
---@param prefix string?
---@return string
local function spriteFile(name, sprite, prefix)
    return (prefix or "") .. name .. "/" .. formatNumber(sprite) .. ".png"
end


local ANIMATIONS = {
    movement = {
        editor = "editorAnimationNormal",
        katie = "customChoreoAnimationMove",
        default = 0
    },
    hit = {
        katie = "customChoreoAnimationHit"
    },
    death = {
        editor = "editorAnimationDeath",
        katie = "customChoreoAnimationDeath",
        default = "x"
    },
    wrap = {
        katie = "customChoreoAnimationWrap",
    },
    portal = {
        katie = "customChoreoAnimationPortal",
    }
}

--- @class entity RiftECS.Entity
local function loadCustomAssets(entity)
    local customAssets = entity.rex_customAssets
    if not customAssets then
        return
    end
    
    local name = customAssets.name
    local default = customAssets.default or {}
    local sprites = customAssets.sprites or {}
    
    entity.sprite = { texture = spriteFile(name, 0, MOD_ASSETS_PREFIX) }
    
    entity.loadCustomSprites = {}
    local loadedSprites = {}
    
    for animationName, animationData in pairs(ANIMATIONS) do
        if not customAssets[animationName] and not animationData.default then
            goto continue
        end
        
        local animation = customAssets[animationName] or { }
        local frames = animation.frames or animationData.default and { { t = 0, sprite = animationData.default } }
        local duration = animation.duration or 1
        
        if animationData.editor then
            local editorTextures = {}
            local editorTimes = {}
            
            for _, frame in ipairs(frames) do
                local sprite = frame.sprite
                editorTextures[#editorTextures + 1] = spriteFile(name, sprite, MOD_ASSETS_PREFIX)
                editorTimes[#editorTimes + 1] = frame.t * duration
            end
            
            entity[animationData.editor] = {
                duration = duration,
                frames = editorTextures,
                times = editorTimes
            }
        end
        
        if animationData.katie then
            entity[animationData.katie] = {
                duration = duration * RiftStep.SUBDIV,
                frames = {},
            }
            
            local katieFrames = entity[animationData.katie].frames
            
            for _, frame in ipairs(frames or {}) do
                local sprite = frame.sprite
                local texture = spriteName(name, sprite)
                
                if not loadedSprites[sprite] then
                    loadedSprites[sprite] = true
                    
                    local spriteData = sprites[sprite] or default
                    entity.loadCustomSprites[#entity.loadCustomSprites + 1] = {
                        name = texture,
                        src = spriteFile(name, sprite),
                        ppu = spriteData.ppu or default.ppu,
                        pivot = spriteData.pivot or default.pivot,
                        mod = "rex"
                    }
                end
                
                katieFrames[#katieFrames + 1] = { t = frame.t, texture = texture }
            end
            
            if animation.scales then
                local first_scale = animation.scales[1] or { t = 0, x = 1, y = 1 }
                local last_scale = first_scale
                local t = 0
                
                local function add_frame(scale1, scale2, time)
                    time = time or t
                    if scale1.x ~= scale2.x or scale1.y ~= scale2.y then
                        local k = (time - scale1.t) / (scale2.t - scale1.t)
                        k = 3 * k * k - 2 * k * k * k
                        
                        katieFrames[#katieFrames + 1] = {
                            t = time,
                            scale = {
                                x = scale1.x + k * (scale2.x - scale1.x),
                                y = scale1.y + k * (scale2.y - scale1.y),
                            }
                        }
                    end
                end
                
                for _, scale in ipairs(animation.scales) do
                    local next_scale = { t = scale.t, x = scale.x or last_scale.x, y = scale.y or last_scale.y }
                    while t <= (scale.t or 0) do
                        if t ~= scale.t then
                            add_frame(last_scale, next_scale)
                        end
                        t = t + 1/300
                    end
                    
                    add_frame(last_scale, next_scale, next_scale.t)
                    last_scale = next_scale
                end
                
                while t < 1 do
                    add_frame(last_scale, { t = 1, x = first_scale.x, y = first_scale.y })
                    t = t + 1/300
                end
            end
            
            
            -- TODO: DRY WITH ABOVE
            if animation.positions then
                local first_pos = animation.positions[1] or { t = 0, x = 0, y = 0 }
                local last_pos = first_pos
                local t = 0
                local function add_frame(pos1, pos2, time)
                    time = time or t
                    if pos1.x ~= pos2.x or pos1.y ~= pos2.y then
                        local k = (time - pos1.t) / (pos2.t - pos1.t)
                        k = 3 * k * k - 2 * k * k * k
                        
                        katieFrames[#katieFrames + 1] = {
                            t = time,
                            position = {
                                x = pos1.x + k * (pos2.x - pos1.x),
                                y = pos1.y + k * (pos2.y - pos1.y),
                            }
                        }
                    end
                end
                
                for _, pos in ipairs(animation.positions) do
                    local next_pos = { t = pos.t, x = pos.x or last_pos.x, y = pos.y or last_pos.y }
                    while t <= (pos.t or 0) do
                        if t ~= pos.t then
                            add_frame(last_pos, next_pos)
                        end
                        t = t + 1/300
                    end
                    
                    add_frame(last_pos, next_pos, next_pos.t)
                    last_pos = next_pos
                end
                
                while t < 1 do
                    add_frame(last_pos, { t = 1, x = first_pos.x, y = first_pos.y })
                    t = t + 1/300
                end
            end
            
            -- TODO: DRY WITH ABOVE
            if animation.colors then
                local first_color = animation.colors[1] or { t = 0, r = 1, g = 1, b = 1 }
                local last_color = first_color
                local t = 0
                
                local function add_frame(color1, color2, time)
                    time = time or t
                    if color1.r ~= color2.r or color1.g ~= color2.g or color1.b ~= color2.b or color1.a ~= color2.a then
                        local k = (time - color1.t) / (color2.t - color1.t)
                        k = 3 * k * k - 2 * k * k * k
                        
                        katieFrames[#katieFrames + 1] = {
                            t = time,
                            colour = { -- TODO repeating all this sucks
                                r = color1.r + k * (color2.r - color1.r),
                                g = color1.g + k * (color2.g - color1.g),
                                b = color1.b + k * (color2.b - color1.b),
                                a = color1.a + k * (color2.a - color1.a),
                            }
                        }
                    end
                end
                
                for _, color in ipairs(animation.colors) do
                    local next_color = { t = color.t, r = color.r or last_color.r, g = color.g or last_color.g, b = color.b or last_color.b, a = color.a or last_color.a }
                    while t <= (color.t or 0) do
                        if t ~= color.t then
                            add_frame(last_color, next_color)
                        end
                        t = t + 1/300
                    end
                    
                    add_frame(last_color, next_color, next_color.t)
                    last_color = next_color
                end
                
                while t < 1 do
                    add_frame(last_color, { t = 1, r = first_color.r, g = first_color.g, b = first_color.b, a = first_color.a })
                    t = t + 1/300
                end
            end
            
            
            
            entity[animationData.katie] = {
                duration = duration * RiftStep.SUBDIV,
                frames = katieFrames,
            }
        end
        ::continue::
    end
    
    entity.rex_customAssets = nil
end

-- BEGIN MODULE EXPORTS

local M = {}
local order = 0

--- @class entity RiftECS.Entity
function M.new(entity)
    order = order + 1
    loadCustomAssets(entity)
    entity.id = 1000
    entity.editorCategory = { id = "rex_enemies" }
    entity.editorOrder = { order = order }
    entity.name = "rex_" .. entity.name
    return RiftCommonEnemy.register(entity)
end

M.DEFAULT_SCALE = {
    { t = 0, x = 0.25, y = 0.17 },
    { t = 0.25, x = 0.23, y = 0.19 },
    { t = 0.46666667 },
    { t = 0.5, x = 0.17, y = 0.25 },
    { t = 0.75, x = 0.19, y = 0.23 },
    { t = 0.96666667 },
}

M.DEFAULT_DEATH = {
    colors = {
        { t = 0, r = 1, g = 1, b = 1, a = 1},
        { t = 0.5, r = 1, g = 1, b = 1, a = 0},
        { t = 1 }
    },
    scales = {
        { t = 0, x = 0.21, y = 0.21 },
        { t = 0.15, x = 0.315, y = 0.315 },
    }
}

M.DEFAULT_FADE = {
    { t = 0, r = 1, g = 1, b = 1, a = 1},
    { t = 0.25, r = 1, g = 1, b = 1, a = 0},
    { t = 0.5, r = 1, g = 1, b = 1, a = 1 }
}

return M