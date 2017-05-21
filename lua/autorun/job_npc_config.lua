--[[-------------------------------------------------------------------------
Script by Valfunde | Version 1.0
If you have any problems, don't hesitate to make github issue
This is configuration file.
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
Don't touch all of these table configurations.
---------------------------------------------------------------------------]]
if not Valfunde then Valfunde = {} end
Valfunde.JNPC = {}
Valfunde.JNPC.CreateNPC = {}
--[[-------------------------------------------------------------------------
After these lines you can edit what you want.
I hope you will like this addon, thanks! See you later.
---------------------------------------------------------------------------]]


--[[-------------------------------------------------------------------------
Configuration of the different npcs
Model to create your npcs :

Valfunde.JNPC.CreateNPC[1] = {							 -- You need to change the number between brackets '[]' (from 1 to ..)
	name = "Bob",										 -- The text wich is above npc head
	color = Color(255, 255, 255, 255),					 -- The color of the text above npc head
	title = "Civil\'s jobs",							 -- The text wich will be show in the menu
	model = "models/kleiner.mdl",						 -- The model of the npc
	pos = Vector(-553, -56, 112),						 -- The vector position of the npc (type 'getpos' in console)
	angle = Angle(0, 0, 0),								 -- The angle of the npc (type 'getpos' in console)
	jobs = {"TEAM_CITIZEN", "TEAM_MAYOR", "TEAM_COOK"},	 -- Put the jobs you want to add in your npc
}														 -- Do not forget to put coma ',' at the end of the lines
---------------------------------------------------------------------------]]
Valfunde.JNPC.CreateNPC[1] = {
	name = "Bob",
	color = Color(255, 255, 255, 255),
	title = "Civil",
	model = "models/kleiner.mdl",
	pos = Vector(-553, -56, 112),
	angle = Angle(0, 0, 0),
	jobs = {"TEAM_CITIZEN", "TEAM_MAYOR", "TEAM_COOK"},
}
Valfunde.JNPC.CreateNPC[2] = {
	name = "Bob's Brother",
	color = Color(255, 255, 255, 255),
	title = "Government ",
	model = "models/gman_high.mdl",
	pos = Vector(-594, -149, 112),
	angle = Angle(0, 0, 0),
	jobs = {"TEAM_POLICE"},
}
--[[-------------------------------------------------------------------------
End of configuration of the different npcs
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
Frame blur configuration
---------------------------------------------------------------------------]]
Valfunde.JNPC.BlurAmount = 4 -- Set the amount of blur between 1 and 6
Valfunde.JNPC.EnableBlur = true  -- Set true / false to enable or disable the blur texture in the frame
Valfunde.JNPC.FrameColor = Color(30, 30, 30, 255) -- Change color of the frame if blur is disabled
--[[-------------------------------------------------------------------------
End of frame blur configuration
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
End of configuration file
---------------------------------------------------------------------------]]
