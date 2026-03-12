if (!hasInterface) exitWith {};

[] spawn
{
    waitUntil {!isNull player && {time > 0}};

    private _category =
    [
        "MTweaks_BOC_Category",
        "Chestpack",
        "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa",
        {},
        {true}
    ] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions"], _category, true] call ace_interact_menu_fnc_addActionToClass;

    private _putOnChest =
    [
        "MTweaks_BOC_PutOnChest",
        "Put Backpack On Chest",
        "\A3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa",
        {
            params ["_target", "_player"];
            [_player] call MTweaks_fnc_putBackpackOnChest;
        },
        {
            params ["_target", "_player"];
            (_target isEqualTo _player) &&
            {vehicle _player isEqualTo _player} &&
            {backpack _player != ""} &&
            {(_player getVariable ["MTweaks_BOC_chestpackData", []]) isEqualTo []}
        }
    ] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "MTweaks_BOC_Category"], _putOnChest, true] call ace_interact_menu_fnc_addActionToClass;

    private _swap =
    [
        "MTweaks_BOC_Swap",
        "Swap Backpack And Chestpack",
        "\A3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa",
        {
            params ["_target", "_player"];
            [_player] call MTweaks_fnc_swapBackpackAndChestpack;
        },
        {
            params ["_target", "_player"];
            (_target isEqualTo _player) &&
            {vehicle _player isEqualTo _player} &&
            {backpack _player != ""} &&
            {!((_player getVariable ["MTweaks_BOC_chestpackData", []]) isEqualTo [])}
        }
    ] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "MTweaks_BOC_Category"], _swap, true] call ace_interact_menu_fnc_addActionToClass;

    private _putOnBack =
    [
        "MTweaks_BOC_PutOnBack",
        "Put Chestpack On Back",
        "\A3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa",
        {
            params ["_target", "_player"];
            [_player] call MTweaks_fnc_putChestpackOnBack;
        },
        {
            params ["_target", "_player"];
            (_target isEqualTo _player) &&
            {vehicle _player isEqualTo _player} &&
            {backpack _player isEqualTo ""} &&
            {!((_player getVariable ["MTweaks_BOC_chestpackData", []]) isEqualTo [])}
        }
    ] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "MTweaks_BOC_Category"], _putOnBack, true] call ace_interact_menu_fnc_addActionToClass;

    if (isNil {missionNamespace getVariable "MTweaks_BOC_PFH"}) then
    {
        private _pfhId =
        [{
            if (hasInterface) then
            {
                {
                    private _hasChestpackData = !((_x getVariable ["MTweaks_BOC_chestpackData", []]) isEqualTo []);
                    private _hasChestpackObject = !isNull (_x getVariable ["MTweaks_BOC_chestpackObject", objNull]);

                    if (_hasChestpackData || _hasChestpackObject) then
                    {
                        [_x] call MTweaks_fnc_updateChestpackPosition;
                    };
                } forEach allPlayers;
            };
        }, 0.05] call CBA_fnc_addPerFrameHandler;

        missionNamespace setVariable ["MTweaks_BOC_PFH", _pfhId];
    };

    player addEventHandler ["Respawn",
    {
        params ["_unit", "_corpse"];

        if (!isNull _corpse) then
        {
            [_corpse] call MTweaks_fnc_removeChestpackObject;
        };

        _unit setVariable ["MTweaks_BOC_chestpackData", [], true];
        _unit setVariable ["MTweaks_BOC_chestpackObject", objNull, false];
    }];
};
