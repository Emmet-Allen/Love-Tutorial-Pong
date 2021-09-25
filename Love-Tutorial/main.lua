require ("player")
require ("ball")
require ("AI")
require ("background")

function love.load()
    Player:load()
    Ball:load()
    AI:load()
    Background:load()

    Score = {player = 0, ai = 0}
    font = love.graphics.newFont(30)
end

function love.update(dt)
    Background:update(dt)
    -- stops updating the game once score is 7
    gameOver(Score.player, Score.ai, dt)
    -- quits the game with "escape" key
    quit()
end

function love.draw()
    -- Background needs to be drawn first!
    Background:draw()
    printGameOver(Score.player, Score.ai)
    Player:draw()
    Ball:draw()
    AI:draw()

end

function drawScore()
    love.graphics.setFont(font)
    love.graphics.print("Player: "..Score.player, 50,50)
    love.graphics. print("AI: "..Score.ai, 1000, 50)
end

function printGameOver(scorePlayer, scoreAi)
    love.graphics.setFont(font)
    if scorePlayer == 7 then 
        love.graphics.print("Player Wins", 500, 50)
    else if scoreAi == 7 then
        love.graphics.print("AI Wins. Press escape to close", 500, 50)
    else
        drawScore()
    end
end
end

function gameOver(scorePlayer, scoreAi, dt)
    if scorePlayer == 7 or scoreAi == 7 then
        love.event.wait()
    else
        Player:update(dt)
        AI:update(dt)
        Ball:update(dt)
    end
end

function quit()
    if love.keyboard.isDown("escape")
    then
        love.event.quit()
    end
end

function checkCollision(a,b) -- aabb collision, checks the side of an object a against its opposite side on object b i.e. a's left to b's right
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end
end
