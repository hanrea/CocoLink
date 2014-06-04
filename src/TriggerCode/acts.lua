require "CocoStudio"

-----------------
local TMoveTo = class("TMoveTo")
	TMoveTo._tag = -1
	TMoveTo._x  = 0
	TMoveTo._y  = 0
	TMoveTo._duration = 0

function TMoveTo:ctor()
    self._tag = -1
    self._x  = 0
    self._y  = 0
    self._duration = 0
end

function TMoveTo:init()
    return true
end

function TMoveTo:done(event,touch)
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end
    local  actionTo = cc.MoveTo:create(self._duration, cc.p(self._x, self._y))
    if nil == actionTo then
        return
    end
	 node:runAction(actionTo)
	cclog("runAction TMoveBy  X: %s Y: %s", self._x , self._y )
end

function TMoveTo:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "x" then
                self._x = subDict["value"]
            elseif key == "y" then
                self._y = subDict["value"]
			 elseif key == "Duration" then
                self._duration = subDict["value"]
            end
        end
    end
end

function TMoveTo:removeAll()
    local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    node:getActionManager():removeAllActions()
    print("TMoveTo::removeAll")
end

------------
local TMoveBy = class("TMoveBy")
TMoveBy._tag = -1
TMoveBy._duration = 0
TMoveBy._x  = 0
TMoveBy._y  = 0
TMoveBy._reverse = false
function TMoveBy:ctor()
    self._tag = -1
    self._duration = 0
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
	cclog("runAction TMoveBy  X: %s Y: %s", self._x , self._y )
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
-----------------
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
	cclog("runAction ScaleTo  X: %s Y: %s", self._scaleX , self._scaleX )
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


-----------------
local TScaleBy = class("TScaleBy")
	TScaleBy._tag  = -1
	TScaleBy._duration = 0
	TScaleBy._scaleX = 0
	TScaleBy._scaleY = 0
	TScaleBy._reverse =false
	TScaleBy._repeatForever=false

function TScaleBy:ctor()
	self._tag  = -1
	self._duration = 0
	self._scaleX = 0
	self._scaleY = 0
	self._reverse =false
	self._repeatForever=false
end

function TScaleBy:init()
    return true
end

function TScaleBy:done(event,touch)
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end

    local actionBy = cc.ScaleBy:create(self._duration, self._scaleX, self._scaleY)
    if nil == actionBy then
        return
    end
	if self._reverse then
		local actionByBack  =actionBy:reverse()
		if self._repeatForever then
			cclog("runAction ScaleBy %s 重复",self._deltaangle)
			node:runAction(cc.RepeatForever:creat(cc.Sequence:create(actionBy,actionByBack,nil)))
		else
			cclog("runAction ScaleBy %s 往返",self._deltaangle)
			node:runAction(cc.Sequence:create(actionBy, actionByBack))
		end
	else
		node:runAction(actionBy)
	end

end

function TScaleBy:serialize(value)
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
			 elseif key == "IsReverse" then
                self._reverse = subDict["value"]
			 elseif key == "IsRepeatForever" then
                self._repeatForever = subDict["value"]
            end
        end
    end
end

function TScaleBy:removeAll()
    print("TScaleBy::removeAll")
end


-----------------
local TSkewTo = class("TSkewTo")
	TSkewTo._tag  = -1
	TSkewTo._duration = 0
	TSkewTo._skewX = 0
	TSkewTo._skewY = 0

function TSkewTo:ctor()
	self._tag  = -1
	self._duration = 0
	self._skewX = 0
	self._skewY = 0

end

function TSkewTo:init()
    return true
end

function TSkewTo:done(event,touch)
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end

    local actionTo = cc.SkewTo:create(self._duration, self._skewX, self._skewY)
    if nil == actionTo then
        return
    end
	node:runAction(actionTo)
end

function TSkewTo:serialize(value)
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
			 elseif key == "IsReverse" then
                self._reverse = subDict["value"]
			 elseif key == "IsRepeatForever" then
                self._repeatForever = subDict["value"]
            end
        end
    end
end

function TSkewTo:removeAll()
    print("TSkewTo::removeAll")
end


-----------------
local TSkewBy = class("TSkewBy")
	TSkewBy._tag  = -1
	TSkewBy._duration = 0
	TSkewBy._skewX = 0
	TSkewBy._skewY = 0
	TSkewBy._reverse =false
	TSkewBy._repeatForever=false

function TSkewBy:ctor()
	self._tag  = -1
	self._duration = 0
	self._skewX = 0
	self._skewY = 0
	self._reverse =false
	self._repeatForever=false
end

function TSkewBy:init()
    return true
end

function TSkewBy:done(event,touch)
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end

    local actionBy = cc.SkewBy:create(self._duration, self._skewX, self._skewY)
    if nil == actionBy then
        return
    end
	if self._reverse then
		local actionByBack  =actionBy:reverse()
		if self._repeatForever then
			cclog("runAction SkewBy %s 重复",self._deltaangle)
			node:runAction(cc.RepeatForever:creat(cc.Sequence:create(actionBy,actionByBack,nil)))
		else
			cclog("runAction SkewBy %s 往返",self._deltaangle)
			node:runAction(cc.Sequence:create(actionBy, actionByBack))
		end
	else
		node:runAction(actionBy)
	end
	
end

function TSkewBy:serialize(value)
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
                self._skewX = subDict["value"]
            elseif key == "ScaleY" then
                self._skewY = subDict["value"]
			 elseif key == "IsReverse" then
                self._reverse = subDict["value"]
			 elseif key == "IsRepeatForever" then
                self._repeatForever = subDict["value"]
            end
        end
    end
end

function TSkewBy:removeAll()
    print("TSkewBy::removeAll")
end

-------------------


local TRotateTo = class("TRotateTo")
TRotateTo._tag 			= -1
TRotateTo._duration 	= 0
TRotateTo._deltaAngle 	= 0

function TRotateTo:ctor()
self._tag 			= -1
self._duration 		= 0
self._deltaangle 	= 0


end

function TRotateTo:init()
    return true
end

function TRotateTo:done(event,touch)
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end

    local actionto = cc.RotateTo:create(self._duration, self._deltaangle)
    if nil == actionto then
        return
    end
		cclog("runAction RotateTo %s",self._deltaangle)
    node:runAction(actionto)
end

function TRotateTo:serialize(value)
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
            elseif key == "DeltaAngle" then
                self._deltaAngle = subDict["value"]
            end
        end
    end
end

function TRotateTo:removeAll()
    cclog("TRotateTo::removeAll")
end
-------------------
local TRotateBy = class("TRotateBy")
TRotateBy._tag  = -1
TRotateBy._duration = 0
TRotateBy._deltaangle = 0

TRotateBy._reverse = false
TRotateBy._repeatForever  =false

function TRotateBy:ctor()
    self._tag = -1
	 self._deltaangle = 0
    self._duration = 0
    self._reverse = false
	self._repeatForever =false
end

function TRotateBy:init()
    return true
end

function TRotateBy:done(event,touch)
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
    if nil == node then
        return
    end

    local actionBy = cc.RotateBy:create(self._duration, self._deltaangle)
    if nil == actionBy then
        return
    end
	if self._reverse then
		local actionByBack  =actionBy:reverse()
		if self._repeatForever then
			cclog("runAction RotateBy %s 重复",self._deltaangle)
			node:runAction(cc.RepeatForever:creat(cc.Sequence:create(actionBy,actionByBack,nil)))
		else
			cclog("runAction RotateBy %s 往返",self._deltaangle)
			node:runAction(cc.Sequence:create(actionBy, actionByBack))
		end
	else
		node:runAction(actionBy)
	end
	cclog("runAction RotateBy %s",self._deltaangle)
    node:runAction(actionBy)
end

function TRotateBy:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "DeltaAngle" then
                self._deltaangle = subDict["value"]
            elseif key == "Duration" then
                self._duration = subDict["value"]
            elseif key == "IsReverse" then
                self._reverse = subDict["value"] ==1 or false
			elseif key == "IsRepeatForever" then
				self._repeatForever = subDict["value"] ==1 or false
            end
        end
    end
end

function TRotateBy:removeAll()
    print("TRotateBy::removeAll")
end



------------------

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
			cclog("TriggerState %s 禁用",self._id )
            obj:setEnable(false)
        elseif self._state == 1 then
			cclog("TriggerState %s 启用",self._id )
            obj:setEnable(true)
        elseif self._state == 2 then
			cclog("TriggerState %s 删除",self._id )
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


------------------

local PlayMusic = class("PlayMusic")
PlayMusic._tag  = -1
PlayMusic._comName = ""
PlayMusic._type = -1

function PlayMusic:ctor()
	self._tag  = -1
	self._comName = ""
	self._type = -1
end

function PlayMusic:init()
    return true
end

function PlayMusic:done(event,touch)
	local audio = ccs.SceneReader:getInstance():getNodeByTag(self._tag):getComponent(self._comName)

	if nil == audio then
		return
	end
	if self._type == 0  then 
		audio:playBackgroundMusic()
	else
		audio:playEffect()
	end
end

function PlayMusic:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "ID" then
                self._id = subDict["value"]
            elseif key == "componentName" then
                self._comName = subDict["value"]
			elseif key == "type" then
                self._type = subDict["value"]
            end
        end
    end
end

function PlayMusic:removeAll()
    print("PlayMusic::removeAll")
end




------------------

local ArmaturePlayAction = class("ArmaturePlayAction")
ArmaturePlayAction._tag  = -1
ArmaturePlayAction._comName = ""
ArmaturePlayAction._aniname = ""

function ArmaturePlayAction:ctor()
	self._tag  = -1
	self._comName = ""
	self._aniname = ""
end

function ArmaturePlayAction:init()
    return true
end

function ArmaturePlayAction:done(event,touch)
	local pRender = ccs.SceneReader:getInstance():getNodeByTag(self._tag):getComponent(self._comName)
	local pAr  =pRender:getNode()
	if nil == pAr then
		return
	end
	if self._type == 0  then 
		pAr:playBackgroundMusic()
	else
		pAr:playEffect()
	end
end

function ArmaturePlayAction:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "ID" then
                self._id = subDict["value"]
            elseif key == "componentName" then
                self._comName = subDict["value"]
			elseif key == "AnimationName" then
                self._aniname = subDict["value"]
            end
        end
    end
end

function ArmaturePlayAction:removeAll()
    print("ArmaturePlayAction::removeAll")
end



------------------

local ChangeDoubleAttribute = class("ChangeDoubleAttribute")
ChangeDoubleAttribute._tag  = -1
ChangeDoubleAttribute._key = ""
ChangeDoubleAttribute._value = 0
ChangeDoubleAttribute._type = 0
ChangeDoubleAttribute._limit = 0

function ChangeDoubleAttribute:ctor()
	self._tag  = -1
	self._key = ""
	self._value = 0
	self._type = 0
	self._limit = 0

end

function ChangeDoubleAttribute:init()
    return true
end

function ChangeDoubleAttribute:done(event,touch)
	local attri = ccs.SceneReader:getInstance():getNodeByTag(self._tag):getComponent("CCComAttribute")
	local value = attri:getFloat(self._key)--
	if 		self._type ==0 then
		value =value-self._value
	elseif  self._type ==1 then
		value=self._value
	else
		value=value + self._value
	end
	
	if  self._limit ==0 then
	
		if value < 0 then
			value=0
		end
	elseif  self._limit ==1 then
		if value > 0 then
			value=0
		end
	end
	
	
end

function ChangeDoubleAttribute:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "Key" then
                self._key = subDict["value"]
			elseif key == "Value" then
                self._value = subDict["value"]
            elseif key == "ChangeType" then
                self._type = subDict["value"]
			elseif key == "Limit" then
                self._limit = subDict["value"]
            end
        end
    end
end

function ChangeDoubleAttribute:removeAll()
    print("ChangeDoubleAttribute::removeAll")
end

------------------

local SetNodeVisible = class("SetNodeVisible")
SetNodeVisible._tag  = -1
SetNodeVisible._show = true


function SetNodeVisible:ctor()
	self._tag  = -1
	self._show = true

end

function SetNodeVisible:init()
    return true
end

function SetNodeVisible:done(event,touch)
	local pNode = ccs.SceneReader:getInstance():getNodeByTag(self._tag)
	if nil == pNode then
		return
	end
	pNode:setVisible(self._show)
end

function SetNodeVisible:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tag" then
                self._tag = subDict["value"]
            elseif key == "Visible" then
                self._show = subDict["value"]
            end
        end
    end
end

function SetNodeVisible:removeAll()
    print("SetNodeVisible::removeAll")
end

------------------

local PlayUIAnimation = class("PlayUIAnimation")
PlayUIAnimation._uiJsonName  = -1
PlayUIAnimation._animaitionName = true


function PlayUIAnimation:ctor()
	self._tag  = -1
	self._show = true

end

function PlayUIAnimation:init()
    return true
end

function PlayUIAnimation:done(event,touch)
	ccs.ActionManagerEx:getInstance():playActionByName(self._uiJsonName,self._animaitionName)
end

function PlayUIAnimation:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "UIJsonName" then
                self._uiJsonName = subDict["value"]
            elseif key == "AnimationName" then
                self._animaitionName = subDict["value"]
            end
        end
    end
end

function PlayUIAnimation:removeAll()
    print("PlayUIAnimation::removeAll")
end



------------------

local StopAllActions = class("StopAllActions")
StopAllActions._vecTags  = -1

function StopAllActions:ctor()
	self._vecTags  = {}
end

function StopAllActions:init()
    return true
end

function StopAllActions:done(event,touch)
	local count = table.getn(self._vecTags)
	for i= 1 ,count do
		local pNode = ccs.SceneReader:getInstance():getNodeByTag(self._vecTags[i])
		if nil ~= pNode then
			pNode:stopAllActions()
		end
	end
end

function StopAllActions:serialize(value)
    local dataItems = value["dataitems"]
    if nil ~= dataItems then
        local count = table.getn(dataItems)
        for i = 1, count do
            local subDict =  dataItems[i]
            local key = subDict["key"]
            if key == "Tags" then
				local strTags =  subDict["value"]
				string.gsub(strTags, '[^,]+', function(w) table.insert(self._vecTags , w) end )--使用逗号分隔tag
            end
        end
    end
end

function StopAllActions:removeAll()
    print("StopAllActions::removeAll")
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

	require "src/TriggerHelper"
	 setLeaveTabel(tabel)
	
	node = ccs.SceneReader:getInstance():getNodeByTag(self._NodeTag )
	 if nil == node then
        return
    end
	cclog(" 宽数 %s 高： %s   ",self._ItemWidth,self._Itemheigth)
	for i=2,self._Row-1  do
		for j=2,self._Col-1 do
			item = ccui.CheckBox:create()
			item:setPosition(cc.p(self._startX +((j-2)*self._ItemWidth), self._startY +((self._Col-i)*self._Itemheigth)))
			item:loadTextureBackGround(tostring("res/"..tabel[i][j]..".png"))
			item:setSize(cc.size(self._ItemWidth,self._Itemheigth))
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


------------------

local ChangeAtlasValue = class("ChangeAtlasValue")
ChangeAtlasValue._NodeTag  = -1
ChangeAtlasValue._WidgetTag = -1
ChangeAtlasValue._AtlasValue = ""
ChangeAtlasValue._IsRelative = false
function ChangeAtlasValue:ctor()
	self._NodeTag  = -1
	self._WidgetTag = -1
	self._AtlasValue = ""
	self._IsRelative = false
end

function ChangeAtlasValue:init()
    return true
end

function ChangeAtlasValue:done(event,touch)
	cclog(" %s  ===   %s    ",self._NodeTag,self._WidgetTag )
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._NodeTag):getComponent("GUIComponent")
	local uilayer = node:getNode()
	local widget = nil
	if nil~= uilayer then
		widget=ccui.Helper:seekWidgetByTag(uilayer, self._WidgetTag)
	end
	
	if self._IsRelative then
		
		local value = tonumber(widget:getStringValue())
		cclog("文本相对值 %s ",value)
		value = value + tonumber(self._AtlasValue)
		cclog("文本相对值 %s ",value)
		widget:setStringValue(tostring( value ))
	else
		widget:setStringValue(self._AtlasValue)
	end
end

function ChangeAtlasValue:serialize(value)
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
			 elseif key == "AltasValue" then
                self._AtlasValue = subDict["value"]
			elseif key == "IsRelative" then
                self._IsRelative = (subDict["value"] == 1  or  false) and true 
            end
        end
    end
end

function ChangeAtlasValue:removeAll()
    print("ChangeAtlasValue::removeAll")
end

------------------

local ChangeProgressValue = class("ChangeProgressValue")
ChangeProgressValue._NodeTag  = -1
ChangeProgressValue._WidgetTag  = -1
ChangeProgressValue._ProgressValue = ""
ChangeProgressValue._IsRelative = false

function ChangeProgressValue:ctor()
	self._NodeTag  = -1
	self._WidgetTag = -1
	self._ProgressValue = ""
	self._IsRelative = false
end

function ChangeProgressValue:init()
    return true
end

function ChangeProgressValue:done(event,touch)
	cclog(" %s  ===   %s    ",self._NodeTag,self._WidgetTag )
	local node = ccs.SceneReader:getInstance():getNodeByTag(self._NodeTag):getComponent("GUIComponent")
	local uilayer = node:getNode()
	local widget = nil
	if nil~= uilayer then
		widget=ccui.Helper:seekWidgetByTag(uilayer, self._WidgetTag)
	end
	if self._IsRelative then
		cclog("相对值 ")
		widget:setPercent(tonumber(widget:getPercent() + tonumber(self._ProgressValue)))
	else
		widget:setPercent(tonumber(self._ProgressValue))
	end
end

function ChangeProgressValue:serialize(value)
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
			elseif key == "ProgressValue" then
                self._ProgressValue = subDict["value"]
			elseif key == "IsRelative" then
                self._IsRelative = (subDict["value"] == 1  or  false) and true 
            end
        end
    end
end

function ChangeProgressValue:removeAll()
    print("ChangeProgressValue::removeAll")
end

ccs.registerTriggerClass("TMoveTo",TMoveTo.new)
ccs.registerTriggerClass("TMoveBy",TMoveBy.new)
ccs.registerTriggerClass("TScaleTo",TScaleTo.new)
ccs.registerTriggerClass("TScaleBy",TScaleBy.new)
ccs.registerTriggerClass("TSkewTo",TSkewTo.new)
ccs.registerTriggerClass("TSkewBy",TSkewBy.new)
ccs.registerTriggerClass("TRotateTo",TRotateTo.new)
ccs.registerTriggerClass("TRotateBy",TRotateBy.new)
ccs.registerTriggerClass("TriggerState",TriggerState.new)
ccs.registerTriggerClass("PlayMusic",PlayMusic.new)
ccs.registerTriggerClass("ArmaturePlayAction",ArmaturePlayAction.new)
--ccs.registerTriggerClass("SequenceMoveTo",SequenceMoveTo.new)
ccs.registerTriggerClass("ChangeDoubleAttribute",ChangeDoubleAttribute.new)
ccs.registerTriggerClass("SetNodeVisible",SetNodeVisible.new)
ccs.registerTriggerClass("PlayUIAnimation",PlayUIAnimation.new)
ccs.registerTriggerClass("StopAllActions",StopAllActions.new)
ccs.registerTriggerClass("CreatLeaveFromJson",CreatLeaveFromJson.new)
ccs.registerTriggerClass("ChangeAtlasValue",ChangeAtlasValue.new)
ccs.registerTriggerClass("ChangeProgressValue",ChangeProgressValue.new)