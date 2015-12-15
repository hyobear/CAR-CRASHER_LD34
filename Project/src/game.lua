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

-- you must crash all cars driving south!
-- cars get faster and spawn faster as time progresses.
-- if more than three pass you, it's game over!

function dist(x1,y1,x2,y2)
	return math.sqrt( (x1 - x2)^2 + (y1 - y2)^2 )
end

function publicGame.load()
	enemyI = i.eCar
	enemies = {} -- array of enemies being drawn
	enemySpeed = 150
	enemyDistance = 10 -- used to spawn enemies further away from each other when it gets to avoid button mashing

	bulletI = i.bullet
	bullets = {} -- array of bullets being drawn
	bulletTimer = 0
	bulletTimerMax = .2

	time = 0 -- time passed since start
	timer = 0
	timerMax = 2
	counter = 0
	counterMax = 0

	player = {x = 65, y = 95, speed = 50, img = i.car, hp = 3}
	background = i.road
	lvl = 1
end

function publicGame.draw(gameScale)
	love.graphics.draw(background, 0, 0, 0, gameScale, gameScale)
	love.graphics.draw(player.img, player.x * gameScale, player.y * gameScale, 0, gameScale * 2, gameScale * 2)
	love.graphics.print("HP: " .. player.hp, 4 * gameScale, 2 * gameScale, 0, gameScale, gameScale)
	love.graphics.print("LV: " .. lvl, 4 * gameScale, 20 * gameScale, 0, gameScale, gameScale)
	love.graphics.print("SPD: \n" .. enemySpeed .. '\npps', 4 * gameScale, 40 * gameScale, 0, gameScale, gameScale)

	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x * gameScale, enemy.y * gameScale, 0, gameScale * 2, gameScale * 2)
	end

end

function publicGame.update(dt)
	if love.keyboard.isDown('left') then
		player.x = 35
	elseif love.keyboard.isDown('right') then
		player.x = 95
	else
		player.x = 65
	end

	tempdt = dt

	counterMax = 5
	counter = counter + tempdt
	if counter == counterMax or counter > counterMax + 5 then
		counter = counterMax
		timerMax = timerMax - 0.2
		enemySpeed = enemySpeed + 20
		lvl = lvl + 1
		tempdt = 0
	end

	if timerMax <= 0.50 then
		timerMax = 0.50
	elseif enemySpeed >= 400 then
		enemySpeed = 400
	end

	-- spawn enemy
	timer = timer + tempdt
	if timer >= timerMax then
		newEnemy = {x = 0, y = -enemyI:getWidth(), img = enemyI}
		math.randomseed(os.time())
		randomSide = math.random(1, 2)
		if randomSide == 1 then
			newEnemy.x = 35
		elseif randomSide == 2 then
			newEnemy.x = 95
		end
		table.insert(enemies, newEnemy)

		timer = 0
	end

	-- enemy conditionals
	for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y + (enemySpeed * dt)
		-- if enemy goes off screen, automatically delete enemy + take away one from hp
		if enemy.y >= love.window.getHeight()/scale then
			table.remove(enemies, i)
			player.hp = player.hp - 1
		elseif dist(player.x * scale, player.y * scale, enemy.x * scale, enemy.y * scale) < (12 + 8) * scale then -- if player touches enemy, delete enemy
			table.remove(enemies, i)
		end
	end

	if player.hp == 0 then
		st.game = false
		st.start = true
		enemySpeed = 150
		bulletTimer = 0
		bulletTimerMax = .2
		time = 0
		timer = 0
		timerMax = 2
		counter = 0
		counterMax = 0
		player = {x = 65, y = 95, speed = 50, img = i.car, hp = 3}
		lvl = 1
	end
end

return publicGame