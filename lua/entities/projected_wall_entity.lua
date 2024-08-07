AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Hard Light Bridge Projected"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.Length = 0
ENT.Enabled = true

function ENT:Initialize()
    if CLIENT then return end
	self:SetSolid(SOLID_BBOX)
    self:SetMoveType(MOVETYPE_NONE)
	self:SetSaveValue("gmod_allowphysgun","0")
	self:NextThink(CurTime())
end

function ENT:Draw()
	self:SetRenderBounds(
		Vector(0,-32,-2),
		Vector(self.Length,32,2)
	)
	render.SetMaterial(Material("Color"))
	render.DrawBox(self:GetPos(),self:GetAngles(),Vector(0,-32,-2),Vector(self.Length,32,2),Color(0,255,255,255))
end

function ENT:Think()
	local length = 4096
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos()+self:GetAngles():Forward()*length,
	})
	self.Length = length*tr.Fraction
	self:SetCollisionBounds(
		Vector(0,-32,-2),
		Vector(self.Length,32,2)
	)
    self:NextThink(CurTime())
	return true
end