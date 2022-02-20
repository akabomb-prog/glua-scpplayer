SCP = {}
SCP.soundHomeDir = "scp"
SCP.materialHomeDir = "scp"

SCP.speed = 120
SCP.runSpeed = SCP.speed * 2
SCP.staminaDrainSpeed = 18
SCP.staminaRecoverSpeed = 8
SCP.sprintRecoveryTime = 3.5

SCP.stepTime = 0.72 * 1000 -- 83.333... bpm
SCP.run_stepTime = 0.48 * 1000 -- 125 bpm

SCP.IstepTime = 1 / SCP.stepTime * 1000
SCP.run_IstepTime = 1 / SCP.run_stepTime * 1000

SCP.down = Vector(0, 0, -6)
SCP.tilt = Angle(0, 0, 1)

SCP.HUD = {}
SCP.HUD.hand = Material(SCP.materialHomeDir .. "/handsymbol.png")
SCP.HUD.hand2 = Material(SCP.materialHomeDir .. "/handsymbol2.png")

SCP.HUDColor = Color(255, 255, 255, 255)
SCP.HUDImgSize = 96
SCP.HUDHalfImgSize = SCP.HUDImgSize * 0.5

SCP.HUDTextColor = Color(232, 232, 232, 255)
SCP.HUDTextColorO = Color(0, 0, 0, 255)

local function trandom(t)
	return t[math.random(#t)]
end

SCP.Step = {
	"Step1.wav",
	"Step2.wav",
	"Step3.wav",
	"Step4.wav",
	"Step5.wav",
	"Step6.wav",
	"Step7.wav",
	"Step8.wav"
}

function SCP.stepsound()
	return SCP.soundHomeDir .. "/step/" .. trandom(SCP.Step)
end

SCP.StepMetal = {
	"StepMetal1.wav",
	"StepMetal2.wav",
	"StepMetal3.wav",
	"StepMetal4.wav",
	"StepMetal5.wav",
	"StepMetal6.wav",
	"StepMetal7.wav",
	"StepMetal8.wav"
}

function SCP.stepmetalsound()
	return SCP.soundHomeDir .. "/step/" .. trandom(SCP.StepMetal)
end

SCP.Run = {
	"Run1.wav",
	"Run2.wav",
	"Run3.wav",
	"Run4.wav",
	"Run5.wav",
	"Run6.wav",
	"Run7.wav",
	"Run8.wav"
}

function SCP.runsound()
	return SCP.soundHomeDir .. "/step/" .. trandom(SCP.Run)
end

SCP.RunMetal = {
	"RunMetal1.wav",
	"RunMetal2.wav",
	"RunMetal3.wav",
	"RunMetal4.wav",
	"RunMetal5.wav",
	"RunMetal6.wav",
	"RunMetal7.wav",
	"RunMetal8.wav"
}

function SCP.runmetalsound()
	return SCP.soundHomeDir .. "/step/" .. trandom(SCP.RunMetal)
end

SCP.StepForest = {
	"StepForest1.wav",
	"StepForest2.wav",
	"StepForest3.wav"
}

function SCP.stepforestsound()
	return SCP.soundHomeDir .. "/step/" .. trandom(SCP.StepForest)
end
