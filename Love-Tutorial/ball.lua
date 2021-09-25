
Ball = {}

function Ball:load()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.img = love.graphics.newImage("assets/ball.png")
    self.height = self.img:getHeight()
    self.width = self.img:getWidth()
    self.speed = 700
    self.xVel = -self.speed -- velocity on X when it first loads
    self.yVel = 0  -- velocity of Y when it first loads, no collision
end

function Ball:update(dt)
    self:move(dt)
    self:collideWall(dt)
    self:collidePlayer()
    self:collideAI()
    self:score()
end

-- controls ball movement across screen
function Ball:move(dt)
    self.x = self.x + self.xVel * dt
    self.y = self.y + self.yVel * dt
end

-- detects collision between top and bottom window boarders
function Ball:collideWall(dt)
    if self.y < 0 then
        self.y = 0
        self.yVel = -self.yVel
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height 
        self.yVel = -self.yVel
    end
end

-- detects collision between Player Paddle
function Ball:collidePlayer()
    if checkCollision(self, Player) then
        self.xVel = self.speed
        local middleBall = self.y + self.height / 2 --use local to declare a local variable, gives middle of ball
        local middlePlayer = Player.y + Player.height / 2 --gives middle positon of player
        local collisionPosition = middleBall - middlePlayer -- detects the position where its hit on either +X or -X
        self.yVel = collisionPosition * 5 -- updates yVel speed by where on the player its hit, either top or bottom corner
    end
end

-- detects collision between AI paddle
function Ball:collideAI()
    if checkCollision(self, AI) then
        self.xVel = -self.speed
        local middleBall = self.y + self.height / 2 --use local to declare a local variable, gives middle of ball
        local middleAI = AI.y + AI.height / 2 --gives middle positon of player
        local collisionPosition = middleBall - middleAI -- detects the position where its hit on either +X or -X
        self.yVel = collisionPosition * 5 -- updates yVel speed by where on the player its hit, either top or bottom corner
    end
end

-- Detects collision between Player Screen Border and AI Screen Border
function Ball:score()
    -- If the ball goes past Player
    if self.x < 0 then
        Ball:resetPosition(1)
        Score.ai = Score.ai + 1
    end

    -- If the ball goes past AI
    if self.x + self.width > love.graphics.getWidth() then
        Ball:resetPosition(-1)
        Score.player = Score.player + 1
    end
end

-- Resets Ball position after Score is made
function Ball:resetPosition(modifier)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.yVel = 0
    self.xVel = self.speed --Ball goes towards Player
end

function Ball:draw()
    --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.draw(self.img, self.x, self.y)
end

