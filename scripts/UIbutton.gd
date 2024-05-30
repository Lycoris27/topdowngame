extends Button

@export var focusing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if focusing:
		SetFocus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	print("bonk")
	pass # Replace with function body.


func _on_mouse_entered():
	print("i don't want you to happen")
	pass # Replace with function body.
	
func SetFocus():
	grab_focus()
