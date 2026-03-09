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
        descriptionShort = "Packed AR-2 Darter UAV. Deploy and recover via ACE interaction.";
        picture = "\mtweaks_uav\ui\darter.paa";
        model = "\A3\Drones_F\Air_F_Gamma\UAV_01\UAV_01_F.p3d";

        class ItemInfo: CBA_MiscItem_ItemInfo
        {
            mass = 80;
        };
    };
};

/*
class CfgVehicles
{
    class B_UAV_01_F;

    class MTweaks_AR2_Inventory: B_UAV_01_F
    {
        author = "MTweaks";
        scope = 1;
        scopeCurator = 0;
        displayName = "AR-2 Darter (Inventory Item)";
    };
};
*/

/*
class CfgFunctions
{
    class MTweaks
    {
        tag = "MT";

        class DarterItem
        {
            file = "\mtweaks_uav\functions";
            class addInteractions
            {
                postInit = 1;
            };
            class canDeployDarter {};
            class deployDarter {};
            class canPickupDarter {};
            class pickupDarter {};
            class getUAVClassForSide {};
            class canSelectBattery {};
            class selectNextBattery {};
        };
    };
};
*/