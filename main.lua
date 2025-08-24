require("src/Dependencies")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())
	love.window.setTitle("Dino")

	_G.gFonts = {
		["small"] = love.graphics.newFont("assets/fonts/alagard.ttf", 8),
		["medium"] = love.graphics.newFont("assets/fonts/alagard.ttf", 16),
		["large"] = love.graphics.newFont("assets/fonts/alagard.ttf", 32),
	}
	love.graphics.setFont(gFonts["small"])

	_G.gTextures = {
		["bg_plx-1"] = love.graphics.newImage("assets/graphics/plx-1.png"),
		["bg_plx-2"] = love.graphics.newImage("assets/graphics/plx-2.png"),
		["bg_plx-3"] = love.graphics.newImage("assets/graphics/plx-3.png"),
		["bg_plx-4"] = love.graphics.newImage("assets/graphics/plx-4.png"),
		["bg_plx-5"] = love.graphics.newImage("assets/graphics/plx-5.png"),
		--
		-- player
		["player"] = love.graphics.newImage("assets/graphics/Dino.png"),
		-- Objects
	}

  _G.bg = BgPlx()

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
		["play"] = function()
			return PlayState()
		end,
	})

	gStateMachine:change("start")

	love.keyboard.keysPressed = {}
end

function love.update(dt)
  bg:update(dt)
	gStateMachine:update(dt)
	love.keyboard.keysPressed = {}
end

function love.draw()
	push:apply("start")
  bg:draw()
	gStateMachine:render()
	push:apply("end")
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
