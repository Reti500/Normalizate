local composer = require( "composer" )
local widget = require( "widget" )
local slide_menu = require ("scripts.scenes.slide_menu")
local scene = composer.newScene()

local _W = display.contentWidth
local _H = display.contentHeight
local halfW = display.contentCenterX
local halfH = display.contentCenterY

-----------Buttons----------
local starButton
local closeButton
local downloadButton
local canTouch = true
local canMove = true
local up,down
local offset = _W *0.2
local group = display.newGroup()


------------Functions.-----------------------------------------------------------------------

local function close(event)
    print("hola")
    if canTouch then
        canTouch = false
        slide_menu.move = true
        composer.hideOverlay( "fade", 400 )
    end
   
end

local function move( event )
    if canMove then
        canMove = false
        event.target:setLabel("hola")
        transition.to( group, { time=500, x=-_W} )
    end
end
local function inputListener( event )
    if event.phase == "began" then

        -- user begins editing textBox
        print( event.text )

    elseif event.phase == "ended" then

        -- do something with textBox's text
    end
end

local function addLayer_dependence(sceneGroup)

    local titleTxt = display.newText( "Búsqueda Por Dependencia", _W*0.5, _H*0.25,"Quicksand-Bold", 20 )
    titleTxt:setFillColor(1,1,1)   

    local product_id = display.newText( "Lista", _W*0.1, _H*0.35, "Quicksand-Bold", 17)
    product_id.anchorX = 0
    product_id:setFillColor( 1, 1,1 )

    local word_id = display.newText( "Búsqueda", _W*0.1, _H*0.5, "Quicksand-Bold", 17)
    word_id.anchorX = 0
    word_id:setFillColor( 1, 1,1 )

    list = widget.newButton
    {
        id = "agendaButton",
        label = "Selecciona...",
        onRelease = move,
        emboss = false,
        shape="rect",
        width =_W*0.4,
        height = _H*0.08,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    list.x = product_id.x+offset
    list.anchorX = 0
    list.y = product_id.y

    list2 = widget.newButton
    {
        id = "agendaButton",
        label = "Selecciona...",
        onRelease = move,
        emboss = false,
        shape="rect",
        width =_W*0.4,
        height = _H*0.08,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    list2.x = word_id.x+(offset*1.5)
    list2.anchorX = 0
    list2.y = word_id.y


  
    sceneGroup:insert(titleTxt)
    sceneGroup:insert(list)
    sceneGroup:insert(list2)
    sceneGroup:insert(product_id)
    sceneGroup:insert(word_id)
end

local function addLayer_advance(sceneGroup)

  
    local titleTxt = display.newText( "Búsqueda Avanzada", _W*0.5, _H*0.25, "Quicksand-Bold", 20 )
    titleTxt:setFillColor( 1, 1,1 )

    local dependence_id = display.newText( "Dependencia", _W*0.1, _H*0.35, "Quicksand-Bold", 17 )
    dependence_id.anchorX = 0
    dependence_id:setFillColor( 1, 1,1 )

    local product_id = display.newText( "Producto", _W*0.1, _H*0.45, "Quicksand-Bold", 17 )
    product_id.anchorX = 0
    product_id:setFillColor( 1, 1,1 )

    local word_id = display.newText( "Palabra", _W*0.1, _H*0.55, "Quicksand-Bold", 17 )
    word_id.anchorX = 0
    word_id:setFillColor( 1, 1,1 )


     list = widget.newButton
    {
        id = "agendaButton",
        label = "Selecciona...",
        onRelease = move,
        emboss = false,
        shape="rect",
        width =_W*0.4,
        height = _H*0.08,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    list.x = dependence_id.x+(offset*2)
    list.anchorX = 0
    list.y = dependence_id.y

    list2 = widget.newButton
    {
        id = "agendaButton",
        label = "Selecciona...",
        onRelease = move,
        emboss = false,
        shape="rect",
        width =_W*0.4,
        height = _H*0.08,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    list2.x = product_id.x+(offset*1.5)
    list2.anchorX = 0
    list2.y = product_id.y


    list3 = widget.newButton
    {
        id = "agendaButton",
        label = "Selecciona...",
        onRelease = move,
        emboss = false,
        shape="rect",
        width =_W*0.4,
        height = _H*0.08,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    list3.x = word_id.x+(offset*1.5)
    list3.anchorX = 0
    list3.y = word_id.y




    sceneGroup:insert(titleTxt)
    sceneGroup:insert(dependence_id)
    sceneGroup:insert(product_id)
    sceneGroup:insert(word_id)
    sceneGroup:insert(list)
    sceneGroup:insert(list2)
    sceneGroup:insert(list3)
end

local function addLayer_product(sceneGroup)
    
    local titleTxt = display.newText( "Busqueda Por Producto", _W*0.5, _H*0.25, "Quicksand-Bold", 20 )
    titleTxt:setFillColor( 1, 1,1)

    local dependence_id = display.newText( "Lista de Productos", _W*0.1, _H*0.34,"Quicksand-Bold", 17)
    dependence_id.anchorX = 0
    dependence_id:setFillColor( 1, 1,1 )


     list = widget.newButton
    {
        id = "agendaButton",
        label = "Selecciona...",
        onRelease = move,
        emboss = false,
        shape="rect",
        width =_W*0.4,
        height = _H*0.08,
        fillColor = { default={ 0.85882353,0.85882353,0.85882353, 0.5 }, over={ 0.85882353,0.85882353,0.85882353, 0.5 } },
        strokeColor = { default={ 0.7019, 0.101, 0.3450, 1 }, over={ 0.8, 0.8, 1, 1 } },
        strokeWidth = 2.5
    }
    list.x = _W*0.5
    
    list.y = dependence_id.y + offset

   
    sceneGroup:insert(titleTxt)
    sceneGroup:insert(dependence_id)
    sceneGroup:insert(list)
end

local function tableView(sceneGroup,table)

    local keys = {
        [1] = "TITULO",
        [2] = "PRODUCTO"
    }

    search = string.upper(search)
    local new_table = {}
    local arrayNMX = db.find_by("NMX", keys, search, nil, 5)
    local arrayNOM = db.find_by("NOM", keys, search, nil, 5)

    if #arrayNMX > 0 then
        for i=1, #arrayNMX do
            new_table[#new_table+1] = arrayNMX[i]
        end
    end

    if #arrayNOM > 0 then
        for i=1, #arrayNMX do
            new_table[#new_table+1] = arrayNMX[i]
        end
    end

    if #new_table > 0 then
        table = new_table
    else
        -- table = {
        --     [1] = {
        --         "TITULO" = "No hay resultados"
        --     }
        -- }
        table[1] = {
            TITULO = "No hay resultados"
        }
        print(#table)
        
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
        else
            composer.hideOverlay( "fade", 0 )
        end
    end
    -- Handle row rendering
    local function onRowRender( event )
        local phase = event.phase
        local row = event.row

        local groupContentHeight = row.contentHeight
        
        if (#table > 0) then
            print(#table)
            local rowTitle = display.newText( row, table[row.index]['TITULO'], 0, 0, nil, 14 )
            rowTitle.x = 10
            rowTitle.anchorX = 0
            rowTitle.y = groupContentHeight * 0.5       
            rowTitle:setFillColor( unpack(row.params.defaultLabelColor) )  
        end     
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
    print("create --one search.lua")
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local search_type = event.params.search_type
    print("type",params)
    if phase == "will" then 
        print("show will ---search") 
        canTouch = true
        canMove = true
        up = display.newRect( _W*0.5, _H*0.08, _W, _H*0.25)  
        up:setFillColor(0,0,0)
        up.alpha = 0.01
        up:addEventListener("touch",close)

        down = display.newRect( _W*0.5, _H*0.9, _W, _H*0.2)  
        down:setFillColor(0,0,0)
        down.alpha = 0.01
        down:addEventListener("touch",close)

        local back = display.newRect( _W*0.5, _H*0.5, _W, _H)  
        back:setFillColor(0.5)
        back.alpha = 0.8


        local background = display.newRoundedRect( _W*0.5, _H*0.5, _W*0.9, _H*0.6,12)  
        background:setFillColor(0.2666666667)  

         searchButton = widget.newButton
          {
        id = "search",
        defaultFile = "images/init/buscar.png",
        overFile = "images/init/buscar_push.png",
        onEvent = handleButtonEvent,
        width = _W*0.6,
        height = _W*0.1
         }
         searchButton.x = _W*0.5
         searchButton.y = _H*0.7 

        group:insert(up)
        group:insert(down)
        group:insert(back)
        group:insert(background)
        group:insert(searchButton)

      

        if search_type == "advance" then   
            addLayer_advance(group)
            --tableView(group,table)
        elseif search_type == "dependence" then
             addLayer_dependence(group)
        elseif search_type == "product" then
            addLayer_product(group)
        end
        slide_menu.move = false
        sceneGroup:insert(group)
          
    elseif phase == "did" then
        print("show did ---search")    
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
        print("hide will ---search")    
      
    elseif phase == "did" then
        print("hide did ---search")    
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
    print("destroy  ---search") 
    up:removeEventListener("touch",close)   
    down:removeEventListener("touch",close)   

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