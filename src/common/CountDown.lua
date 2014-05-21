--倒计时组件
local CountDown = class("CountDown", function()
	local layer=Widget:create()
	return layer
end)

function CountDown:ctor(futureTime,handler,parent,x,y)
	self:registerScriptHandler(function ( etype ) self:onEvent(etype) end)
	self.m_TimeEntryID=nil
	self.futureTime=futureTime
	self.handler=handler
	self.lab=Label:create()
	self.lab:setAnchorPoint(ccp(0,0))
	self.lab:setFontSize(30)
	self.lab:setColor(ccc3(0xff,0xff,0xff))
	self:addChild(self.lab)

	parent:addChild(self)
	self:setPosition(ccp(x,y))
	self:updateTime()
end

function CountDown:setFutureTime( futureTime )
	self.futureTime=futureTime
end

function CountDown:onEvent( eType )
	if eType == "enter"  then
		self:OnEnter()
	elseif eType == "exit"  then
		self:OnExit()
	end
end

function CountDown:OnEnter()
	self.m_TimeEntryID = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function (  )
			self:updateTime() end, 1, false)
end

function CountDown:OnExit()
	if self.m_TimeEntryID~=nil then
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.m_TimeEntryID)
	end
end
--更新时间显示
function CountDown:updateTime()
	local diff= self.futureTime-os.time()
	if diff >0 then
		self.lab:setText(dateFormat(diff))
	else
		if self.handler ~=nil then
			(self.handler)()
		end
		self:removeAllChildrenWithCleanup(true)
		self:removeFromParentAndCleanup(true)
	end
end

return CountDown