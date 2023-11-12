AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Laser Emitter"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.RenderGroup = RENDERGROUP_BOTH

ENT.NextDamageTime = 0

ENT.Model = "models/props/laser_emitter.mdl"

if CLIENT then
    language.Add("env_portal_laser", "Laser Beam")
end

/*
    MODELS
    models/props/laser_emitter_center.mdl
    models/props/laser_emitter.mdl
*/

function ENT:Initialize()
    if CLIENT then 
        self:SetRenderBounds(Vector(-99999,-99999,-99999),Vector(99999,99999,99999))
        return 
    end
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetUseType(SIMPLE_USE)
end

function ENT:KeyValue(k, v)
    if k == "model" then
        self.Model = v
    end
end

function ENT:Think()
    self:NextThink(CurTime())
    local strt = self:GetPos()
    if self:GetModel() == "models/props/laser_emitter.mdl" then
        strt = self:GetPos() - self:GetUp()*14
    end
    local trd = {
        start = strt,
        endpos = strt+self:GetAngles():Forward()*25000,
        filter = self
    }
    local tr = util.TraceLine(trd)
    local trueEndPos, trueEndAng = tr.HitPos,tr.HitNormal:Angle()
    local shouldDoParticle = true
    if IsValid(tr.Entity) then
        if tr.Entity.OnShineByLaser != nil then
            shouldDoParticle = tr.Entity:OnShineByLaser(self)
        end
        if !tr.Entity:IsWorld() and tr.Entity:Health() > 0 and self.NextDamageTime <= CurTime() and SERVER then
            if tr.Entity:GetClass() != "npc_turret_floor" and tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
                tr.Entity:TakeDamage(10,self,self)
                tr.Entity:EmitSound("HL2Player.BurnPain")
                self.NextDamageTime = CurTime()+0.2
            else
                if tr.Entity.TurretP2SelfDestructing == nil then
                    tr.Entity:Ignite(math.huge,0)
                    tr.Entity:Fire("SelfDestruct")
                    tr.Entity.TurretP2SelfDestructing = true
                end
            end
        end
    end
    if shouldDoParticle then
        local ed = EffectData()
        ed:SetOrigin(trueEndPos)
        ed:SetAngles(trueEndAng)
        ed:SetNormal(tr.HitNormal)
        ed:SetMagnitude(1)
        util.Effect("ElectricSpark",ed)
    end
    if CLIENT then
        self:Draw()
    end
    self:NextThink(CurTime())
    return true
end

function ENT:Draw()
    self:DrawModel()
    local strt = self:GetPos()
    if self:GetModel() == "models/props/laser_emitter.mdl" then
        strt = self:GetPos() - self:GetUp()*14
    end
    local trd = {
        start = strt,
        endpos = strt+self:GetAngles():Forward()*25000,
        filter = self
    }
    local tr = util.TraceLine(trd)
    render.SetMaterial(Material('cable/redlaser'))
    render.DrawBeam(strt,tr.HitPos,5,0,0,Color(255,255,255,255))
end