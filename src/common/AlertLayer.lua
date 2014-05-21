--弹出询问界面，有确定与取消两个按钮
local AlertLayer = class("AlertLayer", function()
	local layer=TouchGroup:create()
	return layer
end)
--handler按确认的回调
function AlertLayer:ctor(txt,handler)
	self.txt=txt
	self.handler=handler

	self:registerScriptHandler(function(etype) self:onEvent(etype) end)
	self.popUpLayer=YYPopupLayer:create()
	local scene=CCDirector:sharedDirector():getRunningScene()
	scene:addChild(self.popUpLayer)

	local color_layer = CCLayerColor:create(ccc4(150, 150, 150, 70))
	self.popUpLayer:addChild(color_layer)
	self.popUpLayer:addChild(self)
	self:setPosition(ccp(CScreen.getUIX(),0))

	local bg = readGUI("ui/Run/CommonLayer.json")
	self:addWidget(bg)

	self:setData()
end

function AlertLayer:onEvent( etype )
	if etype == "enter"  then
		
	elseif etype == "exit"  then 
		
	end
end

function AlertLayer:setData(  )
	local panel=self:getWidgetByName("AlertNoVisible")
	panel:setVisible(false)
	local container=self:getWidgetByName("AlertBG")

	local lab=Label:create()
	lab:setAnchorPoint(ccp(0,0))
	lab:setPosition(ccp(30,106))
	lab:setFontSize(28)
	lab:setText(self.txt)
	lab:setColor(ccc3(0xff,0xff,0xff))
	lab:setTextAreaSize(CCSizeMake(350,0))
	lab:setTextHorizontalAlignment(kCCTextAlignmentCenter)
	container:addChild(lab)
	local sizeLab=lab:getContentSize()

	local sureBtn =self:getWidgetByName("comLayerBtnSure")
	local cancleBtn = self:getWidgetByName("comLayerBtnCancel")
	sureBtn.name="comLayerBtnSure"
	cancleBtn.name="comLayerBtnCancel"
	sureBtn:addTouchEventListener(function ( sender, eventType) self:onBtnCallBack( sender, eventType) end)
	cancleBtn:addTouchEventListener(function ( sender, eventType) self:onBtnCallBack( sender, eventType) end)

	if sizeLab.height-64>0 then
		container:setSize(CCSizeMake(400,200+sizeLab.height-64))
	else
		container:setSize(CCSizeMake(400,200))
	end
	self.popUpLayer:check()
end

function AlertLayer:onBtnCallBack( btn, eventType )
	if eventType == 2 then
		return
	end

	if btn.name=="comLayerBtnSure"  then
		(self.handler)()
	end
	self.popUpLayer:removeFromParentAndCleanup(true)
end


return AlertLayer