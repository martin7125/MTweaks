params ["_unit"];

if (isNull _unit) exitWith {};

private _object = _unit getVariable ["MTweaks_BOC_chestpackObject", objNull];
if (!isNull _object) then
{
    detach _object;
    deleteVehicle _object;
};

_unit setVariable ["MTweaks_BOC_chestpackObject", objNull, false];
