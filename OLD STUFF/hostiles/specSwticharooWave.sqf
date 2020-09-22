
//teleport players away from Bulwark
{
    _distToBulwark = 0;
    telePos = getPos _x;
    while {_distToBulwark < 30 && {["mine_", str(_x)] call BIS_fnc_inString} count (telePos nearObjects 10) <= 1} do {
    telePos = [bulwarkRoomPos, 30, BLWK_playAreaRadius - 10, 3, 0, 10, 0] call BIS_fnc_findSafePos;
    _distToBulwark = telePos distance bulwarkBox;
    };
    if (telePos distance _x >= 3 && _x distance bulwarkBox < 30) then {
    _x setPos telePos;
    };
    telePos = [];
} forEach allPlayers;


//Spawn AI Around Bulwark
for ("_i") from 1 to ((floor BLWK_currentWaveNumber / 2) + (floor count allPlayers * 1.5)) do {
    _location = [bulwarkBox] call bulwark_fnc_findPlaceAround;
    _attGroupBand = createGroup [EAST, true];
    _unitClass = selectRandom BLWK_enemyClasses_level_1;
    _unit = objNull;
    _unit = _attGroupBand createUnit [_unitClass, [0,0,0], [], 0.5, "FORM"];
    _unit setPosASL _location;
	sleep 0.3;
	waitUntil {!isNull _unit};

	[_unit] join _attGroupBand;
	_unit setSkill ["aimingAccuracy", 0.05];
	_unit setSkill ["aimingSpeed", 0.05];
	_unit setSkill ["aimingShake", 0.05];
	_unit setSkill ["spotTime", 0.05];
	_unit addEventHandler ["Hit", killPoints_fnc_hit];
	_unit addEventHandler ["Killed", killPoints_fnc_killed];
    _unit setVariable ["killPointMulti", BLWK_pointMulti_men_level1];
	removeAllAssignedItems _unit;
	BLWK_zeus addCuratorEditableObjects [[_unit], true];
    unitArray = waveUnits select 0;
    unitArray append [_unit];
};