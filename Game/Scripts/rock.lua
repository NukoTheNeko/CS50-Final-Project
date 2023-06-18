Rock = Slowable:extend()

function Rock:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    Rock.super.new(self, name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex) 
    
    self.colliderXDisplace = (tilemap.tileWidth * xScale - colliderXSize)/2
    self.colliderYDisplace = tilemap.tileHeight * yScale - colliderYSize
    
    self.animations["default"] = Animation("Assets/RollingStone.png",   4,   2,2,   1,1,   64,64,   4,8)
    self.animationId = "default"
    self.defaultAnimationSpeed = 15
    
    self.defaultSpeed = 600
    self.currentSpeed = self.defaultSpeed

    self.targetPoints = {}
    self.currentTarget = 1
    self.targetChange = -1
    
    table.insert(self.targetPoints, {x = xPos, y = yPos + 300})
    table.insert(self.targetPoints, {x = xPos + 300, y = yPos + 300})
    table.insert(self.targetPoints, {x = xPos + 300, y =  yPos - 300})
    table.insert(self.targetPoints, {x = xPos, y = yPos - 300})
end

function Rock:update(dt)
    Rock.super.update(self, dt)

    local target = self.targetPoints[self.currentTarget]

    local doneX = false
    local doneY = false

    if (math.abs(self.xPos - target.x) < self.currentSpeed * dt) then
        self.xPos = target.x
        doneX = true
    end
    if (math.abs(self.yPos - target.y) < self.currentSpeed * dt) then
        self.yPos = target.y
        doneY = true
    end

    if doneX and doneY then
        self.currentTarget = self.currentTarget + self.targetChange
    end
    if self.currentTarget > #self.targetPoints then
        self.currentTarget = 1
    elseif self.currentTarget < 1 then
        self.currentTarget = #self.targetPoints
    end

    if target.x > self.xPos or target.y > self.yPos then
        self.defaultAnimationSpeed = -15
    else
        self.defaultAnimationSpeed = -15
    end

    self:MoveTowards(target.x, target.y, self.currentSpeed)

    self:ChangeZIndex(self.yPos + self.yPivot - self.colliderYDisplace/2)
end
