/*
	Engine needs appr. 80 mins for cloud coverage.
*/



[] spawn {
	
	
	_locality = if (isServer) then { "Server"; } else { "Player"; };

	while {true} do {
		[format["BTK_fnc_weather: (%1 weather %7) Overcast: %2, Rain %3, Fog: %4, Wind: %5, Gusts: %6", _locality, overcast, rain, fogParams, wind, gusts, floor(time)]] call BTK_fnc_log;
		sleep 5;
	};

};


if (isServer) then {

	[] spawn {

		while {true} do {

			_count = count(switchableUnits + playableUnits);
			waitUntil {_count != count(switchableUnits + playableUnits)};

			if (count(switchableUnits + playableUnits) > _count) then {
				forceWeatherChange;
			};

		};

	};

	[] spawn {

		_dynamic = true;
		_cycleTime = 4800; // 80 mins.

		_overcast = 0;
		_rain = 0;
		_fog = [0,0,0];

		_overcast = 0;
		_rain = 0;
		_fog = [0, 0, 0];
		_windX = (10 - (random 20));
		_windY = (10 - (random 20));
		_windForced = false;

		0 setOvercast _overcast;
		0 setRain _rain;
		0 setFog _fog;
		setWind [_windX, _windY, _windForced];
		//0 setGusts ((_windX max _windY) / 10); // ?? local?

		btk_weather_server = [_overcast, _rain, _fog, [_windX, _windY, _windForced]]; publicVariable "btk_weather_server";

		//count(switchableUnits + playableUnits) > _count

		//if (true) exitWith {};

		if (_dynamic) then {

			_currentCycle = _cycleTime;
			_overcastForecast = 1;
			_rainForecast = 0;
			_fogForecast = [0, 0, 0];
			_first = true;
			
			_cycleTime setOvercast _overcastForecast;
			_cycleTime setRain _rainForecast;
			_cycleTime setFog _fogForecast;
			//setWind [_windX, _windY, _windForced];

			while {true} do {

				if (_currentCycle <= 0) then {

					// Reset
					_currentCycle = _cycleTime;

					// Cycle
					_cycleTime setOvercast _overcastForecast;
					_cycleTime setRain _rainForecast;
					_cycleTime setFog _fogForecast;
					//setWind [_windX, _windY, _windForced];
					//forceWeatherChange;

					[format["BTK_fnc_weather: New weather cycle! %1 over %2 sec.", _overcastForecast, _cycleTime]] call BTK_fnc_log;
					systemChat format["BTK_fnc_weather: New weather cycle! %1 over %2 sec.", _overcastForecast, _cycleTime];

				};

				sleep 10;
				_currentCycle = _currentCycle - 10;
				systemChat format["BTK_fnc_weather: Weather cycle finished in %1 sec.", _currentCycle];

			};

		};

	};

};


if (!(isDedicated)) then {

	[] spawn {

		// Sync at mission start
		if (isNil "btk_jip") then {

			waitUntil {!(isNil "btk_weather_server")};

			0 setOvercast (btk_weather_server select 0);
			0 setRain (btk_weather_server select 1);
			0 setFog (btk_weather_server select 2);
			setWind (btk_weather_server select 3);

		};

	};

};