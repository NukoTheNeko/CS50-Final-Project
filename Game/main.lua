io.stdout:setvbuf("no")

Object = require "Game.Engine.classic"
require "Game.Engine.helpers"
require "Game.Engine.tilemap"
require "Game.Engine.prop"
require "Game.Engine.textui"
require "Game.Engine.gameobject"
require "Game.Scripts.player"
require "Game.Scripts.spikes"
require "Game.Scripts.rock"

local Grid = {
                {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
                {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
                {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
                {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
                {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
                {3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
                {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
             }

function love.load() 
    love.profiler = require('Game.Engine.profile') 
    love.profiler.start()


    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0, 0.66, 0)
    Objects = {}
    ObjectsToDestroy = {}
    
    Tiles = TileMap("Assets/TileMap.png",64,64,4,8,1)
    PlayerTiles = TileMap("Assets/MainCharacterAnim.png",64,64,4,8,1)
    Player = Player("Player", "character", PlayerTiles, 1, 1, 1, 0, 0, 0, true, true, 24, 10, true, 1)
    table.insert(Objects,Player)
    size = 64
    width = 6
    height = 6
    --for i = -size * width, size * width, size do
    --    for j = -size * height, size * height, size do
    --        if math.abs(i) == size * width or math.abs(j) == size * height then
    --            table.insert(Objects,GameObject("Box", "box", Tiles, 4, 1, 1, i, j, 0, false, true, 64, 64, true, j))    
    --        end
    --    end
    --end 
    table.insert(Objects, Spike("SpikeTrap", "spikes",  Tiles, 5, 1, 1, 128, 128, 0, true, false, Tiles.tileWidth, 28, true, 128))   
    table.insert(Objects, Spike("SpikeTrap", "spikes",  Tiles, 5, 1, 1, -128, -128, 0, true, false, Tiles.tileWidth, 28, true, -128))
    table.insert(Objects, Rock("Rock", "rocks",  Tiles, 7, 1, 1, -128, 128, 0, false, true, 54, 20, true, 128))   
    table.insert(Objects, Rock("Rock", "rocks",  Tiles, 7, 1, 1, 128, -128, 0, false, true, 54, 20, true, -128))
    Text = TextUI("Title", "text",  "The Game",100, 5, 5, WindowWidth/2, 100, 0, true, 0)
    Text:SetColor(100,255,200,255)
    table.insert(Objects, Text)
end


--Debug
love.frame = 0
--/Debug


function love.update(dt)


--Debug
    love.frame = love.frame + 1
    if love.frame%100 == 0 then
      love.report = love.profiler.report(20)
      love.profiler.reset()
    end
--/Debug

    DeltaTime = dt
    for i=#Objects,1,-1 do
        if not Objects[i].hasCollision or Objects[i].isUI then
            goto next
        end
        for j=i-1,1,-1 do
            if not Objects[j].hasCollision or Objects[i] == Objects[j] then
                goto continue
            end
            local temp = TableContains(Objects[i].collisionMatrix, Objects[j])
            if CheckCollision(Objects[i],Objects[j]) then
                if temp == 0 then
                    table.insert(Objects[i].collisionMatrix, Objects[j])
                    table.insert(Objects[j].collisionMatrix, Objects[i])
                    Objects[i]:collisionEnter(Objects[j])
                    Objects[j]:collisionEnter(Objects[i])
                end
                Objects[i]:isColliding(Objects[j])
                Objects[j]:isColliding(Objects[i])
            elseif temp ~= 0 then
                table.remove(Objects[i].collisionMatrix, temp)
                local temp2 = TableContains(Objects[j].collisionMatrix, Objects[i])
                if temp2 ~= 0 then
                    table.remove(Objects[j].collisionMatrix, temp2)
                end
                Objects[i]:collisionExit(Objects[j])
                Objects[j]:collisionExit(Objects[i])
            end
            ::continue::
        end
        ::next::
    end
    for x, Object in ipairs(Objects) do
        Object:update(dt)
    end
    for x, ObjectToDestroy in ipairs(ObjectsToDestroy) do
        if not ObjectToDestroy.isUI then
            CleanCollisions(ObjectToDestroy, false)
        end
        local temp = TableContains(Objects, ObjectToDestroy)
        table.remove(Objects, temp)
    end
    collectgarbage()
end



function love.draw()
    love.graphics.scale(1)
    love.graphics.push()
    love.graphics.translate(-Player.xPos + WindowWidth/2, -Player.yPos +  WindowHeight/2)
    Tiles:draw(Grid,-12*64,-12*64)
    for i=#Objects,1,-1 do
        if not Objects[i].isUI then
            Objects[i]:draw()


--Debug
            --CheckCollision(Objects[i], Objects[i])
--/Debug


        end
    end
    love.graphics.pop()


--Debug
    love.graphics.print(love.report or "Please wait...")
--/Debug


    for i = #Objects, 1, -1 do
        if Objects[i].isUI then
            Objects[i]:draw()
        end
    end
end