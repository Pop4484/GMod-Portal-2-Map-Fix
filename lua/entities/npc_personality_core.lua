AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Personality Core"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = true

if CLIENT then
    language.Add("npc_personality_core", "Personality Core")
end

function ENT:KeyValue( key, value )
	if key == "ModelSkin" then
		self:SetSkin(tonumber(value))
	end
	if key == "altmodel" then
		altmodel = value
	end
end
	
function ENT:Initialize()
    if CLIENT then return end
	self:SetModel("models/npcs/personality_sphere/personality_sphere.mdl")
	if altmodel == "0" then
		self:SetModel("models/npcs/personality_sphere/personality_sphere.mdl")
	elseif altmodel == "1" then
		self:SetModel("models/npcs/personality_sphere/personality_sphere_skins.mdl")
	end
	self:ResetSequence("sphere_idle_neutral")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysWake()
	self:SetUseType(SIMPLE_USE)
end

function ENT:Use( activator, useType )
	if activator:IsPlayer() then 
		activator:PickupObject(self)
	end
end

function ENT:AcceptInput( name, activator, caller, data )
	if name == "SetIdleSequence" then
		self:ResetSequence(data)
	end
	if name == "ClearIdleSequence" then
		self:ResetSequence("sphere_idle_neutral")
	end
	if name == "PlayAttach" then
		self:ResetSequence("sphere_plug_attach")
	end
	if name == "PlayLock" then
		self:ResetSequence("sphere_plug_lock")
	end
end

function ENT:Think()
	self:NextThink( CurTime() )
	return true
end
