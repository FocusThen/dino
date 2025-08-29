PlayState = Class({ __includes = BaseState })

function PlayState:init()
	bg.state = "play"
	self.player = Dino()
  self.timer = 0
	self.score = 0
	self.highScore = save:get("score")

	self.objects = {
		{
      id = 1,
			name = "bird",
			entity = Bird,
		},
		{
      id = 2,
			name = "rock",
			entity = Rock,
		},
	}

	self.obstacles = {}
end

function PlayState:update(dt)
  self.timer = self.timer + dt
	self.score = self.score + 1


  if self.timer > 2 then
    table.insert(self.obstacles, self.objects[math.random(1, 2)].entity())
    self.timer = 0
  end


	-- update obstacles
	for _, obstacle in pairs(self.obstacles) do
		obstacle:update(dt)
	end

	-- remove obstacles
	for k, obstacle in pairs(self.obstacles) do
		if obstacle.remove then
			table.remove(self.obstacles, k)
		end
	end

	self.player:update(dt)

	-- collision
	for _, obstacle in pairs(self.obstacles) do
		if self.player:collides(obstacle) then
			gSounds["explosion"]:play()
			gSounds["hurt"]:play()
			bg.state = "stop"

			gStateMachine:change("score", {
				score = self.score,
			})
		end
	end
end

function PlayState:render()
	for _, obstacle in pairs(self.obstacles) do
		obstacle:render()
	end

	love.graphics.setFont(gFonts["medium"])
	love.graphics.print("Score: " .. tostring(self.score), 8, 8)
	love.graphics.print(
		"High Score: " .. tostring(self.highScore),
		VIRTUAL_WIDTH - (100 + #tostring(self.highScore) * 6),
		8
	)

	self.player:render()
end
