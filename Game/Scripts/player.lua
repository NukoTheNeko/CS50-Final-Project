Player = GameObject:extend()

function Player:new(name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    Player.super.new(self, name, tag, tilemap, targetTile, xScale, yScale, xPos, yPos, rotation, hasCollision, blocks, colliderXSize , colliderYSize, visible, zIndex)
    self.defaultSpeed = 250
    self.sprintSpeed = 400
    self.speed = self.defaultSpeed

    self.colliderXDisplace = (tilemap.tileWidth * xScale - colliderXSize)/2
    self.colliderYDisplace = tilemap.tileHeight * yScale - colliderYSize

    self.maxHealth = 100
    self.health = 100

    self.timer = 0
    self.timerLimit = 0

    self.canMove = true
    self.invincible = false

    self.slimeSlash = false
    self.slimeSlashDuration = 0.2
    self.gooDistance = 50
    self.goo = nil

    self.shockCharge = false
    self.shockChargeDuration = 0.2
    self.shockChargeSpeed = 1500

    self.fireBurst = false
    self.fireBurstDuration = 0.4
    self.fireBurstDistance = 50

    self.iceWave = false
    self.iceWaveDuration = 0.4
    self.iceWallDistance = 50
    self.iceWall = nil

    self:ChangeAnimation("downRegularIdle")
    self.slimeState = "Regular"
    self.direction = "down"


    --Regular
    self.animations["downRegularIdle"] = Animation(PlayerTiles,   1,   1,1,   1,1)
    self.animations["rightRegularIdle"] = Animation(PlayerTiles,   1,   1,1,   2,1)
    self.animations["leftRegularIdle"] = Animation(PlayerTiles,   1,   1,1,   3,1)
    self.animations["upRegularIdle"] = Animation(PlayerTiles,   1,   1,1,   4,1)

    self.animations["downRegular"] = Animation(PlayerTiles,   2,   1,2,   1,2)
    self.animations["rightRegular"] = Animation(PlayerTiles,   2,   1,2,   2,2)
    self.animations["leftRegular"] = Animation(PlayerTiles,   2,   1,2,   3,2)
    self.animations["upRegular"] = Animation(PlayerTiles,   2,   1,2,   4,2)

    self.animations["downRegularAbility"] = Animation(PlayerTiles,   4,   1,4,   1,4)
    self.animations["rightRegularAbility"] = Animation(PlayerTiles,   4,   1,4,   2,4)
    self.animations["leftRegularAbility"] = Animation(PlayerTiles,   4,   1,4,   3,4)
    self.animations["upRegularAbility"] = Animation(PlayerTiles,   4,   1,4,   4,4)
    


    --Shock
    self.animations["downShockIdle"] = Animation(PlayerTiles,   1,   1,1,   1,8)
    self.animations["rightShockIdle"] = Animation(PlayerTiles,   1,   1,1,   2,8)
    self.animations["leftShockIdle"] = Animation(PlayerTiles,   1,   1,1,   3,8)
    self.animations["upShockIdle"] = Animation(PlayerTiles,   1,   1,1,   4,8)

    self.animations["downShock"] = Animation(PlayerTiles,   2,   1,2,   1,9)
    self.animations["rightShock"] = Animation(PlayerTiles,   2,   1,2,   2,9)
    self.animations["leftShock"] = Animation(PlayerTiles,   2,   1,2,   3,9)
    self.animations["upShock"] = Animation(PlayerTiles,   2,   1,2,   4,9)

    self.animations["downShockAbility"] = Animation(PlayerTiles,   2,   1,2,   1,11)
    self.animations["rightShockAbility"] = Animation(PlayerTiles,   2,   1,2,   2,11)
    self.animations["leftShockAbility"] = Animation(PlayerTiles,   2,   1,2,   3,11)
    self.animations["upShockAbility"] = Animation(PlayerTiles,   2,   1,2,   4,11)
    


    --Fire
    self.animations["downFireIdle"] = Animation(PlayerTiles,   1,   1,1,   1,13)
    self.animations["rightFireIdle"] = Animation(PlayerTiles,   1,   1,1,   2,13)
    self.animations["leftFireIdle"] = Animation(PlayerTiles,   1,   1,1,   3,13)
    self.animations["upFireIdle"] = Animation(PlayerTiles,   1,   1,1,   4,13)

    self.animations["downFire"] = Animation(PlayerTiles,   2,   1,2,   1,14)
    self.animations["rightFire"] = Animation(PlayerTiles,   2,   1,2,   2,14)
    self.animations["leftFire"] = Animation(PlayerTiles,   2,   1,2,   3,14)
    self.animations["upFire"] = Animation(PlayerTiles,   2,   1,2,   4,14)
    
    self.animations["downFireAbility"] = Animation(PlayerTiles,   5,   1,5,   1,16)
    self.animations["rightFireAbility"] = Animation(PlayerTiles,   5,   1,5,   2,16)
    self.animations["leftFireAbility"] = Animation(PlayerTiles,   5,   1,5,   3,16)
    self.animations["upFireAbility"] = Animation(PlayerTiles,   5,   1,5,   4,16)



    --Ice
    self.animations["downIceIdle"] = Animation(PlayerTiles,   1,   1,1,   1,21)
    self.animations["rightIceIdle"] = Animation(PlayerTiles,   1,   1,1,   2,21)
    self.animations["leftIceIdle"] = Animation(PlayerTiles,   1,   1,1,   3,21)
    self.animations["upIceIdle"] = Animation(PlayerTiles,   1,   1,1,   4,21)

    self.animations["downIce"] = Animation(PlayerTiles,   2,   1,2,   1,22)
    self.animations["rightIce"] = Animation(PlayerTiles,   2,   1,2,   2,22)
    self.animations["leftIce"] = Animation(PlayerTiles,   2,   1,2,   3,22)
    self.animations["upIce"] = Animation(PlayerTiles,   2,   1,2,   4,22)
    
    self.animations["downIceAbility"] = Animation(PlayerTiles,   5,   1,5,   1,24)
    self.animations["rightIceAbility"] = Animation(PlayerTiles,   5,   1,5,   2,24)
    self.animations["leftIceAbility"] = Animation(PlayerTiles,   5,   1,5,   3,24)
    self.animations["upIceAbility"] = Animation(PlayerTiles,   5,   1,5,   4,24)

    self:Move(1,1)
end

function Player:collisionEnter(other)
    if other.tag =="rocks" then
        self:SetColor(255, 2, 2, 255)
    end
end

function Player:collisionExit(other)
    if other.tag =="rocks" then
        self:SetColor(255, 255, 255, 255)
    end
end

love.keypressed = function (k)
    if k=="x" and Player.canMove then
        Player.canMove = false
        Player.timer = 0
        if Player.slimeState == "Regular" then
            Player.timerLimit = Player.slimeSlashDuration 
            Player.slimeSlash = true
            Player.animationSpeed = 20
            if Player.goo == nil then
                local xChange = 0
                local yChange = 0
                if Player.direction == "down" then  
                    yChange = Player.gooDistance
                elseif Player.direction == "left" then  
                    xChange = -Player.gooDistance
                elseif Player.direction == "right" then  
                    xChange = Player.gooDistance
                elseif Player.direction == "up" then  
                    yChange = -Player.gooDistance
                end

                Player.goo = Goo("Goo", "goo", Tiles, 9, 1, 1, Player.xPos + xChange, Player.yPos + yChange, 0, true, false, 64, 64, true, 1)
                table.insert(Objects, Player.goo)
            end



        elseif Player.slimeState == "Shock" then
            Player.timerLimit = Player.shockChargeDuration
            Player.invincible = true
            Player.shockCharge = true
            Player.animationSpeed = 15



        elseif Player.slimeState == "Fire" then
            Player.timerLimit = Player.fireBurstDuration 
            Player.fireBurst = true
            Player.animationSpeed = 12.5

            local xChange = 0
            local yChange = 0
            if Player.direction == "down" then  
                yChange = Player.fireBurstDistance
            elseif Player.direction == "left" then  
                xChange = -Player.fireBurstDistance
            elseif Player.direction == "right" then  
                xChange = Player.fireBurstDistance
            elseif Player.direction == "up" then  
                yChange = -Player.fireBurstDistance
            end

            table.insert(Objects, Fire("Fire", "fire", Tiles, 10, 1, 1, Player.xPos + xChange, Player.yPos + yChange, 0, true, false, 54, 20, true, 1))



        elseif Player.slimeState == "Ice" then
            Player.timerLimit = Player.iceWaveDuration 
            Player.iceWave = true
            Player.animationSpeed = 12.5


            if Player.iceWall ~= nil then
                Player.iceWall:destroy()
            end


            local xChange = 0
            local yChange = 0
            if Player.direction == "down" then  
                yChange = Player.iceWallDistance
            elseif Player.direction == "left" then  
                xChange = -Player.iceWallDistance
            elseif Player.direction == "right" then  
                xChange = Player.iceWallDistance
            elseif Player.direction == "up" then  
                yChange = -Player.iceWallDistance
            end


            Player.iceWall = IceWall("IceWall", "icewall", Tiles, 11, 1, 1, Player.xPos + xChange, Player.yPos + yChange, 0, true, true, 54, 20, true, 1)
            table.insert(Objects, Player.iceWall)
        end
    end
end

function Player:update(dt)
    self.timer = self.timer + dt
    
    if self.timer > self.timerLimit and not self.canMove then
        self.canMove = true
        self.animationSpeed = 5
        if self.slimeSlash then
            self.slimeSlash = false
            if Player.goo.contact == nil then
                Player.goo:destroy()
            end
            Player.goo = nil
        elseif self.shockCharge then
            self.shockCharge = false
            self.invincible = false
        elseif self.fireBurst then
            self.fireBurst = false
        elseif self.iceWave then
            self.iceWave = false
        end
    end



    if love.keyboard.isDown("return") then
        self:destroy()
    end

    


    if love.keyboard.isDown("1") then
        self.slimeState = "Regular"
        if Player.iceWall ~= nil then
            --Player.iceWall:destroy()
        end
    elseif love.keyboard.isDown("2") then
        self.slimeState = "Shock"
        if Player.iceWall ~= nil then
            --Player.iceWall:destroy()
        end
    elseif love.keyboard.isDown("3") then
        self.slimeState = "Fire"
        if Player.iceWall ~= nil then
            --Player.iceWall:destroy()
        end
    elseif love.keyboard.isDown("4") then
        self.slimeState = "Ice"
    end

    local xMovement = 0
    local yMovement = 0

    if love.keyboard.isDown("lshift") then
        self.speed = self.sprintSpeed
    else
        self.speed = self.defaultSpeed
    end
    if not self.canMove then
        goto continue
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        xMovement = xMovement + self.speed * dt
        self.direction = "right"
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        xMovement = xMovement - self.speed * dt
        self.direction = "left"
    elseif love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        yMovement = yMovement - self.speed * dt
        self.direction = "up"
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        yMovement = yMovement + self.speed * dt
        self.direction = "down"
    end

::continue::

    local oldX = self.xPos
    local oldY = self.yPos

    if self.slimeSlash then
        self.ChangeAnimation(self, self.direction .. "RegularAbility")
    elseif self.shockCharge then
        self.ChangeAnimation(self, self.direction .. "ShockAbility")
        local changeX = 0
        local changeY = 0
        if self.direction == "right" then
            changeX = 1
            changeY = 0
        elseif self.direction == "left" then
            changeX = -1
            changeY = 0
        elseif self.direction == "up" then
            changeX = 0
            changeY = -1
        elseif self.direction == "down" then
            changeX = 0
            changeY = 1
        end
        xMovement = self.shockChargeSpeed * dt * changeX
        yMovement = self.shockChargeSpeed * dt * changeY
    elseif self.fireBurst then
        self.ChangeAnimation(self, self.direction .. "FireAbility")
    elseif self.iceWave then
        self.ChangeAnimation(self, self.direction .. "IceAbility")
    end

    self:Move(xMovement,yMovement)
    
    self.zIndex = self.yPos + self.yPivot - self.colliderYDisplace / 2

    if not self.canMove then
    elseif math.abs(oldX - self.xPos) < 0.01 and math.abs(oldY - self.yPos) < 0.01 then
        self.ChangeAnimation(self, self.direction .. self.slimeState  .. "Idle")
    else
        self.ChangeAnimation(self, self.direction .. self.slimeState)
    end
end

function Player:ChangeHealth(value)
    if self.invincible then
        goto continue
    end
    self.health = self.health + value

    if self.health > self.maxHealth then
        self.health = self.maxHealth
    end
    if self.health <= 0 then
        self.health = 0
        self:destroy()
    end
    ::continue::
end