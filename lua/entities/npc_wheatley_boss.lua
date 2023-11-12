AddCSLuaFile()
ENT.Type = "ai"
ENT.Base = "base_anim"

ENT.PrintName = "Wheatley Boss"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = true

if CLIENT then
    language.Add("npc_wheatley_boss", "Wheatley")
end
	
function ENT:Initialize()
    if CLIENT then return end
	self:SetModel("models/npcs/glados/glados_wheatley_boss.mdl")
	self:ResetSequence("sphere_idle_neutral")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysWake()
	self:SetUseType(SIMPLE_USE)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
end

function ENT:Think()
	self:NextThink( CurTime() )
	return true
end
