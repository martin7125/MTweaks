params ["_unit"];

if (isNull _unit) exitWith {};

private _object = _unit getVariable ["MTweaks_BOC_chestpackObject", objNull];
private _chestpackData = _unit getVariable ["MTweaks_BOC_chestpackData", []];

if !(alive _unit) exitWith
{
    if (!isNull _object) then
    {
        [_unit] call MTweaks_fnc_removeChestpackObject;
    };
};

if (_chestpackData isEqualTo []) exitWith
{
    if (!isNull _object) then
    {
        [_unit] call MTweaks_fnc_removeChestpackObject;
    };
};

if (isNull _object) then
{
    private _className = _chestpackData param [0, ""];
    _object = [_unit, _className] call MTweaks_fnc_createChestpackObject;
    _unit setVariable ["MTweaks_BOC_chestpackObject", _object, false];
};

if (isNull _object) exitWith {};

private _animationState = toLower (animationState _unit);
private _isSwimming = (underwater _unit) ||
{
    (_animationState find "aswm" >= 0) ||
    (_animationState find "sswm" >= 0) ||
    (_animationState find "pswm" >= 0) ||
    (_animationState find "swim" >= 0)
};
private _isInParachute = (vehicle _unit) isKindOf "ParachuteBase";
private _isFreefall = (_animationState find "halofreefall" >= 0) || (_animationState find "freefall" >= 0) || (_animationState find "para_pilot" >= 0);

private _offset = [0, 0.24, -0.12];

if (_isFreefall || _isInParachute) then
{
    // Keep the chestpack around the upper legs during freefall/parachute phases.
    _offset = [0, 0.34, -0.20];
}
else
{
    if (_isSwimming) then
    {
        _offset = [0, 0.18, -0.06];
    }
    else
    {
        if ((stance _unit) isEqualTo "PRONE") then
        {
            _offset = [0, 0.28, -0.17];
        };
    };
};

_object attachTo [_unit, _offset, "Pelvis", true];
_object setVectorDirAndUp [vectorDir _unit, vectorUp _unit];
