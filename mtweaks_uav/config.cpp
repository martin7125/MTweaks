class CfgPatches
{
    class MTweaks_UAV
    {
        name = "MTweaks UAV changes/additions";
        author = "Martin";
        requiredAddons[] =
        {
            "A3_Drones_F",
            "ace_main",
            "ace_interact_menu",
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

class CfgFunctions
{
    class MTweaks
    {
        tag = "MTweaks";

        class Darter
        {
            file = "\mtweaks_uav\functions";
            class addInteractions { postInit = 1; };
            class disableUAVCollision { postInit = 1; };
            class pickupVerify {};
            class canPickupDarter {};
            class canDeployDarter {};
            class deployDarter {};
        };
    };
};