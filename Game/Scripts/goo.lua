Goo = GameObject:extend()

function Goo:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    Goo.super.new(self, name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex) 
    self.contact = nil
    self.timer = 0
    self.duration = 5
    self.intensity = 5
end

function Goo:collisionEnter(other)
    if other.tag == "rocks" and self.contact == nil then
        if other.slowed then
            return
        end
        self.contact = other
        other:Slow(self.duration,self.intensity)
    end
end

function Goo:update(dt)
    if self.contact ~= nil then
        self.zIndex = self.contact.zIndex + 1
        self.timer = self.timer + dt
        self.xPos = self.contact.xPos
        self.yPos = self.contact.yPos
        
        if self.timer > self.duration then
            self.contact:RemoveSlow()
            self:destroy()
        end
    else
        self.zIndex = self.yPos
    end
end