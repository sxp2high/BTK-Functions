/*
	[] spawn BTK_fnc_sandstorm;
*/


// No dedicated
if (isDedicated) exitWith {};


// Parameter
_density = 0.05;
_newspapers = false;
//_paths = ["\A3\data_f\cl_grass1.p3d","\A3\data_f\cl_grass2.p3d","\A3\data_f\cl_rock1.p3d","\A3\data_f\cl_leaf.p3d","\A3\data_f\cl_leaf2.p3d","\A3\data_f\cl_leaf3.p3d","\A3\data_f\cl_feathers2.p3d","\A3\data_f\cl_paper1.p3d","\A3\data_f\cl_plastic1.p3d"];


// Dust
_duration = 3;
//_velocity = [0, 7, 0];
_velocity = [(wind select 0), (wind select 1), 0];
_relPos = [-((_velocity select 1) * (_duration / 2)), 0, -6];
_color = [0.4, 0.3, 0.2];
_alpha = 0.1;
_radius = 50;
_radiusHeight = 4;


// Papers
/*_paper1 = (_paths call BIS_fnc_selectRandom);
_paper2 = (_paths call BIS_fnc_selectRandom);
_paper3 = (_paths call BIS_fnc_selectRandom);
_papers = [_paper1,_paper2,_paper3];
_papersCurrent = [];*/


_newsRandom = [0, [_radius, _radius, _radiusHeight], [5, 5, 0], 2, 0.3, [0, 0, 0, 0], 10, 0];
_newsCircle = [0.1, [1, 1, 0]];
_newsInterval = 0.1;


// Main loop
while {true} do {

	// Alive, not flying, no rain & fog, not on water
	waitUntil {sleep 0.935; (alive player) && (((getPosATL (vehicle player)) select 2) < 5) && (rain == 0) && (fog == 0) && !(surfaceIsWater (getPosATL (vehicle player)))};

	_vehicle = vehicle player;
	_vehiclePos = (getPosATL _vehicle);

	_ps = "#particlesource" createVehicleLocal _vehiclePos;
	_ps setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 12, 8, 0], "", "Billboard", 1, _duration, _relPos, _velocity, 1, 1.275, 1, 0, [5], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _vehicle];
	_ps setParticleRandom [_duration, [_radius, _radius, _radiusHeight], [0, 0, 0], 1, 0, [0, 0, 0, 0.05], 0, 0];
	_ps setParticleCircle [0.2, [0, 0, 0]];
	_ps setDropInterval _density;

	/*{
		_paperPs = "#particlesource" createVehicleLocal _vehiclePos;
		_paperPs setParticleParams [[_x, 1, 0, 1], "", "SpaceObject", 1, 5, _relPos, _velocity, 1, 1.25, 1, 0.2, [0,1,1,1,0], [[1,1,1,1]], [0.7], 1, 0, "", "", _vehicle];
		_paperPs setParticleRandom _newsRandom;
		_paperPs setParticleCircle _newsCircle;
		_paperPs setDropInterval _newsInterval;
		_papersCurrent pushBack _paperPs;
	} forEach _papers;*/

	// Dead, flying, rain, fog, or on water
	waitUntil {sleep 1.117; !(alive player) || (vehicle player != _vehicle) || (rain > 0) || (fog > 0) || (surfaceIsWater (getPosATL (vehicle player)))};
	
	deleteVehicle _ps;
	/*{
		deleteVehicle _x;
	} forEach _papers;
	_papersCurrent = [];*/

};