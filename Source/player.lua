--
--  Poke Crossing - A game sandbox for RosieViolet100.
--

import "CoreLibs/object"
import 'CoreLibs/graphics'
import "CoreLibs/sprites"

local gfx <const> = playdate.graphics
local snd <const> = playdate.sound

-- luacheck: globals Player
class('Player').extends(gfx.sprite)

function Player:init(x, y, imagePath)
    Player.super.init(self) -- this is critical

    self.test = 23
    assert(self.test)

    self.image = gfx.image.new(imagePath)
    assert(self.image)

    self:setImage(self.image)
    self:setCollideRect(0, 0, self.width, self.height)

    self.dx = 0.0
    self.dy = 0.0
    self.last_dy = 0.0

    self.jump_time = 0.0

    self:moveTo(x, y)
    self:add()

    self.jump_sound = snd.sampleplayer.new('Sounds/jump')
    assert(self.jump_sound)
end

function Player:update()
    if self.jump_time ~= 0.0 then
        self.dy = playdate.easingFunctions.inOutSine(self.jump_time, 0.0, -60.0, 4.0)
        self.jump_time += 0.3

        if self.jump_time > 8.0 then
            self.dy = 0.0
            self.jump_time = 0.0
        end
    end

    self:moveWithCollisions(self.x + self.dx, self.y + self.dy - self.last_dy)
    self.last_dy =  self.dy

    if self.dx > 0.0 then
        self.dx -= math.min(0.08, self.dx)
    elseif self.dx < 0.0 then
        self.dx -= math.max(-0.08, self.dx)
    end
end

function Player:goLeft()
    if self.dx > -2.0 then
        self.dx -= 0.5
    end
end

function Player:goRight()
    if self.dx < 2.0 then
        self.dx += 0.5
    end
end

function Player:jump()
    if self.jump_time == 0 then
        self.jump_sound:play()
        self.jump_time += 0.1
    end
end

function Player:turn(angle)
    self:setRotation(angle)
end

function Player:isJumping()
    return self.jump_time ~= 0.0
end

function Player:collisionResponse(other) -- luacheck: ignore self other
    local tag = other:getTag()

    if tag == 0 then
        self.dx = 0.0
    end

    return gfx.sprite.kCollisionTypeSlide
end

function Player:drawDebug() -- luacheck: ignore self other
    --gfx.drawText(string.format("*%2.2f %2.2f*", self.dx, self.dy), 1, 1)
end
