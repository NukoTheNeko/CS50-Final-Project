local Player = require("player")
local Objects = {}

function love.load()
    table.insert(Objects,Player)
    table.insert(Objects,CreateObject(10,10,200,200))
    table.insert(Objects,CreateObject(10,10,300,300))
    table.insert(Objects,CreateObject(10,10,300,200))
    table.insert(Objects,CreateObject(10,10,200,300))
end

function love.update(dt)
    if love.keyboard.isDown("return") then
        Player.SetPosition(100,100)
    end

    local xMovement = 0
    local yMovement = 0

    if love.keyboard.isDown("a") then
        xMovement = xMovement - Player.speed * dt
    end
    if love.keyboard.isDown("d") then
        xMovement = xMovement + Player.speed * dt
    end
    if love.keyboard.isDown("w") then
        yMovement = yMovement - Player.speed * dt
    end
    if love.keyboard.isDown("s") then
        yMovement = yMovement + Player.speed * dt
    end

    Player.Move(xMovement,yMovement)
end

function love.draw()
    for index, value in ipairs(Objects) do
        love.graphics.circle("fill", value.x, value.y, value.width, value.height)
    end
end

function CreateObject(height, width, x, y)
    local object = {}
    object.height = height
    object.width = width
    object.x = x
    object.y = y
    return object
end

