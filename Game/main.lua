io.stdout:setvbuf("no")

Object = require "classic"
require "prop"
require "player"
require "helpers"
require "tilemap"

local Grid = {
                {1,2,2,2,2,2,2,3},
                {7,8,8,8,8,8,8,9},
                {7,8,8,8,8,8,8,9},
                {7,8,8,8,8,8,8,9},
                {7,8,8,8,8,8,8,9},
                {31,32,32,32,32,32,32,33},
                {37,38,38,38,38,38,38,39},
                {37,38,38,38,38,38,38,39},
                {43,44,44,44,44,44,44,45}
            }

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0, 0.66, 0)
    Objects = {}

    
    Tiles = TileMap("Assets/tileset.png",16,16,0,0,6)
    Player = Player("Player", "character", "Assets/MainCharacter.png", 1, 1, 0, 0, 0, true, true)
    table.insert(Objects,Player)
    size = 64
    width = 6
    height = 6
    for i = -size * width, size * width, size do
        for j = -size * height, size * height, size do
            if math.abs(i) == size * width or math.abs(j) == size * height then
                table.insert(Objects,Prop("Box", "box", "Assets/Box.png", 1, 1, i, j, 0, true, true))    
            end
        end
    end
    table.insert(Objects,Prop("SpikeTrap", "spikes", "Assets/SpikeTrap.png", 1, 1, 128, 128, 0, true, false))   
    table.insert(Objects,Prop("SpikeTrap", "spikes", "Assets/SpikeTrap.png", 1, 1, -128, -128, 0, true, false))   
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
    Tiles:draw(Grid,-size * width,-size * height)
    for i=#Objects,1,-1 do
        Objects[i]:draw()
    end
end