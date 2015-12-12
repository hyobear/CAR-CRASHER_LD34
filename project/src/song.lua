local publicStart = {}

function publicStart.load()
	
end

function publicStart.draw(startScale)
	love.graphics.printf('Press left to go to options, press right to select song', love.window.getWidth()/4 - 20, 60 * startScale,
		100, center, 0, startScale, startScale)
end

function publicStart.update(dt)

end

function publicStart.keypressed(k)
	if k == 'left' then
		st.start = false
		st.options = true
	end
end

return publicStart