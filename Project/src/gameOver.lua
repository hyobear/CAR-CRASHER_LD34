local publicGameOver = {}

function publicGameOver.load()

end

function publicGameOver.draw(gameOverScale)
	love.graphics.printf('You got to level ' .. lvl .. '! Play again?\nLeft to play again, right to exit.', love.window.getWidth()/4 - 20, 100 * gameOverScale,
		100, center, 0, gameOverScale, gameOverScale)
end

function publicGameOver.update(dt)
	if love.keyboard.isDown('right') then
		st.gameOver = false
		love.event.quit()
	elseif love.keyboard.isDown('left') then
		st.gameOver = false
		st.game = true
	end
end

return publicGameOver