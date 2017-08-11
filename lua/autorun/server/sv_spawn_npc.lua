--[[-------------------------------------------------------------------------
Script by Valfunde
If you have any problems, don't hesitate to contact me or add me on steam (Valfunde *Banna Army) but write a comment before adding me
If you try to edit something wich isn't in configuration file and the script doesn't work, it's you fault so don't come cry and tell script is broken.
---------------------------------------------------------------------------]]

local function InitPostEntity()
	for k, v in pairs(Valfunde.JNPC.CreateNPC) do
		local job_npc = ents.Create("valfunde_job_npc")
		job_npc:SetPos(v.pos)
		job_npc:SetAngles(v.angle)
		job_npc:SetModel(v.model)
		job_npc:Spawn()
		job_npc:Activate()
		job_npc.ID = k
	end
end
hook.Add("InitPostEntity", "SpawningJobsNPC", InitPostEntity)
hook.Add("PostCleanupMap", "SpawningJobsNPC", InitPostEntity)
