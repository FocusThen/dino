PlayState = Class({ __includes = BaseState })

function PlayState:init()
	bg.state = "play"
	self.player = Dino()
	self.score = 0
	self.highScore = save:get("score")

	-- FIX: Bird and rock rendering same time
	self.objects = {
		{
			entity = Bird,
			timer = 0,
			delay = math.random(3, 5),
		},
		{
			entity = Rock,
			timer = 0,
			delay = math.random(1, 2),
		},
	}

	self.obstacles = {}
end

function PlayState:update(dt)
	self.score = self.score + 1

	for _, object in pairs(self.objects) do
		object.timer = object.timer + dt

		if object.timer > object.delay then
			table.insert(self.obstacles, object.entity())
			object.timer = 0
		end
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
