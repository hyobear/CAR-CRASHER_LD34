-- file structure/main.lua based off headchant's boilerplate (thanks man!)
local function Proxy(f)
	return setmetatable({}, {__index = function(self, k)
		local v = f(k)
		rawset(self, k, v)
		return v
	end})
end

-- standard proxies
i   = Proxy(function(k) return love.graphics.newImage('img/' .. k .. '.png') end)
s   = Proxy(function(k) return love.audio.newSource('sfx/' .. k .. '.wav', 'static') end)
m   = Proxy(function(k) return love.audio.newSource('msc/' .. k .. '.wav', 'stream') end)
-- usage: love.graphics.draw(i.background) or s.explosion:play()

function love.load(arg)
	love.graphics.setDefaultFilter('nearest', 'nearest')
	st = {splash = true, start = false, options = false, songSelect = false, game = false, gEnd = false}
	scale = 1
end

function love.update(dt)

end

function love.draw()

end

function love.keypressed(k)
	if k == '1' then
		scale = 1
		love.window.setMode(150, 130, {vsync = true})
	elseif k == '2' then
		scale = 2
		love.window.setMode(150 * scale, 130 * scale, {vsync = true})
	elseif k == '3' then
		scale = 3
		love.window.setMode(150 * scale, 130 * scale, {vsync = true})
	elseif k == '4' then
		scale = 4
		love.window.setMode(150 * scale, 130 * scale, {vsync = true})
	elseif k == '5' then
		scale = 5
		love.window.setMode(150 * scale, 130 * scale, {vsync = true})
	end
end