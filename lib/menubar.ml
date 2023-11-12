open Raylib
open Bears
open Constants
open Gamebounds

(* Checks for valid placement of bear, contingent on position and cash.
   If a player no longer wants to place a bear, they can move the selected
   choice back to the menu to discard their choice. *)
let rec check_valid_placement (mouse_pos : Vector2.t)
    (rectangle_bounds : Rectangle.t list) =
  match rectangle_bounds with
  | [] -> true
  | h :: t ->
      if check_collision_point_rec mouse_pos h == true then false
      else check_valid_placement mouse_pos t

let nevermind (mouse_pos : Vector2.t) (menu : Rectangle.t) =
  check_collision_point_rec mouse_pos menu

let place_bear () =
  if !selected = false && !selected_bear <> None then selected := true
  else if
    nevermind (get_mouse_position ()) (Option.get !Constants.menu_rect)
    && !selected = true
    && is_mouse_button_pressed Left
  then (
    selected := false;
    selected_bear := None)
  else if
    !selected = true
    && is_mouse_button_pressed Left
    && check_valid_placement (get_mouse_position ()) !path_rectangles
    && (Option.get !selected_bear).cost <= !Constants.cash
    && Bears.check_collision_bears !selected_bear !Bears.bear_collection
       == false
  then (
    selected := false;
    Bears.bear_collection := Option.get !selected_bear :: !Bears.bear_collection;
    Constants.cash := !Constants.cash - (Option.get !selected_bear).cost;
    selected_bear := None)

let check_click () =
  if is_mouse_button_pressed Left then
    if
      determine_dart_bear_clicked (get_mouse_position ()) !screen_width
        !screen_height
    then selected_bear := Some (Bears.make_dart_bear (get_mouse_position ()))
    else if
      determine_hockey_bear_clicked (get_mouse_position ()) !screen_width
        !screen_height
    then selected_bear := Some (Bears.make_hockey_bear (get_mouse_position ()))
    else if
      (determine_pumpkin_bear_clicked (get_mouse_position ()))
        !screen_width !screen_height
    then selected_bear := Some (Bears.make_pumpkin_bear (get_mouse_position ()))
    else if
      (determine_ezra_bear_clicked (get_mouse_position ()))
        !screen_width !screen_height
    then selected_bear := Some (Bears.make_ezra_bear (get_mouse_position ()))
    else if
      (determine_dragon_bear_clicked (get_mouse_position ()))
        !screen_width !screen_height
    then selected_bear := Some (Bears.make_dragon_bear (get_mouse_position ()))

let draw_menu rect =
  draw_rectangle_rec rect (Color.create 183 201 226 255);
  draw_rectangle_lines_ex rect 3. Color.black;
  (* Draw the menu bears *)
  Bears.draw_bear_img
    (5.45 *. !screen_width /. 7.)
    (1. *. !screen_height /. 4.)
    Color.red;

  Bears.draw_bear_img
    (5.75 *. !screen_width /. 7.)
    (1. *. !screen_height /. 4.)
    Color.blue;

  Bears.draw_bear_img
    (6.05 *. !screen_width /. 7.)
    (1. *. !screen_height /. 4.)
    Color.orange;

  Bears.draw_bear_img
    (6.35 *. !screen_width /. 7.)
    (1. *. !screen_height /. 4.)
    Color.purple;

  Bears.draw_bear_img
    (6.65 *. !screen_width /. 7.)
    (1. *. !screen_height /. 4.)
    Color.green;
  ()

let lives_box screen_width screen_height =
  Rectangle.create
    (149. *. screen_width /. 200.)
    (0.5 *. screen_height /. 9.)
    (1. *. screen_width /. 9.)
    (screen_height /. 19.)

let cash screen_width screen_height =
  Rectangle.create
    (173. *. screen_width /. 200.)
    (0.5 *. screen_height /. 9.)
    (1. *. screen_width /. 9.)
    (screen_height /. 19.)

let draw_heart heart_text screen_width screen_height =
  draw_texture_ex (Option.get heart_text)
    (Vector2.create
       (149. *. screen_width /. 200.)
       (0.45 *. screen_height /. 9.))
    0. 0.10 Color.white

let draw_cash cash_text screen_width screen_height =
  draw_texture_ex (Option.get cash_text)
    (Vector2.create
       (174. *. screen_width /. 200.)
       (0.55 *. screen_height /. 9.))
    0. 0.07 Color.white

let lives_and_cash_count screen_width screen_height =
  Raylib.draw_text
    (string_of_int !Constants.lives)
    (int_of_float (158. *. screen_width /. 200.))
    (int_of_float (0.62 *. screen_height /. 9.))
    25 Color.white;
  Raylib.draw_text
    (string_of_int !Constants.cash)
    (int_of_float (182. *. screen_width /. 200.))
    (int_of_float (0.62 *. screen_height /. 9.))
    25 Color.white
