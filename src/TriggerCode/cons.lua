require ("CocoStudio")


------------
local TimeElapsed = class("TimeElapsed")
TimeElapsed._totalTime  = -1
TimeElapsed._tmpTime = nil
TimeElapsed._suc   = nil

function TimeElapsed:ctor()
    self._totalTime = -1
    self._tmpTime = nil
    self._suc   = nil

end

function TimeElapsed:init()
	local function update()
		_tmpTime += dt;
		if (self._tmpTime > _totalTime)
		{
			--self._tmpTime = 0.0f;
			self._suc = true;
		}
	end
	_scheduler->schedule(schedule_selector(self.update), this, 0.0f , kRepeatForever, 0.0f, false);
    return true
end

function TimeElapsed:detect(event,touch)

    return self._suc
end

function TimeElapsed:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "TotalTime" then
                self._totalTime = subDict["value"]
            end
        end
    end
end

function TimeElapsed:removeAll()
    print("TimeElapsed::removeAll")
end


------------
local ArmatureActionState = class("NodeInRect")
ArmatureActionState._tag  = -1
ArmatureActionState._comName = nil
ArmatureActionState._aniname   = nil
ArmatureActionState._state   = nil
ArmatureActionState._suc   = false


function ArmatureActionState:ctor()
    self._tag = -1
    self._comName = nil
    self._aniname   = nil
    
	self._state = nil
	self._suc = false
end

function ArmatureActionState:init()

	local pRender = ccs.SceneReader:getInstance():getNodeByTag(self._tag):getComponent(self._comName)
	local pAr  =pRender:getNode()
	if nil == pAr then
		return
	end
	
	local function animationEvent(armature,movementType,movementID)
		
		if movementType == self._state and movementID == self._aniname then
			self._suc = true
		end
	end
	ccs.TriggerMng:getInstance():addArmatureMovementCallBack(pAr, this, movementEvent_selector(ArmatureActionState::animationEvent));
	
    return true
end

function ArmatureActionState:detect(event,touch)
    return self._suc 
end

function ArmatureActionState:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "componentName" then
                self._comName = subDict["value"]
            elseif key == "AnimationName" then
                self._aniname = subDict["value"]
            elseif key == "ActionType" then
                self._state = subDict["value"]
            end
        end
    end
end

function ArmatureActionState:removeAll()
    print("ArmatureActionState::removeAll")
end




------------
local NodeInRect = class("NodeInRect")
NodeInRect._tag  = -1
NodeInRect._origin = nil
NodeInRect._size   = nil

function NodeInRect:ctor()
    self._tag = -1
    self._origin = nil
    self._size   = nil
    self._origin = cc.p(0, 0)
    self._size   = cc.size(0, 0)
end

function NodeInRect:init()
    return true
end

function NodeInRect:detect(event,touch)
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function NodeInRect:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "originX" then
                self._origin.x = subDict["value"]
            elseif key == "originY" then
                self._origin.y = subDict["value"]
            elseif key == "sizeWidth" then
                self._size.width = subDict["value"]
            elseif key == "sizeHeight" then
                self._size.height = subDict["value"]
            end
        end
    end
end

function NodeInRect:removeAll()
    print("NodeInRect::removeAll")
end




------------
local NodeVisible = class("NodeVisible")
NodeVisible._tag  = -1
NodeVisible._visible = false


function NodeVisible:ctor()
    self._tag = -1
    self._visible = false

end

function NodeVisible:init()
    return true
end

function NodeVisible:detect(event,touch)
    local pNode = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= pNode and pNode:isVisible() == self._visible  then
        return true
    end
    return false
end

function NodeVisible:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "Visible" then
                self._visible = subDict["value"]
            end
        end
    end
end

function NodeVisible:removeAll()
    print("NodeVisible::removeAll")
end

------------


未完成
local RectangleCollisionTest = class("RectangleCollisionTest")
RectangleCollisionTest._tag  = -1
RectangleCollisionTest._origin = nil
RectangleCollisionTest._size   = nil

function RectangleCollisionTest:ctor()
    self._tag = -1
    self._origin = nil
    self._size   = nil
    self._origin = cc.p(0, 0)
    self._size   = cc.size(0, 0)
end

function RectangleCollisionTest:init()
    return true
end

function RectangleCollisionTest:detect(event,touch)
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function RectangleCollisionTest:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag_A" then
                self._tag_A = subDict["value"]
            elseif key == "ComName_A" then
                self._comName_A = subDict["value"]
            elseif key == "AOffsetX" then
                self._aOffsetX = subDict["value"]
            elseif key == "AOffsetY" then
                self._aOffsetY = subDict["value"]
            elseif key == "Tags" then
                self._vecTags = subDict["value"]
			elseif key == "ComName_B" then
                self._comName_B = subDict["value"]
            elseif key == "BOffsetX" then
                self._bOffsetX = subDict["value"]
            elseif key == "BOffsetY" then
                self._bOffsetY = subDict["value"]
            end
        end
    end
end

function RectangleCollisionTest:removeAll()
    print("RectangleCollisionTest::removeAll")
end

---------------


local WidgetIsClick = class("WidgetIsClick")
WidgetIsClick._NodeTag  	= -1
WidgetIsClick._WidgetTag 	= nil
WidgetIsClick._WidgetName  	= nil

function WidgetIsClick:ctor()
    self._NodeTag 			= -1
    self._WidgetTag		= nil
    self._WidgetName	= nil
	self._WidgetTag		= -1
    self._WidgetName	= ""
end

function WidgetIsClick:init()
    return true
end

function WidgetIsClick:detect(event,touch)
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._NodeTag):getComponent("GUIComponent")
	local uilayer = node:getNode()
	local widget = nil
    if nil~= node then
		if -1 ~= self._WidgetTag then
			cclog("ttttttttt")
			widget=ccui.Helper:seekWidgetByTag(uilayer, self._WidgetTag)
		elseif nil ~= self._WidgetName then
			 widget=ccui.Helper:seekWidgetByName(uilayer, self._WidgetName)
		end
	end

	if nil~= widget then
		cclog("控件位置 X:%s ，Y：%s",widget:getPositionX(),widget:getPositionY()) 
		local touchpoint = touch:getLocation()
		local width =widget:getSize().width
		local height =widget:getSize().height
		if  touchpoint.x > widget:getPositionX()-width/2  and  touchpoint.x< widget:getPositionX()+width/2  and  touchpoint.y > widget:getPositionY()-height/2  and  touchpoint.y< widget:getPositionY()+height/2    then
			cclog("控件被点击")
			return true
		end
	end

    return false
end

function WidgetIsClick:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "NodeTag" then
                self._NodeTag = subDict["value"]
            elseif key == "WidgetTag" then
                self._WidgetTag = subDict["value"]
            elseif key == "WidgetName" then
                self._WidgetName = subDict["value"]
            end
        end
    end
end

function WidgetIsClick:removeAll()
    print("WidgetIsClick::removeAll")
end

------------

local TabelIsClick = class("TabelIsClick")
TabelIsClick._NodeTag  	= -1
TabelIsClick._WidgetTag 	= nil
TabelIsClick._WidgetName  	= nil

function TabelIsClick:ctor()
    self._NodeTag 		= -1
    self._WidgetTag		= nil
    self._WidgetName	= nil
	self._WidgetTag		= -1
    self._WidgetName	= ""
end

function TabelIsClick:init()
    return true
end

function TabelIsClick:detect(event,touch)
	
	clickTabel ={col=0 ,row=0}
	
	for i=1,8 do
	
		if touch:getLocation().x > 72+40*(i-1) then
			if touch:getLocation().x< 72+40*i then
			clickTabel["col"] = i
				break
			end
		end
	end
	
	for i=0,8 do
		if touch:getLocation().y < 14+40*(9-i) then
			if touch:getLocation().y > 14+40*(9-i-1) then
				clickTabel["row"] = i
				break
			end
		end
	end
	

	require "src/TriggerHelper"
	local clitab =getIndexTabel()
	cclog("上次点击的位置 【%s】【%s】",clitab["cliA"]["col"],clitab["cliA"]["row"])
	if clitab["cliA"]["col"]~=0 then
		setIndexTabelB(clickTabel)
		require "src/TriggerHelper"
		local tab= getLeaveTabel()
		require "src/link"
		local c1 = clitab["cliA"]["col"]
		local r1 =clitab["cliA"]["row"]
		local c2 =clickTabel["col"]
		local r2 =clickTabel["row"]

		if isConnection(tab,c1,r1,c2,r2) then
			setIndexTabelA({col=0 ,row=0})
			setIndexTabelB({col=0 ,row=0})
			tab[r1][c1]=0
			tab[r2][c2]=0
			setLeaveTabel(tab)
			cclog("识别成功，修改表格数据")
			return true
		else
			setIndexTabelA({col=0 ,row=0})
			setIndexTabelB({col=0 ,row=0})
			
		end
	else
		cclog("第一次点击，表格为空")
		setIndexTabelA(clickTabel)
	end
    return false
end

function TabelIsClick:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "NodeTag" then
                self._NodeTag = subDict["value"]
            elseif key == "WidgetTag" then
                self._WidgetTag = subDict["value"]
            elseif key == "WidgetName" then
                self._WidgetName = subDict["value"]
            end
        end
    end
end

function TabelIsClick:removeAll()
    print("TabelIsClick::removeAll")
end

ccs.registerTriggerClass("NodeInRect",NodeInRect.new)
ccs.registerTriggerClass("WidgetIsClick",WidgetIsClick.new)
ccs.registerTriggerClass("TabelIsClick",TabelIsClick.new)
