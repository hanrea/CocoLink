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
    local node = ccs.SceneReader:getInstance():createNodeWithSceneFile("TriggerTest.json")
    cclog("createGameSceneend")
	return node
end

function TriggerTest:onTouchBegan(touch,event)
	cclog("onTouchBegan")
    ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHBEGAN)
	 ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_ALLTOUCH)
    return true
end

function TriggerTest:onTouchMoved(touch,event)
	cclog("onTouchMoved")
    ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHMOVED)
	 ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_ALLTOUCH)
end

function TriggerTest:onTouchEnded(touch,event)
	cclog("onTouchEnded")
    ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHENDED)
	 ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_ALLTOUCH)
end

function TriggerTest:onTouchCancelled(touch,event)
	cclog("onTouchCancelled")
    ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_TOUCHCANCELLED)
	 ccs.sendTriggerEvent(triggerEventDef.TRIGGEREVENT_ALLTOUCH)
end

function TriggerTest:onEnter()
	cclog("onenter")
    local root = self:createGameScene()
    if nil ~= root then
        self:addChild(root, 0, 1)
        self._touchListener = nil
        local listener = cc.EventListenerTouchOneByOne:create()
        listener:setSwallowTouches(true)
        listener:registerScriptHandler(self.onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
        listener:registerScriptHandler(self.onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
        listener:registerScriptHandler(self.onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
        listener:registerScriptHandler(self.onTouchCancelled,cc.Handler.EVENT_TOUCH_CANCELLED )
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
		
		local function onKeyBoardEvent(KeyCode)
			if KeyCode== KEY_F5 then
				cclog("f5ff5f5f5ff5f5f5f")
			end
		end
		layer:registerScriptHandler(onKeyBoardEvent,cc.EVENT_KEYBOARD)
    end
	cclog("creatend")
    return layer
end
-----------Trigger-------------


