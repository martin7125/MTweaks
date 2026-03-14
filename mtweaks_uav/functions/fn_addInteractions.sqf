/*
Adds player self actions and UAV object actions.
*/

if (!hasInterface) exitWith {};

private _deployAction = 
[
  "darterDeployAction",
  "Deploy AR-2 Darter",
  "\mtweaks_uav\ui\darter.paa",
{
  params ["_target", "_player", "_params"];

  [_target, _player] call MTweaks_fnc_deployDarter;
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

    [_target, _player] call MTweaks_fnc_canPickupDarter;
  }
] call ace_interact_menu_fnc_createAction;

["UAV_01_base_F", 0, ["ACE_MainActions"], _pickupAction, true] call ace_interact_menu_fnc_addActionToClass;
