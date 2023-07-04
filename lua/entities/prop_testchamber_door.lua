AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

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
    self:SetSequence("idleopen")
    self:EmitSound("plats/door_round_blue_unlock_01.wav")
    self:TriggerOutput("OnOpen")
end

function ENT:Close()
    self:ResetSequenceInfo()
    self:SetSequence("idleclose")
    self:EmitSound("plats/door_round_blue_lock_01.wav")
    self:TriggerOutput("OnClose")
end