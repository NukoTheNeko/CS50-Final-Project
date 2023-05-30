function love.load()
    myCircle = {};
    myCircle.height = 20;
    myCircle.width = 20;
    myCircle.x = 100;
    myCircle.y = 100;
    speed = 100;
end

function love.update(dt)
    if love.keyboard.isDown("return") then
        myCircle.x = 100;
        myCircle.y = 100;
    end

    movement = speed * dt

    if love.keyboard.isDown("a") then
        myCircle.x = myCircle.x - movement;
    end
    if love.keyboard.isDown("d") then
        myCircle.x = myCircle.x + movement;
    end
    if love.keyboard.isDown("w") then
        myCircle.y = myCircle.y - movement;
    end
    if love.keyboard.isDown("s") then
        myCircle.y = myCircle.y + movement;
    end
end

function love.draw()
    love.graphics.circle("fill", myCircle.x, myCircle.y, myCircle.width, myCircle.height)
end