io.stdout:setvbuf("no")

Object = require "classic"
require "prop"
require "textui"
require "gameobject"
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
    love.profiler = require('profile') 
    love.profiler.start()


    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0, 0.66, 0)
    Objects = {}
    ObjectsToDestroy = {}
    
    Tiles = TileMap("Assets/TileMap.png",64,64,4,8,3)
    PlayerTiles = TileMap("Assets/MainCharacterAnim.png",64,64,4,8,1)
    Player = Player("Player", "character", PlayerTiles, 1, 2, 2, 0, 0, 0, true, true, 50, 20, true, 1)
    Player.colliderXDisplace = 14 
    Player.colliderYDisplace = 88
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
    table.insert(Objects, GameObject("SpikeTrap", "spikes",  Tiles, 5, 1, 1, 128, 128, 0, true, false, 64, 64, true, 128))   
    table.insert(Objects, GameObject("SpikeTrap", "spikes",  Tiles, 5, 1, 1, -128, -128, 0, true, false, 64, 64, true, -128))  
    table.insert(Objects, GameObject("Rock", "rocks",  Tiles, 6, 1, 1, -128, 128, 0, false, true, 64, 64, true, 128))   
    table.insert(Objects, GameObject("Rock", "rocks",  Tiles, 6, 1, 1, 128, -128, 0, false, true, 64, 64, true, -128))
    Text = TextUI("Title", "text",  "The Game",100, 5, 5, WindowWidth/2, 100, 0, true, 0)
    Text:SetColor(100,255,200,255)
    table.insert(Objects, Text)
end

love.frame = 0

function love.update(dt)
    love.frame = love.frame + 1
    if love.frame%100 == 0 then
      love.report = love.profiler.report(20)
      love.profiler.reset()
    end


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
    Tiles:draw(Grid,-600,-800)
    for i=#Objects,1,-1 do
        if not Objects[i].isUI then
            Objects[i]:draw()
            --CheckCollision(Objects[i], Objects[i])
        end
    end
    love.graphics.pop()

    love.graphics.print(love.report or "Please wait...")

    for i = #Objects, 1, -1 do
        if Objects[i].isUI then
            Objects[i]:draw()
        end
    end
end