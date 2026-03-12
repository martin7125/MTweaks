params ["_unit", "_className"];

if (isNull _unit) exitWith {objNull};
if (_className isEqualTo "") exitWith {objNull};

private _existing = _unit getVariable ["MTweaks_BOC_chestpackObject", objNull];
if (!isNull _existing) then
{
    detach _existing;
    deleteVehicle _existing;
};

private _object = createVehicleLocal [_className, [0, 0, 0], [], 0, "CAN_COLLIDE"];
if (isNull _object) exitWith {objNull};

_object allowDamage false;
_object enableSimulation false;
_object disableCollisionWith _unit;

_object attachTo [_unit, [0, 0.24, -0.12], "Pelvis", true];
_object setVectorDirAndUp [vectorDir _unit, vectorUp _unit];

_object
