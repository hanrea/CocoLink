-- 返回一个点 point (CCPoint)
function ccp(x, y)
	return CCPoint(x, y)
end

-- 返回一个size (CCSize)
function ccsi(w,h)
	return CCSize(w,h);
end

-- 返回一个矩形 (CCRect)
function ccr(x,y,w,h)
	return CCRectMake(x,y,w,h);
end

function getIcon( id )
	return string.format("icon/%s.png",id)
end

-- 拆分字符串
function split(szFullString, szSeparator)  
	local nFindStartIndex = 1  
	local nSplitIndex = 1  
	local nSplitArray = {}  
	while true do  
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
	   if not nFindLastIndex then  
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
		break  
	   end  
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
	   nSplitIndex = nSplitIndex + 1  
	end  
	return nSplitArray  
end 



-- 数值格式化
function numFormat(num)
	num = tonumber(num)
	local txt = 0
	if num >= 0 and num < 10000 then
		txt = num
	else
		local numLen = string.len(num)
		if numLen <= 8 then
			txt = string.sub(num,1,-4).."w"
		elseif numLen <= 12 then
			txt = string.sub(num,1,-7).."m"
		elseif numLen <= 20 then
			txt = string.sub(num,1,-9).."b"
		end
	end
	return txt
end

--日期格式化  num 秒数
function dateFormat( num )
	num=tonumber(num)
	local day=math.floor(num/864000)
	local hour = math.floor(math.mod(num,864000)/3600)
	local min = math.floor(math.mod(num,3600)/60)
	local sec = math.floor(math.mod(num,60))
	local txt = nil
	if day>0 then
		txt=string.format("%d天%d:%02d:%02d",day,hour,min,sec)
	elseif hour>0 then
		txt=string.format("%02d:%02d:%02d",hour,min,sec)
	else
		txt=string.format("%02d:%02d",min,sec)
	end
	return txt
end

-- 过滤
function filter(fStr, fWord, fType)
	local tTab = Split(fWord, "|")
	if fType == 0 then
		for k,v in pairs(tTab) do
		    if string.len(v) > 0 then
		        fStr = string.gsub(fStr,v,"***")
		    end			
		end
	else
		local findWord, findStart, findEnd  
		for k,v in pairs(tTab) do
			if string.len(v) > 0 then
				findStart, findEnd = string.find(fStr,v)	
				if findStart ~= nil then
					findWord = string.sub(fStr, findStart, findEnd)
					break
				end
		    end		
		end	
		return findWord
	end
	return fStr
end

-- 聊天 敏感词过滤
function filterChat(chatStr)
	return filter(chatStr, GameFilterWords.CREATE_ROLE_FILTER, 0)
end

-- 创建角色 敏感词过滤
function filterCreateRole(nameStr)
	return filter(nameStr, GameFilterWords.CREATE_ROLE_FILTER, 1)
end

--简单弹窗显示
local m_popUpLayer=nil
function showMessage( str )
	local scene=CCDirector:sharedDirector():getRunningScene()
	local width,height=400,200

	m_popUpLayer=YYPopupLayer:create()
	m_popUpLayer:setAnchorPoint(ccp(0,0))
	m_popUpLayer:setPosition(ccp(0,0))
	scene:addChild(m_popUpLayer)

	local panel=TouchGroup:create()
	panel:setAnchorPoint(ccp(0,0))
	m_popUpLayer:addChild(panel)

	local sp=ImageView:create()
	sp:setAnchorPoint(ccp(0,0))
	sp:loadTexture("ui/Run/panel1.png")
	sp:setScale9Enabled(true)
	panel:addWidget(sp)

	local lab=Label:create()
	lab:setText(str)
	lab:setFontSize(29)
    lab:setFontName("Arial")
    lab:setTextAreaSize(CCSizeMake(270,0))
	lab:setAnchorPoint(ccp(0,0))
	lab:setPosition(ccp(40,70))
	lab:setColor(ccc3(255,255,255))
	lab:setTextHorizontalAlignment(kCCTextAlignmentRight)
	sp:addChild(lab)
	sp:setSize(CCSizeMake(width,lab:getContentSize().height+120))

	local labDown=Label:create()
	labDown:setAnchorPoint(ccp(0,0))
	labDown:setText(GameString.QuickTip)
	labDown:setFontSize(23)
    labDown:setFontName("Arial")
	labDown:setPosition(ccp(width-labDown:getContentSize().width-30,20))
	sp:addChild(labDown)

	local array = CCArray:create()
	array:addObject(CCDelayTime:create(1))
	array:addObject(CCMoveBy:create(0.2,ccp(0,100)))
	array:addObject(CCFadeOut:create(0.2))
	array:addObject( CCCallFunc:create(hideMessage))
    local action = CCSequence:create(array)

	panel:setPosition(ccp((CScreen.getWinSizeWidth()-width)/2,(768)/2))
	panel:runAction(action)
end

function hideMessage(  )
	if m_popUpLayer~=nil then
		m_popUpLayer:removeAllChildrenWithCleanup(true)
		m_popUpLayer:removeFromParentAndCleanup(true)
		m_popUpLayer=nil
	end
end

function showAlert( txt,hanlder )
	require("common.AlertLayer").new(txt,hanlder)
end

function replaceScene(scene)
	CCDirector:sharedDirector():replaceScene(scene)
end
--判断是否是按钮弹出事件
function judgeEndEvent(eventType)
	return eventType == ccs.TouchEventType.ended
end
--在touchground找child
function seekChild( guiRoot,childName )
	return guiRoot:getWidgetByName(childName)
end
--读取CCS的UI文件
function readGUI( path )
	return GUIReader:shareReader():widgetFromJsonFile(path)
end
--根据名字找UI
function seekGUI( guiRoot,childName )
	return UIHelper:seekWidgetByName(guiRoot, childName)
end
--强制转换UI
function castGUI( gui,className )
	return tolua.cast(gui, className)
end
--找到UI并强制转换
function seekCastGUI( guiRoot,childName,className )
	return castGUI(seekGUI( guiRoot,childName ),className)
end
--异步加载动画
function addArmatureAsync( fileName,hanlder )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfoAsync(fileName, hanlder)
end
--同步加载动画
function addArmature( fileName )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(fileName)
end
--增加一个通知侦听
function addNotice( object,hanlder,message )
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(object, hanlder,message)
end
--移除一个通知侦听
function removeNotice( object,message  )
	CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(object,message)
end
--发送一个通知
function postNotice( message )
	CCNotificationCenter:sharedNotificationCenter():postNotification(message,nil)
end

-- 读取文件内容
function loadStringFromFile( fileName )
	return CCString:createWithContentsOfFile(CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)):getCString()
end

-- 读取json中的数据
function loadContent( filename )
	local cjson = require "cjson"
	return cjson.decode(loadStringFromFile(filename))
end

-- 生成一个空的GO额外信息
function createEmptyExtConfig(  )
	local cjson = require "cjson"
	return cjson.decode("{\"id\":\"0\",\"h\":\"0\"}")
end

--金币不足
function showNoEnoughGold(  )
	showAlert(GameString.NotGold,function() CommonScene.goToScene(SceneID.Exchange,CommonScene.getNowSceneID()) end)
end
--代币不足
function showNoEnoughRmb(  )
	showAlert(GameString.NotRmb,function() CommonScene.goToScene(SceneID.Charge,CommonScene.getNowSceneID()) end)
end