Dino = Class({})

local GRAVITY = 20
local SCALE = 3
local DINO_GROUND = GROUND - 60

function Dino:init()
	self.image = gTextures["player"]
	self.quads = GenerateQuads(self.image, 24, 21)
	self.width = 35
	self.height = 40
  self.crouchHeight = 15
	self.isGround = false
  self.isCrouching = false

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

	self.body = {
		width = self.width,
		height = self.height,
		x = self.x + 20,
		y = self.y + 15,
	}
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
			self.currentAnim = self.animations.crouchRun
      self.isCrouching = true
		else
			self.currentAnim = self.animations.run
      self.isCrouching = false
		end
		self.y = DINO_GROUND
		self.isGround = true
	end

  if self.isCrouching then
    self.body.y = self.y + 20
  else
    self.body.y = self.y + 15
  end

end

function Dino:render()
	love.graphics.draw(self.image, self.quads[self.currentAnim:getCurrentFrame()], self.x, self.y, nil, SCALE)
	if DEBUG then
		love.graphics.rectangle("line", self.body.x, self.body.y, self.body.width, self.body.height)
	end
end

function Dino:collides(entity)
	if self.body.x + self.body.width >= entity.body.x and self.body.x <= entity.body.x + entity.body.width then
		if self.body.y + self.body.height >= entity.body.y and self.body.y <= entity.body.y + entity.body.height then
			return true
		end
	end

	return false
end
