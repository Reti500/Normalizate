local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local actionbar = require( "scripts.scenes.actionbar")
local db = require( "scripts.libs.db")

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY
local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

local table1 = {}
local search = nil

for i=1,100 do
    table1[i] = "hola "..i
end

------------Functions.-----------------------------------------------------------------------
local function Date( ... )
    local widget = require( "widget" )

    -- Create two tables to hold data for days and years      
    local days = {}
    local years = {}

    -- Populate the "days" table
    for d = 1, 31 do
        days[d] = d
    end

    -- Populate the "years" table
    for y = 1, 48 do
        years[y] = 1969 + y
    end

    -- Configure the picker wheel columns
    local columnData = 
    {
            -- Months
        { 
            align = "right",
            width = 140,
            startIndex = 5,
            labels = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
        },
        -- Days
        {
            align = "center",
            width = 60,
            startIndex = 18,
            labels = days
        },
        -- Years
        {
            align = "center",
            width = 80,
            startIndex = 10,
            labels = years
        }
    }

    -- Create the widget
    local pickerWheel = widget.newPickerWheel
    {
    top = display.contentHeight - 222,
    columns = columnData
    }

    -- Get the table of current values for all columns
    -- This can be performed on a button tap, timer execution, or other event
    local values = pickerWheel:getValues()

    -- Get the value for each column in the wheel (by column index)
    local currentMonth = values[1].value
    local currentDay = values[2].value
    local currentYear = values[3].value

    print( currentMonth, currentDay, currentYear )
end

local function tableView(sceneGroup,table)

    local keys = {
        [1] = "TITULO",
        [2] = "PRODUCTO"
    }

    local new_table = {}
    local arrayNMX = db.find_by("NMX", keys, search, nil, 10)
    local arrayNOM = db.find_by("NOM", keys, search, nil, 10)

    if #arrayNMX > 0 then

        for i=1, #arrayNMX do
            new_table[i] = arrayNMX[i]['TITULO']
        end

        -- table = new_table
    end

    if #arrayNOM > 0 then
        for i=1, #arrayNMX do
            new_table[i] = arrayNMX[i]['TITULO']
        end
    end

    if #new_table > 0 then
        table = new_table
    end

    local tableViewColors = {
        rowColor = { default = { 1 }, over = { 30/255, 144/255, 1 } },
        lineColor = { 220/255 },
        catColor = { default = { 150/255, 160/255, 180/255, 200/255 }, over = { 150/255, 160/255, 180/255, 200/255 } },
        defaultLabelColor = { 0, 0, 0, 0.6 },
        catLabelColor = { 0 }
    }
    tableViewColors.rowColor.default = { 48/255 }
    tableViewColors.rowColor.over = { 72/255 }
    tableViewColors.lineColor = { 36/255 }
    tableViewColors.catColor.default = { 80/255, 80/255, 80/255, 0.9 }
    tableViewColors.catColor.over = { 80/255, 80/255, 80/255, 0.9 }
    tableViewColors.defaultLabelColor = { 1, 1, 1, 0.6 }
    tableViewColors.catLabelColor = { 1 }

    local tableView

    -- Listen for tableView events
    local function tableViewListener( event )
        local phase = event.phase
       
        if event.phase == "ended" and table[event.target.index] ~= nil then
            print( "Event.phase is:", table[event.target.index] )
        end
    end
    -- Handle row rendering
    local function onRowRender( event )
        local phase = event.phase
        local row = event.row

        local groupContentHeight = row.contentHeight
        
        local rowTitle = display.newText( row, table[row.index], 0, 0, nil, 14 )
        rowTitle.x = 10
        rowTitle.anchorX = 0
        rowTitle.y = groupContentHeight * 0.5       
        rowTitle:setFillColor( unpack(row.params.defaultLabelColor) )       
    end
    
    -- Handle row updates
    local function onRowUpdate( event )
        local phase = event.phase
        local row = event.row
        --print( row.index, ": is now onscreen" )
    end
    
    -- Handle touches on the row
    local function onRowTouch( event )
        local phase = event.phase
        local row = event.target
        if ( "release" == phase ) then
        end
    end
    -- Create a tableView
    tableView = widget.newTableView
    {
        top = actionbar.getHeight(),
        left = -ox,
        width = display.contentWidth+ox+ox, 
        height = display.contentHeight,--+oy+oy-32,
        hideBackground = true,
        listener = tableViewListener,
        onRowRender = onRowRender,
        onRowUpdate = onRowUpdate,
        onRowTouch = onRowTouch,
    }
    sceneGroup:insert( tableView )

    local keys = {
        [1] = "TITULO",
        [2] = "PRODUCTO"
    }

    local arrayNMX = db.find_by("NMX", keys, search)
    local arrayNOM = db.find_by("NOM", keys, search)

    -- tableView:insertRow
    -- {
    --     isCategory = true,
    --     rowHeight = rowHeight,
    --     rowColor = rowColor,
    --     lineColor = tableViewColors.lineColor,
    --     params = v
    -- }
    -- for k,v in pairs(array) do
    --     local isCategory = false
    --     local rowHeight = 32
    --     local rowColor = { 
    --         default = tableViewColors.rowColor.default,
    --         over = tableViewColors.rowColor.over,
    --     }
    --     tableView:insertRow
    --     {
    --         isCategory = isCategory,
    --         rowHeight = rowHeight,
    --         rowColor = rowColor,
    --         lineColor = tableViewColors.lineColor,
    --         params = { defaultLabelColor=tableViewColors.defaultLabelColor, catLabelColor=tableViewColors.catLabelColor }
    --     }
    -- end

    -- Create 75 rows
    for i = 1,#table do
        local isCategory = false
        local rowHeight = 32
        local rowColor = { 
            default = tableViewColors.rowColor.default,
            over = tableViewColors.rowColor.over,
        }
        -- Insert the row into the tableView
        tableView:insertRow
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = tableViewColors.lineColor,
            params = { defaultLabelColor=tableViewColors.defaultLabelColor, catLabelColor=tableViewColors.catLabelColor }
        }
    end
end
--------------------------------End Functions-------------------------------------------------------------------

-----------------------------------Scenes Functions---------------------------------
function scene:create( event )
    local sceneGroup = self.view
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        search = event.params['search']
        tableView(sceneGroup,table1, search)
    elseif phase == "did" then
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
      
    elseif phase == "did" then
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
end
------------------------------End Funcitons--------------------------------------
---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------------
return scene