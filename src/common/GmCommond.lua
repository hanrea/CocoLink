--GM命令
module("GmCommond", package.seeall)

function onGmCB( )
	local id=Bit.synAll()
	NetdataHandler.sendSynchro(id)
end

function addGold( num )
	if num>0 then
		NetdataHandler.sendGM(1,num,0,onGmCB)
	else
		NetdataHandler.sendGM(2,-num,0,onGmCB)
	end
end

function addRmb( num )
	if num>0 then
		NetdataHandler.sendGM(3,num,0,onGmCB)
	else
		NetdataHandler.sendGM(4,-num,0,onGmCB)
	end
end

function addCapNum( num )
	if num>0 then
		NetdataHandler.sendGM(5,num,0,onGmCB)
	else
		NetdataHandler.sendGM(6,-num,0,onGmCB)
	end
end

function setLVID( lv )
	NetdataHandler.sendGM(7,lv,0,onGmCB)
end

function addFood( id,num )
	if id==nil then
		id,num=4101,99
	end
	NetdataHandler.sendGM(8,id,num,onGmCB)
end

function addMaterial( id,num )
	NetdataHandler.sendGM(9,id,num,onGmCB)
end

function addTool( id,num )
	NetdataHandler.sendGM(10,id,num,onGmCB)
end

function unlockRole( id )
	NetdataHandler.sendGM(11,id,0,onGmCB)
end

function addPet( id )
	NetdataHandler.sendGM(12,id,0,onGmCB)
end