/**
*  fn_killed
*
*  Event handler for unit death.
*
*  Domain: Event
**/

if (isServer) then {
    _unit = _this select 0;
    _instigator = _this select 2;
    if (isPlayer _instigator) then {
        _kilPointMulti = _unit getVariable "killPointMulti";
        [_instigator, (BLWK_pointsForKill * _kilPointMulti)] call killPoints_fnc_add;
        _killPoints = (BLWK_pointsForKill * _kilPointMulti);
        _pointsArr = _unit getVariable "points";
        {
          _killPoints = _killPoints + _x;
        } forEach _pointsArr;

        [_unit, round (BLWK_pointsForKill * _kilPointMulti), [0.1, 1, 0.1]] remoteExec ["killPoints_fnc_hitMarker", _instigator];
    };
};