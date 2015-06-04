package gamekit;
import openfl.display.Graphics;
import openfl.Lib;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
class Parallex extends Layer {
    public static var DIRECTION_RIGHT:Int = 0;
    public static var DIRECTION_LEFT:Int = 180;
    private var d2r:Float = Math.PI / -180;
    var _img:Tilesheet;
    var _imgW:Int;
    var _imgH:Int;
    var _count:Int;
    var _speed:Float;
    var _direction:Float;
    var _layers:Array<Float>;
#if debug
    public var debugColor:Int=0x00FF00;
#end
    public function new(src:BitmapData,c:Int,spd:Float,d:Float) {
    _img = new Tilesheet(src);
    _count = c;
    _speed = spd;
    _direction = d;
    _imgW = src.width;
    _imgH = src.height;
     super(Lib.current.stage.stageWidth,src.height);
    _img.addTileRect(new Rectangle(0,0,src.width,src.height));
     _layers = new Array<Float>();
       for(l in 0..._count)
           _layers.push((l*_imgW));
    }
    private function add(i:Int):Void {



    }
  override public function draw(g:Graphics):Void {
      var tiles:Array<Float> = [];
      for(l in 0..._count)
      {
          if(_layers[l]+_imgW<0)
          {
              if(l==0)
              {
                  _layers[0]=_layers[_layers.length-1]+(_imgW-10);
              }
              else
              {
                  _layers[l]=_layers[l-1]+_imgW;
              }
          }
          else{
              var _objd_ = _direction * d2r;
              _layers[l] += _speed * Math.cos(_objd_);
          }
          tiles = tiles.concat([_layers[l], _y, 0]);
      }

    _img.drawTiles(g,tiles);
  }
#if debug
    override public function showDebug(g:Graphics):Void {
        if(isVisible())
        {
            g.beginFill(debugColor,0.2);
            g.drawRect(_x,_y,_width,_height);
        }
    }
#end
  public function setSpeed(i:Float):Void {
    _speed =i;
  }
  public function setDirection(i:Float):Void {
        _direction =i;
  }
}
