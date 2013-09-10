local snd = require ("SoundCache")
local sh = require ( "KendersLib.spriteHelper" )

local scene = storyboard.newScene ()

scene.title = "Menu"

local function buttonImage ( params )
    local touchFunction = params.touchFunction
    local releaseFunction = params.releaseFunction
    local outFunction = params.outFunction
    local stateFunction = params.stateFunction
    local x = params.x
    local y = params.y
    local dir = params.dir
    local frames = params.frames
    local parent = params.parent
    
    if dir ~= nil then
        for _, f in pairs ( frames ) do
            frames [ _ ] = dir .. f
        end
    end
    
    local img = sh.spriteForFrames ( frames )
    img.state = 1
    function img:setState ( state ) 
        self.state = state
        if state <= #frames and state > 0 then
            self:setFrame ( state )
        end
        if ( stateFunction ) then
            stateFunction ( state )
        end
    end
    function img:touch ( event )
        if ( event.phase == "began" ) then
	        display.getCurrentStage():setFocus(self)
            if ( touchFunction ) then
                touchFunction ( event )
            end
        end
        if ( event.phase == "ended" ) then
            if ( isPointInRect ( event, self.contentBounds ) and releaseFunction ) then
                releaseFunction ( event )
            elseif ( outFunction ) then
                outFunction ( event )
            end
            display.getCurrentStage():setFocus(nil)
        end
    end
    
    img:addEventListener ( "touch", img )
    img.x, img.y = x, y
    if parent then
        parent:insert ( img )
    end
    return img
end

local function goToPlay ()
    storyboard.pushScene ( "menu", { effect = "slideDown" })
end

function scene:createScene ( event )
    sh.loadSheets ( {{ "assets.Spritesheets.menuitems", "assets/Spritesheets/menuitems.png" }, })
    
    local view = display.newGroup ()
    scene.group = view
    local bg = display.newImageRect( view, "Default.png", 570, 384)
    bg.x, bg.y, bg.z = 240, 160, 1
    
    -- buttons
    start = buttonImage ({
        frames = {"start-button", "start-button2"},
        parent = view,
        x = 377,
        y = 98,
        touchFunction = function ( ev )
        end,
        releaseFunction = function ( ev )
            goToPlay ()
        end,
        outFunction = function ( ev )
        end,
    })    
    
    zSort ( view )
        
end

function scene:enterScene ( event )
    storyboard.purgeScene ( "titlescreen" )
    local view = scene.group
end

scene:addEventListener ( "createScene" )
scene:addEventListener ( "enterScene" )

return scene