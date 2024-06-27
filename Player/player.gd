extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim=get_node("AnimatedSprite2D")



func _ready():
	anim.play("walking")
	
func _physics_process(delta):
	# Add the gravity.
	var animated_sprite=$AnimatedSprite2D
	
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.play("taunt")
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.scale.x=-1 * direction
		if is_on_floor():
			animated_sprite.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animated_sprite.play("idle")

	move_and_slide()
