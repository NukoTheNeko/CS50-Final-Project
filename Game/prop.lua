Prop = Object:extend()
require("animation")

function Prop:new(name, tag, xScale, yScale, xPos, yPos, rotation, visible, zIndex)

    self.xScale = xScale
    self.yScale = yScale


    self.xPos = xPos
    self.yPos = yPos


    self.rotation = rotation


    self.xPivot = 0
    self.yPivot = 0


    self.red = 1
    self.green = 1
    self.blue = 1
    self.alpha = 1


    self.name = name
    self.tag = tag

    self.visible = visible
    
    self.isUI = true;
    
    self:ChangeZIndex(zIndex)
end



function Prop:update(dt)
end



function Prop:destroy()
    table.insert(ObjectsToDestroy, self)
end



function Prop:SetPosition(xPos, yPos)
    self.xPos = xPos
    self.yPos = yPos
end




function Prop:SetRotation(rotation)
    self.rotation = rotation
end



function Prop:SetScale(xScale, yScale)
    self.xScale = xScale
    self.yScale = yScale
end



function Prop:SetPivot(xPivot, yPivot)
    self.xPivot = xPivot
    self.yPivot = yPivot
end



function Prop:SetColor(red, green, blue, alpha)
    self.red = red/255
    self.green = green/255
    self.blue = blue/255
    self.alpha = alpha/255
end



function Prop:SetName(name)
    self.name = name
end



function Prop:SetTag(tag)
    self.tag = tag
end



function Prop:ChangeZIndex(zIndex)
    self.zIndex = zIndex
    TableZSort(Objects)
end



function Prop:draw()
    if not self.visible then
        return
    end
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
end