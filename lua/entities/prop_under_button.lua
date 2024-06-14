AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Underground_Button"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = true

ENT.Delay = 1
ENT.istimer = false

ENT.Timing = false
ENT.ResetTime = 0

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props_underground/underground_testchamber_button.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetUseType(SIMPLE_USE)
end

function ENT:KeyValue(k, v)
    if (string.lower(k) == "skin") then
        self:SetSkin(tonumber(v))
    end
    if k == "OnPressed" or k == "OnButtonReset" then
        self:StoreOutput(k, v)
    end
    if k == "Delay" then
        self.Delay = tonumber(v)
    end
    if k == "istimer" then
        self.istimer = v
    end
end

function ENT:Use(activator)
    if self.Timing then return end
    self:ResetSequence( "Press" )
    self:TriggerOutput("OnPressed",activator)
    self.Timing = true
    self.ResetTime = CurTime() + self.Delay
end

function ENT:Think()
    if self.Timing and self.Delay >= 0 then
        if self.ResetTime <= CurTime() then
            self:ResetSequence( "Release" )
            self:TriggerOutput("OnButtonReset",self)
            self.Timing = false
        end 
    end
    self:NextThink(CurTime())
    return true
end