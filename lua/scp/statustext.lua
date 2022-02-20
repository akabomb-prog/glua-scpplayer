if not SCP.FontCreated then
    surface.CreateFont("SCPStatusFont16", {
        font = "Courier New",
        size = 16
    })
    SCP.FontCreated = true
end

SCP.StatusTextString = ''
SCP.StatusLingerTime = 6
SCP.StatusFadeOutTime = 4
SCP.StatusFadeOutBeforeEnd = SCP.StatusLingerTime - SCP.StatusFadeOutTime
SCP.StatusLingerEnd = 0 -- time

SCP.StatusTextXMult = 0.5
SCP.StatusTextYMult = 0.75

function SCP.GetStatusAlphaMultiplier()
    local timeLeft = math.max(0, SCP.StatusLingerEnd - CurTime())
    local progress = math.min(SCP.StatusLingerTime - timeLeft, SCP.StatusLingerTime)
    if progress < SCP.StatusFadeOutTime then
        return 1
    else
        return math.ease.InExpo(timeLeft / SCP.StatusFadeOutBeforeEnd)
    end
end

function SCP.ShouldShowText()
    return CurTime() < SCP.StatusLingerEnd
end

function SCP.StatusText(text)
    SCP.StatusTextString = text
    SCP.StatusLingerEnd = CurTime() + SCP.StatusLingerTime
end
