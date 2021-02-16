extends CanvasLayer

onready var button = $MarginContainer/ColorRect/CenterContainer/VBoxContainer/Button

func _ready():
	print("Hi, i'm a modal")
	button.connect("pressed",self,"_on_button_pressed")

func _on_button_pressed():
	print("Thank you, bye!")
	ViewManager.modal_dismiss()
