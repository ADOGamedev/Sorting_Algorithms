extends Node2D

signal array_sorted

@onready var bar = preload("res://bar.tscn")
var array_len = 75
var array = []
var comparisons = 0
var array_accesses = 0
var delay = 0.5
var sorting = false
enum SortingTypes {BUBBLE, SELECTION, INSERTION, MERGE, QUICK, HEAP, COUNTING, SHELL, TIM, RADIX, BOGO}
var sorting_type = SortingTypes.BUBBLE
var hash = {}
var volume = 1.0
var elapsed_ms = 0

func _ready() -> void:
	randomize()
	$control_panel.stop_bogo_sort_button.connect("pressed", Callable(get_node("algorithms_manager/bogo_sort"), "_on_stop_bogo_sort"))
	gen_array(false)
	
func gen_array(suffle : bool, use_custom_suffle = false, clear = true):
	comparisons = 0
	array_accesses = 0
	if clear:
		array = []
		for child in %bars_hbox_cont.get_children():
			child.queue_free()
		
		for i in range(1, array_len + 1):
			array.append(i)

	if suffle and !use_custom_suffle:
		array.shuffle()
	
	for n in array:
		if !clear:
			break
		var new_bar = bar.instantiate()
		hash[n] = new_bar
		%bars_hbox_cont.add_child(new_bar)
		new_bar.update_num(n, array_len)
		new_bar.use_border(array_len < 200)
		new_bar.unselect()
	
	if suffle and use_custom_suffle:
		await $shuffle.shuffle(array, hash, %bars_hbox_cont)

func unselect_bars():
	for child in %bars_hbox_cont.get_children():
		child.unselect()
		
func finish_sorting(solved = true):
	var acumulated_delay = 0
	if solved:
		for i in %bars_hbox_cont.get_children():
			play_pop(i.num)
			acumulated_delay = await await_delay(acumulated_delay)
			i.select()
			
	$control_panel.enable_size_slider()
	$control_panel.enable_buttons()
	$control_panel.show_stop_bogo_sort_button(false)

func await_delay(acumulated_delay : float):
	acumulated_delay += 0.8 / len(array)
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
	return acumulated_delay
		
func play_pop(num : int):
	var effect = AudioServer.get_bus_effect(AudioServer.get_bus_index("PitchBut"), 0)
	effect.pitch_scale = num / float(array_len) + 0.1
	effect.pitch_scale = clampf(effect.pitch_scale, 0.2, 2.3)
	$pop.play()
	
func sort_array():
	$control_panel.disable_size_slider()
	$control_panel.disable_buttons()
	match sorting_type:
		SortingTypes.BUBBLE: await $algorithms_manager.bubble_sort(array, hash, %bars_hbox_cont)
		SortingTypes.SELECTION: await $algorithms_manager.selection_sort(array, hash, %bars_hbox_cont)
		SortingTypes.INSERTION: await $algorithms_manager.insertion_sort(array, hash, %bars_hbox_cont)
		SortingTypes.MERGE: await $algorithms_manager.merge_sort(array, hash, %bars_hbox_cont)
		SortingTypes.QUICK: await $algorithms_manager.quick_sort(array, hash, %bars_hbox_cont)
		SortingTypes.HEAP: await $algorithms_manager.heap_sort(array, hash, %bars_hbox_cont)
		SortingTypes.COUNTING: await $algorithms_manager.counting_sort(array, hash, %bars_hbox_cont)
		SortingTypes.SHELL: await $algorithms_manager.shell_sort(array, hash, %bars_hbox_cont)
		SortingTypes.TIM: await $algorithms_manager.tim_sort(array, hash, %bars_hbox_cont)
		SortingTypes.RADIX: await $algorithms_manager.radix_sort(array, hash, %bars_hbox_cont)
		SortingTypes.BOGO: 
			$control_panel.show_stop_bogo_sort_button(true)
			await $algorithms_manager.bogo_sort(array, hash)

	
