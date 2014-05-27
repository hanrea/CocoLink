--------------
-----动画-----
--------------

--
local leaveTabel={}
function getLeaveTabel( )
	return leaveTabel
end
function setLeaveTabel(tab )
	 leaveTabel  =tab
end



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
function addArmatureAsync( fileName,hanlder )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfoAsync(fileName, hanlder)
end
--同步加载动画
function addArmature( fileName )
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(fileName)
end

function testcreat(tabelRow,tabelCol,NumbelMix,NumbelMax)
	NumbelMix = math.ceil(NumbelMix) or 0
	NumbelMax = math.ceil(NumbelMax) or 100
	local tab={}
	math.randomseed(os.time())
	for i=1,tabelRow do
		tabRow={}
		for j=1,tabelCol do
			tabRow[j]=0
			--tabRow[j]=math.random(NumbelMix,NumbelMax)
			--print(math.random(NumbelMix,NumbelMax))
			--print("tab["..i.."]["..j.."]===>"..tab[i][j])
		end
		tab[i]=tabRow
	end
	--print_r(tab)
	---test
	print(isConnection(tab,1,1,1,1))
	print(isConnection(tab,1,1,1,2))
	print(isConnection(tab,1,2,3,3))
	print(isConnection(tab,2,2,4,4))
	
	
end


---------------
---判断入口
function isConnection(tabel,x1,y1,x2,y2)
		print_r(tabel)
	cclog("rukou %f    %f   %f    %f   ",x1,y1,x2,y2)
	if  x1 ==x2 then
		
		if y1==y2 then
			cclog("---------61")
			return false
		end
	end
	if islineConnection(tabel,x1,y1,x2,y2) then
		cclog("直线连接成功")
		return true
	elseif   isOneCornerConnection(tabel,x1,y1,x2,y2) then
		cclog("直角连接成功")
		return true
	elseif  isTwoCornerConnection(tabel,x1,y1,x2,y2) then
		cclog("两个拐角连接成功")
		return true
	else
		cclog("连接失败")
		return false
	end
end

----单行
function islineConnection(tabel,x1,y1,x2,y2)
	cclog("直线连接：A;[%f][%f]   B:[%f][%f ]",x1,y1,x2,y2)
	local i=0
	local temp
	
	if x1==x2 then
		local caltabel = tabel[x1]
		temp = math.abs(y2-y1)
		if y2>y1 then
			for i=1,temp do
				if caltabel[y1+i] ~= 0 then
					cclog("---------66")
					return false
				end
			end
		else
			for i=1,temp do
				if caltabel[y1-i] ~= 0 then
					cclog("---------73")
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
					cclog("---------88")
					return false
				end
			end
		else
			for i=1,temp do
				local rowtabel =tabel[x1+1]
				if rowtabel[y1] ~= 0 then
					cclog("---------96")
					return false
				end
			end
		end
	end
	
	return true
end



function isOneCornerConnection(tabel,x1,y1,x2,y2)
	cclog("直角连接：A;[%f][%f]   B:[%f][%f ]",x1,y1,x2,y2)
	if tabel[x1][y2]==0 then
		cclog("---------141")
		if 	islineConnection(tabel,x1,y1,x1,y2) then 
			cclog("---------143")
			if	islineConnection(tabel,x2,y2,x1,y2) then
				return true
			end
		end
	end
	if tabel[x2][y1]==0 then
		cclog("---------150")
		if 	islineConnection(tabel,x1,y1,x2,y1) then
			
			if islineConnection(tabel,x2,y2,x2,y1) then
				cclog("---------154")
				return true
			end
		end
	end
	return false
end


function isTwoCornerConnection(tabel,x1,y1,x2,y2)
	cclog("两直角连接：A;[%f][%f]   B:[%f][%f ]",x1,y1,x2,y2)

	cclog("向左扫描")

	for i=y1-1,i>=0,i-1 do
		if tabel[x1][i]~= 0 then
		
		elseif isOneCornerConnection(tabel,x1,i,x2,y2) then
			return true
		end
	end
	
	cclog("往上扫描")
	for i= x1-1,i>=0,i-1 do
		if tabel[i][y1]~=0 then
		elseif isOneCornerConnection(tabel,i,y1,x2,y2) then
			return true
		end
	end
	
	cclog("往上扫描")
	for i=y1+1,table.getn(tabel[y1]),i+1 do
		if tabel[x1][i]~=0 then
		elseif isOneCornerConnection(tabel,x1,i,x2,y2) then
			return true
		end
	end
	
	cclog("往下扫描")
	for i=x1+1,table.getn(tabel),i+1 do
		if tabel[i][x1]~=0 then
		elseif isOneCornerConnection(tabel,i,y1,x2,y2) then
			return true
		end
	end
	return false
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
	
	--print_r(tab)
end

---生成  /  归零表格
function creatNullTabel(tabelRow,tabelCol,tabel)
	tabel=tabel or {}
	for i=1,tabelRow do
		tabRow= tabel[i] or {}
		for j=1,tabelCol do
			tabRow[j]=0
		end
		tabel[i]=tabRow
	end
	return tabel
end

--行、列、最小值、最大值
--生成随机表格,对对碰

function creatDoubleRandomTable(tabelRow,tabelCol,NumbelMix,NumbelMax)
	NumbelMix = math.ceil(NumbelMix) or 0
	NumbelMax = math.ceil(NumbelMax) or 10
	tabelRow= math.ceil(NumbelMax/2)*2+2
	tabelCol= math.ceil(tabelCol/2)*2+2
	local total = tabelRow * tabelCol /2
	local tabel=creatNullTabel(tabelRow,tabelCol)
	math.randomseed(os.time())
	
	for t=0,total do
		--记录两个点的位置
		local x1= 0
		local y1= 0
		local x2= 0
		local y2= 0
		--图像索引
		local spriteindex = math.random(NumbelMix,NumbelMax)
		
		--模拟添加第一个点
		while x1==0  do
			while y1==0  do
				local xa= math.random(1,tabelCol)
				local ya= math.random(1,tabelRow)
				if tabel[xa][ya] ==0 then
					cclog("addone")
					x1=xa 
					y1=ya
				end
			end
		end
		 --模拟添加第er个点
		while x2==0 do
			while y2==0 do
				local xb= math.random(1,tabelCol)
				local yb= math.random(1,tabelRow)
				if tabel[xb][yb] ==0 then
					cclog("addtwo")
					x2=xb 
					y2=yb
				end
			end
		end
		cclog("spriteindex:%f   end：%f    %f   %f    %f   ",spriteindex,x1,y1,x2,y2)
		--if isConnection(tabel,x1,y1,x2,y2) then
			tabel[x1][y1]=spriteindex
			tabel[x2][y2]=spriteindex
		--end
	end
	print_r(tabel)

end


--yunfeng log
function print_r(root)
	-- local print = print
	-- local tconcat = table.concat
	-- local tinsert = table.insert
	-- local srep = string.rep
	-- local type = type
	-- local pairs = pairs
	-- local tostring = tostring
	-- local next = next
	
	-- local cache = {  [root] = "." }
	-- local function _dump(t,space,name)
		-- local temp = {}
		-- for k,v in pairs(t) do
			-- local key = tostring(k)
			-- if cache[v] then
				-- tinsert(temp,"     +    " .. key .. " {" .. cache[v].."}")
			-- elseif type(v) == "table" then
				-- local new_key = name .. "." .. key
				-- cache[v] = new_key
				-- tinsert(temp,"\n+     " .. key .."\n   ".. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
			-- else
				-- tinsert(temp,"     +   " .. key .. " ==>" .. tostring(v))
			-- end
		-- end
		-- return tconcat(temp,"\n"..space)
	-- end
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
				tinsert(temp,"\n" .. "".. _dump(v,space .. (next(t,k) and "" or " " ).. srep("",#key),new_key))
			else
				tinsert(temp,"\t" ..  "" .. tostring(v))
			end
		end
		return tconcat(temp,""..space)
	end
	file = io.open("src/a.txt","w")
	file:write(string.format(_dump(root, "","")))
	file:close()
	--print(_dump(root, "",""))
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