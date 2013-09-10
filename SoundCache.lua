module( ..., package.seeall )

local audioCacheTable = {}
local audiosPlaying = {}
local print = function()
end
function preloadSound(fileName)
	if audioCacheTable[fileName] ~= nil then
		print ("== audioCacheTable[", fileName, "] = ", audioCacheTable[fileName])
		return
	end
    print ("Adding to Sound Cache: ", fileName)
    snd = audio.loadSound(fileName)
    audioCacheTable[fileName] = snd
end
function playAudio(fileName, params)
    local onComplete = nil
	local volume = 1
	if (params==nil) then
		params = {}
	end
	
    if (params and params.onComplete) then
        onComplete = params.onComplete
    end
	if (params and params.volume) then
		volume = params.volume
	end
    local snd = audioCacheTable[fileName]
    if (snd == nil) then
		preloadSound(fileName)
		snd = audioCacheTable[fileName]
    end
	local onC = function(channel)
		if (onComplete) then
			onComplete()
		end
		audio.setVolume(1, {channel=channel})
		print ("channel ", channel, "back to volume 1")
	end
	local ch
    local channel = audio.play(snd, {loops = params.loops, onComplete = function()
		print ("ch", ch)
		onC(ch)
	end})
	ch = channel
	audio.setVolume(volume, {channel=ch})
	print ("Volume: "..volume..", channel: "..ch)
	return channel
end

function purgeAll()
    print ("purging sounds")
    for k, v in pairs(audioCacheTable) do
        audio.dispose(v)
        v = nil
    end
    audioCacheTable = {}
end

function playOneAudio(fileName, params)
	if (audiosPlaying[fileName] == nil) then
		audiosPlaying[fileName] = fileName
		local c = nil
		if (params and params.onComplete) then
			c = params.onComplete
		end
		local onC = function()
			audiosPlaying[fileName] = nil
			
			if (c) then
				c()
			end
		end
		if (params == nil) then
			params = {}
		end
		params.onComplete = onC
		return playAudio(fileName, params)
	else
		print("Skipping audio playing, as it's busy")
		return nil
	end
end
			

