Prop = Object:extend()

function Prop:new(height, width, x, y)
    self.height = height
    self.width = width
    self.x = x
    self.y = y
end

function Prop:SetPosition(xPos, yPos)
    self.x = xPos
    self.y = yPos
end

function Prop:draw()
    love.graphics.circle("fill", self.x, self.y, self.width, self.height)
end