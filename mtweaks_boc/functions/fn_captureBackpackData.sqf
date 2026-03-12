params ["_unit"];

if (isNull _unit) exitWith {[]};

private _className = backpack _unit;
if (_className isEqualTo "") exitWith {[]};

private _backpackContainer = unitBackpack _unit;
if (isNull _backpackContainer) exitWith {[]};

[
    _className,
    getItemCargo _backpackContainer,
    getWeaponCargo _backpackContainer,
    getMagazineCargo _backpackContainer,
    getBackpackCargo _backpackContainer
]
