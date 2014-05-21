
--花费界面
local CostLayer = class("CostLayer", function()
	local layer=TouchGroup:create()
	return layer
end)

--ctype枚举
CostLayer.Gold=1
CostLayer.Rmb=2

function CostLayer:ctor(txt,handler,ctype,num)
	self.txt=txt
	self.handler=handler
	self.ctype=ctype
	self.num=num

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

function CostLayer:onEvent( etype )
	if etype == "enter"  then
		
	elseif etype == "exit"  then 
		
	end
end

function CostLayer:setData(  )
	local img= castGUI(self:getWidgetByName("comLayerImg"),"ImageView")
	local labTitle=castGUI(self:getWidgetByName("comLayerLabTitle"),"Label")
	local labNum=castGUI(self:getWidgetByName("comLayerLabNum"),"LabelAtlas")

	if self.ctype==CostLayer.Gold then
		img:loadTexture("ui/Run/gold.png")
	else
		img:loadTexture("ui/Run/cash.png")
	end

	labNum:setStringValue(self.num)
	labTitle:setText(self.txt)

	local sureBtn =self:getWidgetByName("comLayerBtnSure")
	local cancleBtn = self:getWidgetByName("comLayerBtnCancel")
	sureBtn.name="comLayerBtnSure"
	cancleBtn.name="comLayerBtnCancel"
	sureBtn:addTouchEventListener(function ( sender, eventType) self:onBtnCallBack( sender, eventType) end)
	cancleBtn:addTouchEventListener(function ( sender, eventType) self:onBtnCallBack( sender, eventType) end)

	local panel=self:getWidgetByName("AlertNoVisible")
	panel:setVisible(true)

	self.popUpLayer:check()
end

function CostLayer:onBtnCallBack( btn, eventType )
	if not judgeEndEvent(eventType) then
		return
	end

	if btn.name=="comLayerBtnSure"  then
		(self.handler)()
	end
	self.popUpLayer:removeFromParentAndCleanup(true)
end


return CostLayer