
application = {
    launchPad = false,
    
	content = {
		width = 320,
		height = 480, 
		scale = "letterBox",
		fps = 30,
        imageSuffix = {
		    ["@2x"] = 1.7,
		    ["@4x"] = 3.5,
		}
	},

    --[[
    -- Push notifications

    notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert", "newsstand"
            }
        }
    }
    --]]    
}
