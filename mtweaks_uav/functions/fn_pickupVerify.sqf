/*
Server-side function to ensure only one player can pick up the UAV in order to prevent duplication.
*/

if (!isServer) exitWith {};

params ["_target", "_player"];

if (isNull _player) exitWith {};
if (isNull _target) exitWith {};
if (_target getVariable ["MTweaks_uav_pickingUp", false]) exitWith {};

_target setVariable ["MTweaks_uav_pickingUp", true];

_player addItem "MTweaks_AR2_Item";
_player addMagazine ["MTweaks_UAVBattery", round ((fuel _target) * 1000)];

deleteVehicle _target;