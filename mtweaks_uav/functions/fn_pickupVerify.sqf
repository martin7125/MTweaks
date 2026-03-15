/*
Server-side function to ensure only one player can pick up the UAV in order to prevent duplication.
*/

if (!isServer) exitWith {};

params ["_target", "_player"];

if (isNull _player) exitWith {};
if (_target getVariable ["MTweaks_uav_pickingUp", false]) exitWith {};

_target setVariable ["MTweaks_uav_pickingUp", true];

_player addItem "MTweaks_AR2_Item";
_player addMagazine ["MTweaks_UAVBattery", round ((fuel _target) * 1000)];

[_player, "amovpercmstpsraswrfldnon_ainvpercmstpsraswrfldnon_putdown"] remoteExec ["playMove", _player];

deleteVehicle _target;