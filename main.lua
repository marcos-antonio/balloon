-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local background = display.newImageRect("background.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local platform = display.newImageRect( "platform.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

local balloon = display.newImageRect( "balloon.png", 112, 112 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

local physics = require( "physics" )
physics.start()

physics.addBody( platform, "static" )
physics.addBody( balloon, "dynamic", { radius=55, bounce=0.3 } )

local function myTouchListener( event )

    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus(event.target)
        print( "object touched = " .. tostring(event.target) )
    elseif ( event.phase == "moved" ) then
        print( "touch location in content coordinates = " .. event.x .. "," .. event.y )
    elseif ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        balloon:applyLinearImpulse( (balloon.x - event.x) * .005, (balloon.y - event.y) * .005, balloon.x, balloon.y )
        print(balloon.x, balloon.y, event.x, event.y)
        print( "touch ended on object " .. tostring(event.target) )
    end
    return true
end


balloon:addEventListener( "touch", myTouchListener )
