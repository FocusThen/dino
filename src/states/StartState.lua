StartState = Class({ __includes = BaseState })

function StartState:update(_)
	if love.keyboard.wasPressed("space") then

	end

	if love.keyboard.wasPressed("escape") then
		love.event.quit()
	end
end

function StartState:render()
	-- title
	love.graphics.setFont(gFonts["large"])
	love.graphics.printf("Dino", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, "center")

	love.graphics.setFont(gFonts["medium"])
	love.graphics.printf("START For Space", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, "center")
end
