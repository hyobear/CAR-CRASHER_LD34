local publicStart = {}

function publicStart.load()
	
end

function publicStart.draw(startScale)
	love.graphics.printf('Press left to go to options, press right to start game', love.window.getWidth()/4 - 20, 100 * startScale,
		100, center, 0, startScale, startScale)
end

function publicStart.update(dt)

end

function publicStart.keypressed(k)
	if k == 'left' then
		st.start = false
		st.options = true
	elseif k == 'right' then
		st.start = false
		st.game = true
	end
end

return publicStart