
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
