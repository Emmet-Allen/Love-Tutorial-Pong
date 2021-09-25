
Player = {}

function Player:load()
    self.x = 50
    self.y = love.graphics.getHeight() / 2 --uses love function to get the height of the window (in pixels)
    self.img = love.graphics.newImage("assets/1.png")
    self.width = self.img:getWidth() -- sets the width of the hitbox equal to the width of the image
    self.height = self.img:getHeight() -- sets the height of the hitbox equal to the height of the image
    self.speed = 500
end

function Player:update(dt)
    self:move(dt)
    self:checkBoudaries(dt)
end

function Player:move(dt)
    if love.keyboard.isDown("w") then --checks if key is pressed
        self.y = self.y - self.speed * dt --updated y-pos. by subtracting its height from its speed * delta time
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
end

function Player:checkBoudaries(dt)
    if self.y < 0 then
        self.y = 0 --keeps the paddle from going above top of the window
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height --keeps paddle above the bottom of window by taking into account the height of the paddle
    end
end


function Player:draw()
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.draw(self.img, self.x, self.y)
end