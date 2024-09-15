extends Node

@export var rows: int = 8
@export var num_bouncers_per_row: int = 10
@export var width: int = 960
@export var initial_x: int = - 460
@export var initial_y: int = - 500

@onready var bouncer = preload("res://Scenes/bouncer.tscn")

var bouncers: Array[Array] = []

@onready var timer = $Timer

func _ready():
	for y in range(rows):
		self.bouncers.insert(y, [])
		for x in range(num_bouncers_per_row):
			var bouncer_inst: Node2D = bouncer.instantiate()
			
			var even_row = y % 2 == 0
			var sum_x =  (self.width / self.num_bouncers_per_row) / 2 if even_row else 0
			
			var x_tmp = (x * (self.width / self.num_bouncers_per_row)) + self.initial_x + sum_x
			var y_tmp = y * 60 + self.initial_y
			
			self.add_child(bouncer_inst)
			bouncer_inst.position = Vector2(x_tmp, y_tmp)
			self.bouncers[y].insert(x, bouncer_inst)
			print(bouncer_inst.position)
	
	self.timer.wait_time = 1
	self.timer.timeout.connect(self.onTimer)
	self.timer.start()
	
func onTimer():
	var rand_x = randi_range(0, self.bouncers.size() - 1)
	var rand_y = randi_range(0, self.bouncers[rand_x].size() - 1)
	
	var bouncer_inst = self.bouncers[rand_x][rand_y] as Bouncer
	bouncer_inst.setPower(GameState.BouncerPowers.BOUNCY)
	print(rand_x, rand_y)
