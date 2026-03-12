params ["_unit"];

if (isNull _unit) exitWith {};
if !(_unit isEqualTo player) exitWith {};

if (backpack _unit isEqualTo "") exitWith
{
    hint "No backpack on your back to swap.";
};

private _chestpackData = _unit getVariable ["MTweaks_BOC_chestpackData", []];
if (_chestpackData isEqualTo []) exitWith
{
    hint "You do not have a chestpack to swap.";
};

private _backpackData = [_unit] call MTweaks_fnc_captureBackpackData;
if (_backpackData isEqualTo []) exitWith
{
    hint "Could not read current backpack data.";
};

removeBackpack _unit;

private _restored = [_unit, _chestpackData] call MTweaks_fnc_applyBackpackData;
if (!_restored) exitWith
{
    [_unit, _backpackData] call MTweaks_fnc_applyBackpackData;
    hint "Could not move chestpack to back.";
};

_unit setVariable ["MTweaks_BOC_chestpackData", _backpackData, true];

[_unit] call MTweaks_fnc_removeChestpackObject;
private _object = [_unit, _backpackData param [0, ""]] call MTweaks_fnc_createChestpackObject;
_unit setVariable ["MTweaks_BOC_chestpackObject", _object, false];
[_unit] call MTweaks_fnc_updateChestpackPosition;

hint "Swapped backpack and chestpack.";
