local slide_menu = {}
local composer = require( "composer" )
local widget = require( "widget" )

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY
local backgroundMenu 
local touchX = {}
local i = 1
local dir = false ---izquierda
local range = _W*0.07
local posInit = _W*1.25 -- _W*1.25
local isOpen = false
local group = display.newGroup()
local offset = _W *0.15
local myRectangle = nil
slide_menu.move = true
------------Functions.-----------------------------------------------------------------------
local listener1 = function( obj )
   --print( "Cerro")
end

local function moveListener(event)
   if slide_menu.move then
       if event.phase == "moved" then
          
            local dx = math.abs( event.x - event.xStart ) 

            i = i + 1
            touchX[1] = event.xStart
            touchX[i] = event.x

            if touchX[i-1] < touchX[i] then            
                print("----->derecha") 
                dir = true         
                group.x  = group.x+4.5
                
            elseif touchX[i-1] > touchX[i] then            
                print("<-----izquierda")
                dir = false
                print(group.x,_W*0.5)
                if group.x <= -_W*0.5 then

                else
                    print("putos.."..group.x)
                    group.x  = group.x-4.5
                end          
            end
            
        elseif event.phase == "ended" then
            i = 1
            if math.abs(event.xStart-event.x) > range and dir then
                print("cerrar")
                listenersButtons(true)
                isOpen = false
                slide_menu.close()
            elseif math.abs(event.xStart-event.x) > range and  dir == false then
                print("abrir")
                listenersButtons(false)
                isOpen = true
                slide_menu.open()
            else 
                print("normal")
                if group.x > -_W*0.25 then--cerrar
                    isOpen = false   
                    slide_menu.close()
                elseif (event.xStart == event.x and event.target.id == "close") and isOpen then
                    print("puto")
                    isOpen = false
                    slide_menu.close()
                elseif group.x > -_W*0.5  then
                    isOpen = true 
                    slide_menu.open()
                end
            end        
        end
    end
end

slide_menu.create = function (sceneGroup)
   
    
    myRectangle = display.newRect( _W*0.5, _H*0.5, _W, _H )  
    myRectangle:setFillColor( 0.5 )
    myRectangle.alpha = 0.01  
    myRectangle:addEventListener("touch",moveListener)

    -- local close = display.newRect( _W*0.75, _H*0.5, _W*0.5, _H )  
    -- close:setFillColor( 0.5 )
    -- close.alpha = 1 
    -- close.id = "close"
   -- close:addEventListener( "touch", moveListener )   

    backgroundMenu = display.newImageRect( "images/slide_menu/background@2x.png", _W*0.5, _H)
    backgroundMenu.x = posInit
    backgroundMenu.y = _H*0.6 
    backgroundMenu.anchorX = 0.5
    backgroundMenu:toFront()    

    imageProfile = display.newImageRect( "Icon@2x.png", backgroundMenu.width, _H*0.25)
    imageProfile.x = posInit
    imageProfile.y = _H*0.22 
    imageProfile.anchorX = 0.5
    imageProfile:toFront()

    chatIcon = display.newImageRect( "Icon-hdpi.png", _W*0.13, _W*0.13)
    chatIcon.x = posInit - offset
    chatIcon.y =  _H*0.4 

    chatButton = widget.newButton
    {
        id = "chatButton",
        label = "Chat",
        onEvent = handleButtonEvent,
        width = _W*0.35,
        height = _W*0.15
    }
    chatButton.x = chatIcon.x+(offset*1.3)
    chatButton.y = chatIcon.y

    
    foroIcon = display.newImageRect( "Icon-hdpi.png", _W*0.13, _W*0.13)
    foroIcon.x = posInit - offset
    foroIcon.y = _H*0.48  

    foroButton = widget.newButton
    {
        id = "foroButton",
        label = "Foros",
        onEvent = handleButtonEvent,
        width = _W*0.35,
        height = _W*0.15
    }
    foroButton.x = foroIcon.x+(offset*1.3)
    foroButton.y = foroIcon.y



    favoriteIcon = display.newImageRect( "Icon-hdpi.png", _W*0.13, _W*0.13)
    favoriteIcon.x = posInit - offset
    favoriteIcon.y = _H*0.56 

    favoritesButton = widget.newButton
    {
        id = "favoritesButton",
        label = "Favoritos",
        onEvent = handleButtonEvent,
        width = _W*0.35,
        height = _W*0.15
    }
    favoritesButton.x = favoriteIcon.x+(offset*1.3)
    favoritesButton.y = favoriteIcon.y


    agendaIcon = display.newImageRect( "Icon-hdpi.png", _W*0.13, _W*0.13)
    agendaIcon.x = posInit - offset
    agendaIcon.y = _H*0.64     

    agendaButton = widget.newButton
    {
        id = "agendaButton",
        label = "Agenda",
        onEvent = handleButtonEvent,
        width = _W*0.35,
        height = _W*0.15
    }
    agendaButton.x = agendaIcon.x+(offset*1.3)
    agendaButton.y = agendaIcon.y   

    settingsIcon = display.newImageRect( "Icon-hdpi.png", _W*0.13, _W*0.13)
    settingsIcon.x = posInit - offset
    settingsIcon.y = _H*0.9 

    settingsButton = widget.newButton
    {
        id = "settingsButton",
        label = "Ajustes",
        onEvent = handleButtonEvent,
        width = _W*0.35,
        height = _W*0.15
    }
    settingsButton.x = settingsIcon .x+(offset*1.3)
    settingsButton.y = settingsIcon.y   
    

    group:insert( backgroundMenu )
    --group:insert( close )
    group:insert( imageProfile )
    group:insert( chatButton )
    group:insert( chatIcon )    
    group:insert( foroButton )
    group:insert( foroIcon )
    group:insert( favoritesButton )
    group:insert( favoriteIcon )
    group:insert( agendaButton )
    group:insert( agendaIcon )
    group:insert( settingsButton )
    group:insert( settingsIcon )

    --sceneGroup:insert(group)
end
slide_menu.open = function()
   -- transition.to( backgroundMenu, { time=200, x=_W*0.75, onComplete=listener1 } )
    transition.to( group, { time=200, x=-_W*0.5, onComplete=listener1 } )
end

slide_menu.close = function()
   -- transition.to( backgroundMenu, { time=200, x=_W*1.3, onComplete=listener1 } )
    transition.to( group, { time=200, x=0, onComplete=listener1 } )
end

--------------------------------End Functions-------------------------------------------------------------------



--------------------------------------------------------------------------------
return slide_menu