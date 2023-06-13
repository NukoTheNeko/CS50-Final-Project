WindowWidth = love.graphics.getWidth()
WindowHeight = love.graphics.getHeight()

DeltaTime = 0



function CheckCollision(prop1, prop2)
    local prop1Left = prop1.xPos - (prop1.colliderXSize * prop1.xScale / 2)
    local prop1Right = prop1.xPos + (prop1.colliderXSize * prop1.xScale / 2)
    local prop1Top = prop1.yPos - (prop1.colliderYSize * prop1.yScale / 2)
    local prop1Bottom = prop1.yPos + (prop1.colliderYSize * prop1.yScale / 2)

    local prop2Left = prop2.xPos - (prop2.colliderXSize * prop2.xScale / 2)
    local prop2Right = prop2.xPos + (prop2.colliderXSize * prop2.xScale / 2)
    local prop2Top = prop2.yPos - (prop2.colliderYSize * prop2.yScale / 2)
    local prop2Bottom = prop2.yPos + (prop2.colliderYSize * prop2.yScale / 2)

    love.graphics.setColor(1, 0, 0, 0.4)
    love.graphics.rectangle("fill",prop1Left,prop1Top,prop1Right-prop1Left,prop1Bottom-prop1Top)

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



function Sort(a,b)
    return a.zIndex > b.zIndex
end

function TableZSort(tableToSort)
    table.sort(tableToSort, Sort)
end



function CleanCollisions(ObjectToClean, remains)
    for y, Object in ipairs(Objects) do
        if Object == ObjectToClean then
            goto skip
        end
        local temp = TableContains(Object.collisionMatrix, ObjectToClean)  
        table.remove(Object.collisionMatrix, temp)
        Object:collisionExit(ObjectToClean)
        if remains then
            ObjectToClean:collisionExit(Object)
        end
        ::skip::
    end
end