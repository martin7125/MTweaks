/*
Checks if the player can pickup the UAV.
*/

params ["_target", "_player"];

if (isNull _target) exitWith {false};

alive _target &&
vehicle _player isEqualTo _player &&
_player canAdd "MTweaks_AR2_Item" &&
_player canAdd "MTweaks_UAVBattery"