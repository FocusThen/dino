ScoreState = Class({ __includes = BaseState })

function ScoreState:enter(params)
	self.score = params.score
end

function ScoreState:update(_)
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
		gStateMachine:change("play")
	end
end

function ScoreState:render()
	love.graphics.setFont(gFonts["medium"])
	love.graphics.printf("Oof! You lost!", 0, 50, VIRTUAL_WIDTH, "center")

	love.graphics.setFont(gFonts["large"])
	love.graphics.printf("Score: " .. tostring(self.score), 0, 80, VIRTUAL_WIDTH, "center")

	love.graphics.setFont(gFonts["medium"])
	love.graphics.printf("Press Enter to Play Again!", 0, 130, VIRTUAL_WIDTH, "center")
end
