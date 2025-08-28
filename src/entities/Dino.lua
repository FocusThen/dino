Dino = Class({})

local GRAVITY = 20
local SCALE = 3
local DINO_GROUND = GROUND - 60
local DINO_HEIGHT = 30
local DINO_WIDTH = 30
local DINO_CROUCH_HEIGHT = DINO_HEIGHT + 30

function Dino:init()
	self.image = gTextures["player"]
	self.quads = GenerateQuads(self.image, 24, 21)
	self.width = DINO_WIDTH
	self.height = DINO_HEIGHT
	self.isGround = false

	self.animations = {
		run = Animation({
			frames = { 5, 6, 7, 8, 9 },
			interval = 0.1,
		}),
		jump = Animation({
			frames = { 13 },
			interval = 0.2,
		}),
		crouchRun = Animation({
			frames = { 19, 20, 21, 22, 23 },
			interval = 0.1,
		}),
	}
	self.currentAnim = self.animations.run

	self.x = 10
	self.y = DINO_GROUND

	self.dy = 0
end

function Dino:update(dt)
	self.currentAnim:update(dt)

	self.dy = self.dy + GRAVITY * dt

	if love.keyboard.wasPressed("space") and self.isGround then
		gSounds["jump"]:play()
		self.currentAnim = self.animations.jump
		self.dy = -8
	end

	self.y = self.y + self.dy
	self.isGround = false

	if self.y >= DINO_GROUND then
		if love.keyboard.isDown("down") then
			self.height = DINO_CROUCH_HEIGHT
			self.currentAnim = self.animations.crouchRun
		else
			self.height = DINO_HEIGHT
			self.currentAnim = self.animations.run
		end
		self.y = DINO_GROUND
		self.isGround = true
	end
end

function Dino:render()
	love.graphics.draw(self.image, self.quads[self.currentAnim:getCurrentFrame()], self.x, self.y, nil, SCALE)
	if DEBUG then
		love.graphics.rectangle("line", self.x + (self.width / 2), self.y + (self.height / 2), self.width, self.height)
	end
end

function Dino:collides(entity)
	local dinoX = self.x + (self.width / 2)
	local dinoY = self.y + (self.height / 2)
	if dinoX + self.width >= entity.x and dinoX <= entity.x + entity.width then
		if dinoY + self.height >= entity.y and dinoY <= entity.y + entity.height then
			return true
		end
	end

	return false
end
