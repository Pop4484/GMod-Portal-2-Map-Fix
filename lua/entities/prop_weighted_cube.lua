AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Weighted Storage Cube"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.CubeType = 0

ENT.Shining = false
ENT.ShineEndTime = 0
ENT.NextDamageTime = 0

local CubeModels = {}
CubeModels[1] = "models/props/metal_box.mdl"
CubeModels[2] = "models/props/reflection_cube.mdl"
CubeModels[3] = "models/props/metal_box.mdl"
CubeModels[4] = "models/props/metal_box.mdl"
CubeModels[5] = "models/props/metal_box.mdl"

if CLIENT then
    language.Add("prop_weighted_cube", "Weighted Storage Cube")
    killicon.Add("prop_weighted_cube","killicons/prop_weighted_cube",Color( 255, 80, 0, 200 ))
end

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel(CubeModels[self.CubeType+1])
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysWake()
    self:GetPhysicsObject():SetMass(120)
end

function ENT:PhysicsCollide(colData,collider)
    if colData.Speed < 150 then return end
    self:EmitSound("P2SolidMetal.ImpactHard",65,100,colData.Speed/1000)
end

function ENT:KeyValue( key, value )
	if key == "CubeType" then
		self.CubeType = value
        self:SetModel(CubeModels[self.CubeType+1])
        print(self.CubeType)
	end
end

function ENT:Think()
    if !self.Shining then return end
    self:NextThink(CurTime())
    local strt = self:GetPos()//+self:OBBCenter()
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
    if self.ShineEndTime <= CurTime() and self.Shining then
        self.Shining = false
    end
    self:NextThink(CurTime())
    return true
end

function ENT:Draw()
    self:DrawModel()
    //if self.CubeType != 2 then return end
    if !self.Shining then return end
    self:SetRenderBounds(Vector(-99999,-99999,-99999),Vector(99999,99999,99999))
    local strt = self:GetPos()
    local trd = {
        start = strt,
        endpos = strt+self:GetAngles():Forward()*25000,
        filter = self
    }
    local tr = util.TraceLine(trd)
    render.SetMaterial(Material('cable/redlaser'))
    render.DrawBeam(strt,tr.HitPos,5,0,0,Color(255,255,255,255))
end
function ENT:OnShineByLaser(laser)
    //if self.CubeType != 2 then return end // 2 = Reflection
    self.ShineEndTime = CurTime()+0.1
    if self.Shining then return end
    self.Shining = true
end