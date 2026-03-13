/*
Checks if the player can deploy the UAV.
*/

params ["_target", "_player"];

vehicle _player == _player &&
"MTweaks_AR2_Item" in items _player &&
"MTweaks_UAVBattery" in magazines _player