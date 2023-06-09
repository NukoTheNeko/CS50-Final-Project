Player = Prop:extend()

function Player:new(name, tag, sprite, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks)
    Player.super:new(name, tag, sprite, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks)
    self.speed = 250

    self.animationId = "idledown";

    self.animations["idledown"] = Animation("Assets/MainCharacterAnim.png",   1,   1,1,   1,1,   64,64,   4,8)
    self.animations["idleright"] = Animation("Assets/MainCharacterAnim.png",   1,   1,1,   2,1,   64,64,   4,8)
    self.animations["idleleft"] = Animation("Assets/MainCharacterAnim.png",   1,   1,1,   3,1,   64,64,   4,8)
    self.animations["idleup"] = Animation("Assets/MainCharacterAnim.png",   1,   1,1,   4,1,   64,64,   4,8)
    self.animations["down"] = Animation("Assets/MainCharacterAnim.png",   2,   1,2,   1,2,   64,64,   4,8)
    self.animations["right"] = Animation("Assets/MainCharacterAnim.png",   2,   1,2,   2,2,   64,64,   4,8)
    self.animations["left"] = Animation("Assets/MainCharacterAnim.png",   2,   1,2,   3,2,   64,64,   4,8)
    self.animations["up"] = Animation("Assets/MainCharacterAnim.png",   2,   1,2,   4,2,   64,64,   4,8)

end

function Player:collisionEnter(other)
    if other.tag == "spikes" then
        self:SetColor(255, 2, 2, 255)
    end
end

function Player:collisionExit(other)
    if other.tag == "spikes" then
        self:SetColor(255, 255, 255, 255)
    end
end

function Player:update(dt)
    if love.keyboard.isDown("return") then
        self:SetPosition(0,0)
    end

    local xMovement = 0
    local yMovement = 0

    if love.keyboard.isDown("lshift") then
        self.speed = 400
    else
        self.speed = 250
    end

    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        xMovement = xMovement + self.speed * dt
        self.animationId = "right"
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        xMovement = xMovement - self.speed * dt
        self.animationId = "left"
    elseif love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        yMovement = yMovement - self.speed * dt
        self.animationId = "up"
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        yMovement = yMovement + self.speed * dt
        self.animationId = "down"
    end
    if xMovement == 0 and yMovement == 0 and not string.find(self.animationId,"idle") then
        self.animationId = "idle" .. self.animationId
    end

    self:Move(xMovement,yMovement)
end