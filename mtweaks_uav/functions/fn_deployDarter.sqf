/*
Sets up the AR-2 Darter UAV for deployment. Exact placement is handled via ACE carry.
*/

params ["_player"];

//Select which UAV to spawn depending on player side
private _uavClass = switch (side _player) do {
  case west: {"B_UAV_01_F"};
  case east: {"O_UAV_01_F"};
  case independent: {"I_UAV_01_F"};
  default {""};
};

private _spawnOffset = [0, 1.2, 0.5];

//Sort UAV batteries by capacity
private _batteries = magazinesAmmo _player select {(_x select 0) isEqualTo "MTweaks_UAVBattery"};
_batteries = [_batteries, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;

if (_batteries isEqualTo []) exitWith {};

//Select the battery with highest capacity to be used for UAV deployment
private _largestBattery = round ((_batteries select 0) select 1);
private _fuel = _largestBattery / 1000;

private _uav = createVehicle [_uavClass, _player modelToWorld _spawnOffset];
//_uav enableSimulationGlobal false; //Disable simulation or else UAV will make noise while carrying

[_uav, _fuel] remoteExecCall ["setFuel", _uav];
[_uav, false] remoteExecCall ["engineOn", _uav];

_player removeItem "MTweaks_AR2_Item";
_player removeMagazines "MTweaks_UAVBattery";

//Rebuild UAV battery magazine inventory except for the one used for deployment
{
  if (_forEachIndex == 0) then {continue};

  _player addMagazine ["MTweaks_UAVBattery", _x select 1];
} forEach _batteries;

//Use ACE carry to place the UAV
[_uav, true, _spawnOffset, 0, true, false] call ace_dragging_fnc_setCarryable;
[_player, _uav] call ace_dragging_fnc_startCarry;
[_uav, false] remoteExecCall ["allowDamage", _uav];

//Re-enable UAV simulation and create crew once player is done carrying it
[{
  _this params ["_player", "_uav"];

  isNull (attachedTo _uav) || !(alive _player) || !(alive _uav)
},
{
  _this params ["_player", "_uav"];

  //_uav enableSimulationGlobal true;
  [_uav, false] call ace_dragging_fnc_setCarryable;
  createVehicleCrew _uav;
}, [_player, _uav]] call CBA_fnc_waitUntilAndExecute;