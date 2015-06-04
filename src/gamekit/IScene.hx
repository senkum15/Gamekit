package gamekit;
import openfl.display.Graphics;
interface IScene {
    public function onCreate():Void;
    public function onDraw(g:Graphics):Void;
    public function onStep():Void;
    public function onDestroy():Void;
    public function onKeyPressed(keyCode:Int):Void;
    public function onKeyRepeated(keyCode:Int):Void;
    public function onKeyReleased(keyCode:Int):Void;
    public function onPointerPressed(x:Int,y:Int):Void;
    public function onPointerDragged(x:Int,y:Int):Void;
    public function onPointerReleased(x:Int,y:Int):Void;
}
