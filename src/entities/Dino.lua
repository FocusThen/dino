Dino = Class({})

local GRAVITY = 20
local GROUND = VIRTUAL_HEIGHT - 80
local SCALE = 3

function Dino:init()
	self.image = gTextures["player"]
	self.quads = GenerateQuads(self.image, 24, 21)
	self.width = 22 * SCALE
	self.height = 19 * SCALE
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
	self.y = GROUND

	self.dy = 0
end

function Dino:update(dt)
	self.currentAnim:update(dt)

	self.dy = self.dy + GRAVITY * dt

	if love.keyboard.wasPressed("space") and self.isGround then
		self.currentAnim = self.animations.jump
		self.dy = -8
	end

	self.y = self.y + self.dy
	self.isGround = false

	if self.y >= GROUND then
		if love.keyboard.isDown("down") then
			self.currentAnim = self.animations.crouchRun
		else
			self.currentAnim = self.animations.run
		end
		self.y = GROUND
		self.isGround = true
	end
end

function Dino:render()
	love.graphics.draw(self.image, self.quads[self.currentAnim:getCurrentFrame()], self.x, self.y, nil, SCALE)
	-- debug collider
	-- love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

function Dino:collides(entity)
	if self.x + self.width >= entity.x and self.x <= entity.x + entity.width then
		if self.y + self.height >= entity.y and self.y <= entity.y + entity.height then
			return true
		end
	end

	return false
end
