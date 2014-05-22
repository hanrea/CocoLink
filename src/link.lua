
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
	print(isConnection(tab,1,1,1,1))--false
	print(isConnection(tab,1,1,1,2))--true1
	print(isConnection(tab,1,2,3,3))--true2
	print(isConnection(tab,2,2,4,4))--true2
	print(isConnection(tab,2,2,6,6))--true2	
	
	
end



---------------
---判断入口
function isConnection(tabel,x1,y1,x2,y2)
	cclog("rukou %f    %f   %f    %f   ",x1,y1,x2,y2)
	if  x1 ==x2 then
		if y1==y2 then
			cclog("位置相同")
			return false
		end
	end
	if islineConnection(tabel,x1,y1,x2,y2) then
		cclog("直线连接")
		return true
	elseif   isOneCornerConnection(tabel,x1,y1,x2,y2) then
		cclog("一个折点")
		return true
	elseif  isTwoCornerConnection(tabel,x1,y1,x2,y2) then
		cclog("两次匹配")
		return true
	else
		cclog("无匹配数据50")
		return false
	end

end

----单行
function islineConnection(tabel,x1,y1,x2,y2)
	cclog("islineConnection %s    %s   %s    %s   ",x1,y1,x2,y2)
	
	local temp
	if x1==x2 then
		local i=1
		temp = math.abs(y2-y1)
		if y2>y1 then
			while i < temp do
				if tabel[x1][y1+i] ~= 0 then
					cclog("垂直直连中断66")
					
					return false
				end
				i=i+i
			end
			return true
		else
			while i < temp do
				if tabel[x1][y1-i] ~= 0 then
					cclog("垂直直连中断74")
					return false
				end
				i=i+i
			end
			return true
		end
		
	end
	if y1==y2 then
		local i=1
		temp = math.abs(x2-x1)-1
		cclog("yyyyyyy==86==%s  temp ==%s",y1,temp)
		if x2>x1 then
			while i < temp do
				cclog("====>  %s",i)
				if tabel[x1+i][y1] ~= 0 then
					cclog("直连失败95")
					return false
				end
				i=i+i
			end
			return true
		else
			while i < temp do
			cclog("====>  %s",i)
				if tabel[x1-i][y1] ~= 0 then
					cclog("直连失败104")
					return false
				end
				i=i+i
			end
			return true
		end
		
	end
	cclog("直连失败112")
	return false
end

function isOneCornerConnection(tabel,x1,y1,x2,y2)
		
	--cclog("isOneCornerConnection %s    %s   %s    %s   ",x1,y1,x2,y2)
	if tabel[x1][y2]==0 then
		cclog("---------127")
		if 	islineConnection(tabel,x1,y1,x1,y2) then 
			cclog("---------129")
			if	islineConnection(tabel,x2,y2,x1,y2) then
				return true
			end
		end
	end
	if tabel[x2][y1]==0 then
		
		if 	islineConnection(tabel,x1,y1,x2,y1) then
			if islineConnection(tabel,x2,y2,x2,y1) then
				cclog("---------139")
				return true
			end
		end
	end
	cclog("一折失败138")
	return false
end


function isTwoCornerConnection(tabel,x1,y1,x2,y2)

	cclog("isTwoCornerConnection%s    %s   %s    %s   ",x1,y1,x2,y2)
	local i=0
	--往左扫描
	for i= x1-1,1,-1 do
			cclog("158===%s==%s    %s   %s    %s   ",i,x1,y1,x2,y2)
		if tabel[i][y1] ~=0 then
			i=1
			break
		elseif isOneCornerConnection(tabel,i,y1,x2,y2) then
		cclog("左扫成功")
			return true
		end
	end
	
	--往上扫描
	
	for i=y1-1,1,-1 do
		if tabel[x1][i]~= 0 then
			i=1
			break
		elseif isOneCornerConnection(tabel,x1,i,x2,y2) then
		cclog("上扫成功")
			return true
		end
	end
	
	--往右扫描
	
	for i=x1+1,table.getn(tabel[y1]),1 do
		if tabel[i][x1]~=0 then
			i=table.getn(tabel[y1])
			break
		elseif isOneCornerConnection(tabel,i,y1,x2,y2) then
			return true
		end
	end
	
	--往下扫描
	
	for i=y1+1,table.getn(tabel),1 do
		if tabel[x1][i]~=0 then
		i=table.getn(tabel)
		break
		elseif isOneCornerConnection(tabel,x1,i,x2,y2) then
			return true
		end
	end
	return false
end

--行、列、最小值、最大值,一个边缘
--生成随机表格,对对碰

function creatDoubleRandomTable(tabelRow,tabelCol,NumbelMix,NumbelMax)
	NumbelMix = math.ceil(NumbelMix) or 1
	NumbelMax = math.ceil(NumbelMax) or 9
	local total = tabelRow * tabelCol /2
	tabelRow= math.ceil(tabelRow/2)*2+2
	tabelCol= math.ceil(tabelCol/2)*2+2
	cclog(" %s    %s   ",tabelRow,tabelCol)
	
	local tabel=creatNullTabel(tabelRow,tabelCol)
	math.randomseed(os.time())
	
	while total > 0 do
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
				local xa= math.random(2,tabelCol-1)
				local ya= math.random(2,tabelRow-1)
				if tabel[ya][xa] ==0 then
					x1=xa 
					y1=ya
				end
			end
		end
		 --模拟添加第er个点
		while x2==0 do
			while y2==0 do
				local xb= math.random(2,tabelCol-1)
				local yb= math.random(2,tabelRow-1)
				if tabel[yb][xb] ==0 then
						x2=xb 
						y2=yb
				end
			end
		end
		cclog("spriteindex:%s   end：%s %s %s %s ",spriteindex,x1,y1,x2,y2)
		--if isConnection(tabel,x1,y1,x2,y2) then
			tabel[y1][x1]=spriteindex
			tabel[y2][x2]=spriteindex
			total = total -1
			cclog("===========  %s   ==============",total)
			if total ==0 then
				print_r(tabel)
			end
		--end
		
	end
	

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

--- 读取表格文件
function creatTabelfromeFile()
	tabel= {}
	for line in io.lines("src/leave.txt") do
		splitlist = {}
		string.gsub(line, '[^,]+', function(w) table.insert(splitlist, w) end )
		table.insert(tabel, splitlist)
	end
	--io:close()
	print_r(tabel)
	--return tabel
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
				tinsert(temp,"\n" .. "".. _dump(v,space .. (next(t,k) and "" or "" ).. srep("",#key),new_key))
			else
				if #temp ==0 then
				tinsert(temp,tostring(v))
				else
				tinsert(temp,"," ..  "" .. tostring(v))
				end
			end
		end
		
		return tconcat(temp,""..space)
	end
	
	print(_dump(root, "",""))
	
	local file = io.open("src/leave.txt","a")
	 --file:write(string.format(_dump(root, "","").."\n\n==========================="..os.date().."==========================\n"))
	 file:close()
end
