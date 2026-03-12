if (!hasInterface) exitWith {};

private _deployAction = 
[
  "darterDeployAction",
  "Deploy AR-2 Darter",
  "\mtweaks_uav\ui\darter.paa",
{
  private _uavClass = switch (playerside) do {
    case west: {"B_UAV_01_F"};
    case east: {"O_UAV_01_F"};
    case independent: {"I_UAV_01_F"};
    default {""};
  };

  private _batteries = magazinesAmmo player select {(_x select 0) isEqualTo "MTweaks_UAVBattery"};
  _batteries = [_batteries, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;

  private _largestBatteryCapacity = (_batteries select 0) select 1;
  if (isNil "_largestBatteryCapacity") exitWith {};

  private _fuel = _largestBatteryCapacity / 1000;
  private _deployPosATL = player modelToWorld [0, 1.2, 0];
  private _deploySurfaceNormal = surfaceNormal _deployPosATL;

  private _uav = createVehicle [_uavClass, getPosATL player];
  createVehicleCrew _uav;

  [_uav, _fuel] remoteExec ["setFuel", _uav];
  [_uav, false] remoteExec ["engineOn", _uav];

  player removeItem "MTweaks_AR2_Item";
  player removeMagazines "MTweaks_UAVBattery";

  {
    if (_forEachIndex == 0) then {continue};

    player addMagazine ["MTweaks_UAVBattery", _x select 1];
  } forEach _batteries;

  [_uav, true, [0, 1.2, 0.4], 0, true, false] call ace_dragging_fnc_setCarryable;
  [player, _uav] call ace_dragging_fnc_startCarry;

  [player, _fuel] remoteExecCall ["MTweaks_fnc_deployDarterServer", 2];
},
{  
  params ["_target", "_player", "_params"];

  [_target, _player] call MTweaks_fnc_canDeployDarter;
}] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions"], _deployAction, true] call ace_interact_menu_fnc_addActionToClass;


private _pickupAction = 
[
  "darterPickupAction",
  "Pack AR-2 Darter",
  "\A3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa",
  {
    params ["_target", "_player", "_params"];

    [_target, _player] remoteExec ["MTweaks_fnc_pickupVerify", 2];
  },
  {
    params ["_target", "_player", "_params"];

    [_target, _player] call MTweaks_fnc_canPickupDarter
  }
] call ace_interact_menu_fnc_createAction;

["UAV_01_base_F", 0, ["ACE_MainActions"], _pickupAction, true] call ace_interact_menu_fnc_addActionToClass;
