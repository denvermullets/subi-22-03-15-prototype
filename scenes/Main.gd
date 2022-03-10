extends Node

# share scene for use in godot node panel as defined variable
export(PackedScene) var mob_scene
var score: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	new_game()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_ScoreTimer_timeout():
	score += 1

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_MobTimer_timeout():
	# choose a random location on Path2d
	var mob_spawn_location: Node2D = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	# create a mob instance and add it to the scene
	var mob = mob_scene.instance()
	add_child(mob)

	# set the mob's direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2

	# set mob's position to random spot
	mob.position = mob_spawn_location.position

	# add some randomness
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# choose the velocity
	var velocity: Vector2 = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
