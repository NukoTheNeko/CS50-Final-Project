Prop = Object:extend()
require("animation")

function Prop:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, visible)
    self.tilemap = tilemap
    self.targetTile = targetTile

    self.animations = {}
    self.animationId = nil
    self.animationSpeed = 5

    self.xScale = xScale
    self.width = xScale * tilemap.tileWidth
    self.yScale = yScale
    self.height = yScale * tilemap.tileHeight


    self.xPos = xPos
    self.yPos = yPos


    self.rotation = rotation


    self.xPivot = tilemap.tileWidth/2
    self.yPivot = tilemap.tileHeight/2


    self.red = 1
    self.green = 1
    self.blue = 1
    self.alpha = 1


    self.name = name
    self.tag = tag


    self.hasCollision = hasCollision
    self.blocks = blocks
    self.collisionMatrix = {}
    self.visible = visible
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
    if self.blocks then
        for index, value in ipairs(Objects) do
            if value.blocks and value ~= self then
                if CheckCollision(self, value) then
                    self.xPos = self.xPos - xAmount
                    self.yPos = self.yPos - yAmount
                end
            end
        end
    end
end



function Prop:SetRotation(rotation)
    self.rotation = rotation
end



function Prop:SetScale(xScale, yScale)
    self.xScale = xScale
    self.width = xScale * self.tilemap.tileWidth
    self.yScale = yScale
    self.height = yScale * self.tilemap.tileHeight
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
    if not self.visible then
        return
    end
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    if self.animationId == nil then
        love.graphics.draw(self.tilemap.tileSheet, self.tilemap.tiles[self.targetTile], self.xPos, self.yPos, self.rotation, self.xScale, self.yScale, self.xPivot, self.yPivot)
    else
        local animation = self.animations[self.animationId]
        animation:Play(self.animationSpeed) 
        love.graphics.draw(animation.spriteSheet,
            animation.frames[math.floor(animation.currentFrame)],
            self.xPos, self.yPos, self.rotation,
            self.xScale, self.yScale,
            animation.xPivot, animation.yPivot)
    end
end