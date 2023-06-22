Animation = Object:extend()
require("Game.Engine.helpers")

function Animation:new(tileMap, totalFrames, hFrameCount, vFrameCount, firstHFrame, firstVFrame)
    self.tileMap = tileMap

    self.hFrameCount = hFrameCount
    self.vFrameCount = vFrameCount

    self.startingFrame = firstHFrame + ((firstVFrame - 1) * tileMap.tileHCount)

    self.currentFrame = 0
    self.totalFrames = totalFrames

end

function Animation:Play(speed)
    self.currentFrame = self.currentFrame + speed * DeltaTime
    if math.floor(self.currentFrame) > self.totalFrames - 1 then
        self.currentFrame = 0
    elseif math.floor(self.currentFrame) < 0 then
        self.currentFrame = self.totalFrames - 1
    end
end
--self.animations["defualt"] = Animation(Animations,   6,   4,1,   1,3)

function Animation:GetAnimQuad()
    local h = math.floor(self.currentFrame % self.hFrameCount)
    local v = self.tileMap.tileHCount * math.floor(self.currentFrame / self.hFrameCount)
    return self.tileMap:GetQuad(self.startingFrame + v + h)
end