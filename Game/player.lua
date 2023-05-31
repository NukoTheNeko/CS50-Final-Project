Player = Prop:extend()

function Player:new(height, width, x, y)
    Player.super:new(height, width, x, y)
    self.speed = 100
end

function Player:Move(xAmount, yAmount)
    self.x = self.x + xAmount
    self.y = self.y + yAmount
end