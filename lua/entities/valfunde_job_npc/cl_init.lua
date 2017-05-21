--[[-------------------------------------------------------------------------
Script by Valfunde
If you have any problems, don't hesitate to make github issue
If you try to edit something wich isn't in configuration file and the script doesn't work, it's you fault so don't come cry and tell script is broken.
---------------------------------------------------------------------------]]

include("shared.lua")
--[[-------------------------------------------------------------------------
Create custom font
---------------------------------------------------------------------------]]
surface.CreateFont("Valfunde_JNPC_24B",
{
	font = "Arial",
	extended = false,
	size = 24,
	weight = 500,
	antialias = true,
})
surface.CreateFont("Valfunde_JNPF_32B",
{
	font = "Arial",
	extended = false,
	size = 32,
	weight = 850,
	antialias = true,
})
surface.CreateFont("Valfunde_JNPC_22B",
{
	font = "Arial",
	extended = false,
	size = 22,
	weight = 500,
	antialias = true,
})
surface.CreateFont("Valfunde_JNPC_18B",
{
	font = "Arial",
	extended = false,
	size = 18,
	weight = 750,
	antialias = true,
})
surface.CreateFont("Valfunde_JNPC_15B",
{
	font = "Arial",
	extended = false,
	size = 15,
	weight = 500,
	antialias = true,
})

--[[-------------------------------------------------------------------------
Create blur function 
---------------------------------------------------------------------------]]
local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat("$blur", (i/3)*(amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

--[[-------------------------------------------------------------------------
Main function
---------------------------------------------------------------------------]]
local ID = 1

local function JobNPCMenu()

	ID = net.ReadInt(8)

	local color = {}
	color.white = Color(255, 255, 255)
	color.grey = Color(90, 90, 90, 255)
	color.a_black = Color(0, 0, 0, 225)
	color.d_grey = Color(50, 50, 50, 225)
	color.l_red = Color(180, 0, 0, 255)

	local f = vgui.Create("DFrame")
	f:SetSize(800, 600)
	f:SetTitle("")
	f:SetDraggable(false)
	f:ShowCloseButton(false)
	f:MakePopup()
	f:Center()
	f.Paint = function(self)
		if Valfunde.JNPC.EnableBlur then
			DrawBlur(self, Valfunde.JNPC.BlurAmount)
			surface.SetDrawColor(color.grey)
			surface.DrawOutlinedRect(0, 0, 800, 600)
		else
			draw.RoundedBox(0, 0, 0, 800, 600,Valfunde.JNPC.FrameColor)
		end
		draw.RoundedBox(0, 0, 0, 800, 25, color.grey)
		draw.SimpleTextOutlined(Valfunde.JNPC.CreateNPC[ID].title, "Valfunde_JNPF_32B", 400, 35, color.white,TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color.grey)
	end

	local c = vgui.Create("DButton", f)
	c:SetSize(65, 25)
	c:SetPos(735, 0)
	c:SetText("")
	c.Paint = function(self)
		draw.RoundedBox(0, 0, 0, 65, 25, color.l_red)
		draw.SimpleText("X", "Valfunde_JNPC_24B", 32.5, 12.5, color.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	c.DoClick = function()
		f:Close()
	end

	local s = vgui.Create("DScrollPanel", f)
	s:SetSize(700, 500)
	s:SetPos(50, 75)
	s:GetVBar():SetSize(0)

	local l = vgui.Create("DIconLayout", s)
	l:SetSize(700, 500)
	l:SetPos(0, 0)
	l:SetSpaceX(0)
	l:SetSpaceY(5)

	for k, v in pairs(Valfunde.JNPC.CreateNPC[ID].jobs) do
		job = _G[v]

		local job_slot = team.NumPlayers(job)
		local max_job_slot = 0
		local job_name = ""
		local job_description = ""
		local job_model = ""

		for k, v in pairs(RPExtraTeams) do
			if k == job then
				max_job_slot = v.max
				job_name = v.name
				job_description = v.description
				job_model = table.GetFirstValue(v.model)
			end
		end

		local hV = false
		local j = l:Add("DButton")
		j:SetSize(700, 100)
		j:SetText("")
		j.OnCursorEntered = function() hV = true end
		j.OnCursorExited = function() hV = false end
		if job_slot < max_job_slot or max_job_slot == 0 then
			j:SetEnabled(true)
			j.Paint = function()
				draw.RoundedBox(0, 0, 0, 700, 100, color.d_grey)
				surface.SetDrawColor(130, 130, 130, 255)
				surface.DrawOutlinedRect(0 ,0, 700, 100)
				if hV then
				    surface.DrawRect(0, 0, 700, 100)
				end
				draw.SimpleText(job_name.." :", "Valfunde_JNPC_22B", 105, 2.5, Color(255, 255,255,255))
				draw.SimpleText(job_slot.."/"..max_job_slot, "Valfunde_JNPC_18B", 50, 90, Color(255, 255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.DrawText(job_description, "Valfunde_JNPC_15B", 105, 25, Color(255, 255,255,255))
			end
		else
			j:SetEnabled(false)
			j.Paint = function()
				draw.RoundedBox(0, 0, 0, 700, 100, color.a_black)
				surface.SetDrawColor(130, 130, 130, 255)
				surface.DrawOutlinedRect(0, 0, 700, 100)
				draw.SimpleText(job_name.." :", "Valfunde_JNPC_22B", 105, 2.5, Color(255, 255,255,255))
				draw.SimpleText(job_slot.."/"..max_job_slot, "Valfunde_JNPC_18B", 50, 90, Color(255, 255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.DrawText(job_description, "Valfunde_JNPC_15B", 105, 25, Color(255, 255,255,255))
			end
		end
		j.DoClick = function()
			net.Start("valfunde_jnpc_jobswitch")
			net.WriteString(v)
			net.SendToServer()
			f:Close()
		end

		local p = vgui.Create("DModelPanel", j)
		p:SetSize(100, 80)
		p:SetModel(job_model)
		p:SetCamPos(Vector(70, -15, 60))
		p:SetLookAt(Vector(5, 0, 62.5))
		p:SetFOV(26)
		function p:LayoutEntity(Entity) return end

	end

end

--[[-------------------------------------------------------------------------
Run 'JobNPCMenu' function when npc is clicked
---------------------------------------------------------------------------]]
net.Receive("ValfundeJobNPCGUI", JobNPCMenu)

--[[-------------------------------------------------------------------------
3D2D Text above NPC's head
---------------------------------------------------------------------------]]
hook.Add("PostDrawOpaqueRenderables", "HeadNPCText", function()
	for ID, ent in pairs(ents.FindByClass("valfunde_job_npc")) do
		if ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 100000 then
			local ang = ent:GetAngles()
			local pos = ent:GetPos()
			local up = ent:GetUp()

			ang:RotateAroundAxis(ang:Forward(), 90)
			ang:RotateAroundAxis(ang:Right(), -90)
			cam.Start3D2D(pos+up*90, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.35)
				draw.SimpleText(Valfunde.JNPC.CreateNPC[ID].name, "Valfunde_JNPF_32B", 0, 0, Valfunde.JNPC.CreateNPC[ID].color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT)
			cam.End3D2D()
		end
	end
end)
