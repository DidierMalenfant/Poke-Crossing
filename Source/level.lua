--
--  Poke Crossing - A game sandbox for RosieViolet100.
--

import 'CoreLibs/sprites'
import 'CoreLibs/object'

import '../toyboxes/DidierMalenfant/pdutility/tiled.lua'

local gfx <const> = playdate.graphics
local min <const>, max <const> =  math.min, math.max

local display_width <const>, display_height <const> = playdate.display.getSize()

class('Level').extends(playdate.graphics.sprite)

function Level:init(pathToLevelJSON)
	Level.super.init(self)

	self:setZIndex(0)
	self:setCenter(0, 0)	-- set center point to center bottom

	self.layers, self.tile_width, self.tile_height = pdutility.graphics.tiled.importTilemapsFromTiledJSON(pathToLevelJSON)
	assert(self.layers, 'Error importing Tiled level file.')

	self.level_width = 0
	self.level_height = 0

	for _, layer in ipairs(self.layers) do
		self.level_width = max(self.level_width, layer.pixelWidth)
		self.level_height = max(self.level_height, layer.pixelHeight)
	end

	self:setBounds(0, 0, self.level_width, self.level_height)

	self.min_x = 0
	self.max_x = self.level_width - display_width - self.tile_width

	self.camera_x = 0
	self.camera_Y = 0

	self:setupWallSprites()

	self:addSprite()
end

function Level:size()
	return self.level_width, self.level_height
end

function Level:setupWallSprites()
	for _, layer in ipairs(self.layers) do
		local tilemap = layer.tilemap
		local empty_ids = layer.empty_ids
		local width, height = tilemap:getSize()

		local x = 0
		local y = 0
		for row = 1, height do
			local column = 1
			while column <= width do
				local gid = tilemap:getTileAtPosition(column, row)
				if gid and empty_ids[gid] == nil then
					local cellWidth = self.tile_width

					local w = gfx.sprite.new()
					w:setUpdatesEnabled(false) -- remove from update cycle
					w:setVisible(false) -- invisible sprites can still collide
					w:setCenter(0,0)
					w:setBounds(x, y, cellWidth, self.tile_width)
					w:setCollideRect(0, 0, cellWidth, self.tile_height)
					w:setImageDrawMode(playdate.graphics.kDrawModeCopy)
					w:addSprite()
					w.gid = gid
					w.column = column
					w.row = row
					w.isWall = true
				end

				x += self.tile_width
				column += 1
			end

			x = 0
			y += self.tile_height
		end
	end

	-- We add left, right and bottom borders to the entire level
	gfx.sprite.addEmptyCollisionSprite(0, 0, 1, self.level_height)
	gfx.sprite.addEmptyCollisionSprite(self.level_width - 1, 0, self.level_width, self.level_height)
	gfx.sprite.addEmptyCollisionSprite(0, self.level_height + 1, self.level_width, self.level_height + 1)
end


function Level:updateCameraPosition(x, y)  -- luacheck: ignore self
	self.camera_x = x
	self.camera_y = y
end

function Level:update()
	-- TODO: dynamically load and unload sprites as the player moves around the level
	self.camera_x = max(self.camera_x, 0)
	self.camera_x = min(self.camera_x, self.level_width - display_width)

	self.camera_y = max(self.camera_y, 0)
	self.camera_y = min(self.camera_y, self.level_height - display_height)

	gfx.setDrawOffset(-self.camera_x, -self.camera_y)
end

function Level:draw(_x, _y, _width, _height)
	for _, layer in ipairs(self.layers) do
		layer.tilemap:draw(0, 0)
	end
end
