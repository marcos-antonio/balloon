-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local background = display.newImageRect("bg.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local chao = display.newImageRect( "platform.png", 300, 50 )
chao.x = display.contentCenterX
chao.y = display.actualContentHeight-20

local paredeDir = display.newRect(display.actualContentWidth, display.actualContentHeight, 0, 98000)

local paredeEsq = display.newRect(0, display.actualContentHeight, 0, 98000)

local balloon = display.newImageRect( "balloon.png", 48, 48 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

local physics = require( "physics" )
physics.start()

physics.addBody( chao, "static" )
physics.addBody( paredeDir, "static" )
physics.addBody( paredeEsq, "static" )
physics.addBody( balloon, "dynamic", { radius=25, bounce=0.0 } )

local function myTouchListener( event )

    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus(event.target)
        print( "object touched = " .. tostring(event.target) )
    elseif ( event.phase == "moved" ) then
        print( "touch location in content coordinates = " .. event.x .. "," .. event.y )
    elseif ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        balloon:applyLinearImpulse( (balloon.x - event.x) * .003, (balloon.y - event.y) * .003, balloon.x, balloon.y )
        print(balloon.x, balloon.y, event.x, event.y)
        print( "touch ended on object " .. tostring(event.target) )
    end
    return true
end


balloon:addEventListener( "touch", myTouchListener )
