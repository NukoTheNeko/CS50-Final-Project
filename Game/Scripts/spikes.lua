Spike = GameObject:extend()

function Spike:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    Spike.super.new(self, name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    self.damage = 15    
    
    self.colliderXDisplace = (tilemap.tileWidth * xScale - colliderXSize)/2
    self.colliderYDisplace = tilemap.tileHeight * yScale - colliderYSize
    
    self:ChangeAnimation("down")
    self.animations["down"] = Animation("Assets/TileMap.png",   1,   1,1,   3,2,   64,64,   4,8)
    self.animations["up"] = Animation("Assets/TileMap.png",   1,   1,1,   2,2,   64,64,   4,8)
end

function Spike:collisionEnter(other)
    if other.tag == "character" then
        other:ChangeHealth(-self.damage)
        self:ChangeAnimation("up")
    end
end

function Spike:collisionExit(other)
    if other.tag == "character" and other.health ~= 0 then
        self:ChangeAnimation("down")
    end
end