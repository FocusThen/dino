require("src/Dependencies")

DEBUG = false

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
		-- parallax
		["bg_plx-1"] = love.graphics.newImage("assets/graphics/plx-1.png"),
		["bg_plx-2"] = love.graphics.newImage("assets/graphics/plx-2.png"),
		["bg_plx-3"] = love.graphics.newImage("assets/graphics/plx-3.png"),
		["bg_plx-4"] = love.graphics.newImage("assets/graphics/plx-4.png"),
		["bg_plx-5"] = love.graphics.newImage("assets/graphics/plx-5.png"),
		-- ground
		["ground"] = love.graphics.newImage("assets/graphics/ground.png"),
		-- player
		["player"] = love.graphics.newImage("assets/graphics/Dino.png"),
		-- obstacles
		["bird"] = love.graphics.newImage("assets/graphics/Bird.png"),
		["barrel"] = love.graphics.newImage("assets/graphics/barrel.png"),
		["rock"] = love.graphics.newImage("assets/graphics/rock.png"),
		["stump"] = love.graphics.newImage("assets/graphics/stump.png"),
	}

	_G.gSounds = {
		["explosion"] = love.audio.newSource("assets/sounds/explosion.wav", "static"),
		["hurt"] = love.audio.newSource("assets/sounds/hurt.wav", "static"),
		["jump"] = love.audio.newSource("assets/sounds/jump.wav", "static"),
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
		["score"] = function()
			return ScoreState()
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
	if key == "q" then
		DEBUG = not (DEBUG and true)
	end

	if key == "escape" then
		love.event.quit()
	end

	love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end
