--
--  Poke Crossing - A game sandbox for RosieViolet100.
--

import "CoreLibs/graphics"
import "CoreLibs/timer"
import "CoreLibs/object"

import "player"
import "level"

local gfx <const> = playdate.graphics

local display_width <const>, display_height <const> = playdate.display.getSize()

class('Main', { background_image = nil, violet = nil }).extends()

function Main:init()
    Main.super.init(self)

    gfx.setFont(gfx.getSystemFont())

    self.background_image = gfx.image.new('Artwork/Backgrounds/NightSky')
    assert(self.background_image, 'Error loading background image.')

    -- We want player's update() to be called before the background's, so add it first
    self.violet = Player(40, 0, 'Artwork/Sprites/Violet')
    assert(self.violet, 'Error loading character.')

    self.level = Level('Levels/LevelOne.tmj')
    assert(self.level, 'Error loading level.')

    gfx.sprite.setBackgroundDrawingCallback(
        function(_x, _y, _width, _height)
            -- _x, _y, _width, _height is the updated area in sprite-local coordinates
            -- The clip rect is already set to this area, so we don't need to set it ourselves
            self.background_image:draw(0, 0)

            self.violet:drawDebug()
        end
    )
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

    self.level:updateCameraPosition(self.violet.x - (display_width / 2),
                                    self.violet.y - (display_height / 2) + 20)

    gfx.sprite.update()
    playdate.timer.updateTimers()
    playdate.drawFPS(385,0)
end

local main = Main()

function playdate.update()
    main:update()
end
