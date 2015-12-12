local publicOptions = {}

scaleCounter = 1

function publicOptions.load()
	
end

function publicOptions.draw(optionsScale)
	love.graphics.printf('Press left to change scale, right to go back to start', love.window.getWidth()/4 - 20, 60 * optionsScale,
		100, center, 0, optionsScale, optionsScale)
end

function publicOptions.update(dt)
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

function publicOptions.keypressed(k)
	if k == 'right' then
		st.options = false
		st.start = true
	end
end

return publicOptions