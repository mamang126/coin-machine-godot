class_name Bouncer extends StaticBody2D

var Big = preload("res://Utils/big.gd")

@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var powerTimer: Timer = $PowerTimer

@onready var particle1: GPUParticles2D = $Particle1
@onready var particleTimer: Timer = $ParticleTimer

@onready var soundEmitter: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var soundList: Array[AudioStreamWAV] = [
	preload("res://Assets/Sounds/pickupCoin.wav"),
	preload("res://Assets/Sounds/pickupCoin (1).wav"),
	preload("res://Assets/Sounds/pickupCoin (2).wav"),
	preload("res://Assets/Sounds/pickupCoin (3).wav"),
	preload("res://Assets/Sounds/pickupCoin (4).wav"),
	preload("res://Assets/Sounds/pickupCoin (5).wav"),
	preload("res://Assets/Sounds/pickupCoin (6).wav"),
	preload("res://Assets/Sounds/pickupCoin (7).wav"),
]

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var actualPower = null

func _ready():
	self.setIddle(true)
	
	self.timer.timeout.connect(self.onTimer)
	
	self.powerTimer.timeout.connect(self.resetPower)
	self.powerTimer.one_shot = true
	
	self.particleTimer.wait_time = 0.5
	self.particleTimer.timeout.connect(self.resetParticle)

func onBallCollision():
	if self.collision_layer == 2: return
	print('Collision bouncer')
	self.call_deferred("setIddle", false)
	self.timer.start()
	GameState.addMoney(self.calculateMoney())
	self.playCollisionSound()
	
func playCollisionSound():
	self.soundEmitter.stream = self.soundList.pick_random()
	self.soundEmitter.play()

func calculateMoney():
	match self.actualPower:
		null:
			return Big.new(1)
		GameState.BouncerPowers.BOUNCY:
			self.particle1.emitting = true
			self.particleTimer.start()
			return Big.new(100)
	
func onTimer():
	self.call_deferred("setIddle", true)
	
func setIddle(val: bool):
	self.collision_layer = 1 if val else 2
	self.collider.disabled = !val
	self.sprite.modulate.a = 1 if val else 0.2
	
func setPower(power: GameState.BouncerPowers):
	match power:
		GameState.BouncerPowers.BOUNCY:
			self.setBouncy(true)
	self.collider.debug_color = Color.AQUA
	self.sprite.animation = "power"
	
	self.powerTimer.wait_time = GameState.getPowerDuration(power)
	self.powerTimer.start()
	self.actualPower = power
			
func setBouncy(val: bool):
	self.physics_material_override.bounce = 1 if val else 0.5
	
func resetPower():
	self.setBouncy(false)
	self.collider.debug_color = Color("e3447b6b")
	self.sprite.animation = "default"
	self.actualPower = null
	self.particle1.emitting = false
	
func resetParticle():
	self.particle1.emitting = false
