AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Testchamber Door"
ENT.Category = "Portal 2"
ENT.Spawnable = true

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/portal_door_combined.mdl")
    self:SetSequence("idleclose")
end

function ENT:KeyValue(k,v)
    if k == "OnOpen" or k == "OnClose" then
        self:StoreOutput(k, v)
    end
end

function ENT:AcceptInput(inp,act,call,data)
    if inp == "Open" then
        self:Open()
    end
    if inp == "Close" then
        self:Close()
    end
end

function ENT:Open()
    self:ResetSequenceInfo()
    self:ResetSequence("Open")
    self:EmitSound("plats/door_round_blue_unlock_01.wav")
    self:TriggerOutput("OnOpen")
end

function ENT:Close()
    self:ResetSequenceInfo()
    self:ResetSequence("Close")
    self:EmitSound("plats/door_round_blue_lock_01.wav")
    self:TriggerOutput("OnClose")
end

ENT.AutomaticFrameAdvance = true
function ENT:Think()
    self:NextThink(CurTime())
    return true
end