params ["_unit"];

if (isNull _unit) exitWith {};
if !(_unit isEqualTo player) exitWith {};

if (backpack _unit isEqualTo "") exitWith
{
    hint "No backpack on your back.";
};

private _existingChestpack = _unit getVariable ["MTweaks_BOC_chestpackData", []];
if !(_existingChestpack isEqualTo []) exitWith
{
    hint "You already have a chestpack.";
};

private _backpackData = [_unit] call MTweaks_fnc_captureBackpackData;
if (_backpackData isEqualTo []) exitWith
{
    hint "Could not read backpack data.";
};

private _className = _backpackData param [0, ""];

_unit setVariable ["MTweaks_BOC_chestpackData", _backpackData, true];
removeBackpack _unit;

private _object = [_unit, _className] call MTweaks_fnc_createChestpackObject;
_unit setVariable ["MTweaks_BOC_chestpackObject", _object, false];
[_unit] call MTweaks_fnc_updateChestpackPosition;

hint "Backpack moved to chest.";
