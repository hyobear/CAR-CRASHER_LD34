local publicGame = {}

function publicGame.load()
	
end

function publicGame.draw(gameScale)

end

function publicGame.update(dt)
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

function publicGame.keypressed(k)
	if k == 'right' then
		st.options = false
		scaleCounter = -1
		st.start = true
	end
end

return publicGame