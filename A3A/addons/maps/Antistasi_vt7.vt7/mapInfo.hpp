#include "..\BuildObjectsList.hpp"
class vt7 {
	population[] = {
		{"aarre",80},{"Alapihlaja",90},{"Eerikkala",88},{"haavisto",60},{"Hailila",90},{"Hanski",100},{"Harju",100},{"harjula",70},{"Hurppu",80},{"Hyypianvuori",60},{"Jarvenkyla",100},{"Kirkonkyla",400},{"Klamila",150},{"Koivuniemi",100},{"Korpela",80},{"Kouki",90},{"Lansikyla",100},{"Myllynmaki",60},{"Nakarinmaki",90},{"Niemela",60},{"Ojala",80},{"Onnela",100},{"Pajunlahti",90},{"piispa",100},{"Pyterlahti",190},{"Rannanen",80},{"Ravijoki",90},{"Riko",100},{"Santaniemi",100},{"Skippari",80},{"suopelto",80},{"Sydankyla",150},{"uski",80},{"Uutela",100},{"Vilkkila",110},{"Virojoki",500},{"Ylapaa",80},{"Ylapihlaja",80},{"Souvio",70}
	};
	disabledTowns[] = {"Tikanen","toipela","hirvela","kallio","Kuusela","nopala"};
	antennas[] = {
		{907.35,2955.65,0}, {6644.62,7275.58,0.00256348}, {6242.47,13009.4,0.39426},{1768.36,15526.1,0.00277328}, {15449.2,16603.3,0}, {15224.6,14150.1,0},{10709.6,11024.9,0}
	};
	antennasBlacklistIndex[] = {};
	banks[] = {{14501.2,14607.6,0.0752449},{14669.9,14700.3,-0.102319}};
	garrison[] = {
		{},{"airport_2", "Seaport_1", "Outpost_3", "Outpost_16", "control_25", "control_29", "control_24", "control_30", "control_19", "control_21", "control_22", "control_20", "control_23"},{},{"control_25", "control_29", "control_63", "control_62", "control_24", "control_64", "control_30", "control_19", "control_21", "control_22", "control_20", "control_23"}
	};
	fuelStationTypes[] = {
		"Land_FuelStation_Feed_F","Land_fs_feed_F","Land_FuelStation_01_pump_malevil_F","Land_FuelStation_01_pump_F","Land_FuelStation_02_pump_F","Land_FuelStation_03_pump_F","Land_A_FuelStation_Feed","Land_Ind_FuelStation_Feed_EP1","Land_FuelStation_Feed_PMC","Land_Fuelstation","Land_Fuelstation_army","Land_Benzina_schnell"
	};
	milAdministrations[] = {
		{13719.3,6269.5,9.53674e-007},{1292.88,7044,0}
	};
	climate = "temperate";
	buildObjects[] = {
		BUILDABLES_HISTORIC,
		BUILDABLES_MODERN_GREEN,
		BUILDABLES_TEMPERATE,
		BUILDABLES_CUP,
		BUILDABLES_UNIVERSAL
	};
};
