Save = Class({})

function Save:init(data)
	self.data = data
end

function Save:get(key)
	return self.data[key]
end

function Save:set(key, value)
	self.data[key] = value
end

function Save:save()
	local saveGame = Serialize(self.data)
	love.filesystem.write("data.lua", saveGame)
end

function Save:load()
	if love.filesystem.getInfo("data.lua") then
		local data = love.filesystem.load("data.lua")
		self.data = data()
	else
		self:save()
	end
end
