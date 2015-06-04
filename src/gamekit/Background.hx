package gamekit;
import openfl.display.Tilesheet;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.display.GradientType;
import openfl.geom.Matrix;
import openfl.display.Graphics;

import openfl.display.BitmapData;
class Background extends Layer {

    private var _img:Tilesheet;
    private var _matrix:Matrix;
    private var _viewW:Int;
    private var _viewH:Int;
    public function new(src:BitmapData,w:Int,h:Int) {
    _img = new Tilesheet(src);
    _img.addTileRect(new Rectangle(0,0,src.width,src.height));
    _viewW = w;
    _viewH = h;
    super(src.width,src.height);
    _matrix = new Matrix();
    setTransform();
    }
   override public function draw(g:Graphics){
       _img.drawTiles(g,[_x,_y,0,_matrix.a, _matrix.b, _matrix.c, _matrix.d,1],true,Tilesheet.TILE_TRANS_2x2|Tilesheet.TILE_ALPHA);

   }
    public function setTransform():Void {
        _matrix.identity();
        _matrix.scale(_viewW/_width,_viewH/_height);
    }
}
