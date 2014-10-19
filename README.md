SaloonShoot-cocos2dv3
=====================
Code for the iOS game [SaloonShoot](https://itunes.apple.com/us/app/saloonshoot-fast-annoying/id872550824?mt=8) made using [cocos2d-v3](http://www.cocos2d-swift.org/blog/cocos2d-v3-is-here).

Shows iAd and Admob ads but without using mediation. Instead, iAd is tried first and if it fails to load Admob ad is tried. I use this approach, instead of admob-mediation, because it is more transparent and I have seen ambiguity (in the past while using mediation) in the reportings of iAd and admob.

Change the `Intervals` in the [TuningParams.h](https://github.com/iabtyagi/SaloonShoot-cocos2dv3/blob/master/SaloonShoot/Classes/TuningParams.h#L39) file to change the playing hardness of the game.

NOTE: I am not working on this game anymore. I am uploading it just in
case it is of any help to anybody. So I may not be able to fix
bugs/issues, if any or give any kind of support.
