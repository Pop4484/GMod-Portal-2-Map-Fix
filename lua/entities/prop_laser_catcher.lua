AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Laser Catcher"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.Model = "models/props/laser_catcher.mdl"

ENT.Shining = false 
ENT.ShingEndTime = 0

/*
    MODELS
    models/props/laser_emitter_center.mdl
    models/props/laser_emitter.mdl
*/

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetUseType(SIMPLE_USE)
end

function ENT:KeyValue(k, v)
    if k == "OnPowered" or k == "OnUnpowered" then
        self:StoreOutput(k, v)
    end
    if k == "model" then
        self.Model = v
    end
end

function ENT:Think()
    if CLIENT then return end
    if self.ShingEndTime <= CurTime() and self.Shining then
        self.Shining = false
        self:TriggerOutput("OnUnpowered")
    end
end

function ENT:OnShineByLaser(laser)
    if CLIENT then return end
    self.ShingEndTime = CurTime()+0.1
    if self.Shining then return end
    self.Shining = true
    self:TriggerOutput("OnPowered")
    print("Fired.")
end