--通用场景
module("CommonScene", package.seeall)

local m_ui=nil
local m_layer = nil
local m_nowSceneID = nil
local m_sceneCB = {}
local m_sceneList = {}
local m_titleImg={}
local m_imgTitle1=nil
local m_imgTitel2=nil
local m_commonscene=nil

function createScene()
	local scene=CCScene:create()
	scene:registerScriptHandler(onEvent)

	local imgBg=ImageView:create()
	imgBg:loadTexture("ui/Run/bj0.png",UI_TEX_TYPE_LOCAL)
	scene:addChild(imgBg)
	imgBg:setPosition(ccp(CScreen.getWinSizeWidth()/2,CScreen.getWinSizeHeight()/2))

	m_ui = TouchGroup:create()
    scene:addChild(m_ui)
    m_ui:setPosition(ccp(CScreen.getUIX(),0))
    
    m_commonscene = readGUI("ui/Run/tongyong.json")
    m_ui:addWidget(m_commonscene)

    local btnGold= seekGUI(m_commonscene,"CommonBtnGold")
    local btnRmb=seekGUI(m_commonscene,"CommonBtnRmb")
    local btnBack=seekGUI(m_commonscene,"CommonBtnBack")

    btnGold:addTouchEventListener(onGoldCB)
    btnRmb:addTouchEventListener(onRmbCB)
    btnBack:addTouchEventListener(onBackCB)

   	m_imgTitle1=seekCastGUI(m_commonscene,"comImgTitle1","ImageView")
	m_imgTitel2=seekCastGUI(m_commonscene,"comImgTitle2","ImageView")

    m_layer=nil
    m_nowSceneID=nil
    m_sceneList={}
    --切换界面调用的入口
    m_sceneCB={
    		   [SceneID.Welcome]=showWelcome, 
			   [SceneID.Level] = showLevle, 
			   [SceneID.Prepare]= showPrepare,
			   [SceneID.Kitchen]=showKitchen, 
			   [SceneID.Cook]=showCookLayer, 
			   [SceneID.Player]=showPlayerLayer, 
			   [SceneID.Pet]=showPetLayer, 
			   [SceneID.PlayeLvUp]=showPlayerLvUpLayer, 
			   [SceneID.PetLvUp]=showPetLvUpLayer,
			   [SceneID.Exchange]=showExchange,
			   [SceneID.Charge]=showChargeLayer,
			   [SceneID.Fire]=showFireLayer,
			   [SceneID.Mail]=showMail,
			} 
	--通用界面上面的图标
	m_titleImg={
			   [SceneID.Prepare]= {"ui/Run/title/title_gold.png","ui/Run/zi_zhunbei.png"},
			   [SceneID.Kitchen]={"ui/Run/title/title_role.png","ui/Run/zi_cook.png"},
			   [SceneID.Cook]={"ui/Run/title_food.png","ui/Run/zi_cook.png"},
			   [SceneID.Player]={"ui/Run/title/title_role.png","ui/Run/zi_role.png"},
			   [SceneID.Pet]={"ui/Run/title/title_pet.png","ui/Run/zi_pet.png"},
			   [SceneID.PlayeLvUp]={"ui/Run/title/title_shuxing.png","ui/Run/zi_att.png"},
			   [SceneID.PetLvUp]={"ui/Run/title/title_shuxing.png","ui/Run/zi_att.png"},
			   [SceneID.Exchange]={"ui/Run/title/title_gold.png","ui/Run/zi_duihuan.png"},
			   [SceneID.Charge]={"ui/Run/title_chongzhi.png","ui/Run/zi_chongzhi.png"},
			   [SceneID.Fire]={"ui/Run/title_chongzhi.png","ui/Run/zi_chongzhi.png"},
			} 

    return scene
end

function onEvent( event )
	if event == "enter"  then
		onEnter()
	elseif event == "exit" then
		onExit()
	end
end

function onEnter(  )
	updateNum()
	switchLayer()
	addNotice(self, updateNum,LocalMsg.RmbChange)
	addNotice(self, updateNum,LocalMsg.GoldChange)
end

function onExit(  )
    m_layer=nil
    m_nowSceneID=nil
    m_sceneList={}
    removeNotice(self,LocalMsg.RmbChange)
    removeNotice(self,LocalMsg.GoldChange)
end

function getNowSceneID(  )
	return m_nowSceneID or SceneID.Welcome
end

--更新金币代币显示
function updateNum(  )
	local labGold=seekCastGUI(m_commonscene,"commonLabGold","LabelAtlas")
	labGold:setStringValue(UserData.getGold())

	local labRmb=seekCastGUI(m_commonscene,"commonLabRmb","LabelAtlas")
	labRmb:setStringValue(UserData.getRmb())
end
--点击加金币响应
function onGoldCB( sender, eventType )
	if judgeEndEvent(eventType) then
		Audio.playSound("ui_btn")
		goToScene(SceneID.Exchange,m_nowSceneID)
	end
end
--点击加代币响应
function onRmbCB( sender, eventType )
	if judgeEndEvent(eventType) then
		Audio.playSound("ui_btn")
		goToScene(SceneID.Charge,m_nowSceneID)
	end
end
--点击返回按钮
function onBackCB( sender, eventType )
	if judgeEndEvent(eventType) then
		Audio.playSound("ui_btn")
		local senceID=table.remove(m_sceneList)
		if senceID==SceneID.Charge or senceID==SceneID.Exchange then
			onBackCB(nil,ccs.TouchEventType.ended)
			return
		end
		goToScene(senceID,m_nowSceneID,false)
	end
end
--进行界面切换
function switchLayer( )
	if m_layer~=nil then
		m_layer:removeAllChildrenWithCleanup(true)
		m_layer:removeFromParentAndCleanup(true)
		m_layer=nil
	end

	if m_nowSceneID==SceneID.Welcome or m_nowSceneID==SceneID.Level or m_nowSceneID==SceneID.Mail then
		local runScene=m_sceneCB[m_nowSceneID]()
		CCDirector:sharedDirector():replaceScene(runScene)
		return
	end

	m_layer=m_sceneCB[m_nowSceneID]()
	m_layer:setPosition(ccp(CScreen.getUIX(),0))
	local scene=CCDirector:sharedDirector():getRunningScene()
    scene:addChild(m_layer)

    local img=m_titleImg[m_nowSceneID]
    m_imgTitle1:loadTexture(img[1])
	m_imgTitel2:loadTexture(img[2])
end
--设置返回列表
function setScene( goSceneID,nowSceneID,back )
	m_nowSceneID=goSceneID
	if back then
		table.insert(m_sceneList,nowSceneID)
	end
end
--back需不需要退回nowSceneID
function goToScene( goSceneID,nowSceneID,back )
	if back==nil then
		back=true
	end

	if nowSceneID==SceneID.Welcome or nowSceneID==SceneID.Level or nowSceneID==SceneID.Mail then
		local scene=createScene()
		setScene(goSceneID,nowSceneID,back)
		CCDirector:sharedDirector():replaceScene(scene)
		return
	end

	setScene(goSceneID,nowSceneID,back)
	switchLayer()
end

function showWelcome( )
	return require("welcome.WelcomeScene").new()
end

function showLevle()
	return require("levelSelect.LevelSelectScene").new()
end

function showPrepare(  )
	return require("prepare.PrepareLayer").new()
end

function showKitchen(  )
	return require("kitchen.KitchenLayer").new()
end

function showCookLayer( )
	return require("kitchen.CookLayer").new()
end

function showPlayerLayer(  )
	return require("display.RoleLayer").new(RoleType.Player) 
end

function showPetLayer(  )
	return require("display.RoleLayer").new(RoleType.Pet) 
end

function showPlayerLvUpLayer(  )
	return require("levelUp.RoleLvUpLayer").new(RoleType.Player) 
end

function showPetLvUpLayer(  )
	return require("levelUp.PetLvUpLayer").new(RoleType.Pet,onBackCB) 
end

function showChargeLayer(  )
	return require("charge.ChargeLayer").new()
end

function showExchange(  )
	return require("charge.ExchangeLayer").new()
end

function showFireLayer()
	return require("kitchen.FireLayer").new()
end

function showMail(  )
	return require("mail.MailScene").new()
end