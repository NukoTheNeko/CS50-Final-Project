Player = Prop:extend()

function Player:new(name, tag, sprite, xScale, yScale, xPos, yPos, rotation, hasCollision)
    Player.super:new(name, tag, sprite, xScale, yScale, xPos, yPos, rotation, hasCollision)
    self.speed = 100
end

function Player:collisionEnter(other)
    if other.tag == "rock" then
        self:SetColor(255, 123, 123, 255)
    end
end

function Player:collisionExit(other)
    if other.tag == "rock" then
        self:SetColor(123, 123, 255, 255)
    end
end

function Player:update(dt)
    if love.keyboard.isDown("return") then
        self:SetPosition(100,100)
    end

    local xMovement = 0
    local yMovement = 0

    if love.keyboard.isDown("a") then
        xMovement = xMovement - self.speed * dt
    end
    if love.keyboard.isDown("d") then
        xMovement = xMovement + self.speed * dt
    end
    if love.keyboard.isDown("w") then
        yMovement = yMovement - self.speed * dt
    end
    if love.keyboard.isDown("s") then
        yMovement = yMovement + self.speed * dt
    end

    self:Move(xMovement,yMovement)
end