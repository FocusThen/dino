Rock = Class({})

function Rock:init()
	self.image = gTextures["rock"]
	self.width = 40
	self.height = 25
	self.speed = 150
  self.remove = false

	self.x = VIRTUAL_WIDTH + 32
	self.y = GROUND - 20

  self.body = {
    width = self.width,
    height = self.height,
    x = self.x,
    y = self.y + 8,
  }
end

function Rock:update(dt)
	if self.x > -self.width then
	   self.x = self.x - self.speed * dt
    self.body.x = self.x
	 else
	   self.remove = true
	end
end

function Rock:render()
	love.graphics.draw(self.image, self.x, self.y)

	if DEBUG then
		love.graphics.rectangle("line", self.body.x, self.body.y, self.body.width, self.body.height)
	end
end
