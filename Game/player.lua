Player = Prop:extend()

function Player:new(name, tag, sprite, xScale, yScale, xPos, yPos, rotation, hasCollision)
    Player.super:new(name, tag, sprite, xScale, yScale, xPos, yPos, rotation, hasCollision)
    self.speed = 100

    self.animationNum = 1;

    --idle - 1
    table.insert(self.animations, Animation("Assets/anim.png", 1, 1,1,1,1,16,17,0,0))
    --down - 2
    table.insert(self.animations, Animation("Assets/anim.png", 2, 1,2,1,2,16,17,0,0))
    --right - 3
    table.insert(self.animations, Animation("Assets/anim.png", 2, 1,2,2,2,16,17,0,0))
    --up - 4
    table.insert(self.animations, Animation("Assets/anim.png", 2, 1,2,3,2,16,17,0,0))
    --left - 5
    table.insert(self.animations, Animation("Assets/anim.png", 2, 1,2,4,2,16,17,0,0))

end

function Player:collisionEnter(other)
    if other.tag == "rock" then
        self:SetColor(255, 2, 2, 255)
    end
end

function Player:collisionExit(other)
    if other.tag == "rock" then
        self:SetColor(255, 255, 255, 255)
    end
end

function Player:update(dt)
    if love.keyboard.isDown("return") then
        self:SetPosition(100,100)
    end

    local xMovement = 0
    local yMovement = 0

    if love.keyboard.isDown("d") then
        xMovement = xMovement + self.speed * dt
        self.animationNum = 3
    end
    if love.keyboard.isDown("a") then
        xMovement = xMovement - self.speed * dt
        self.animationNum = 5
    end   
    if love.keyboard.isDown("w") then
        yMovement = yMovement - self.speed * dt
        self.animationNum = 4
    end
    if love.keyboard.isDown("s") then
        yMovement = yMovement + self.speed * dt
        self.animationNum = 2
    end
    if xMovement == 0 and yMovement == 0 then
        self.animationNum = 1
    end

    self:Move(xMovement,yMovement)
end