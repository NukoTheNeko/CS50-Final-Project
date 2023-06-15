GameObject = Prop:extend()


function GameObject:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize, colliderYSize, visible, zIndex)
    GameObject.super.new(self, name, tag, xScale, yScale, xPos, yPos, rotation, visible, zIndex)

    self.animations = {}
    self.animationId = nil
    self.animationSpeed = 5

    self.tilemap = tilemap
    self.targetTile = targetTile

    self.isUI = false;

    self.hasCollision = hasCollision
    self.blocks = blocks
    self.collisionMatrix = {}

    self.colliderXSize = colliderXSize
    self.colliderYSize = colliderYSize
    self.colliderXDisplace = 0
    self.colliderYDisplace = 0

    self.xPivot = tilemap.tileWidth/2
    self.yPivot = tilemap.tileHeight/2

end



function GameObject:isColliding(other)
end



function GameObject:collisionEnter(other)
end



function GameObject:collisionExit(other)
end



function GameObject:Move(xAmount, yAmount)
    self.xPos = self.xPos + xAmount
    self.yPos = self.yPos + yAmount
    if self.blocks then
        for index, value in ipairs(Objects) do
            if value.blocks and value ~= self then
                if CheckCollision(self, value) then
                    self.xPos = self.xPos - xAmount
                    self.yPos = self.yPos - yAmount
                    xAmount = 0
                    yAmount = 0
                end
            end
        end
    end
    xAmount = 0
    yAmount = 0
end



function GameObject:SetCollision(hasCollision)
    self.hasCollision = hasCollision
end



function GameObject:draw()
    if not self.visible then
        return
    end
    GameObject.super.draw(self)
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