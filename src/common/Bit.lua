--二进制操作 同步信息
module("Bit", package.seeall)

local setList={[0]=0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80,0x100,0x200,0x400,0x800,0x1000,0x2000,0x4000,0x8000}

--把相应的位index设置为1
function set( x,index )
	return libBit.bit:_xor(x,setList[index])
end
--相应的位index是否置为1
function isset( x,index )
	local param=libBit.bit:_and(x,setList[index])
	if param==nil or param==0 then
		return false
	else
		return true
	end
end

--102 同步信息 金币0	代币1	关卡2	角色3	倒计时4	帽子5	角色6	宠物7
--食材8	菜肴9	道具10
function synGold( param )
	return set(param,0)
end
function synRmb( param )
	return set(param,1)
end
function synLv( param )
	return set(param,2)
end
function synPlayerID( param )
	return set(param,3)
end
function synCDTime( param )
	return set(param,4)
end
function synCapNum( param )
	return set(param,5)
end
function synPlayerList( param )
	return set(param,6)
end
function synPetList( param )
	return set(param,7)
end
function synMaterial( param )
	return set(param,8)
end
function synFood( param )
	return set(param,9)
end
function synTool( param )
	return set(param,10)
end

function synAll(  )
	local param=0
	param=synGold(param)
	param=synRmb(param)
	param=synLv(param)
	param=synPlayerID(param)
	param=synCDTime(param)
	param=synCapNum(param)
	param=synPlayerList(param)
	param=synPetList(param)
	param=synMaterial(param)
	param=synFood(param)
	param=synTool(param)
	return param
end
