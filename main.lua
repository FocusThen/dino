require("src/Dependencies")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())
	love.window.setTitle("Dino")

	_G.gFonts = {
		["small"] = love.graphics.newFont("assets/fonts/font.ttf", 8),
		["medium"] = love.graphics.newFont("assets/fonts/font.ttf", 16),
		["large"] = love.graphics.newFont("assets/fonts/font.ttf", 32),
	}
	love.graphics.setFont(gFonts["small"])

	_G.gTextures = {
		["bg_plx-1"] = love.graphics.newImage("assets/graphics/plx-1.png"),
		["bg_plx-2"] = love.graphics.newImage("assets/graphics/plx-2.png"),
		["bg_plx-3"] = love.graphics.newImage("assets/graphics/plx-3.png"),
		["bg_plx-4"] = love.graphics.newImage("assets/graphics/plx-4.png"),
		["bg_plx-5"] = love.graphics.newImage("assets/graphics/plx-5.png"),
	}

	_G.gLayerBg = {
		{ img = gTextures["bg_plx-1"], speed = 0, scroll = 0 },
		{ img = gTextures["bg_plx-2"], speed = 10, scroll = 0 },
		{ img = gTextures["bg_plx-3"], speed = 20, scroll = 0 },
		{ img = gTextures["bg_plx-4"], speed = 30, scroll = 0 },
		{ img = gTextures["bg_plx-5"], speed = 40, scroll = 0 },
	}

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		pixelperfect = false,
		highdpi = true,
		stretched = false,
	})

	_G.gStateMachine = StateMachine({
		["start"] = function()
			return StartState()
		end,
	})

	gStateMachine:change("start")

	love.keyboard.keysPressed = {}
end

function love.update(dt)
	for _, layer in ipairs(gLayerBg) do
		layer.scroll = (layer.scroll + layer.speed * dt) % BACKGROUND_LOOPING_POINT
	end

	gStateMachine:update(dt)
	love.keyboard.keysPressed = {}
end

function love.draw()
	push:apply("start")

	for _, layer in ipairs(gLayerBg) do
		for i = 0, 3 do
			love.graphics.draw(layer.img, -layer.scroll + (i * layer.img:getWidth()), 0)
		end
	end

	gStateMachine:render()

	displayFPS()

	push:apply("end")
end

function _G.displayFPS()
	-- simple FPS display across all states
	love.graphics.setFont(gFonts["small"])
	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5)
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end
