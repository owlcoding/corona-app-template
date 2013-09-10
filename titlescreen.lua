
local scene = storyboard.newScene ()

local function tapNGo ( event )
    -- print ( event.name )
    -- printTable ( event )
    if event == nil or event.phase == "began" then
        storyboard.navigator:pushScene ( "menu", "crossFade" )
    end
end
scene.title = "Title Screen"

function scene:willEnterScene ( event )
    local view = scene.view
    local grp = display.newGroup ()
    scene.group = grp

    scene.group.bg = display.newImageRect( grp, "Default.png", 570, 384) -- this is the size of all devices :) 
    scene.group.bg.x, scene.group.bg.y, scene.group.bg.z = 240, 160, 1

    grp:addEventListener ( "touch", tapNGo )
    
    zSort ( scene.group )
end



function scene:exitScene ( event )
    display.remove ( scene.group )
    scene.group.bg = nil
    scene.group = nil
end


scene:addEventListener ( "willEnterScene" )
scene:addEventListener ( "exitScene" )
return scene