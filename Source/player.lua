--
--  Poke Crossing - A game sandbox for RosieViolet100.
--

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx <const> = playdate.graphics
local snd <const> = playdate.sound

local gravity <const> = 1.2
local jump_force <const> = 15.0
local max_fall_speed <const> = 3.0
local move_force_on_ground <const> = 5.0
local move_force_in_air <const> = 1.0
local max_move_force <const> = 5.0
local lateral_friction <const> = 0.4

class('Player').extends(gfx.sprite)

function Player:init(x, y, image_path)
    Player.super.init(self) -- this is critical

    self.image = gfx.image.new(image_path)
    assert(self.image, 'Error creating a new image.')

    self:setImage(self.image)
    self:setCollideRect(10, 0, self.width - 20, self.height)

    self:setZIndex(10)
    --self:setCenter(0, 0)	-- set center point to center bottom

    self.dx = 0.0
    self.dy = 0.0

    self:moveTo(x, y)
    self:add()

    self.jump_sound = snd.sampleplayer.new('Sounds/jump')
    assert(self.jump_sound, 'Error loading jump sound.')
end

function Player:update()
    self.dy += gravity
    if self.dy > 0.0 then
        self.dy = math.max(self.dy, max_fall_speed)
    end

    local wanted_x = self.x + self.dx
    local wanted_y = self.y + self.dy

    local actual_x, actual_y, _, _ = self:moveWithCollisions(wanted_x, wanted_y)

    if actual_x ~= wanted_x then
        self.dx = 0.0
    elseif self.dx > 0.0 then
        self.dx -= math.min(lateral_friction, self.dx)
    elseif self.dx < 0.0 then
        self.dx -= math.max(-lateral_friction, self.dx)
    end

    if actual_y ~= wanted_y then
        self.dy = 0.0
    end
end

function Player:goLeft()
    if self:isJumping() == true then
        self.dx -= move_force_in_air
    else
        self.dx -= move_force_on_ground
    end

    self.dx = math.max(-max_move_force, self.dx)
end

function Player:goRight()
    if self:isJumping() == true then
        self.dx += move_force_in_air
    else
        self.dx += move_force_on_ground
    end

    self.dx = math.min(max_move_force, self.dx)
end

function Player:jump()
    if self:isJumping() ~= true then
        self.jump_sound:play()
        self.dy = -jump_force
    end
end

function Player:turn(angle)
    self:setRotation(angle)
end

function Player:isJumping()
    return self.dy ~= 0.0
end

function Player:collisionResponse(other) -- luacheck: ignore self other
    return gfx.sprite.kCollisionTypeSlide
end

function Player:drawDebug() -- luacheck: ignore self
    --gfx.drawText(string.format('*%2.2f %2.2f*', self.dx, self.dy), 1, 1)
end
