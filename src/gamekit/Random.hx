package gamekit;
class Random {
    public static function choose(s:Array<Dynamic>):Dynamic {
        return s[Math.round(Math.random() * s.length)];
    }

    public static function random(_value:Float):Float {
        return Math.random() * _value;
    }

    public static function irandom(_value:Int):Int {
        return Math.round((Math.random() * _value));
    }
    public static function irange(from:Int,to:Int):Int {
        return Math.round(Math.random()*(to-from+1)+from);
    }
}
