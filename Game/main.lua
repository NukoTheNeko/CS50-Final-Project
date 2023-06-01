Object = require "classic"
require "prop"
require "player"
require "helpers"

local Player = Player("Player", "character", "Assets/character.png", 0.1, 0.1, 100, 100, 0, true)
local Objects = {}

function love.load()
    table.insert(Objects,Player)
    table.insert(Objects,Prop("Rock1", "rock", "Assets/rock.png", 0.1, 0.1, 200, 200, 0, true))
    table.insert(Objects,Prop("Rock2", "rock", "Assets/rock.png", 0.1, 0.1, 200, 300, 0, true))
    table.insert(Objects,Prop("Rock3", "rock", "Assets/rock.png", 0.1, 0.1, 300, 200, 0, true))
    table.insert(Objects,Prop("Rock4", "rock", "Assets/rock.png", 0.1, 0.1, 300, 300, 0, true))
    Player:SetColor(123, 123, 255, 255)
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update(dt)
    for index, object in ipairs(Objects) do
        object:update(dt)
        for i = index + 1, #Objects do
            if CheckCollision(object,Objects[i]) and object.hasCollision and Objects[i].hasCollision then
                object:isColliding(Objects[i])
                Objects[i]:isColliding(object)
            end
        end
    end
end

function love.draw()
    for index, object in ipairs(Objects) do
        object:draw()
    end
end

