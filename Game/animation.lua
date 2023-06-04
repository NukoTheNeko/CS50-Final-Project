Animation = Object:extend()
require("helpers")

function Animation:new(spriteSheet, totalFrames, hFrameCount, vFrameCount, firstHFrame, firstVFrame,frameWidth, frameHeight, outerBorder, innerBorder)
    self.spriteSheet = love.graphics.newImage(spriteSheet)
    self.frames = {}

    self.totalFrames = totalFrames
    self.currentFrame = 1

    self.imageHeight = self.spriteSheet:getHeight()
    self.imageWidth = self.spriteSheet:getWidth()

    self.xPivot = frameWidth/2
    self.yPivot = frameHeight/2

    for i = 0, vFrameCount - 1 do
        for j = 0, hFrameCount - 1 do
            table.insert(self.frames, love.graphics.newQuad(outerBorder + (firstHFrame - 1 + j) * (frameWidth + innerBorder), outerBorder + (firstVFrame - 1 + i) * (frameHeight + innerBorder), frameWidth, frameHeight, self.imageWidth, self.imageHeight))
        end 
    end
end

function Animation:Play(speed)
    self.currentFrame = self.currentFrame + speed * DeltaTime
    if math.floor(self.currentFrame) > self.totalFrames then
        self.currentFrame = 1
    end
end