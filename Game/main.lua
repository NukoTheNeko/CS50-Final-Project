io.stdout:setvbuf("no")

Object = require "classic"
require "prop"
require "player"
require "helpers"
require "tilemap"

local Player = Player("Player", "character", "Assets/anim.png", 3, 3, 100, 100, 0, true)
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
local Tiles = TileMap("Assets/tileset.png",16,16,0,0,3)

local Objects = {}

function love.load()
    table.insert(Objects,Player)
    table.insert(Objects,Prop("Rock1", "rock", "Assets/rock.png", 0.1, 0.1, 200, 200, 0, true))
    table.insert(Objects,Prop("Rock2", "rock", "Assets/rock.png", 0.1, 0.1, 200, 300, 0, true))
    table.insert(Objects,Prop("Rock3", "rock", "Assets/rock.png", 0.1, 0.1, 300, 200, 0, true))
    table.insert(Objects,Prop("Rock4", "rock", "Assets/rock.png", 0.1, 0.1, 300, 300, 0, true))
    love.graphics.setBackgroundColor(0, 0, 0)
end

function love.update(dt)
    DeltaTime = dt
    for i=#Objects,1,-1 do
        Objects[i]:update(dt)
        for j=#Objects-i,1,-1 do
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
    Tiles:draw(Grid,300,300)
    for i=#Objects,1,-1 do
        Objects[i]:draw()
    end
end