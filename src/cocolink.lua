require "src/TriggerCode/acts"
require "src/TriggerCode/cons"
require "src/TriggerCode/eventDef"

-----------Trigger-------------
TriggerTest = class("TriggerTest")
print(TriggerTest) 
function TriggerTest.extend(target)
	
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, TriggerTest)
	cclog("extend")
    return target
end

function TriggerTest:createGameScene()
	cclog("createGameScene")
    local node = ccs.SceneReader:getInstance():createNodeWithSceneFile("res/publish/MainScene.json")
    cclog("createGameSceneend")
	return node
end

function TriggerTest:onEnter()
	cclog("onenter")
    local root = self:createGameScene()
    if nil ~= root then
        self:addChild(root, 0, 1)
        self._touchListener = nil
        local listener = cc.EventListenerTouchOneByOne:create()
        listener:setSwallowTouches(true)
			
		local function onTouchBegan(touch,event)
			cclog("touchbegin")
            ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHBEGAN,touch)
            return true
        end

        local function onTouchMoved(touch,event)
            ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHMOVED,touch)
        end

        local function onTouchEnded(touch,event)
            ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHENDED,touch)
        end

        local function onTouchCancelled(touch,event)
            ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHCANCELLED,touch)
        end

        listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
        listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
        listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
        listener:registerScriptHandler(onTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED )
        local eventDispatcher = self:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
        self._touchListener = listener
        local function update(dt)
            ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_UPDATESCENE)
        end
        self:scheduleUpdateWithPriorityLua(update,0)
        ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_ENTERSCENE)
    end
    
	----------------
end

function TriggerTest:onExit()
    ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_LEAVESCENE)
    self:unscheduleUpdate()
    local dispatcher = self:getEventDispatcher()
    dispatcher:removeEventListener(self._touchListener)
    ccs.TriggerMng.destroyInstance()
    ccs.ArmatureDataManager:destroyInstance()
    ccs.SceneReader:destroyInstance()
    ccs.ActionManagerEx:destroyInstance()
    ccs.GUIReader:destroyInstance()
end

function TriggerTest.create()
    local layer = TriggerTest.extend(cc.Layer:create())

    if nil ~= layer then
        local function onNodeEvent(event)
			cclog("event")
            if "enter" == event then
                layer:onEnter()
            elseif "exit" == event then
                layer:onExit()
            end
        end
        layer:registerScriptHandler(onNodeEvent)
		--键盘监听事件
		local function onKeyReleased(keyCode, event)
            local label = event:getCurrentTarget()
            if keyCode == cc.KeyCode.KEY_F5 then
				package.loaded["src/cocolink.lua"] = nil  
				require("src/cocolink.lua")
				cclog("f555555555555")
            end
        end
        local listener = cc.EventListenerKeyboard:create()
        listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )
		
		local eventDispatcher = layer:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
    end
	cclog("creatend")
    return layer
end
-----------Trigger-------------


