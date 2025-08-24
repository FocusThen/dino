PlayState = Class({ __includes = BaseState })

function PlayState:init()
  bg.state = "play"
	self.player = Dino()
	self.timer = 0
	self.score = 0
end

function PlayState:update(dt)
	self.timer = self.timer + dt

	if self.timer > 2 then
		-- local y =
		-- 	math.max(-PIPE_HEIGHT + 10, math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
		-- self.lastY = y
		--
		-- table.insert(self.pipePairs, PipePair(y))
		self.timer = 0
	end

  self.player:update(dt)

end


function PlayState:render()
	love.graphics.setFont(gFonts["medium"])
	love.graphics.print("Score: " .. tostring(self.score), 8, 8)

	self.player:render()
end

