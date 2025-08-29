Bird = Class({})

function Bird:init()
	self.image = gTextures["bird"]
	self.quads = GenerateQuads(self.image, 32, 32)
	self.width = 32
	self.height = 16
	self.speed = 150
	self.remove = false

	self.animations = {
		fly = Animation({
			frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9 },
			interval = 0.1,
		}),
	}

	self.currentAnim = self.animations.fly


	self.x = VIRTUAL_WIDTH + 32
	self.y = math.random(VIRTUAL_HEIGHT - 50 , 50)

	self.body = {
		width = self.width,
		height = self.height,
		x = self.x,
		y = self.y + 8,
	}
end

function Bird:update(dt)
	self.currentAnim:update(dt)

	if self.x > -self.width then
		self.x = self.x - self.speed * dt
		self.body.x = self.x
	else
		self.remove = true
	end
end

function Bird:render()
	love.graphics.draw(self.image, self.quads[self.currentAnim:getCurrentFrame()], self.x, self.y)

	if DEBUG then
		love.graphics.rectangle("line", self.body.x, self.body.y, self.body.width, self.body.height)
	end
end
