--[[-------------------------------------------------------------------------
Script by Valfunde
If you have any problems, don't hesitate to make github issue
If you try to edit something wich isn't in configuration file and the script doesn't work, it's you fault so don't come cry and tell script is broken.
---------------------------------------------------------------------------]]

AddCSLuaFile("cl_init.lua") 
AddCSLuaFile("shared.lua")
include("shared.lua") 

--[[-------------------------------------------------------------------------
Basic functions
---------------------------------------------------------------------------]]
function ENT:Initialize()
 	self:SetHullType(HULL_HUMAN)
	self:SetUseType(SIMPLE_USE)
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX)
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:DropToFloor()
	self:SetMaxYawSpeed(5000)
	local PhysAwake = self.Entity:GetPhysicsObject()
	if PhysAwake:IsValid() then
		PhysAwake:Wake()
	end 
end

function ENT:OnTakeDamage()
	return false
end

util.AddNetworkString("ValfundeJobNPCGUI")
function ENT:AcceptInput(event, act, ply, data)
    if event == "Use" and IsValid(ply) and ply:IsPlayer() then
        net.Start("ValfundeJobNPCGUI")
        net.WriteInt(self.ID, 8)
		net.Send(ply)
    end
end

--[[-------------------------------------------------------------------------
End of basic functions
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
Team switch functions
---------------------------------------------------------------------------]]
util.AddNetworkString("valfunde_jnpc_jobswitch")	
net.Receive("valfunde_jnpc_jobswitch", function(len, ply)
	local string = net.ReadString()
	local team = _G[string]
	ply:changeTeam(team)
end)

--[[-------------------------------------------------------------------------
End of team switch functions
---------------------------------------------------------------------------]]