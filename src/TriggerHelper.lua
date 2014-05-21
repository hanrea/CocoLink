--------------
-----动画-----
--------------

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
function addArmatureAsync( fileName,hanlder )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfoAsync(fileName, hanlder)
end
--同步加载动画
function addArmature( fileName )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(fileName)
end

---------------
---判断入口
function isConnection(tabel,x1,y1,x2,y2)
	if islineConnection(tabel,x1,y1,x2,y2) or isOneCornerConnection(tabel,x1,y1,x2,y2) or IsTwoCornerConnection(tabel,x1,y1,x2,y2) then
		return true
	else
		return false
	end
end

----单行
function islineConnection(tabel,x1,y1,x2,y2)
	local i=0
	local temp
	if  x1 ==x2 and y1==y2 then
		return false
	end
	if x1==x2 then
		local caltabel = tabel[x1]
		temp = math.abs(y2-y1)
		if y2>y1 then
			for i=1,temp do
				if caltabel[y1+i] ~= 0 then
					return false
				end
			end
		else
			for i=1,temp do
				if caltabel[y1-i] ~= 0 then
					return false
				end
			end
		end
	end

	
	if y1==y2 then
		temp = math.abs(x2-x1)
		if x2>x1 then
			for i=1,temp do
				local rowtabel =tabel[x1+1]
				if rowtabel[y1] ~= 0 then
					return false
				end
			end
		else
			for i=1,temp do
				local rowtabel =tabel[x1+1]
				if rowtabel[y1] ~= 0 then
					return false
				end
			end
		end
	end
end

function isOneCornerConnection(tabel,x1,y1,x2,y2)
	if tabel[x1][y2]==0 and IsLineConnection(tabel,x1,y1,x1,y2) and IsLineConnection(tabel,x2,y2,x1,y2) then
	 return true
	end
	if tabel[x2][y1]==0 and IsLineConnection(tabel,x1,y1,x2,y1) and IsLineConnection(tabel,x2,y2,x2,y1) then
	 return true
	end
	return false
end
function IsTwoCornerConnection(tabel,x1,y1,x2,y2)
	local i
	--往左扫描
	for i=y1-1,i>=0,i-1 do
		if tabel[x1][i]~= 0 then
		elseif isOneCornerConnection(tabel,x1,i,x2,y2) then
			return true
		end
	end
	--往上扫描
	for i= x1-1,i>=0,i-1 do
		if tabel[i][y1]~=0 then
		elseif isOneCornerConnection(tabel,i,y1,x2,y2) then
			return true
		end
	end
	
	--往右扫描
	for i=y1+1,table.getn(tabel[y1]),i+1 do
		if tabel[x1][i]~=0 then
		elseif isOneCornerConnection(tabel,x1,i,x2,y2) then
			return true
		end
	end
	
	--往下扫描
	for i=x1+1,table.getn(tabel),i+1 do
		if tabel[i][x1]~=0 then
		elseif isOneCornerConnection(tabel,i,y1,x2,y2) then
			return true
		end
	end
end

--------------
--数据处理----
--------------
--行、列、最小值、最大值
--生成随机表格
function creatRandomTable(tabelRow,tabelCol,NumbelMix,NumbelMax)
	NumbelMix = math.ceil(NumbelMix) or 0
	NumbelMax = math.ceil(NumbelMax) or 100
	local tab={}
	math.randomseed(os.time())
	for i=1,tabelRow do
		tabRow={}
		for j=1,tabelCol do
			tabRow[j]=math.random(NumbelMix,NumbelMax)
			print(math.random(NumbelMix,NumbelMax))
			--print("tab["..i.."]["..j.."]===>"..tab[i][j])
		end
		tab[i]=tabRow
	end
	print_lua_table(tab)
	print_r(tab)
end

---生成归零表格
function creatNullTabel(tabelRow,tabelCol,tabel)
	tabel=tabel or {}
	for i=1,tabelRow do
		tabRow= tabel[i] or {}
		for j=1,tabelCol do
			tabRow[j]=0
		end
		tabel[i]=tabRow
	end
	-- print_r(tabel)
	return tabel
end

--行、列、最小值、最大值
--生成随机表格,对对碰

function creatDoubleRandomTable(tabelRow,tabelCol,NumbelMix,NumbelMax)
	NumbelMix = math.ceil(NumbelMix) or 0
	NumbelMax = math.ceil(NumbelMax) or 10
	local total = tabelRow * tabelCol /2
	local tabel=creatNullTabel(tabelRow,tabelCol)
	
	tabRow[j]=math.random(NumbelMix,NumbelMax)
	
	math.randomseed(os.time())
	
	for t=0,total do
		--记录两个点的位置
		local x1,y1=0
		local x2,y2=0
		local index = math.random(NumbelMix,NumbelMax)
		
		
		--模拟添加第一个点
		while x1~=- and y1~=0 do
			local xa= math.random(1,tabelCol)
			local ya= math.random(1,tabelRow)
			if tabel[xa][ya] ~=0 then
				x1=xa 
				y1=ya
			end
		end
		 
		 --模拟添加第一个点
		while x2~=- and y2~=0 do
			local xb= math.random(1,tabelCol)
			local yb= math.random(1,tabelRow)
			if tabel[xb][yb] ~=0 then
				x2=xb 
				y2=yb
			end
		end
		
		
	end

	print_lua_table(tab)
	print_r(tab)
end
--yunfeng log
function print_r(root)
	local print = print
	local tconcat = table.concat
	local tinsert = table.insert
	local srep = string.rep
	local type = type
	local pairs = pairs
	local tostring = tostring
	local next = next
	
	local cache = {  [root] = "." }
	local function _dump(t,space,name)
		local temp = {}
		for k,v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				tinsert(temp,"     +    " .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp,"\n+     " .. key .."\n   ".. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
			else
				tinsert(temp,"     +   " .. key .. " ==>" .. tostring(v))
			end
		end
		return tconcat(temp,"\n"..space)
	end
	print(_dump(root, "",""))
end


--打印表格
function print_lua_table(lua_table,indent)
	indent = indent or 0
	for k, v in pairs(lua_table) do
		if type(k) == "string" then
			k = string.format("%q", k)
		end
		local szSuffix = ""
		
		if type(v) == "table" then
			szSuffix = "{"
		end
		local szPrefix = string.rep("    ", indent)
		formatting = szPrefix.."["..k.."]".." = "..szSuffix
		if type(v) == "table" then
			print(formatting)
			print_lua_table(v, indent + 1)
			print(szPrefix.."},")
		else
			local szValue = ""
			if type(v) == "string" then
				szValue = string.format("%q", v)
			else
				szValue = tostring(v)
			end
			print(formatting..szValue..",")
		end
	end
end