(**This module handles the creation of all projectiles and the handling of collisions. *)

open Raylib
open Bears
open Balloons

type bullet = {
  origin : bear;
  mutable position : Vector2.t;
  velocity : Vector2.t;
  image : Texture2D.t option;
  radius : float;
  mutable pierce : int;
  mutable hits : Balloons.balloon list;
  mutable timer : int;
  target : balloon option;
}
(**-Pierce is how many balloons a bullet can pierce through.
  -Damage is how many layers of a bullet will go through.
  -Hits is the list of balloons that a bullet has already collided with, used so
  a bullet cannot hit the same balloon twice.
  -Origin is the position the bullet was fired from, so that we can delete bullets
  once they leave the bear's range.*)

val freeze_fired : (int ref * bear) list ref
(**The number of frames to display the freeze_fired animation.*)

val bullet_collection : bullet list ref
(**A collection of all the bullets currently on the screen.*)

val vector_angle : Vector2.t -> float
(**Given a vector returns the corresponding angle*)

val calculate_new_vel : bear -> Vector2.t -> Vector2.t
(**Given a bear and a target position, returns the velocity vector the projectile should have. *)

val projectile_moving_calc : bear -> balloon -> float * Vector2.t
(**Calculates the velocity vector for a projectile that was jus fired.*)

val determine_projectile_img : bear -> Texture2D.t option
(**Determiens the image of the projectile, depending on the bear firing it.*)

val is_balloon_in_range : bear -> balloon -> bool
(**Determine if a given balloon is in range of the tower.*)

val compare_balloons_helper : balloon -> balloon -> int
(**Determine which balloon is closer to the next turn point.*)

val compare_balloons : balloon -> balloon -> int
(**Determine which balloon is closer to the exit. Closer to the exit means "less_than"*)

val sort_balloons : balloon list -> balloon list
(**Sort the balloon list to be from closest to the end to furthest from the end.*)

val find_target : bear -> balloon list -> balloon option
(**Finds the balloon in range of the tower closest to the exist, assuming balloon 
    list is sorted*)

val fire_dart : bear -> balloon -> unit
(**Fires a dart.*)

val init_puck : bear -> float -> float -> bullet
(**Fires a dart nail in specified directions. *)

val fire_pucks : bear -> unit
(**Fires a dart in a nail shooter way.*)

val find_balloons_in_range : bear -> balloon list -> balloon list
(**Returns the list of balloons in range of the bear.*)

val freeze_balloons : bear -> balloon list -> unit
(**Applies a bear's freeze to all the balloons in the given list.*)

val draw_freeze_animations : (int ref * bear) list -> unit
(**Draws the freeze animation for all polar bears that have fired.*)

val update_animation_list : (int ref * bear) list -> (int ref * bear) list
(**Updates the animation list, removing expired animations.*)

val fire_polar : bear -> balloon list -> unit
(**Fires the given polar bear.*)

val init_projectile : bear -> balloon -> balloon list -> unit
(**Fires a projectile given a bear and a target balloon.*)

val fire_all_shots : bear list -> balloon list -> unit
(**Attempts to make every bear fire. Some bears may not fire when called to their 
attack speed. Precondition: balloons must be sorted.*)

val update_bullet : bullet -> unit
(**Updates a bullet's position using its velocity.*)

val update_bullets : bullet list -> unit
(**Updates all the bullets in a bullet list.*)

val dart_collisions : bear -> bullet -> balloon list -> unit
(**Updates each balloon in balloon_list and the given a dart's collision status.*)

val update_bullet_collision : bullet -> balloon list -> unit
(**Updates bullets and balloons if a collision has occurred. Compares
   given bullet with each balloon in balloon_list.*)

val update_collisions : bullet list -> balloon list -> unit
(**Updates the state of the game depending on any collisions occuring in the current frame.*)

val check_screen_bounds : bullet -> bool
(**Check if a bullet is still within the bounds of the screen.*)

val check_tower_bounds : bullet -> bool
(**Check if a bullet is within it's tower's range.*)

val check_bullet_bounds : bullet -> bool
(**Delete bullets that have left the bounds of the screen or their tower's
   range. TRUE if it is out of bounds and should be deleted.*)

val time_expired : bullet -> bool
(** Ensures that the Sniper bear always hits the target. *)

val remove_bullets : bullet list -> bullet list
(**Remove bullets whether they are out of bounds or have collided.*)

val draw_bullet : bullet -> unit
(**Draws the given bullet on the screen.*)

val draw_bullets : bullet list -> unit
(**Draws all the bullets in a bullet list to the screen.*)

val update_angle_bear : bear -> balloon list -> unit
(**Updates the angle a bear is facing such that it faces the balloon closest to the exit within its range*)

val update_angles : bear list -> balloon list -> unit
(**Calls update_angle_bear for each bear in a bear list.*)
