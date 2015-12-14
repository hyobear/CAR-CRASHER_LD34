local publicGame = {}

local function Proxy(f)
	return setmetatable({}, {__index = function(self, k)
		local v = f(k)
		rawset(self, k, v)
		return v
	end})
end

i   = Proxy(function(k) return love.graphics.newImage('img/' .. k .. '.png') end)
s   = Proxy(function(k) return love.audio.newSource('sfx/' .. k .. '.wav', 'static') end)
m   = Proxy(function(k) return love.audio.newSource('msc/' .. k .. '.wav', 'stream') end)

-- you must shoot all cars driving south!
-- if more than three pass you, it's game over!
-- cars get faster, spawn faster, and you have less bullets as time progresses.
-- you can only take 3 hits

function publicGame.load()
	enemyI = i.eCar
	bulletI = i.bullet
	background = i.road
	enemies = {} -- array of enemies being drawn
	bullets = {} -- array of bullets being drawn
	player = {x = 65, y = 95, speed = 50, img = i.car, hp = 3}
	bulletTimer = 0
	time = 0
	spawnFreq = 4
	spawnTimer = spawnFreq
end

function publicGame.draw(gameScale)
	love.graphics.draw(background, 0, 0, 0, gameScale, gameScale)
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x * gameScale, bullet.y * gameScale, 0, gameScale * 2, gameScale * 2)
	end
	love.graphics.draw(player.img, player.x * gameScale, player.y * gameScale, 0, gameScale * 2, gameScale * 2)
end

function publicGame.update(dt)
	bulletTimerMax = 0.2
	bulletTimer = bulletTimer + dt
	time = time + dt -- adds one every second
	spawnTimer = spawnFreq - dt -- takes away one every second

	if spawnTimer <= 0 then
		-- enemy spawn code
		spawnTimer = freq
	end

	if love.keyboard.isDown('left') then
		if player.x >= 28 then
			player.x = player.x - (player.speed * dt) -- collision check!
		end
	elseif love.keyboard.isDown('right') then
		if player.x <= (love.window.getWidth() - player.img:getWidth() * 2 - 29) then
			player.x = player.x + (player.speed * dt) -- more collision checking!
		end
	end

	bulletTimer = bulletTimer + dt
	if bulletTimer >= bulletTimerMax then
		newBullet = {x = player.x + ((player.img:getWidth())/2), y = player.y - 2 * scale, img = bulletI}
		table.insert(bullets, newBullet)
		canShoot = false
		bulletTimer = 0
	end

	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)
		if bullet.y == -20 then
			table.remove(bullets, i)
		end
	end
end


return publicGame