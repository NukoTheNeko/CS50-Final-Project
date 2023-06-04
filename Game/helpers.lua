WindowWidth = love.graphics.getWidth()
WindowHeight = love.graphics.getHeight()

DeltaTime = 0

function CheckCollision(prop1, prop2)
    local prop1Left = prop1.xPos
    local prop1Right = prop1.xPos + prop1.width
    local prop1Top = prop1.yPos
    local prop1Bottom = prop1.yPos + prop1.height

    local prop2Left = prop2.xPos
    local prop2Right = prop2.xPos + prop2.width
    local prop2Top = prop2.yPos
    local prop2Bottom = prop2.yPos + prop2.height

    return  prop1Right > prop2Left
        and prop1Left < prop2Right
        and prop1Bottom > prop2Top
        and prop1Top < prop2Bottom
end

function TableContains(tableToSearch, toFind)
    for i, element in pairs(tableToSearch) do
        if element == toFind then 
            return i
        end
    end
    return 0
end