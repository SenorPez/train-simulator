------------------------------------------------
-- ScenarioScript.lua
-- 14/06/2011
-- Copyright 2011 RailSimulator.com ltd
--
-- Scenario Script - 'People Power '
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
	
	if event == "start" then -- intro cinematic
		
		SysCall ( "CameraManager:ActivateCamera", "start", 0 );
		SysCall ( "ScenarioManager:LockControls");
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "start.html", 19, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "start" then
	
	if event == "guard" then -- intro cinematic
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 5 );
		SysCall ( "CameraManager:JumpTo", -78.92043, 40.32923, 10.00 );
		SysCall ( "CameraManager:LookAt", "guard1" );
		SysCall ( "whistle1:SetParameter", "ScenarioTrigger", 1.0 );
		return TRUE;
			
	end -- if event == "guard" then
		
	if event == "cab" then -- Put in cabview
		
		SysCall ( "CameraManager:ActivateCamera", "CabCamera", 0 );
		SysCall ( "ScenarioManager:UnlockControls");
		return TRUE;
			
	end -- if event == "cab" then
	
	if event == "cab2" then -- Put in cabview
		
		SysCall ( "CameraManager:ActivateCamera", "CabCamera", 0 );

		return TRUE;
			
	end -- if event == "cab2" then
	
	if event == "cresson" then -- intro cinematic
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 5 );
		SysCall ( "CameraManager:JumpTo", -78.59118, 40.46288, 1.00 );
		SysCall ( "CameraManager:LookAt", "guard2" );
		SysCall ( "whistle2:SetParameter", "ScenarioTrigger", 1.0 );
		return TRUE;
			
	end -- if event == "cresson" then
	
	if event == "jones" then -- intro cinematic
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "jones.html", 20, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "start" then
	
	if event == "cressonfail" then -- intro cinematic
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 5 );
		SysCall ( "CameraManager:JumpTo", -78.59118, 40.46288, 1.00 );
		SysCall ( "CameraManager:LookAt", "guard2" );
		SysCall ( "ScenarioManager:TriggerScenarioFailure", "Guard Yelling: 9825A you needed to stop here at Cresson!" );
		return TRUE;
			
	end -- if event == "cresson" then
	
	if event == "rock" then -- intro cinematic
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "rock.html", 19, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "start" then
	
	if event == "end" then -- intro cinematic
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 0 );
		SysCall ( "CameraManager:JumpTo", -78.39970, 40.51524, 1.00 );
		SysCall ( "CameraManager:LookAt", "9825" );
		return TRUE;
			
	end -- if event == "cresson" then
	
end
