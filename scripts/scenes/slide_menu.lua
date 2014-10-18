local slide_menu = {}
local composer = require( "composer" )

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY
local backgroundMenu 

------------Functions.-----------------------------------------------------------------------
local listener1 = function( obj )
    print( "Cerro")
end

local function moveListener(event)
   if event.phase == "moved" then
        --event.target
        print("Move",event.x)
        print(backgroundMenu.width+_W*0.25 )
        if event.x < backgroundMenu.width+_W*0.25 then
        else
            backgroundMenu.x = event.x
        end
    elseif event.phase == "ended" then
        if event.x > _W*0.75 then--cerrar
            print("terminar")
            transition.to( backgroundMenu, { time=500, x=_W*1.22, onComplete=listener1 } )
        else

        end
    end
    print("Move",event.x)
end

slide_menu.create = function (sceneGroup)
    backgroundMenu = display.newImageRect( "images/slide_menu/background@2x.png", _W*0.5, _H)
    backgroundMenu.x = _W*0.75
    backgroundMenu.y = _H*0.5 
    backgroundMenu.anchorX = 0.5
    backgroundMenu:toFront()
    backgroundMenu:addEventListener( "touch", moveListener )
    sceneGroup:insert(backgroundMenu)
end
slide_menu.open = function()
    
end

slide_menu.close = function()

end
--------------------------------End Functions-------------------------------------------------------------------



--------------------------------------------------------------------------------
return slide_menu