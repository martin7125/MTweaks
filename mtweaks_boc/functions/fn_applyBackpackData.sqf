params ["_unit", "_data"];

if (isNull _unit) exitWith {false};
if !(_data isEqualType [] && {count _data >= 5}) exitWith {false};

private _className = _data param [0, ""];
if (_className isEqualTo "") exitWith {false};

if !(backpack _unit isEqualTo "") then
{
    removeBackpack _unit;
};

_unit addBackpack _className;
private _backpackContainer = unitBackpack _unit;
if (isNull _backpackContainer) exitWith {false};

clearAllItemsFromBackpack _unit;

private _addCargo =
{
    params ["_container", "_cargo", "_addFunction"];

    private _classes = _cargo param [0, []];
    private _counts = _cargo param [1, []];

    for "_i" from 0 to ((count _classes) - 1) do
    {
        private _amount = _counts param [_i, 0];
        if (_amount > 0) then
        {
            [_container, _classes # _i, _amount] call _addFunction;
        };
    };
};

private _addItem = { params ["_container", "_class", "_count"]; _container addItemCargoGlobal [_class, _count]; };
private _addWeapon = { params ["_container", "_class", "_count"]; _container addWeaponCargoGlobal [_class, _count]; };
private _addMagazine = { params ["_container", "_class", "_count"]; _container addMagazineCargoGlobal [_class, _count]; };
private _addBackpack = { params ["_container", "_class", "_count"]; _container addBackpackCargoGlobal [_class, _count]; };

[_backpackContainer, _data param [1, [[], []]], _addItem] call _addCargo;
[_backpackContainer, _data param [2, [[], []]], _addWeapon] call _addCargo;
[_backpackContainer, _data param [3, [[], []]], _addMagazine] call _addCargo;
[_backpackContainer, _data param [4, [[], []]], _addBackpack] call _addCargo;

true
