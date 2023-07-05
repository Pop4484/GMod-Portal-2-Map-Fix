AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Downed = false

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/portal_button.mdl")
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_NONE)
end

function ENT:KeyValue(k, v)
    if k == "OnPressed" or k == "OnUnPressed" then
        self:StoreOutput(k, v)
    end
    if k == "Delay" then
        self.Delay = v
    end
    if k == "istimer" then
        self.istimer = v
    end
end

function ENT:Down(activator)
    if self.Downed then return end
    self.Downed = true
    self:SetSequence( "up" )
    self:TriggerOutput("OnPressed",activator)
    self:EmitSound("buttons/button_synth_positive_01.wav")
end

function ENT:Up()
    if !self.Downed then return end
    self.Downed = false
    self:SetSequence( "down" )
    self:EmitSound("buttons/button_synth_negative_02.wav")
    self:TriggerOutput("OnUnPressed",self)
end

function ENT:Think()
    if CLIENT then return end
    local yee = {
        start = self:GetPos(),
        endpos = self:GetPos(),
        mins = Vector(-20,-20,-0),
        maxs = Vector(20,20,10),
        filter = self
    }
    local tr = util.TraceHull(yee)
    if IsValid(tr.Entity) then
        self:Down(tr.Entity)
    else
        self:Up(tr.Entity)
    end
end

function ENT:Draw()
    self:DrawModel()
    if !GetConVar("developer"):GetBool() then return end
    render.DrawWireframeBox( self:GetPos(), Angle( 0, 0, 0 ), Vector(-20,-20,-0), Vector(20,20,10), Color(255,255,255,255), false )
end