------------------------------------------------
-- ScenarioScript.lua
-- 14/06/2011
-- Copyright 2011 RailSimulator.com ltd
--
-- Scenario Script Tutorial - 'Early Morning Switching '
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
		return TRUE;
			
	end -- if event == "wagoncam" then
	
	if event == "intro" then -- Pan around and look at wagons
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "wagontext.html", 15, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "wagoncam" then
	
	if event == "intro2" then -- Pan around and look at wagons
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "wagontext2.html", 24, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "wagoncam" then
	
	if event == "check" then -- look at couplings
	
		SysCall ( "ScenarioManager:LockControls");	
		SysCall ( "CameraManager:ActivateCamera", "couplingcam", 0	);
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "couple.html", 18, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "coupling" then
	
	
	if event == "slope" then -- look at slope yard
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 0 );
		SysCall ( "CameraManager:JumpTo", -78.38396, 40.53150, 10.00 );
		SysCall ( "CameraManager:LookAt", "8550" );
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "slope.html", 20, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "slope" then
	
	if event == "unlock1" then -- unlock controls
		SysCall ( "CameraManager:ActivateCamera", "CabCamera", 0 );
		SysCall ( "ScenarioManager:UnockControls");
		
		return TRUE;
			
	end -- if event == unlock controls
	
		
	if event == "cab" then -- Put in cabview
		
		SysCall ( "CameraManager:ActivateCamera", "CabCamera", 0 );
		SysCall ( "ScenarioManager:UnlockControls");
		return TRUE;
			
	end -- if event == "cab" then
	
	if event == "cab2" then -- Put in cabview
		
		SysCall ( "CameraManager:ActivateCamera", "CabCamera", 0 );
		SysCall ( "ScenarioManager:UnlockControls");
		return TRUE;
			
	end -- if event == "cab2" then
	
	if event == "complete" then -- look at slope yard
	
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 0 );
		SysCall ( "CameraManager:JumpTo", -78.41064, 40.50871, 1.00 );
		SysCall ( "CameraManager:LookAt", "8550" );
		return TRUE;
			
	end -- if event == "complete" then cinematic

	
	
end
