package gamekit;
import openfl.display.Graphics;
import openfl.system.Capabilities;
import openfl.Lib;
class LayerManager {
    private var _viewX:Int;
    private var _viewY:Int;
    private var _viewWidth:Int;
    private var _viewHeight:Int;
    private var _layers:Array<Layer>;
    private var _debug:Bool;
    public function new() {
        _debug =false;
        _layers = new Array<Layer>();
    #if flash
        setViewWindow(0,0,Lib.current.stage.stageWidth,Lib.current.stage.stageHeight);
       // setViewWindow(0,0,Math.round(Capabilities.screenResolutionX),Math.round(Capabilities.screenResolutionY));
    #end
    #if mobile
        setViewWindow(0,0,Capabilities.screenResolutionX,Capabilities.screenResolutionY);
    #end
    #if desktop
        setViewWindow(0,0,Lib.current.stage.stageWidth,Lib.current.stage.stageHeight);
    #end

    }
    public function setViewWindow(i:Int,j:Int,k:Int,l:Int) : Void {
        _viewX = i;
        _viewY = j;
        _viewWidth = k;
        _viewHeight = l;
    }
   public function draw(g:Graphics):Void {

       for (i in 0..._layers.length)
       {
          if(_layers[i].isVisible())
          {

                  _layers[i].draw(g);
              #if debug
                  if(_debug)
                      _layers[i].showDebug(g);
              #end

          }
       }
    }
   public function add(layer:Layer)
     {
        _layers.push(layer);
     }

   public function remove(layer:Layer)
     {
       if(layer != null)
       {
           _layers.remove(layer);
       }
     }
    public function getViewX():Int {
        return _viewX;
    }
    public function getViewY():Int {
        return _viewY;
    }
    public function getViewHeight():Int {
        return _viewHeight;
    }
    public function getViewWidth():Int {
        return _viewWidth;
    }
    public function getLength():Int {
       return _layers.length;
    }
    public function getLayer(i:Int):Layer{
        return _layers[i];
    }
	public function setDebug(d:Bool):Void {
		_debug = d;
	}
}
