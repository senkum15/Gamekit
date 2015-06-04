package gamekit;
import openfl.display.Graphics;
interface ICanvas {
public function render(g:Graphics):Void;
public function update():Void;
public function keyPressed(keyCode:Int):Void;
public function keyRepeated(keyCode:Int):Void;
public function keyReleased(keyCode:Int):Void;
public function pointerPressed(x:Int,y:Int):Void;
public function pointerDragged(x:Int,y:Int):Void;
public function pointerReleased(x:Int,y:Int):Void;
public function showNotify():Void;
public function hideNotify():Void;
public function flushGraphics():Void;
}
