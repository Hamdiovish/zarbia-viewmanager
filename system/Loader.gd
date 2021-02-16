extends Control

signal thread_finish

const SIMULATED_DELAY_SEC = 0.0

var thread = null

func _thread_load(path):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	var total = ril.get_stage_count()
	print("Loader: total: ",total)
	# Call deferred to configure max load steps.
#	progress.call_deferred("set_max", total)

	var res = null

	while true: #iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread.
		print("Loader: stage: ",ril.get_stage())
#		progress.call_deferred("set_value", ril.get_stage())
		# Simulate a delay.
		#OS.delay_msec(int(SIMULATED_DELAY_SEC * 3000.0))
		# Poll (does a load step).
		var err = ril.poll()
		# If OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource.
			res = ril.get_resource()
			break
		elif err != OK:
			# Not OK, there was an error.
			print("There was an error loading")
			break

	# Send whathever we did (or did not) get.
	call_deferred("_thread_done")
	return res

func _thread_done():
	print("Loader:_thread_done()")
	var resource = thread.wait_to_finish()
	var new_scene = resource.instance()
	emit_signal("thread_finish",new_scene)

func load_scene(path):
	thread = Thread.new()
	thread.start( self, "_thread_load", path)
