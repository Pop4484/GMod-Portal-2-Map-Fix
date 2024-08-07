AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Floor Button"
ENT.Category = "Portal 2"
ENT.Spawnable = true
ENT.Downed = false

function ENT:Initialize()
    self:SetMoveType(MOVETYPE_NONE)
    self:SetModel("models/props/portal_button.mdl")
    //self:PhysicsInitBox(Vector(-self:GetModelBounds().X, -self:GetModelBounds().Y, -6), Vector(self:GetModelBounds().X, self:GetModelBounds().Y, 13))
    --self:PhysicsInit(SOLID_VPHYSICS)
    self:SetCollisionBounds(Vector(-self:GetModelBounds().X, -self:GetModelBounds().Y, -6), Vector(self:GetModelBounds().X, self:GetModelBounds().Y, 6))
    self:SetSolid(SOLID_BBOX)
    self:SetMoveType(MOVETYPE_NONE)
    --self:SetPos(self:GetPos()-Vector(0, 0, 10))
end

function ENT:KeyValue(k, v)
    if k == "OnPressed" or k == "OnUnPressed" then
        self:StoreOutput(k, v)
    end
end

function ENT:Down(activator)
    if self.Downed then return end
    self.Downed = true
    //self:PhysicsInitBox(Vector(-self:GetModelBounds().X, -self:GetModelBounds().Y, -6), Vector(self:GetModelBounds().X, self:GetModelBounds().Y, 6))
    self:SetMoveType(MOVETYPE_NONE)
    self:ResetSequence( "down" )
    self:TriggerOutput("OnPressed",activator)
    self:EmitSound("buttons/portal_button_down_01.wav")
end

function ENT:Up()
    if !self.Downed then return end
    self.Downed = false
    //self:PhysicsInitBox(Vector(-self:GetModelBounds().X, -self:GetModelBounds().Y, -6), Vector(self:GetModelBounds().X, self:GetModelBounds().Y, 13))
    self:SetMoveType(MOVETYPE_NONE)
    self:ResetSequence( "up" )
    self:EmitSound("buttons/portal_button_up_01.wav")
    self:TriggerOutput("OnUnPressed",self)
end

function ENT:Think()
    self:OnCustomThink()
    if CLIENT then return end
    local yee = {
        start = self:GetPos(),
        endpos = self:GetPos(),
        mins = Vector(-20,-20,-6),
        maxs = Vector(20,20,15),
        filter = self
    }
    local tr = util.TraceHull(yee)
    if IsValid(tr.Entity) then
        if (IsValid(tr.Entity:GetPhysicsObject()) and (tr.Entity:GetPhysicsObject():GetMass() > 100) and tr.Entity:GetMoveType() == MOVETYPE_VPHYSICS) then
           self:Down(tr.Entity)
        elseif tr.Entity:GetMoveType() == MOVETYPE_STEP or tr.Entity:GetMoveType() == MOVETYPE_WALK then
            self:Down(tr.Entity)
        end
    else
        self:Up(tr.Entity)
    end
    self:NextThink(CurTime())
    return true
end

function ENT:Draw()
    self:DrawModel()
    if !GetConVar("developer"):GetBool() then return end
    render.DrawWireframeBox( self:GetPos(), Angle( 0, 0, 0 ), Vector(-20,-20,-0), Vector(20,20,10), Color(255,255,255,255), false )
end

ENT.AutomaticFrameAdvance = true
function ENT:OnCustomThink()
    self:NextThink(CurTime())
    return true
end