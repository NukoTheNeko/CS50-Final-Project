io.stdout:setvbuf("no")

Object = require "classic"
require "prop"
require "player"
require "helpers"
require "tilemap"

local Grid = {
                {3,3,3,3,3,3,3,3},
                {3,3,3,3,3,3,3,3},
                {3,3,3,3,3,3,3,3},
                {2,2,2,2,2,2,2,2},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1}
             }

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0, 0.66, 0)
    Objects = {}

    
    Tiles = TileMap("Assets/TileMap.png",64,64,4,8,2)
    PlayerTiles = TileMap("Assets/MainCharacterAnim.png",64,64,4,8,1)
    Player = Player("Player", "character", PlayerTiles, 1, 1, 1, 0, 0, 0, true, true, true)
    table.insert(Objects,Player)
    size = 64
    width = 6
    height = 6
    for i = -size * width, size * width, size do
        for j = -size * height, size * height, size do
            if math.abs(i) == size * width or math.abs(j) == size * height then
                table.insert(Objects,Prop("Box", "box", Tiles, 4, 1, 1, i, j, 0, false, true, true))    
            end
        end
    end
    table.insert(Objects,Prop("SpikeTrap", "spikes",  Tiles, 5, 1, 1, 128, 128, 0, true, false, true))   
    table.insert(Objects,Prop("SpikeTrap", "spikes",  Tiles, 5, 1, 1, -128, -128, 0, true, false, true))   
    table.insert(Objects,Prop("Rock", "rocks",  Tiles, 6, 1, 1, -128, 128, 0, false, true, true))   
    table.insert(Objects,Prop("Rock", "rocks",  Tiles, 6, 1, 1, 128, -128, 0, false, true, true))   
end

function love.update(dt)
    DeltaTime = dt
    for i=#Objects,1,-1 do
        Objects[i]:update(dt)
        for j=#Objects-i+1,1,-1 do
            if not Objects[i].hasCollision or not Objects[j].hasCollision then
                goto continue
            end
            local temp = TableContains(Objects[i].collisionMatrix, Objects[j])
            if CheckCollision(Objects[i],Objects[j]) then
                if temp == 0 then
                    table.insert(Objects[i].collisionMatrix, Objects[j])
                    Objects[i]:collisionEnter(Objects[j])
                    Objects[j]:collisionEnter(Objects[i])
                end
                Objects[i]:isColliding(Objects[j])
                Objects[j]:isColliding(Objects[i])
            elseif temp ~= 0 then
                table.remove(Objects[i].collisionMatrix, temp)
                Objects[i]:collisionExit(Objects[j])
                Objects[j]:collisionExit(Objects[i])
            end
            ::continue::
        end
    end
end

function love.draw()
    love.graphics.scale(1)
    love.graphics.translate(-Player.xPos + WindowWidth/2, -Player.yPos+  WindowHeight/2)
    Tiles:draw(Grid,-600,-800)
    for i=#Objects,1,-1 do
        Objects[i]:draw()
    end
end