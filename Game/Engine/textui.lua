TextUI = Prop:extend()

function TextUI:new(name, tag, message, textBoxWidth, xScale, yScale, xPos, yPos, rotation, visible, zIndex)
    TextUI.super.new(self, name, tag, xScale, yScale, xPos, yPos, rotation, visible, zIndex)
    self.message = message
    self.textBoxWidth = textBoxWidth
    self:SetPivot(textBoxWidth/2,0)
    self.isUI = true;
end

function TextUI:draw()
    if not self.visible then
        return
    end
    TextUI.super.draw(self)
    self.message = Player.health
end

function TextUI:update(dt)
end
