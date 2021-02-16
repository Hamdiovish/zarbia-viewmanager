Hello Godoter,
Hope you like our ViewManager, we use this ViewManager in our game, ZARBIA, to orginize and beautifying screens presentation.
This ViewManager allow to apply different in/out effect via one single line.
The animation is using a grayscaled images, see "mask" folder, so in order to get a new in/out effect is to open Gimp/PS and draw it.

Regarding usage:
1° Add ViewManager.tscn as autoload
2° Call it using one single line:
ViewManager.modal_show(your_scene_instance,effect,cutoff)
Ex: ViewManager.modal_show(your_scene_instance,ViewManager.EFFECT.light,1.0)
or simply use the default params:
ViewManager.modal_show(your_scene_instance)

3° Dismiss the shown scene with another line:
ViewManager.modal_dismiss()

We are currently implementing an async loading mechanism and other features, we will push it once it is enough tested.

Feel free to use and update it in your games.


All the love from ZARBIA team from Tunisia!

Enjoy!