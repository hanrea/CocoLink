require "Cocos2d"
require "Cocos2dConstants"


-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end

	cc.FileUtils:getInstance():addSearchResolutionsOrder("src");
	cc.FileUtils:getInstance():addSearchResolutionsOrder("res");


local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
	cc.FileUtils:getInstance():addSearchResolutionsOrder("src");
	cc.FileUtils:getInstance():addSearchResolutionsOrder("res");
	local schedulerID = 0
    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or 
       (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
       (cc.PLATFORM_OS_MAC == targetPlatform) then
	   cclog("isstrat")
    end
    ---------------
	require "src/cocolink"
end

---------------------------背景音乐播放----------------------------------

    -- local bgMusicPath = nil 
    -- if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        -- bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("res/background.caf")
    -- else
        -- bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("res/background.mp3")
    -- end
    -- cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
    -- local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
    -- cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)

----------------------------内存使用输出----------------------------------------
local timeCount = 0
local function checkMemory(dt)
    timeCount = timeCount + dt
    local used = tonumber(collectgarbage("count"))
    cclog(string.format("[LUA] MEMORY USED: %0.2f KB, UPTIME: %04.2fs", used, timeCount))
end
--if DEBUG  then
    CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(checkMemory, 20.0, false)
--end
xpcall(main, __G__TRACKBACK__)
