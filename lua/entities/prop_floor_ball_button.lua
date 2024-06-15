AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Floor Ball Button"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = true

ENT.Downed = false

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/ball_button.mdl") -- we do this later
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_NONE)
end

function ENT:KeyValue(k, v)
    if k == "model" then
        self:SetModel(v)
    end

    if k == "OnPressed" or k == "OnUnPressed" then
        self:StoreOutput(k, v)
    end
end

function ENT:Down(activator)
    if self.Downed then return end
    self.Downed = true
    self:ResetSequence( "down" )
    self:TriggerOutput("OnPressed",activator)
end

function ENT:Up()
    if !self.Downed then return end
    self.Downed = false
    self:ResetSequence( "idle" )
    self:EmitSound("buttons/portal_button_up_01.wav")
    self:TriggerOutput("OnUnPressed",self)
end

function ENT:Think()
    self:NextThink(CurTime())
    if CLIENT then return true end
    local yee = {
        start = self:GetPos(),
        endpos = self:GetPos(),
        mins = Vector(-20,-20,-0),
        maxs = Vector(20,20,10),
        filter = self,
        ignoreworld = true
    }
    local tr = util.TraceHull(yee)
    if IsValid(tr.Entity) then
        self:Down(tr.Entity)
    else
        self:Up(tr.Entity)
    end
    return true
end

function ENT:Draw()
    self:DrawModel()
    if !GetConVar("developer"):GetBool() then return end
    render.DrawWireframeBox( self:GetPos(), Angle( 0, 0, 0 ), Vector(-20,-20,-0), Vector(20,20,10), Color(255,255,255,255), false )
end