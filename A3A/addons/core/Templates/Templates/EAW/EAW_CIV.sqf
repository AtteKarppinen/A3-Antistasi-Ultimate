//////////////////////////
//       Vehicles       //
//////////////////////////    

["vehiclesCivCar", [
    "LIB_GazM1", 1
    , "LIB_GazM1_dirty", 1
    , "LIB_GazM1_SOV_camo_sand", 1
    , "LIB_GazM1_SOV", 1
    ]] call _fnc_saveToTemplate;

["vehiclesCivIndustrial", [
    "LIB_Zis5v", 1
]] call _fnc_saveToTemplate;

["vehiclesCivBoat", [
    "LIB_LCA", 0.1
]] call _fnc_saveToTemplate;

["vehiclesCivRepair", [
    "LIB_Zis6_Parm", 0.1
]] call _fnc_saveToTemplate;

["vehiclesCivMedical", [
    "LIB_Zis5v_Med", 0.1
]] call _fnc_saveToTemplate;

["vehiclesCivFuel", [
    "LIB_Zis5v_Fuel", 0.1
]] call _fnc_saveToTemplate;

/////////////////////
///  Identities   ///
/////////////////////

["faces", ["LivonianHead_6","RussianHead_1","RussianHead_2","RussianHead_3","RussianHead_4","RussianHead_5","LIB_aleksei_IF","LIB_boyartsev_IF","LIB_bykov_IF","LIB_Otto_IF","LIB_Volker_IF","LIB_Walter_IF","LIB_Wolf_IF"]] call _fnc_saveToTemplate;

//////////////////////////
//       Loadouts       //
//////////////////////////

private _civUniforms = [
    "EAW_Civ_1_Uniform",
    "EAW_Civ_1_Uniform_Brown",
    "EAW_Civ_1_Uniform_Grey",
    "EAW_Civ_1_Uniform_Tan",
    "EAW_Civ_1_Uniform_White",
    "EAW_Civ_Robe_Uniform_Blue",
    "EAW_Civ_Robe_BlueGrey",
    "EAW_Civ_Robe_Grey"
];

private _pressUniforms = [
    "EAW_Civ_1_Uniform",
    "EAW_Civ_1_Uniform_Brown",
    "EAW_Civ_1_Uniform_Grey",
    "EAW_Civ_1_Uniform_Tan",
    "EAW_Civ_1_Uniform_White",
    "EAW_Civ_Robe_Uniform_Blue",
    "EAW_Civ_Robe_BlueGrey",
    "EAW_Civ_Robe_Grey"
    ];            //Uniforms given to Press/Journalists

private _workerUniforms = [
    "EAW_Civ_1_Uniform",
    "EAW_Civ_1_Uniform_Brown",
    "EAW_Civ_1_Uniform_Grey",
    "EAW_Civ_1_Uniform_Tan",
    "EAW_Civ_1_Uniform_White"
    ];           //Uniforms given to Workers at Factories/Resources

["uniforms", _civUniforms + _pressUniforms + _workerUniforms] call _fnc_saveToTemplate;          //Uniforms given to the Arsenal, Allowed for Undercover and given to Rebel Ai that go Undercover

_civHats = [
    "H_LIB_CIV_Villager_Cap_1",
    "H_LIB_CIV_Villager_Cap_2",
    "H_LIB_CIV_Villager_Cap_3",
    "H_LIB_CIV_Villager_Cap_4",
    "H_LIB_CIV_Worker_Cap_1",
    "H_LIB_CIV_Worker_Cap_2",
    "H_LIB_CIV_Worker_Cap_3",
    "H_LIB_CIV_Worker_Cap_4"
    ];

["headgear", _civHats] call _fnc_saveToTemplate;            //Headgear given to Normal Civs, Workers, Undercover Rebels.


private _loadoutData = call _fnc_createLoadoutData;

_loadoutData set ["uniforms", _civUniforms];
_loadoutData set ["pressUniforms", _pressUniforms];
_loadoutData set ["workerUniforms", _workerUniforms];
_loadoutData set ["helmets", _civHats];
_loadoutData set ["pressHelmets", ["H_LIB_CIV_Villager_Cap_1", "H_LIB_CIV_Villager_Cap_2", "H_LIB_CIV_Villager_Cap_3", "H_LIB_CIV_Villager_Cap_4"]];
_loadoutData set ["workerHelmets", ["", "H_LIB_CIV_Worker_Cap_1", "H_LIB_CIV_Worker_Cap_2", "H_LIB_CIV_Worker_Cap_3", "H_LIB_CIV_Worker_Cap_4"]];
_loadoutData set ["facewear", ["G_LIB_Dienst_Brille","G_LIB_Dienst_Brille2","G_LIB_GER_Gloves1","G_LIB_GER_Gloves2","G_LIB_GER_Gloves3"]];

_loadoutData set ["maps", ["ItemMap"]];

private _manTemplate = {
    ["helmets"] call _fnc_setHelmet;
    ["uniforms"] call _fnc_setUniform;
    ["facewear"] call _fnc_setFacewear;

    ["items_medical_standard"] call _fnc_addItemSet;

    ["maps"] call _fnc_addMap;
};
private _workerTemplate = {
    ["workerHelmets"] call _fnc_setHelmet;
    ["workerUniforms"] call _fnc_setUniform;
    ["facewear"] call _fnc_setFacewear;

    ["items_medical_standard"] call _fnc_addItemSet;

    ["maps"] call _fnc_addMap;
    ["watches"] call _fnc_addWatch;
    ["compasses"] call _fnc_addCompass;
};
private _pressTemplate = {
    ["pressHelmets"] call _fnc_setHelmet;
    ["pressUniforms"] call _fnc_setUniform;
    ["facewear"] call _fnc_setFacewear;

    ["items_medical_standard"] call _fnc_addItemSet;

    ["maps"] call _fnc_addMap;
};
private _prefix = "militia";
private _unitTypes = [
    ["Press", _pressTemplate],
    ["Worker", _workerTemplate],
    ["Man", _manTemplate]
];

[_prefix, _unitTypes, _loadoutData] call _fnc_generateAndSaveUnitsToTemplate;
