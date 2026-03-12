class CfgPatches
{
    class MTweaks_BOC
    {
        name = "MTweaks Backpack On Chest";
        author = "MTweaks";
        requiredAddons[] =
        {
            "A3_Characters_F",
            "ace_main",
            "ace_interact_menu",
            "cba_main"
        };
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class MTweaks
    {
        tag = "MTweaks";

        class BackpackOnChest
        {
            file = "\mtweaks_boc\functions";
            class addInteractions
            {
                postInit = 1;
            };
            class applyBackpackData {};
            class captureBackpackData {};
            class createChestpackObject {};
            class putBackpackOnChest {};
            class putChestpackOnBack {};
            class removeChestpackObject {};
            class swapBackpackAndChestpack {};
            class updateChestpackPosition {};
        };
    };
};
