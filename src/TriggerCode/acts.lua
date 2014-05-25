require "CocoStudio"

local TMoveBy = class("TMoveBy")
TMoveBy._tag = -1
TMoveBy._duration = 0
TMoveBy._x  = 0
TMoveBy._y  = 0
TMoveBy._reverse = false
function TMoveBy:ctor()
    self._tag = -1
    self._duration = 0.0
    self._x  = 0
    self._y  = 0
    self._reverse = false
end

function TMoveBy:init()
    return true
end

function TMoveBy:done(event,touch)
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end
    local  actionBy = cc.MoveBy:create(self._duration, cc.p(self._x, self._y))
    if nil == actionBy then
        return
    end

    if true == self._reverse then
        local actionByBack = actionBy:reverse()
        node:runAction(cc.Sequence:create(actionBy, actionByBack))
    else
        node:runAction(actionBy)
    end
end

function TMoveBy:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "Duration" then
                self._duration = subDict["value"]
            elseif key == "x" then
                self._x = subDict["value"]
            elseif key == "y" then
                self._y = subDict["value"]
            elseif key == "IsReverse" then
                self._reverse = subDict["value"]
            end
        end
    end
end

function TMoveBy:removeAll()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    node:getActionManager():removeAllActions()
    print("TMoveBy::removeAll")
end

local TScaleTo = class("TScaleTo")
TScaleTo._tag  = -1
TScaleTo._duration = 0
TScaleTo._scaleX = 0
TScaleTo._scaleY = 0

function TScaleTo:ctor()
    self._tag = -1
    self._duration = 0
    self._scaleX = 0
    self._scaleY = 0
end

function TScaleTo:init()
    return true
end

function TScaleTo:done(event,touch)
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end

    local actionTo = cc.ScaleTo:create(self._duration, self._scaleX, self._scaleY)
    if nil == actionTo then
        return
    end

    node:runAction(actionTo)
end

function TScaleTo:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "Duration" then
                self._duration = subDict["value"]
            elseif key == "ScaleX" then
                self._scaleX = subDict["value"]
            elseif key == "ScaleY" then
                self._scaleY = subDict["value"]
            end
        end
    end
end

function TScaleTo:removeAll()
    print("TScaleTo::removeAll")
end


local TriggerState = class("TriggerState")
TriggerState._id  = -1
TriggerState._state = 0

function TriggerState:ctor()
    self._id    = -1
    self._state = 0
end

function TriggerState:init()
    return true
end

function TriggerState:done(event,touch)
    local obj = ccs.TriggerMng.getInstance():getTriggerObj(self._id)
    if nil ~= obj then
        if self._state == 0 then
            obj:setEnable(false)
        elseif self._state == 1 then
            obj:setEnable(true)
        elseif self._state == 2 then
            ccs.TriggerMng.getInstance():removeTriggerObj(self._id)
        end
    end
end

function TriggerState:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "ID" then
                self._id = subDict["value"]
            elseif key == "State" then
                self._state = subDict["value"]
            end
        end
    end
end

function TriggerState:removeAll()
    print("TriggerState::removeAll")
end



-----------------------------------
----------添加ArmatureItem---------
-----------------------------------
local CreatLeaveFromJson = class("CreatLeaveFromJson")
    CreatLeaveFromJson._NodeTag   = 0
    CreatLeaveFromJson._LeaveFile = ""
	CreatLeaveFromJson._Row    	= 0
    CreatLeaveFromJson._Col 		= 0
	CreatLeaveFromJson._startX  	= 0
    CreatLeaveFromJson._startY 	= 0
	CreatLeaveFromJson._ItemWidth = 0
    CreatLeaveFromJson._Itemheigth= 0
	CreatLeaveFromJson._ScaleX  	= 0
    CreatLeaveFromJson._ScaleY	= 0

function CreatLeaveFromJson:ctor()
    self._NodeTag    = 0
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

function CreatLeaveFromJson:init()

    return true
end

function CreatLeaveFromJson:done(event,touch)
	if touch~=nil then
		cclog("touc ==>  %s  ",touch:getLocation().x)
	end
	tabel= {}
	for line in io.lines("src/leave.txt") do
		splitlist = {}
		string.gsub(line, '[^,]+', function(w) table.insert(splitlist, w) end )
		table.insert(tabel, splitlist)
	end

	node = ccs.SceneReader:getInstance():getNodeByTag(self._NodeTag )
	 if nil == node then
        return
    end
	cclog("%s   %s   ",self._Row,self._Col)
	for i=2,self._Row-1  do
		for j=2,self._Col-1 do
			item = ccui.CheckBox:create()
			item:setPosition(cc.p(self._startX/2 +(j*self._ItemWidth), self._startY/2 +((self._Col-i-1)*self._Itemheigth)))
			item:loadTextureBackGround(tostring("res/"..tabel[i][j]..".png"))
			item:setScaleX(self._ScaleX)
			item:setScaleY(self._ScaleY)
			item:setTouchEnabled(false)
			node:addChild(item)
		end		
	end
end

function CreatLeaveFromJson:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
			if key == "NodeTag" then
                self._NodeTag = subDict["value"]
            elseif key == "LeaveFile" then
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

function CreatLeaveFromJson:removeAll()
    print("CreatLeaveFromJson::removeAll")
end

ccs.registerTriggerClass("CreatLeaveFromJson",CreatLeaveFromJson.new)
ccs.registerTriggerClass("TScaleTo",TScaleTo.new)
ccs.registerTriggerClass("TMoveBy",TMoveBy.new)
ccs.registerTriggerClass("TriggerState",TriggerState.new)
