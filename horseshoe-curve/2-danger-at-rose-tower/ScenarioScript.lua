------------------------------------------------
-- ScenarioScript.lua
-- 14/06/2011
-- Copyright 2011 RailSimulator.com ltd
--
-- Scenario Script Tutorial - 'Danger at Rose Tower '
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
	
	if event == "pan1" then -- Pan around
		
		SysCall ( "CameraManager:ActivateCamera", "camera2", 0 );
		SysCall ( "ScenarioManager:LockControls");
		return TRUE;
			
	end -- if event == "pan1" then
	
	if event == "intro" then 
			
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "af7a2b92-ad57-4bdc-88be-eef5f7459b6a", "intro.html", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "intro" then
	
	if event == "lookfire" then -- jump and look at fire
		
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 0 );
		SysCall ( "CameraManager:JumpTo", -78.37740, 40.53831, 1.00 );
		SysCall ( "CameraManager:LookAt", "rose2" );
		return TRUE;
			
	end -- if event == "lookfire" then
	
	if event == "fire" then 
			
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "cb93fad3-e5f0-4b5a-8254-13debcad766a", "fire.html", 10, MSG_LEFT + MSG_BOTTOM, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "fire" then
	
	
	if event == "instruction1" then -- jump and look at fire
		
		SysCall ( "CameraManager:ActivateCamera", "camera3", 0 );
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "cb93fad3-e5f0-4b5a-8254-13debcad766a", "instruction1.html", 15, MSG_RIGHT + MSG_TOP, MSG_REG, FALSE );
		return TRUE;
			
	end -- if event == "lookfire" then
	
	if event == "instruction2" then -- play instruction 2 message
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "cb93fad3-e5f0-4b5a-8254-13debcad766a", "instruction2.html", 15, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "instruction 2" then
	
	if event == "instruction3" then -- play instruction 3 message
		
		SysCall ( "ScenarioManager:ShowInfoMessageExt", "cb93fad3-e5f0-4b5a-8254-13debcad766a", "instruction3.html", 15, MSG_RIGHT + MSG_TOP, MSG_SMALL, FALSE );
		return TRUE;
			
	end -- if event == "instruction 3" then
	
	
	if event == "cab" then -- Put in cabview
		
		SysCall ( "CameraManager:ActivateCamera", "CabCamera", 0 );
		SysCall ( "ScenarioManager:UnlockControls");
		return TRUE;
			
	end -- if event == "cab" then
	
	if event == "complete" then -- jump and look at fire
		
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 20 );
		SysCall ( "CameraManager:JumpTo", -78.37762, 40.53824, 1.00 );
		SysCall ( "CameraManager:LookAt", "rose2" );
		return TRUE;
			
	end -- if event == "complete" then
	
	if event == "fail" then -- jump and look at fire
		
		SysCall ( "CameraManager:ActivateCamera", "FreeCamera", 20 );
		SysCall ( "CameraManager:JumpTo", -78.37762, 40.53824, 1.00 );
		SysCall ( "CameraManager:LookAt", "rose2" );
		Syscall ( "ScenarioManager:TriggerScenarioFailure", "Alto to 9764A.  What's going on?  You are not following instructions! It is lucky that the fire is now under control or those freight cars might have caught a spark.  Come back to the depot, your surpervisor wants a word." );
		return TRUE;
			
	end -- if event == "fail" then
	
end
