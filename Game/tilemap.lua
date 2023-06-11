TileMap = Object:extend()

function TileMap:new(tileSheet, tileWidth, tileHeight, outerBorder, innerBorder, scale)
    self.tileSheet = love.graphics.newImage(tileSheet)
    self.tiles = {}

    self.scale = scale
    
    self.tileHCount = math.floor(self.tileSheet:getWidth() / tileWidth)
    self.tileVCount = math.floor(self.tileSheet:getHeight() / tileHeight)

    self.tileWidth = tileWidth
    self.tileHeight = tileHeight

    for i = 0, self.tileVCount - 1 do
        for j = 0, self.tileHCount - 1 do
            table.insert(self.tiles, love.graphics.newQuad(outerBorder + j * (tileWidth + innerBorder), outerBorder + i * (tileHeight + innerBorder), tileWidth, tileHeight, self.tileSheet:getWidth(), self.tileSheet:getHeight()))
        end
    end
end

function TileMap:draw(grid, topLeftX, topLeftY)
    for i,row in ipairs(grid) do
        for j,tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.setColor(1,1,1,1)
                love.graphics.draw(self.tileSheet, self.tiles[tile], topLeftX + j * self.tileWidth * self.scale, topLeftY + i * self.tileHeight * self.scale,0,self.scale)
            end
        end
    end
end

function TileMap:GetQuad(quadNumber)
    return self.tiles[quadNumber]
end