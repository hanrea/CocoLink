--计时器
module("Timer", package.seeall)

local m_timerList={}
local m_timeEntryID=nil


function start( )
	m_timeEntryID=CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateTime, 0, false)
end

function stop(  )
	m_timerList={}
	CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(m_timeEntryID)
end

function updateTime( )
	for k,v in pairs(m_timerList) do
		if v.time<=os.time() then
			(v.hanlder)()
			m_timerList[k]=nil
		end
	end
end
--futureTime未来时间，与os.time()同单位级
function addTimer( key,futureTime,hanlder )
	if m_timerList[key]~=nil then
		return
	end
	
	m_timerList.key={time=futureTime,hanlder=hanlder}
end

function getTime( key )
	return m_timerList[key].time
end