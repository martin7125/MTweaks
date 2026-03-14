class CfgPatches
{
    class MTweaks_UAV
    {
        name = "MTweaks UAV changes/additions";
        author = "Martin";
        requiredAddons[] =
        {
            "A3_Characters_F",
            "A3_Drones_F",
            "A3_Drones_F_Air_F_Gamma_UAV_01",
            "ace_interaction",
            "ace_logistics_uavbattery",
            "cba_main"
        };
        weapons[] =
        {
            "MTweaks_AR2_Item"
        };
        magazines[] =
        {
            "MTweaks_UAVBattery"
        };
        units[] = {};
    };
};

class CfgMagazines
{
    class CA_Magazine;

    class MTweaks_UAVBattery: CA_Magazine
    {
        author = "MTweaks";
        scope = 2;
        scopeArsenal = 2;
        displayName = "UAV Battery";
        descriptionShort = "UAV battery used with packed UAVs.";
        picture = "\z\ace\addons\logistics_uavbattery\ui\UAV_battery_ca.paa";
        model = "\z\ace\addons\logistics_uavbattery\data\ace_battery.p3d";
        count = 1000;
        mass = 20;
        ace_disableRepacking = 1;
    };
};

class CfgWeapons
{
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class MTweaks_AR2_Item: ACE_ItemCore
    {
        author = "MTweaks";
        scope = 2;
        scopeArsenal = 2;
        displayName = "AR-2 Darter (Packed)";
        descriptionShort = "Deploy and recover via ACE interaction. UAV battery is needed for deployment.";
        picture = "\mtweaks_uav\ui\darter.paa";
        model = "a3\props_f_enoch\military\equipment\batterypack_01_closed_f.p3d";

        class ItemInfo: CBA_MiscItem_ItemInfo
        {
            mass = 80;
        };
    };
};

class CfgVehicles
{
    class Man;
    class Air;

    class Helicopter: Air 
    {
        class ACE_Actions {
            class ACE_MainActions {};
        };
    };
    class Helicopter_Base_F: Helicopter 
    {
        class ACE_Actions: ACE_Actions 
        {
            class ACE_MainActions: ACE_MainActions {};
        };
    };

    
    class UAV_01_base_F: Helicopter_Base_F
    {
        class ACE_Actions: ACE_Actions
        {
            class ACE_MainActions: ACE_MainActions
            {
                class MTweaks_DarterPickup
                {
                  displayName = "Pack AR-2 Darter";
                  condition = "[_target, _player] call MTweaks_fnc_canPickupDarter";
                  statement = "[_target, _player] remoteExecCall ['MTweaks_fnc_pickupVerify', 2]";
                  icon = "\A3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa";
                };
            };
        };
    };

    class CAManBase: Man
    {
        class ACE_SelfActions
        {
            class ACE_Equipment
            {
                class MTweaks_DarterDeploy
                {
                  displayName = "Deploy AR-2 Darter";
                  condition = "[_player] call MTweaks_fnc_canDeployDarter";
                  statement = "[_player] call MTweaks_fnc_deployDarter";
                  icon = "\mtweaks_uav\ui\darter.paa";
                };
            };
        };
    };
};

class CfgFunctions
{
    class MTweaks
    {
        tag = "MTweaks";

        class Darter
        {
            file = "\mtweaks_uav\functions";
            //class addInteractions { postInit = 1; };
            class disableUAVCollision { postInit = 1; };
            class pickupVerify {};
            class canPickupDarter {};
            class canDeployDarter {};
            class deployDarter {};
        };
    };
};