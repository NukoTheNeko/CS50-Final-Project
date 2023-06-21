Fire = GameObject:extend()

function Fire:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    Fire.super.new(self, name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex) 
    self.colliderXDisplace = (tilemap.tileWidth * xScale - colliderXSize)/2
    self.colliderYDisplace = tilemap.tileHeight * yScale - colliderYSize
    self:ChangeZIndex(self.yPos + self.yPivot - self.colliderYDisplace/2)
    self.duration = 1
    self.timer = 0
    self.animations["default"] = Animation("Assets/Animations.png",   4,   4,1,   1,1,   64,64,   4,8)
    self.ChangeAnimation(self, "default")
    self.animationSpeed = 30
end

function Fire:collisionEnter(other)
    if other.combustible == true then
        other:destroy()
    end
end

function Fire:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.duration then
        self:destroy()
    end
end