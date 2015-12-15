local publicStart = {}

local scaleCounter = -1

local function Proxy(f)
	return setmetatable({}, {__index = function(self, k)
		local v = f(k)
		rawset(self, k, v)
		return v
	end})
end

i   = Proxy(function(k) return love.graphics.newImage('img/' .. k .. '.png') end)

function publicStart.load()
	
end

function publicStart.draw(startScale)
	love.graphics.draw(i.title, 0, 0, 0, startScale, startScale)
end

function publicStart.update(dt)
	if love.keyboard.isDown('left') then
		scaleCounter = scaleCounter + 1
		if scaleCounter == 1 then
			scale = 1
			love.window.setMode(150, 130, {vsync = true})
		elseif scaleCounter == 2 then
			scale = 2
			love.window.setMode(150 * scale, 130 * scale, {vsync = true})
		elseif scaleCounter == 3  then
			scale = 3
			love.window.setMode(150 * scale, 130 * scale, {vsync = true})
		elseif scaleCounter == 4 then
			scale = 4
			love.window.setMode(150 * scale, 130 * scale, {vsync = true})
		elseif scaleCounter == 5 then
			scale = 5
			love.window.setMode(150 * scale, 130 * scale, {vsync = true})
		end
		if scaleCounter > 5 then
			scaleCounter = 0
		end
	end
end

function publicStart.keypressed(k)
	if k == 'right' then
		st.start = false
		st.game = true
	end
end

return publicStart