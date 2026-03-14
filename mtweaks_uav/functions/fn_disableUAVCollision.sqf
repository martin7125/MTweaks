/*
Disable player collisions with Darter UAVs to prevent them from being used as weapons.
*/

["UAV_01_base_F", "init", {
  _this params ["_uav"];

  player disableCollisionWith _uav;
}, true, [], true] call CBA_fnc_addClassEventHandler;

player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
  
  {player disableCollisionWith _x} forEach entities "UAV_01_base_F";
}];