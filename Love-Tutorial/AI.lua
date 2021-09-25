
AI = {}

function AI:load()
    self.img = love.graphics.newImage("assets/2.png")
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2
    self.yVel = 0
    self.speed = 500

    self.timer = 0
    self.rate = 0.30
end

function AI:update(dt)
    self:move(dt)
    self:checkBoudaries(dt)
    self.timer = self.timer + dt
    if self.timer > self.rate then
        self.timer = 0
        self:acquireTarget()
    end
end

function AI:move(dt)
    self.y = self.y + self.yVel * dt
end

function AI:acquireTarget()
    if Ball.y + Ball.height < self.y then --track the ball on +Y
        self.yVel = -self.speed
    elseif Ball.y > self.y + self.height then --track the ball on -Y
        self.yVel = self.speed
    else
        self.yVel = 0
    end
end

function AI:checkBoudaries(dt)
    if self.y < 0 then
        self.y = 0 --keeps the paddle from going above top of the window
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height --keeps paddle above the bottom of window by taking into account the height of the paddle
    end
end

function AI:draw()
   -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
   love.graphics.draw(self.img, self.x, self.y)
end