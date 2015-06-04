package gamekit;
import openfl.display.Graphics;
class Room implements IScene {
    private var _layers:LayerManager;
    private var _viewX:Int;
    private var _viewY:Int;
    private var _viewWidth:Int;
    private var _viewHeight:Int;
    public function new() {
        _layers = new LayerManager();
        _viewX  = _layers.getViewX();
        _viewY  = _layers.getViewY();
        _viewWidth = _layers.getViewWidth();
        _viewHeight = _layers.getViewHeight();
		
    }
    public function onCreate():Void {

    }
    public function add(l:Layer):Void {
        _layers.add(l);
    }
    public function onDraw(g:Graphics):Void {
      _layers.draw(g);
    }
    public function onStep():Void {

    }
    public function onKeyPressed(keyCode:Int):Void {

    }
    public function onKeyRepeated(keyCode:Int):Void {

    }
    public function onKeyReleased(keyCode:Int):Void {

    }
    public function onPointerPressed(x:Int,y:Int):Void {

    }
    public function onPointerDragged(x:Int,y:Int):Void {

    }
    public function onPointerReleased(x:Int,y:Int):Void {

    }
	public function showDebug(d:Bool):Void {
		_layers.setDebug(d);
	}
    public function remove(l:Layer):Void {
        _layers.remove(l);
    }
    public function onDestroy():Void {
        for(l in 0..._layers.getLength()){
             _layers.remove(_layers.getLayer(l));
        }
        _layers=null;
    }
}
