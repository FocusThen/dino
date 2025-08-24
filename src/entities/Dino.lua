Dino = Class({})

local GRAVITY = 20
local GROUND = VIRTUAL_HEIGHT - 50

function Dino:init()
	self.image = gTextures["player"]
	self.quads = GenerateQuads(self.image, 24, 21)
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.isGround = false

	self.animations = {
		run = Animation({
			frames = { 5, 6, 7, 8, 9 },
			interval = 0.2,
		}),
		jump = Animation({
			frames = { 13 },
			interval = 0.2,
		}),
	}
	self.currentAnim = self.animations.run

	self.x = 10
	self.y = GROUND

	self.dy = 0
end

function Dino:update(dt)
	self.currentAnim:update(dt)

	self.dy = self.dy + GRAVITY * dt

	if love.keyboard.wasPressed("space") and self.isGround then
		self.currentAnim = self.animations.jump
		self.dy = -5
	end

	self.y = self.y + self.dy
  self.isGround = false

	if self.y >= GROUND then
		self.currentAnim = self.animations.run
		self.y = GROUND
		self.isGround = true
	end
end

function Dino:render()
	love.graphics.draw(self.image, self.quads[self.currentAnim:getCurrentFrame()], self.x, self.y, nil, 2)
end

function Dino:collides(entity)
	if self.x + self.width >= entity.x and self.x <= entity.x + entity.width then
		if self.y + self.height >= entity.y and self.y <= entity.y + entity.height then
			return true
		end
	end

	return false
end
