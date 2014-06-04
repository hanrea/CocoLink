--------------
-----动画-----
--------------

--记录当前表
local leaveTabel={}
function getLeaveTabel( )
	return leaveTabel
end
function setLeaveTabel(tab )
	 leaveTabel  =tab
end
--记录点击
local indextabel={cliA={col=0 ,row=0},cliB={col=0 ,row=0}}
function getIndexTabel( )
	return indextabel
end
function setIndexTabelA(tab)
	 indextabel["cliA"]  =tab
end
function setIndexTabelB(tab )
	 indextabel["cliB"]  =tab
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

--------------
-----动画-----
--------------

--异步加载动画
function addArmatureAsync(fileName,hanlder )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfoAsync(fileName, hanlder)
end
--同步加载动画
function addArmature( fileName )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(fileName)
end
