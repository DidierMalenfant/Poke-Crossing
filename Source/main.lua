--
--  Poke Crossing - A game sandbox for RosieViolet100.
--

import 'CoreLibs/graphics'
import "CoreLibs/timer"
import "CoreLibs/object"

-- luacheck: globals Player
import 'player'

local gfx <const> = playdate.graphics

class('Main', { backgroundImage = nil, violet = nil }).extends()

function Main:init()
    Main.super.init(self)

    gfx.setFont(gfx.getSystemFont())

    local myTestTable = {}
    table.insert(myTestTable, 0)

    self.backgroundImage = gfx.image.new('Artwork/Backgrounds/NightSky')
    assert(self.backgroundImage)

    self.violet = Player(40, 219, 'Artwork/Sprites/Violet')
    assert(self.violet)

    gfx.sprite.setBackgroundDrawingCallback(
        function(_x, _y, _width, _height)
            -- _x, _y, _width, _height is the updated area in sprite-local coordinates
            -- The clip rect is already set to this area, so we don't need to set it ourselves
            self.backgroundImage:draw(0, 0)

            self.violet:drawDebug()
        end
    )

    gfx.sprite.addEmptyCollisionSprite(0, 0, 1, 240)
    gfx.sprite.addEmptyCollisionSprite(399, 0, 1, 240)
    gfx.sprite.addEmptyCollisionSprite(0, 241, 400, 1)
end

function Main:update()
    -- Our game goes here
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        self.violet:goRight()
    end

    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        self.violet:goLeft()
    end

    if playdate.buttonIsPressed(playdate.kButtonA) then
        self.violet:jump()
    end

    local crankPosition = playdate.getCrankPosition()
    self.violet:turn(2 * crankPosition)

    -- Update other things
    self.violet:update()
    gfx.sprite.update()
    playdate.timer.updateTimers()
    -- playdate.drawFPS(385,0)
end

local main = Main()

function playdate.update()
    main:update()
end
