params ["_unit"];

if (isNull _unit) exitWith {};
if !(_unit isEqualTo player) exitWith {};

private _chestpackData = _unit getVariable ["MTweaks_BOC_chestpackData", []];
if (_chestpackData isEqualTo []) exitWith
{
    hint "You do not have a chestpack.";
};

if !(backpack _unit isEqualTo "") exitWith
{
    hint "Back slot is occupied. Use Swap backpack and chestpack.";
};

private _restored = [_unit, _chestpackData] call MTweaks_fnc_applyBackpackData;
if (!_restored) exitWith
{
    hint "Could not move chestpack to back.";
};

_unit setVariable ["MTweaks_BOC_chestpackData", [], true];
[_unit] call MTweaks_fnc_removeChestpackObject;

hint "Chestpack moved to back.";
