extends CanvasLayer

signal view_ready

onready var sec_container = $SecondaryViewportContainer
onready var sec_viewport = $SecondaryViewportContainer/Viewport
onready var cover = $CoverContainer/Cover
onready var cover_container = $CoverContainer

onready var animator = $AnimationPlayer

enum EFFECT {light, shards, blinds }

func modal_show(scene,effect=EFFECT.shards,smooth=0.4):
	print("display()")
	get_tree().get_root().set_disable_input(true)
	
	cover.texture =get_tree().current_scene.get_viewport().get_texture()
	cover.visible=true
	cover_container.visible=true
	
	var effect_param=load("res://system/resource/mask/"+EFFECT.keys()[effect]+".png")
	if effect_param:
		sec_container.material.set_shader_param("mask",effect_param)
	sec_container.material.set_shader_param("smooth_size", smooth)
	sec_container.visible=true
	
	sec_viewport.add_child(scene)
	animator.play("in")
	yield(animator,"animation_finished")
	get_tree().get_root().set_disable_input(false)

func modal_dismiss():
	print("dismiss()")
	get_tree().get_root().set_disable_input(true)
	animator.play("out")
	yield(animator,"animation_finished")
	sec_container.visible=false
	cover.visible=false
	cover_container.visible=false
	get_tree().get_root().set_disable_input(false)
	clear(sec_viewport)

func clear(view:Viewport):
	for item in view.get_children():
		item.queue_free()

func pop_root():
	var last = get_tree().root.get_child_count()-1
	if last>0:
		get_tree().root.get_child(last).queue_free()
		get_tree().current_scene=get_tree().root.get_child(last-1)

func push_root(scene):
	get_tree().root.add_child(scene)
	get_tree().current_scene = scene

func _ready():
	print("ViewManager:_ready():")
	sec_container.visible=false
	cover.visible=false
	cover_container.visible=false
