BgPlx = Class({})

function BgPlx:init(state)
	self.state = "stop"
	if state then
		self.state = state
	end
	_G.gLayerBg = {
		{ img = gTextures["bg_plx-1"], speed = 0, scroll = 0 },
		{ img = gTextures["bg_plx-2"], speed = 10, scroll = 0 },
		{ img = gTextures["bg_plx-3"], speed = 20, scroll = 0 },
		{ img = gTextures["bg_plx-4"], speed = 30, scroll = 0 },
		{ img = gTextures["bg_plx-5"], speed = 40, scroll = 0 },
	}
end

function BgPlx:update(dt)
	if self.state == "play" then
		for _, layer in ipairs(gLayerBg) do
			layer.scroll = (layer.scroll + layer.speed * dt) % BACKGROUND_LOOPING_POINT
		end
	end
end

function BgPlx:draw()
	for _, layer in ipairs(gLayerBg) do
		for i = 0, 3 do
			love.graphics.draw(layer.img, -layer.scroll + (i * layer.img:getWidth()), 0)
		end
	end
end
