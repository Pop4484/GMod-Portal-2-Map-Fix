AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Turret"
ENT.Category = "Portal 2"
ENT.Spawnable = true

function ENT:Initialize()
    local realTurret = ents.Create("npc_turret_floor")
    realTurret:SetModel("models/npcs/turret/turret.mdl")
    realTurret:SetPos(self:GetPos())
    realTurret:SetAngles(self:GetAngles())
    realTurret:Spawn()
    realTurret:GetPhysicsObject():Sleep()
    self:Remove()
end