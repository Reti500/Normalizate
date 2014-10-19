local actionbar = {}
local composer = require( "composer" )
local widget = require( "widget" )

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY
local backgroundMenu 


local function textListener( event )

    if ( event.phase == "began" ) then

        -- user begins editing text field
        print( event.text )

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then

        -- text field loses focus
        -- do something with defaultField's text
        print( "Submitted text: " .. event.target.text )

    elseif ( event.phase == "editing" ) then

        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )

    end
end

actionbar.create = function (group)
    
    actionbar.searchField = native.newTextField( _W*0.43, _H*0.05, _W*0.8, _H*0.07 )
    actionbar.searchField:addEventListener( "userInput", textListener )
    actionbar.searchField.placeholder = "Buscar"
    actionbar.searchField:setReturnKey("search")
    -- -- Create the widget
    local searchButton = widget.newButton
    {
        id = "searchButton",
        label = "B",
        onEvent = handleButtonEvent,
        width = actionbar.searchField.width*0.20,
        height = actionbar.searchField.height
    }
    searchButton.x = _W*0.5+actionbar.searchField.width*0.5
    searchButton.y = actionbar.searchField.y

    actionbar.searchButton = searchButton

    group:insert(actionbar.searchField)
    group:insert(actionbar.searchButton)
end
--------------------------------End Functions-------------------------------------------------------------------



--------------------------------------------------------------------------------
return actionbar