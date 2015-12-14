local publicSplash = {}

local counter = 0
function publicSplash.load()
	dttemp = 0
end

function publicSplash.draw(splash, splashScale)
	-- pic goes down to specific y coordinate, then stops
	splashEq = (dttemp - 2.5) * 25 * splashScale
	love.graphics.draw(splash, splashEq, 0, 0, splashScale)
end

function publicSplash.update(dt)
	-- splash screen will only last 5 seconds
	dttemp = dttemp + dt
	counter = counter + dt
	if dttemp >= 2.5 then
		dttemp = 2.5
		splashEq = 0
	elseif counter >= 2.5 then
		st.splash = false
		st.start = true
	end
end

function publicSplash.keypressed(k)
	if k == 'left' then
		st.splash = false
		st.start = true
	elseif k == 'right' then
		st.splash = false
		st.start = true
	end
end

return publicSplash