AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Hard Light Bridge"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.m_pLightBridge = NULL

function ENT:CreateBridge()
    if IsValid(self.m_pLightBridge) then return end // dont create multiple bridges
    bridge = ents.Create("projected_wall_entity")
    bridge:SetPos(self:GetPos())
    bridge:SetAngles(self:GetAngles())
    bridge:SetOwner(self)
    bridge:SetParent(self) // this makes the bridge nocollide
    bridge:SetSolid(SOLID_OBB) // do this
    bridge:Spawn()
    self.m_pLightBridge = bridge // and finally set this
end

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/metal_box.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
end

function ENT:Think()
    if CLIENT then return end
    self:NextThink(CurTime())
end