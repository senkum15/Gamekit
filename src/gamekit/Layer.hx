package gamekit;
import openfl.display.Graphics;
class Layer {
    var _x:Float;
    var _y:Float;
    var _width:Int;
    var _height:Int;
    var _visible:Bool;
    var _depth:Int;
    public function new(width:Int,height:Int,depth:Int=0) {
        _visible = true;
        _width = width;
        _height=height;
        _depth=depth;
     }
    public function setPosition(i:Float,j:Float):Void {
        _x = i;
        _y = j;
    }
    public function move(i:Float,j:Float):Void {
        _x +=i;
        _y +=j;
    }
    public function getX():Float {
        return _x;
    }
    public function getY():Float {
        return _y;
    }
    public function getWidth():Int {
        return _width;
    }
    public function getHeight():Int {
        return _height;
    }
    public function setVisible(flag:Bool):Void {
        _visible = flag;
    }
    public function isVisible():Bool {
        return _visible;
    }
    public function getDepth():Int {
        return _depth;
    }
    public function draw(g:Graphics):Void {
    }
    #if debug
    public function showDebug(g:Graphics):Void {
    }
    #end
}


