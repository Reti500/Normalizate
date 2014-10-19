local composer = require( "composer" )
local widget = require( "widget" )

local actionbar = {}
local objects = {}

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY
local backgroundMenu = nil
local actionbarGroup = nil
local max_tam = _H*0.1

actionbar.getHeigth = function()
    return max_tam
end

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
    actionbarGroup = display.newGroup()

    objects.searchField = native.newTextField( _W*0.43, _H*0.05, _W*0.8, _H*0.07 )
    objects.searchField:addEventListener( "userInput", textListener )
    objects.searchField.placeholder = "Buscar"
    objects.searchField:setReturnKey("search")
    -- -- Create the widget
    objects.searchButton = widget.newButton
    {
        id = "searchButton",
        label = "B",
        onEvent = handleButtonEvent,
        width = objects.searchField.width*0.20,
        height = objects.searchField.height
    }
    objects.searchButton.x = _W*0.5+objects.searchField.width*0.5
    objects.searchButton.y = objects.searchField.y

    actionbarGroup:insert( objects.searchField )
    actionbarGroup:insert( objects.searchButton )

    actionbarGroup:toBack()

    group:insert( actionbarGroup )
end
--------------------------------End Functions-------------------------------------------------------------------



--------------------------------------------------------------------------------
return actionbar