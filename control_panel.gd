extends Control

@onready var stop_bogo_sort_button = %stop_bogo_sort_button

func _ready() -> void:
	%bubble_sort.grab_focus()
	
func _process(delta: float) -> void:
	%comparisons.text = "COMPARISONS:   " + str(owner.comparisons)
	%array_accesses.text = "ARRAY ACCESSES:   " + str(owner.array_accesses)

func _on_delay_slider_value_changed(value: float) -> void:
	owner.delay = value
	%delay_label.text = "DELAY:   " + str(value) + "ms"

func _on_size_slider_value_changed(value: float) -> void:
	owner.array_len = int(value)
	%size_label.text = "ARRAY SIZE:   " + str(int(value))
	owner.gen_array(false)

func enable_size_slider():
	%size_slider.mouse_filter = 0
	
func disable_size_slider():
	%size_slider.mouse_filter = 2

func disable_buttons():
	for button in $%algorithms_hbox_cont.get_children():
		button.disabled = true
		button.mouse_filter = 2
	%sort_button.disabled = true
	%unsort_button.disabled = true
	
func enable_buttons():
	for button in $%algorithms_hbox_cont.get_children():
		button.disabled = false
		button.mouse_filter = 0
	%sort_button.disabled = false
	%unsort_button.disabled = false
	
func show_stop_bogo_sort_button(show : bool):
	%sort_button.visible = !show
	%unsort_button.visible = !show
	%stop_bogo_sort_button.visible = show
	
func _on_bubble_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.BUBBLE

func _on_selection_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.SELECTION

func _on_insertion_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.INSERTION

func _on_merge_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.MERGE

func _on_quick_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.QUICK

func _on_heap_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.HEAP

func _on_counting_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.COUNTING

func _on_shell_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.SHELL

func _on_tim_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.TIM

func _on_radix_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.RADIX

func _on_bogo_sort_pressed() -> void:
	owner.sorting_type = owner.SortingTypes.BOGO
	
func _on_sort_button_pressed() -> void:
	owner.unselect_bars()
	owner.sort_array()

func _on_unsort_button_pressed() -> void:
	owner.gen_array(true)

func log10(x: float) -> float:
	return log(x) / log(10.0)

func _on_volume_slider_value_changed(value: float) -> void:
	%volume_label.text = "VOLUME:   " + str(int(value)) + "%"
	var volume_db
	if value <= 0:
		volume_db = -80
	else:
		volume_db = 20 * log10(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("PitchBut"), volume_db)
