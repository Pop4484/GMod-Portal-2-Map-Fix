AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Personality Core"
ENT.Category = "Portal 2"
ENT.Spawnable = true

if CLIENT then
    language.Add("npc_personality_core", "Personality Core")
end

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/npcs/personality_sphere/personality_sphere.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysWake()
end