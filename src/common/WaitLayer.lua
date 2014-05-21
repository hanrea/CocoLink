--菊花加载界面
module("WaitLayer", package.seeall)

local m_handler=nil
local m_loadNum=0
local m_loadList={}
local m_popUpLayer=nil
local m_TimeEntryID=nil
local m_netWaitTime=nil

function createPanle(  )
	m_popUpLayer=YYPopupLayer:create()
	local scene=CCDirector:sharedDirector():getRunningScene()
	scene:addChild(m_popUpLayer)
	m_popUpLayer:setPosition(ccp(CScreen.getUIX(),0))
	m_popUpLayer:registerScriptHandler(onEvent)

	addArmature("avatar/lording.ExportJson")
	local animation= CCArmature:create("lording")
	m_popUpLayer:addChild(animation)
	animation:getAnimation():playWithIndex(0)
	animation:setPosition(ccp(CScreen.getWinSizeWidth()/2, CScreen.getWinSizeHeight()/2))
	m_popUpLayer:check()

	m_handler=nil
	m_loadNum=0
	m_loadList={}
end

function onEvent( etype )
	if etype == "enter"  then
		
	elseif etype == "exit"  then 
		m_popUpLayer=nil
		m_handler=nil
		m_TimeEntryID=nil
	end
end
--网络请求等待
function netWaiting(  )
	createPanle()
	m_netWaitTime=0
	m_TimeEntryID = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function (  )
			updateTime() end, 1, false)
end
--请求计时，如果请求超过一定秒，报网络错误
function updateTime(  )
	m_netWaitTime=m_netWaitTime+1
	if m_netWaitTime > 10 then
		showMessage(GameString.WrongNet)
		removeWaiting()
	end
end
--移除网络请求菊花界面
function removeWaiting( )
	if m_TimeEntryID~=nil then
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(m_TimeEntryID)
	end
	if m_popUpLayer~=nil then
		m_popUpLayer:removeAllChildrenWithCleanup(true)
		m_popUpLayer:removeFromParentAndCleanup(true)
	end
end


--加载所有人物动画
function loadRoleList(handler)
	createPanle()
	m_handler=handler

	for k,v in pairs(TemplateData.playerData) do
		table.insert(m_loadList,v.id)
	end
	startLoad()
end
--加载玩家所拥有宠物动画
function loadPetList( handler )
	createPanle()
	m_handler=handler

	for k,v in pairs(UserData.getPetList()) do
		table.insert(m_loadList,v.id)
	end
	startLoad()
end
--进准备界面的加载
function loadPrepareList( handler )
	createPanle()
	m_handler=handler

	local petList=LocalData.getPetList()
	if petList~=nil then
		for k,v in pairs(petList) do
			local uvo=UserData.getPetByIndex(tonumber(v))
			if uvo~=nil then
				table.insert(m_loadList,uvo.id)
			end
		end
	else
		local upet=UserData.getPetList()
		table.insert(m_loadList,upet[1].id)
	end

	table.insert(m_loadList,UserData.getPlayerID())
	startLoad( )
end

function startLoad(  )
	m_loadNum=0
	for k,v in pairs(m_loadList) do
		addArmatureAsync(string.format("avatar/%s.ExportJson",v),onLoadComplete)
	end
end
--percent大于等于1 用于判断所有资源加载完毕不靠谱
function onLoadComplete( percent )
	m_loadNum=m_loadNum+1

	if m_loadNum<table.nums(m_loadList) then
		return
	end

	if percent<1 then 
		return 
	end

	if m_handler~=nil then
		(m_handler)(percent)
	end

	if m_popUpLayer~=nil then
		m_popUpLayer:removeAllChildrenWithCleanup(true)
		m_popUpLayer:removeFromParentAndCleanup(true)
		m_popUpLayer=nil
	end
end
