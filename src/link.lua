--测试函数
function testcreat()

	local tab= {}
	for line in io.lines("src/TestLeave.txt") do
		splitlist = {}
		string.gsub(line, '[^,]+', function(w) table.insert(splitlist, w) end )
		table.insert(tab, splitlist)
	end

	print(isConnection(tab,2,2,4,2))
	print(isConnection(tab,2,2,3,3))
	print(isConnection(tab,3,4,4,7))
	print(isConnection(tab,2,2,5,2))
	print(isConnection(tab,7,3,7,5))
	print(isConnection(tab,2,6,4,6))
	print(isConnection(tab,4,7,4,5))
	print(isConnection(tab,7,3,2,3))
end



---------------
---判断入口
function isConnection(tabel,C1,R1,C2,R2)

	cclog("rukou %s    %s   %s    %s   ",C1,R1,C2,R2)
	if tabel ~= nil then
		if tonumber(tabel[R1][C1]) ~= tonumber(tabel[R2][C2]) then
			cclog("不是一对")
			return false
		end
		cclog("A(%s,%s):%s === B(%s,%s):%s",C1,R1,tabel[R1][C1], C2,R2,tabel[R2][C2])
		if  C1 ==C2 then
			if R1==R2 then
				cclog("位置相同")
				return false
			end
		end
		if islineConnection(tabel,C1,R1,C2,R2) then
			cclog("\n 直线连接")
			return true
		elseif   isOneCornerConnection(tabel,C1,R1,C2,R2) then
			cclog("\n 一个折点")
			return true
		elseif  isTwoCornerConnection(tabel,C1,R1,C2,R2) then
			cclog("\n 两次匹配")
			return true
		else
			cclog("无匹配数据50")
			return false
		end
	end
end

----单行
function islineConnection(tabel,C1,R1,C2,R2)
	--cclog("直连测试： %s    %s   %s    %s   ",C1,R1,C2,R2)
	
	local temp
	--同一列连接
	if C1==C2 then
		local i=1
		temp = math.abs(R2-R1)
		if R2>R1 then
			--相邻
			if R1+1 == R2 then
				--cclog("相邻")
				return true
			end
			while i < temp do
				if tonumber(tabel[R1+i][C1]) ~= 0 then
					--cclog("垂直直连中断")
					return false
				end
				i=i+1
			end
			return true
		else
			--相邻
			if R2+1 == R1 then
				--cclog("相邻")
				return true
			end
			while i < temp do
				if tonumber(tabel[R1-i][C1]) ~= 0 then
					--cclog("垂直直连中断")
					return false
				end
				i=i+1
			end
			return true
		end
	end
	--同行连接
	if R1==R2 then
		local i=1
		temp = math.abs(C2-C1)
		if C2>C1 then
			--相邻
			if C1+1 == C2 then
				--cclog("相邻")
				return true
			end
			while i < temp do
				if tonumber(tabel[R1][C1+i]) ~= 0 then
					--cclog("水平直连失败95")
					return false
				end
				i=i+1
			end
			return true
		else
			--相邻
			if C2+1 == C1 then
				return true
			end
			while i < temp do
			--cclog("====>  %s",i)
				if tonumber(tabel[R1][C1-i])~= 0 then
					--cclog("水平直连失败104")
					return false
				end
				i=i+1
			end
			return true
		end
		
	end
	--cclog("直连失败")
	return false
end

function isOneCornerConnection(tabel,C1,R1,C2,R2)
		
	--cclog("isOneCornerConnection %s    %s   %s    %s   ",C1,R1,C2,R2)
	if tonumber(tabel[R2][C1])==0 then
		
		if 	islineConnection(tabel,C1,R1,C1,R2) then 
			--cclog("---------129")
			if	islineConnection(tabel,C2,R2,C1,R2) then
				return true
			end
		end
	end
	if tonumber(tabel[R1][C2])==0 then
		
		if 	islineConnection(tabel,C1,R1,C2,R1) then
			if islineConnection(tabel,C2,R2,C2,R1) then
				--cclog("---------139")
				return true
			end
		end
	end
	--cclog("一折失败138")
	return false
end


function isTwoCornerConnection(tabel,C1,R1,C2,R2)

	--cclog("isTwoCornerConnection%s    %s   %s    %s   ",C1,R1,C2,R2)
	local i=0
	--cclog("左扫开始")
	for i= C1-1,1,-1 do
			--cclog("158===%s==%s    %s   %s    %s   ",i,C1,R1,C2,R2)
			--cclog("158%s ",tonumber(tabel[R1][i]) )
		if tonumber(tabel[R1][i]) ~=0 then
			--i=1
			--cclog("左扫184  %s  %s",i,tabel[R1][i])
			break
		elseif isOneCornerConnection(tabel,i,R1,C2,R2) then
			--cclog("左扫成功")
			return true
		end
	end
	
	--往上扫描
	--cclog("上扫开始")
	for i=R1-1,1,-1 do
		if tonumber(tabel[i][C1])~= 0 then
			--i=1
			break
		elseif isOneCornerConnection(tabel,C1,i,C2,R2) then
		--cclog("上扫成功")
			return true
		end
	end
	
	--往右扫描
	
	for i=C1+1,table.getn(tabel[R1]),1 do
		if tonumber(tabel[i][C1])~=0 then
			i=table.getn(tabel[R1])
			break
		elseif isOneCornerConnection(tabel,i,R1,C2,R2) then
			return true
		end
	end
	
	--往下扫描
	
	for i=R1+1,table.getn(tabel),1 do
		if tonumber(tabel[i][C1])~=0 then
		i=table.getn(tabel)
		break
		elseif isOneCornerConnection(tabel,C1,i,C2,R2) then
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
	--cclog(" %s    %s   ",tabelRow,tabelCol)
	
	local tabel=creatNullTabel(tabelRow,tabelCol)
	math.randomseed(os.time())
	
	while total > 0 do
		--记录两个点的位置
		local C1= 0
		local R1= 0
		local C2= 0
		local R2= 0
		--图像索引
		local spriteindex = math.random(NumbelMix,NumbelMax)
		
		--模拟添加第一个点
		while C1==0  do
			while R1==0  do
				local xa= math.random(2,tabelCol-1)
				local ya= math.random(2,tabelRow-1)
				if tabel[ya][xa] ==0 then
					C1=xa 
					R1=ya
				end
			end
		end
		 --模拟添加第er个点
		while C2==0 do
			while R2==0 do
				local xb= math.random(2,tabelCol-1)
				local yb= math.random(2,tabelRow-1)
				if tabel[yb][xb] ==0 then
						C2=xb 
						R2=yb
				end
			end
		end
		--cclog("spriteindex:%s   end：%s %s %s %s ",spriteindex,C1,R1,C2,R2)
		--if isConnection(tabel,C1,R1,C2,R2) then
			tabel[R1][C1]=spriteindex
			tabel[R2][C2]=spriteindex
			total = total -1
			--cclog("===========  %s   ==============",total)
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
	
	--print(_dump(root, "",""))
	
	local file = io.open("src/leave.txt","a")
	 file:write(string.format(_dump(root, "","").."\n\n==========================="..os.date().."==========================\n"))
	 file:close()
end
