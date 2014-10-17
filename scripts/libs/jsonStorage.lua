local json = require( "json" )

local jsonStorage = {}

jsonStorage.saveData = function(table,filename)	
	
	local path = system.pathForFile( filename..".txt", system.DocumentsDirectory )
	local file = io.open( path, "w" )
	file:write( table )

	io.close( file )
	file = nil
end

jsonStorage.openData= function(key,filename)
    
    key = key or "nil"

	local path = system.pathForFile( filename..".txt", system.DocumentsDirectory )

	local file = io.open( path, "r" )
	local jsonData = file:read( "*a" )    
	io.close( file )
	file = nil

    if key == "nil" then
        return jsonData
    else
    	local response = json.decode( jsonData )       
        local decode = response[key]
    	return decode
    end
end

jsonStorage.doesFileExist =  function( fname, path )

    local results = false
    local filePath = system.pathForFile( fname, path )
    --filePath will be 'nil' if file doesn't exist and the path is 'system.ResourceDirectory'
    if ( filePath ) then
        filePath = io.open( filePath, "r" )
    end

    if ( filePath ) then
        print( "File found: " .. fname )
        --clean up file handles
        filePath:close()
        results = true
    else
        print( "File does not exist: " .. fname )
    end

    return results
end

return jsonStorage