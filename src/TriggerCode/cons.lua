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
		 self._tmpTime =self._tmpTime+ dt;
		if self._tmpTime > _totalTime then
			cclog("self._tmpTime:  %s",self._tmpTime)
			self._suc = true;
		end
	end
	 CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(update, 0.0, false)
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
local ArmatureActionState = class("ArmatureActionState")
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
	
	local function animationEvent(armatureBack,movementType,movementID)
		if movementType == self._state and movementID == self._aniname then
			self._suc = true
		end
    end

    pAr:getAnimation():setMovementEventCallFunc(animationEvent)
	
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


--
local RectangleCollisionTest = class("RectangleCollisionTest")
RectangleCollisionTest._tag_A = -1
RectangleCollisionTest._comName_A = ""
RectangleCollisionTest._aOffsetX = 0
RectangleCollisionTest._aOffsetY = 0
RectangleCollisionTest._vecTags = -1
RectangleCollisionTest._comName_B = ""
RectangleCollisionTest._bOffsetX = 0
RectangleCollisionTest._bOffsetY = 0

function RectangleCollisionTest:ctor()
    self._tag_A = -1
	self._comName_A = ""
	self._aOffsetX = -1
	self._aOffsetY = -1
	self._vecTags = -1
	self._comName_B = ""
	self._bOffsetX = -1
	self._bOffsetY = -1

end

function RectangleCollisionTest:init()
    return true
end

function RectangleCollisionTest:detect(event,touch)
	--辅助方法
	local function isRectCollision(rect1,rect2)
		local x1 = rect1.origin.x
		local y1 = rect1.origin.y
		local w1 = rect1.size.width
		local h1 = rect1.size.height
		local x2 = rect2.origin.x
		local y2 = rect2.origin.y
		local w2 = rect2.size.width
		local h2 = rect2.size.height

		if math.abs(x1 - x2) > (w1 * 0.5 + w2 * 0.5) or math.abs(y1 - y2) > (h1 * 0.5 + h2 * 0.5) then
			return false;
		end
		return true;
	end
	--辅助方法
	local function getNode(pNode,comName)
		
		 if nil ~= pNode then
			cclog("pNode is null！")
			return 
		 end
		 return pNode:getComponent(comName):getNode()
	end

	--判断方法
    local pComNodeA = ccs.SceneReader:getInstance():getNodeByTag(self._tag_A)
    if nil ~= pComNodeA and ccs.SceneReader:getInstance():getAttachComponentType()==ccs.SceneReader.AttachComponentType.EMPTY_NODE then
        pComNodeA =getNode(pComNodeA,self._comName_A)
		if nil ~= pComNodeA then
			for	i,iter in pairs(self._vecTags) do
				local pComNodeB = ccs.SceneReader:getInstance():getNodeByTag(iter)
				if nil~= pComNodeB and ccs.SceneReader:getInstance():getAttachComponentType()==ccs.SceneReader.AttachComponentType.EMPTY_NODE then
					pComNodeB =getNode(pComNodeB,self._comName_B)
				end
				local p1 = pComNodeA:getPosition()
				local p2 = pComNodeB:getPosition()
				local ARect =cc.rect(p1.x, p1.y, pComNodeA:getContentSize().width + _aOffsetX, pComNodeA:getContentSize().height + _aOffsetY)
				local BRect =cc.rect(p2.x, p2.y, pComNodeB:getContentSize().width + _bOffsetX, pComNodeB:getContentSize().height + _bOffsetY)
				if isRectCollision(ARect, BRect) then
					return true
				end
			end			
		end
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
	cclog(" %s  ===   %s    ",self._NodeTag,self._WidgetTag )
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
TabelIsClick._LeaveFile = ""
TabelIsClick._Row    	= 0
TabelIsClick._Col 		= 0
TabelIsClick._startX  	= 0
TabelIsClick._startY 	= 0
TabelIsClick._ItemWidth = 0
TabelIsClick._Itemheigth= 0
TabelIsClick._ScaleX  	= 0
TabelIsClick._ScaleY	= 0

function TabelIsClick:ctor()
	self._LeaveFile = ""
	self._Row    	= 0
    self._Col 		= 0
	self._startX  	= 0
    self._startY 	= 0
	self._ItemWidth = 0
    self._Itemheigth= 0
	self._ScaleX  	= 0
    self._ScaleY	= 0
end

function TabelIsClick:init()
    return true
end

function TabelIsClick:detect(event,touch)
	if touch~=nil then
		cclog("touc ==>  %s ===%s ",touch:getLocation().x,touch:getLocation().y)
	end
	
	cclog("self._startX ===>%s",self._startX )
	clickTabel ={col=0 ,row=0}
	
	for i=2,self._Col-1 do
		if touch:getLocation().x > self._startX+self._ItemWidth *(i-2)-(self._ItemWidth/2) then
			if touch:getLocation().x< self._startX+self._ItemWidth *(i-2)+(self._ItemWidth/2) then
					clickTabel["col"] = i
				break
			end
		end
	end
	for i=2,self._Row-1 do
		if touch:getLocation().y < self._startY + self._Itemheigth*(self._Row-i)+(self._Itemheigth/2) then
			if touch:getLocation().y > self._startY + self._Itemheigth*(self._Row-i)-(self._Itemheigth/2) then
				clickTabel["row"] = i
				break
			end
		end
	end
	cclog("本次点击位置【%s】【%s】",clickTabel["col"],clickTabel["row"])
	require "src/LinkTabel"
	local clitab = LinkTabel:instance():getClickTabel()
	--cclog("上次点击的位置 【%s】【%s】",clitab["cliA"]["col"],clitab["cliA"]["row"])
	if nil== clitab then
		cclog("第一次点击，表格为空")
		LinkTabel:instance():setClickTabelA(clickTabel)
		--return false
	end
	
	if clitab["cliA"]["col"]~=0 and clitab["cliA"]["row"]~=0 then
		LinkTabel:instance():setClickTabelB(clickTabel)
		require("src/link")
		local tab= LinkTabel:instance():getLeaveTabel()
		-- cclog("输出表")
		-- print_r(tab)
		local c1 = clitab["cliA"]["col"]
		local r1 =clitab["cliA"]["row"]
		local c2 =clickTabel["col"]
		local r2 =clickTabel["row"]
		
		if isConnection(tab,c1,r1,c2,r2) then
			cclog("识别成功，修改表格数据")
			--LinkTabel:instance():setClickTabelA({col=0 ,row=0})
			--LinkTabel:instance():setClickTabelB({col=0 ,row=0})
			tab[r1][c1]=0
			tab[r2][c2]=0
			LinkTabel:instance():setLeaveTabel(tab)
			
			return true
		else
			cclog("识别失败，重置点击")
			LinkTabel:instance():setClickTabelA({col=0 ,row=0})
			LinkTabel:instance():setClickTabelB({col=0 ,row=0})
			
		end
	else
		cclog("第一次点击，表格为空")
		LinkTabel:instance():setClickTabelA(clickTabel)
		require("src/link")
		local tab= LinkTabel:instance():getLeaveTabel()
		cclog("输出表")
		print_r(tab)
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
            if key == "LeaveFile" then
                self._LeaveFile = subDict["value"]
			elseif key == "Row" then
                self._Row = subDict["value"]
			elseif key == "Col" then
                self._Col = subDict["value"]
			elseif key == "startX" then
                self._startX = subDict["value"]
			elseif key == "startY" then
                self._startY = subDict["value"]
			elseif key == "ItemWidth" then
                self._ItemWidth = subDict["value"]
			elseif key == "Itemheigth" then
                self._Itemheigth = subDict["value"]
			elseif key == "ScaleX" then
                self._ScaleX = subDict["value"]
			elseif key == "ScaleY" then
                self._ScaleY = subDict["value"]
            end
        end
    end
end

function TabelIsClick:removeAll()
    print("TabelIsClick::removeAll")
end

ccs.registerTriggerClass("TimeElapsed",TimeElapsed.new)
ccs.registerTriggerClass("ArmatureActionState",ArmatureActionState.new)
ccs.registerTriggerClass("NodeInRect",NodeInRect.new)
ccs.registerTriggerClass("NodeVisible",NodeVisible.new)
ccs.registerTriggerClass("RectangleCollisionTest",RectangleCollisionTest.new)
ccs.registerTriggerClass("WidgetIsClick",WidgetIsClick.new)
ccs.registerTriggerClass("TabelIsClick",TabelIsClick.new)
