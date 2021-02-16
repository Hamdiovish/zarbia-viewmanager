extends CanvasLayer

onready var button = $MarginContainer/MainScreen/Button
var modal_scene = preload("res://Modal.tscn")

func _ready():
	print("All the love of the ZARBIA team to the Godot people!")
	button.connect("pressed",self,"_on_button_pressed")

func _on_button_pressed():
	print("Aouch, i'm pressed!")
	var instance = modal_scene.instance()
	ViewManager.modal_show(instance)
