AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Weighted Storage Cube"
ENT.Category = "Portal 2"
ENT.Spawnable = true

if CLIENT then
    language.Add("prop_weighted_cube", "Weighted Storage Cube")
    killicon.Add("prop_weighted_cube","killicons/prop_weighted_cube",Color( 255, 80, 0, 200 ))
end

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/metal_box.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysWake()
end

function ENT:PhysicsCollide(colData,collider)
    if colData.Speed < 150 then return end
    self:EmitSound("P2SolidMetal.ImpactHard",65,100,colData.Speed/1000)
end