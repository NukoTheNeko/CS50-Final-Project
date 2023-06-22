IceWall = GameObject:extend()

function IceWall:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    IceWall.super.new(self, name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex) 
    self.colliderXDisplace = (tilemap.tileWidth * xScale - colliderXSize)/2
    self.colliderYDisplace = tilemap.tileHeight * yScale - colliderYSize
    self.zIndex = self.yPos + self.yPivot - self.colliderYDisplace / 2
    self.combustible = true
    self.animations["spawn"] = Animation(Animations,   4,   4,1,   1,2)
    self.ChangeAnimation(self, "spawn")
    self.animationSpeed = 12.5
    self.animDuration = 0.3
    self.timer = 0
end

function IceWall:collisionEnter(other)
    if other.tag == "rocks" then
        other:Reverse()
    end
end

function IceWall:update(dt)
    if self.animationId ~= nil then
        self.timer = self.timer + dt
        if self.timer > self.animDuration then
            self.animationId = nil
        end
    end
end