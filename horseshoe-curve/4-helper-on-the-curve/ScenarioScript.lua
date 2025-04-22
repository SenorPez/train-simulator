------------------------------------------------
-- ScenarioScript.lua
-- 14/06/2011
-- Copyright 2011 RailSimulator.com ltd
--
-- Scenario Script- 'Helper on the Curve '
------------------------------------------------

-- true/false defn
FALSE = 0
TRUE = 1

-- condition return values
CONDITION_NOT_YET_MET = 0
CONDITION_SUCCEEDED = 1
CONDITION_FAILED = 2

-- Message types
MT_INFO = 0			-- large centre screen pop up
MT_ALERT = 1		-- top right alert message

MSG_TOP = 1
MSG_VCENTRE = 2
MSG_BOTTOM = 4
MSG_LEFT = 8
MSG_CENTRE = 16
MSG_RIGHT = 32

MSG_SMALL = 0
MSG_REG = 1
MSG_LRG = 2

------------------------------------------------
-- Fn OnEvent
-- 		event - name of the event
--	    return - TRUE/FALSE if event handled
function OnEvent ( event )

-- Instruction triggers
---------------------------

-- Timed triggers
---------------------------
	
	if event == "start" then -- Pan around and look at wagons
		
		SysCall ( "CameraManager:ActivateCamera", "start", 0 );
		SysCall ( "ScenarioManager:LockControls");
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "start.html", 20, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "start" then
	
	
		
	if event == "cab" then -- Put in cabview
		
		SysCall ( "CameraManager:ActivateCamera", "CabCamera", 0 );
		SysCall ( "ScenarioManager:UnlockControls");
		return TRUE;
			
	end -- if event == "cab" then
	

	if event == "coupled" then -- message when coupled
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "coupled.html", 5, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "coupled" then
	
	
	if event == "coupled2" then -- another message when coupled
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "coupled2.html", 5, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "coupled" then
	
	if event == "ill" then -- message when Ted is ill
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "ill.html", 20, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "ill" then
	
	if event == "mgstart" then -- MG communication
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "mgstart.html",20, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "mgstart" then
	
	if event == "mgstop" then -- MG communication
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "mgstop.html", 20, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "mgstop" then
	
	if event == "complete" then -- Final camera
		
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 0 );
		SysCall ( "CameraManager:JumpTo", -78.58755, 40.46755, 10.00 );
		SysCall ( "CameraManager:LookAt", "4660A" );
		return TRUE;
			
	end -- if event == "complete" then
	
end
