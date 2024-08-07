AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Hard Light Bridge"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.m_pLightBridge = NULL

function ENT:AcceptInput(inp,act,call,data)
    if inp == "Enable" then
        self.Enabled = true
    end
    if inp == "Disable" then
        self.Enabled = false
    end
end

function ENT:CreateBridge()
    if IsValid(self.m_pLightBridge) then return end // dont create multiple bridges
    bridge = ents.Create("projected_wall_entity")
    bridge:SetPos(self:GetPos())
    bridge:SetAngles(self:GetAngles())
    bridge:SetOwner(self)
    bridge:SetParent(self) // this makes the bridge nocollide
    bridge:Spawn()
    self.m_pLightBridge = bridge // and finally set this
    return bridge
end

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/wall_emitter.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:CreateBridge()
end

function ENT:KeyValue(k, v)
    if k == "StartEnabled" then
        self.Enabled = v
    end
end

function ENT:Think()
    if CLIENT then return end
    if !self.Enabled && IsValid(self.m_pLightBridge) then
        self.m_pLightBridge:Remove()
        self.m_pLightBridge = NULL
    end
    if self.Enabled && !IsValid(self.m_pLightBridge) then
        self:CreateBridge()
    end
    self:NextThink(CurTime())
end