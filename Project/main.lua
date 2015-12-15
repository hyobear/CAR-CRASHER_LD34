-- file structure/proxy function based off of headchant's boilerplate (thanks man!)
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

splash = require('src.splash')
start = require('src.start')
game = require('src.game')
gameOver = require('src.gameOver')

function love.load()
	scale = 1 -- init's scale
	love.graphics.setDefaultFilter('nearest', 'nearest')
	font = love.graphics.newFont('fnt.ttf', 10 * scale)
	st = {splash = true, start = false, game = false, gameOver = false}
	splash.load()
	start.load()
	game.load()
	gameOver.load()
end

function love.draw()
	love.graphics.setFont(font)
	if st.splash == true then
		splash.draw(i.splash, scale)
	elseif st.start == true then
		start.draw(scale)
	elseif st.game == true then
		game.draw(scale, car)
	elseif st.gameOver == true then
		gameOver.draw(scale)
	end
end

function love.update(dt)
	if st.splash == true then
		splash.update(dt)
	elseif st.start == true then
		start.update(dt)
	elseif st.game == true then
		game.update(dt)
	elseif st.gameOver == true then
		gameOver.update(dt)
	end
end

function love.keypressed(k)
	if k == 'escape' then
	   	love.event.quit()
	end

	if st.splash == true then
		splash.keypressed(k)
	elseif st.start == true then
		start.keypressed(k)
	end
end