Prop = Object:extend()

function Prop:new(name, tag, sprite, xScale, yScale, xPos, yPos, rotation, hasCollision)
    self.sprite = love.graphics.newImage(sprite)


    self.xScale = xScale
    self.width = xScale * self.sprite:getWidth()
    self.yScale = yScale
    self.height = yScale * self.sprite:getHeight()


    self.xPos = xPos
    self.yPos = yPos


    self.rotation = rotation


    self.xPivot = self.sprite:getWidth()/2
    self.yPivot = self.sprite:getHeight()/2


    self.red = 1
    self.green = 1
    self.blue = 1
    self.alpha = 1


    self.name = name
    self.tag = tag


    self.hasCollision = hasCollision
    self.collisionMatrix = {}
end



function Prop:update(dt)
end



function Prop:isColliding(other)
end



function Prop:collisionEnter(other)
end



function Prop:collisionExit(other)
end



function Prop:SetPosition(xPos, yPos)
    self.xPos = xPos
    self.yPos = yPos
end



function Prop:Move(xAmount, yAmount)
    self.xPos = self.xPos + xAmount
    self.yPos = self.yPos + yAmount
end



function Prop:SetRotation(rotation)
    self.rotation = rotation
end



function Prop:SetScale(xScale, yScale)
    self.xScale = xScale
    self.width = xScale * self.sprite:getWidth()
    self.yScale = yScale
    self.height = yScale * self.sprite:getHeight()
end



function Prop:SetPivot(xPivot, yPivot)
    self.xPivot = xPivot
    self.yPivot = yPivot
end



function Prop:SetColor(red, green, blue, alpha)
    self.red = red/255
    self.green = green/255
    self.blue = blue/255
    self.alpha = alpha/255
end



function Prop:SetName(name)
    self.name = name
end



function Prop:SetTag(tag)
    self.tag = tag
end



function Prop:SetCollision(hasCollision)
    self.hasCollision = hasCollision
end



function Prop:draw()
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    love.graphics.draw(self.sprite, self.xPos, self.yPos, self.rotation, self.xScale, self.yScale, self.xPivot, self.yPivot)
end