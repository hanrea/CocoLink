--音乐与音效播放
module("Audio", package.seeall)

local sharedEngine = SimpleAudioEngine:sharedEngine()
local soundList = {}

function start(  )
    CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateTime, 0.07, false)
end

function endAudio(  )
    CCSUtils:shareCCSUtils():endAudio()
end

function updateTime(  )
    for k,v in pairs(soundList) do
        k = pickFile(k)
        sharedEngine:playEffect(k, false)
    end
    soundList = {}
end


function pickFile( filename )
    if TARGET_PLATFORM == kTargetIphone or TARGET_PLATFORM == kTargetIpad then
        return string.format("music/%s.aac", filename)
    elseif TARGET_PLATFORM == kTargetAndroid then
        return string.format("android-music/%s.ogg", filename)
    end
    -- kTargetWindows,kTargetMacOS,
    return nil
end
--加载背景音乐
function preloadMusic(filename)
    if not LocalData.getMusicEnable() then
        return
    end

    filename=pickFile(filename)
    if filename==nil then
        return
    end
    sharedEngine:preloadBackgroundMusic(filename)
end
--播放背景音乐
function playMusic(filename, isLoop)
    if not LocalData.getMusicEnable() then
        return
    end
    
    filename=pickFile(filename)
    if filename==nil then
        return
    end
    if type(isLoop) ~= "boolean" then isLoop = true end
    stopMusic(true)
    sharedEngine:playBackgroundMusic(filename, isLoop)
end

function getMusicVolume()
    return sharedEngine:getBackgroundMusicVolume()
end

function setMusicVolume(volume)
    sharedEngine:setBackgroundMusicVolume(volume)
end

function getSoundsVolume()
    return sharedEngine:getEffectsVolume()
end

function setSoundsVolume(volume)
    sharedEngine:setEffectsVolume(volume)
end

function stopMusic(isReleaseData)
    if type(isReleaseData) ~= "boolean" then isReleaseData = false end
    sharedEngine:stopBackgroundMusic(isReleaseData)
end

function pauseMusic()
    sharedEngine:pauseBackgroundMusic()
end

function resumeMusic()
    sharedEngine:resumeBackgroundMusic()
end

function rewindMusic()
    ending:rewindBackgroundMusic()
end

function willPlayMusic()
    return sharedEngine:willPlayBackgroundMusic()
end

function isMusicPlaying()
    return sharedEngine:isBackgroundMusicPlaying()
end

--加载音效
function preloadSound(filename)
    if not LocalData.getEffectEnable() then
        return
    end

    filename=pickFile(filename)
    if filename==nil then
        return
    end
    sharedEngine:preloadEffect(filename)
end
--播放音效
function playSound(filename, isLoop)
    if LocalData.getEffectEnable() then
        soundList.filename = {}
    end
end

function pauseSound(handle)
    sharedEngine:pauseEffect(handle)
end

function pauseAllSounds()
    sharedEngine:pauseAllEffects()
end

function resumeSound(handle)
    sharedEngine:resumeEffect(handle)
end

function resumeAllSounds(handle)
    sharedEngine:resumeAllEffects()
end

function stopSound(handle)
    sharedEngine:stopEffect(handle)
end

function stopAllSounds()
    sharedEngine:stopAllEffects()
end

function unloadSound(filename)
    sharedEngine:unloadEffect(filename)
end
