-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local perspective = require("perspective")
local camera = perspective.createView()

display.setStatusBar(display.HiddenStatusBar)

local background = display.newImageRect("bg.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local chao = display.newImageRect( "platform.png", 300, 50 )
chao.x = display.contentCenterX
chao.y = display.actualContentHeight-20

local randomPlat = display.newImageRect( "platform.png", 120, 50 )
randomPlat.x = 70
randomPlat.y = display.actualContentHeight - 120


local randomPlat2 = display.newImageRect( "platform.png", 120, 50 )
randomPlat2.x = display.contentCenterX + 80
randomPlat2.y = display.actualContentHeight - 250

local paredeDir = display.newRect(display.actualContentWidth, display.actualContentHeight, 0, 98000)

local paredeEsq = display.newRect(0, display.actualContentHeight, 0, 98000)

local balloon = display.newImageRect( "balloon.png", 48, 48 )
balloon.x = display.contentCenterX + 100
balloon.y = display.contentCenterY + display.contentCenterY / 1.5
balloon.alpha = 0.8

camera:add(balloon, 1) -- Add player to layer 1 of the camera
camera:add(background, 2)
camera:add(randomPlat, 2)
camera:add(randomPlat2, 2)
camera:prependLayer()
camera:setParallax(1, 0.9)

local physics = require( "physics" )
physics.start()

physics.addBody( chao, "static" )
physics.addBody( randomPlat, "static" )
physics.addBody( randomPlat2, "static" )
physics.addBody( paredeDir, "static" )
physics.addBody( paredeEsq, "static" )
physics.addBody( balloon, "dynamic", { radius=24, bounce=0.0, friction=1 } )

balloon.gravityScale = 1
balloon.isFixedRotation = true

local function myTouchListener( event )

    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus(event.target)
        print( "object touched = " .. tostring(event.target) )
    elseif ( event.phase == "moved" ) then
        print( "touch location in content coordinates = " .. event.x .. "," .. event.y )
    elseif ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        balloon:applyLinearImpulse( (balloon.x - event.x) * .004, (balloon.y - event.y) * .002, balloon.x, balloon.y )
        print(balloon.x, balloon.y, event.x, event.y)
        print( "touch ended on object " .. tostring(event.target) )
    end
    return true
end


local function onBalloonPreCollision(event)
    if ((event.other.y) < event.target.y) then
        event.contact.isEnabled = false
    end
end

balloon:addEventListener("preCollision", onBalloonPreCollision)
balloon:addEventListener( "touch", myTouchListener )
camera.damping = 10
camera:setFocus(balloon)
camera:track()