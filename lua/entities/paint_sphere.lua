AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Paint Sphere"
ENT.Category = "Portal 2"
ENT.Spawnable = true

if CLIENT then
    language.Add("paint_sphere", "Paint Sphere")
end

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/sphere.mdl")
    self:SetCollisionBounds(Vector(0,0,0),Vector(0,0,0))
    self:PhysicsInit(SOLID_OBB)
    self:SetMoveType(MOVETYPE_FLYGRAVITY)
    self:SetMaterial("models/shiny")
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
    self:PhysWake()
end

function ENT:Touch(ent)
    if ent:GetClass() == self:GetClass() then return end
    self:Remove()
end