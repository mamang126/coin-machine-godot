class_name Ball extends RigidBody2D

func _ready():
	self.contact_monitor = true;
	self.max_contacts_reported = 3
	self.body_entered.connect(self.onCollision)
	
func _process(delta):
	if self.position.y < -1000:
		self.queue_free()
	
func onCollision(body: Node2D):
	if body.has_method('onBallCollision'):
		body.onBallCollision()
