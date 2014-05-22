require ("CocoStudio")

---------------------
local TimeElapsed = class("TimeElapsed")
TimeElapsed._totalTime  = 0
TimeElapsed._tmpTime = 0
TimeElapsed._suc = false

function TimeElapsed:ctor()
    self._totalTime = 0
	self._tmpTime = 0
	self._suc = false
end

function TimeElapsed:update(dt)
	self._tmpTime = self._tmpTime + dt
	if self._tmpTime > self._totalTime then
		self._suc =true
	end
    return true
end

function TimeElapsed:init()
	CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(self:update,20.0)
	
    return true
end

function TimeElapsed:detect()
    return self._suc
end

function TimeElapsed:serialize(value)
    local dataItems = 	["dataitems"]
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

---------------------
local ArmatureActionState = class("ArmatureActionState")
ArmatureActionState._tag  = -1
ArmatureActionState._state = -1
ArmatureActionState._size   = nil

function ArmatureActionState:ctor()
    self._tag = -1
	self._state = -1
	self._size   = nil
 
end

function ArmatureActionState:init()
    return true
end

function ArmatureActionState:detect()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function ArmatureActionState:serialize(value)
    local dataItems = 	["dataitems"]
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

function ArmatureActionState:removeAll()
    print("ArmatureActionState::removeAll")
end
------------------

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

function NodeInRect:detect()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function NodeInRect:serialize(value)
    local dataItems = 	["dataitems"]
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

---------------------
local NodeVisible = class("NodeVisible")
NodeVisible._tag  = -1
NodeVisible._origin = nil
NodeVisible._size   = nil

function NodeVisible:ctor()
    self._tag = -1
    self._origin = nil
    self._size   = nil
    self._origin = cc.p(0, 0)
    self._size   = cc.size(0, 0)
end

function NodeVisible:init()
    return true
end

function NodeVisible:detect()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function NodeVisible:serialize(value)
    local dataItems = 	["dataitems"]
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

function NodeVisible:removeAll()
    print("NodeVisible::removeAll")
end
---------------------
local NodeVisible = class("NodeVisible")
NodeVisible._tag  = -1
NodeVisible._origin = nil
NodeVisible._size   = nil

function NodeVisible:ctor()
    self._tag = -1
    self._origin = nil
    self._size   = nil
    self._origin = cc.p(0, 0)
    self._size   = cc.size(0, 0)
end

function NodeVisible:init()
    return true
end

function NodeVisible:detect()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function NodeVisible:serialize(value)
    local dataItems = 	["dataitems"]
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

function NodeVisible:removeAll()
    print("NodeVisible::removeAll")
end

---------------------
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

function RectangleCollisionTest:detect()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function RectangleCollisionTest:serialize(value)
    local dataItems = ["dataitems"]
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

function RectangleCollisionTest:removeAll()
    print("RectangleCollisionTest::removeAll")
end

-------------------------
------是否点击UI控件-----
-------------------------
--通过判断点击位置是否在节点内来判断

local ClickOnWidget = class("ClickOnWidget")
ClickOnWidget._NodeId  = -1
ClickOnWidget._WidgetName = nil
--ClickOnWidget.Widget = nil


function ClickOnWidget:ctor()
    self._NodeId = -1
	self._WidgetName= nil
	--self.Widget = nil
end

function ClickOnWidget:init()
    return true
end

function ClickOnWidget:detect()
	--获取UI节点
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._NodeId)
	--获取控件
	local widget =ccs.UIHelper:seekWidgetByName(node,self._WidgetName)
	--点击位置？？？？？？？需要在条件或者事件获取一些信息？？？？？？？
	local clickPosition = cc.p(100,100)--模拟数据

	if clickPosition.x > widget.getPositionX and clickPosition.x < widget.getPositionXthen+widget.width and clickPosition.y > widget.getPositionY and clickPosition.y < widget.getPositionY() +widget.height then
        return true
    end
	
    return false
end

function ClickOnWidget:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "nodeID" then
                self._NodeId = subDict["value"]
            end
        end
    end
end

function ClickOnWidget:removeAll()
    print("ClickOnWidget::removeAll")
end

-------------------------
--------点击节点---------
-------------------------
--通过判断点击位置是否在节点内来判断

local ClickOnNode = class("ClickOnNode")
ClickOnNode._tag  = -1
ClickOnNode._origin = nil
ClickOnNode._size   = nil

function ClickOnNode:ctor()
    self._tag = -1
    self._origin = nil
    self._size   = nil
    self._origin = cc.p(0, 0)
    self._size   = cc.size(0, 0)
end

function ClickOnNode:init()
    return true
end

function ClickOnNode:detect()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil ~= node and math.abs(node:getPositionX() - self._origin.x) <= self._size.width and math.abs(node:getPositionY() - self._origin.y) <= self._size.height then
        return true
    end
    return false
end

function ClickOnNode:serialize(value)
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

function ClickOnNode:removeAll()
    print("ClickOnNode::removeAll")
end
-------------------------
ccs.registerTriggerClass("NodeInRect",NodeInRect.new)
ccs.registerTriggerClass("ClickOnWidget",ClickOnWidget.new)
ccs.registerTriggerClass("ClickOnNode",ClickOnNode.new)