BgPlx = Class({})

function BgPlx:init(state)
	self.state = "stop"

	if state then
		self.state = state
	end
	_G.gLayerBg = {
		{ img = gTextures["bg_plx-1"], speed = 0, scroll = 0 },
		{ img = gTextures["bg_plx-2"], speed = 30, scroll = 0 },
		{ img = gTextures["bg_plx-3"], speed = 40, scroll = 0 },
		{ img = gTextures["bg_plx-4"], speed = 60, scroll = 0 },
		{ img = gTextures["bg_plx-5"], speed = 120, scroll = 0 },
		{ name = "ground", img = gTextures["ground"], speed = 140, scroll = 0 },
	}
end

function BgPlx:update(dt)
	if self.state == "play" then
		for _, layer in ipairs(gLayerBg) do
      if layer.name == "ground" then
        layer.scroll = (layer.scroll + layer.speed * dt) % GROUND_LOOPING_POINT
      else
        layer.scroll = (layer.scroll + layer.speed * dt) % BACKGROUND_LOOPING_POINT
      end
		end
	end
end

function BgPlx:draw()
	for _, layer in ipairs(gLayerBg) do
		for i = 0, 3 do
			love.graphics.draw(
				layer.img,
				-layer.scroll + (i * layer.img:getWidth()),
				layer.name == "ground" and GROUND or 0
			)
		end
	end
end
