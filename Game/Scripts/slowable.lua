Slowable = GameObject:extend()

function Slowable:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    Slowable.super.new(self, name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex) 
    
    self.defaultSpeed = 250
    self.defaultAnimationSpeed = 15
    self.currentSpeed = self.defaultSpeed
    self.animationSpeed = self.defaultAnimationSpeed

    self.slowed = false

    self.timer = 0
    self.timerLimit = 0
end


function Slowable:Slow(duration, intensity)
    self.slowed = true
    self.currentSpeed = self.defaultSpeed / intensity
    self.animationSpeed = self.defaultAnimationSpeed / intensity
        
    self.timer = 0
    self.timerLimit = duration
end

function Slowable:RemoveSlow()
    self.slowed = false
    self.currentSpeed = self.defaultSpeed
    self.animationSpeed = self.defaultAnimationSpeed
        
    self.timer = 0
end

function Slowable:update(dt)
    self.timer = self.timer + dt
end