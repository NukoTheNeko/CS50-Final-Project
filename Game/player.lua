local Player = {}
Player.height = 30
Player.width = 30
Player.x = 500
Player.y = 500
Player.speed = 100

function Player.Move(xAmount, yAmount)
    Player.x = Player.x + xAmount
    Player.y = Player.y + yAmount
end

function Player.SetPosition(xPos, yPos)
    Player.x = xPos
    Player.y = yPos
end

return Player