LinkTabel = {}

function LinkTabel:instance()
    local o = _G.gameTabel
    if o then return o end
    o = {leaveTabel={},clickTabel={cliA={col=0 ,row=0},cliB={col=0 ,row=0}}}
    _G.gameTabel = o
    setmetatable(o, self)
    self.__index = self
    return o
end

function LinkTabel:setLeaveTabel(tab)
	 _G.gameTabel["leaveTabel"] = tab
end

function LinkTabel:getLeaveTabel()
    return   _G.gameTabel["leaveTabel"]
end

--记录点击
 --clickTabel={cliA={col=0 ,row=0},cliB={col=0 ,row=0}}
function LinkTabel:setClickTabelA(tab)
	_G.gameTabel["clickTabel"]["cliA"]  =tab
end

function LinkTabel:setClickTabelB(tab)
	 _G.gameTabel["clickTabel"]["cliB"]  =tab
end

function LinkTabel:getClickTabel()
	return _G.gameTabel["clickTabel"]
end

function LinkTabel:clear()
    _G.gameTabel = false
end

