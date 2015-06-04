package gamekit;

import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import gamekit.Spriter;
import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
import openfl.display.Graphics;
class Spriter extends Layer implements ISprite {
        public static var R2D:Float =  -180 / Math.PI;
        public static var D2R:Float = Math.PI/-180;
        public static var TWO_PI:Float = Math.PI * 2;
     //origin
        public static var ORIGIN_TOPLEFT:Int = 0;
        public static var ORIGIN_TOP:Int=1;
        public static var ORIGIN_TOPRIGHT:Int=2;
        public static var ORIGIN_CENTERLEFT:Int = 3;
        public static var ORIGIN_CENTER:Int = 4;
        public static var ORIGIN_CENTERRIGHT:Int = 5;
        public static var ORIGIN_BOTTOMLEFT:Int = 6;
        public static var ORIGIN_BOTTOM:Int = 7;
        public static var ORIGIN_BOTTOMRIGHT:Int = 8;
        //Frame
            private var _img:Tilesheet;         //  indicates sprite of object. Sprite affects drawing and collision behaviours
            private var _frameWidth:Int;        //  sprite each frame width
            private var _frameHeight:Int;       //  sprite ect fram height
            private var _numberFrames:Int;      //  sprite total number of frames
            private var _xoffset:Float;         //  indicates sprite x offset (origin)
            private var _yoffset:Float;         //  indicates sprite y offset (origin)
            private var _xprevious:Float;       //  previous x position
            private var _yprevious:Float;       //  previous y position
            private var _xstart:Float;          //  starting x position
            private var _ystart:Float;          //  starting y position
            public var direction:Float;       //  movement direction
            public var speed:Float;           //  movement speed
            private var _currentOrigin:Int;     //  indicates sprite origin position
        //transformation
            private var _scaleX:Float;          //  scale x value of graphic
            private var _scaleY:Float;          //  scale y value of graphic
            private var _angle:Float;           //  rotation value of graphic
            private var _alpha:Float;           //  transparency of graphic (0..1)
            private var _matrix:Matrix;         //  transformation matrix;
        //Animation
            private var frameSequence:Array<Int>;
            private var sequenceIndex:Int;
            private var customSequenceDefined:Bool;
        //Collision
            public var isCollide:Bool;
            public var hitbox:Rect;
    #if debug
            public var debugColor:Int=0x00FF00;
    #end
    public function new(src:BitmapData,origin:Int=0,collide:Bool=false,row:Int=0,col:Int=0,dep:Int=0) {
        _angle=0;
        _scaleX=_scaleY=1;
        _alpha =1.0;
        isCollide = collide;
        speed =0;
        direction=0;
        if(row<1 && col<1)
        {
            _frameWidth  = src.width;
            _frameHeight = src.height;
        }else if(row>0 && col>0) {
            _frameWidth  = Math.round(src.width/col);
            _frameHeight = Math.round(src.height/row);
        }
        super(_frameWidth,_frameHeight,dep);
        _matrix = new Matrix();
        setOrigin(origin);
        initializeFrames(src,false);

    }

/* ----------------------------------------------------------------------------------------
                                      Position
   ------------------------------------------------------------------------------------------*/
    override public function setPosition(i:Float,j:Float):Void {
        _xprevious=_x;
        _yprevious=_y;
        super.setPosition(i,j);
        setTransform();
        setCollisionRectBound();
    }
    override public function move(i:Float,j:Float):Void {
        _xprevious=_x;
        _yprevious=_y;
        super.move(i,j);
    }
   public function setOrigin(i:Int):Void {
       _currentOrigin =i;
       switch(_currentOrigin)
       {
           case Spriter.ORIGIN_TOPLEFT:
               _xoffset =0;
               _yoffset =0;
           case Spriter.ORIGIN_TOP:
               _xoffset =_width/2;
               _yoffset =0;
           case Spriter.ORIGIN_TOPRIGHT:
               _xoffset =_width;
               _yoffset =0;
           case Spriter.ORIGIN_CENTERLEFT:
               _xoffset = 0;
               _yoffset = _height/2;
           case Spriter.ORIGIN_CENTER:
               _xoffset = _width/2;
               _yoffset = _height/2;
           case Spriter.ORIGIN_CENTERRIGHT:
               _xoffset = _width;
               _yoffset = _height/2;
           case Spriter.ORIGIN_BOTTOMLEFT:
               _xoffset = 0;
               _yoffset = _height;
           case Spriter.ORIGIN_BOTTOM:
               _xoffset = _width/2;
               _yoffset = _height;
           case Spriter.ORIGIN_BOTTOMRIGHT:
               _xoffset = _width;
               _yoffset = _height;

       }
   }

     public function getPreviousX():Float {
        return _xprevious;
    }
    public function getPreviousY():Float {
        return _yprevious;
    }
    public function getStartX():Float {
        return _xstart;
    }
    public function getStartY():Float {
        return _ystart;
    }


/* ----------------------------------------------------------------------------------------
                                       Animation
   ---------------------------------------------------------------------------------------- */
    private function initializeFrames(image:BitmapData,flag:Bool):Void {
        var k:Int = image.width;
        var l:Int = image.height;
        var i1:Int = Math.round(k/_width);
        var j1:Int = Math.round(l/_height);
        _img = new Tilesheet(image);
        _numberFrames = i1 * j1;
        if (!flag) {
            sequenceIndex = 0;
        }
        if (!customSequenceDefined) {
            frameSequence = new Array<Int>();
        }
        var k1:Int =0;
        var l1:Int=0;
        var i2:Int=0;
        while(l1<l)
        {
            i2=0;
            while(i2<k)
            {
                _img.addTileRect(new Rectangle(i2,l1,_width,_height),new Point(_xoffset,_yoffset));
                if (!customSequenceDefined) {
                    frameSequence[k1] = k1;
                }
                k1++;
                i2 +=_width;
            }
            l1+=_height;
        }
    }
    public function setFrame(i:Int):Void {
        if(i>=0 && i<=frameSequence.length)
        {
            sequenceIndex = i;
        }
    }
    public function getFrame():Int {
        return sequenceIndex;
    }
    public function getRawFrameCount():Int {
        return _numberFrames;
    }
    public function getFrameSequenceLength():Int {
        return frameSequence.length;
    }
    public function nextFrame():Void {
        sequenceIndex = (sequenceIndex + 1) % frameSequence.length;
    }
    public function prevFrame():Void {
        if (sequenceIndex == 0) {
            sequenceIndex = frameSequence.length - 1;
        } else {
            sequenceIndex--;
        }
    }
    public function setFrameSequence(sequence:Array<Int>=null):Void {
        if(_numberFrames<=1)
            return;
        frameSequence = null;
        if (sequence == null) {
            sequenceIndex = 0;
            customSequenceDefined = false;
            frameSequence = new Array<Int>();
            for(i in 0..._numberFrames)
            {
                frameSequence[i] = i;
            }
        }
        else {
            for(j in 0...sequence.length)
            {
                if (sequence[j] >= 0 || sequence[j] <= _numberFrames)
                {

                    customSequenceDefined = true;
                    frameSequence = new Array<Int>();
                    frameSequence[j] =sequence[j];
                    sequenceIndex = 0;
                }
            }
        }



    }
/* ----------------------------------------------------------------------------------------
                                       Draw
   ------------------------------------------------------------------------------------------*/
    override public function draw(g:Graphics):Void {
        if(isVisible())
        {
           // setTransform();
            //setCollisionRectBound();
            if (speed != 0) {
                var _d = direction * Spriter.D2R;
                move(speed * Math.cos(_d),speed * Math.sin(_d));
            }
			 setTransform();
			 setCollisionRectBound();
            _img.drawTiles(g,[_x,_y,frameSequence[sequenceIndex],_matrix.a, _matrix.b, _matrix.c, _matrix.d,_alpha],true,Tilesheet.TILE_TRANS_2x2|Tilesheet.TILE_ALPHA);
        }

    }
    #if debug
    override public function showDebug(g:Graphics):Void {
        if(isVisible())
        {
            g.beginFill(debugColor,0.2);
            g.drawRect(hitbox.x,hitbox.y,hitbox.width,hitbox.height);
        }
    }
    #end
/* ----------------------------------------------------------------------------------------
                                       Transform
   ------------------------------------------------------------------------------------------*/
    public function setScale(i:Float,j:Float):Void {
        _scaleX = i;
        _scaleY = j;
    }
    public function setAngle(i:Float):Void {
        _angle += i;
    }
    public function setAlpha(i:Float):Void {
        _alpha = i;
    }
    public function getScaleX():Float {
        return _scaleX;
    }
    public function getScaleY():Float {
        return _scaleY;
    }
    public function getAngle():Float {
        return _angle;
    }
    public function getAlpha():Float {
        return _alpha;
    }
    public function setTransform():Void {
        _matrix.identity();
        _matrix.scale(_scaleX,_scaleY);
        _matrix.rotate(_angle);
        _matrix.translate(_x,_y);
    }
    public function setCollisionRectBound():Void {
        if(isCollide)
        {
            hitbox = {
                x:_matrix.tx-(_xoffset*_matrix.a),
                y:_matrix.ty-(_yoffset*_matrix.d),
                width :_width*_matrix.a,
                height: _height*_matrix.d
            }
        }
    }
// BBox <> Point
    private function collide_bbox_point(x2:Float,y2:Float):Bool {
        return (x2 >= hitbox.x && x2 <= hitbox.x+hitbox.width && y2 >= hitbox.y && y2 <=  hitbox.y+hitbox.height);
    }
    public function collidesWithSpriter(s:Spriter):Bool {
        if(!isVisible() || !s.isVisible())
            return false;
        var i:Float = s.hitbox.x;
        var j:Float = s.hitbox.y;
        var k:Float = i+s.hitbox.width;
        var l:Float = j+s.hitbox.height;
        if(collide_bbox_point(i,j)||collide_bbox_point(k,j)||collide_bbox_point(i,l)||collide_bbox_point(k,l))
        {
          #if debug
            debugColor = 0xFF0000;
            s.debugColor = 0xFF0000;
          #end
            return true;
        }
        else{
          #if debug
            debugColor = 0x00FF00;
            s.debugColor = 0x00FF00;
          #end
            return false;
        }


    }
    public function collidesWithParallex(t:Parallex):Bool {
        if(!isVisible() || !t.isVisible())
            return false;
        var i:Float = t.getX();
        var j:Float = t.getY();
        var k:Float = i+t.getWidth();
        var l:Float = j+t.getHeight();
        if(collide_bbox_point(i,j)||collide_bbox_point(k,j)||collide_bbox_point(i,l)||collide_bbox_point(k,l))
        {
#if debug
            debugColor = 0xFF0000;
            t.debugColor = 0xFF0000;
#end
            return true;
        }
        else{
#if debug
            debugColor = 0x00FF00;
            t.debugColor = 0x00FF00;
#end
            return false;
        }
    }
    public function collidesWithTiled(t:TiledLayer,pixelLevel:Bool):Bool{return false;}
    public function collidesWithPoint(x:Float,y:Float):Bool{
        if(collide_bbox_point(x,y))
        {
#if debug
            debugColor = 0xFF0000;
           
#end
            return true;
        }
        else{
#if debug
            debugColor = 0x00FF00;
         
#end
            return false;
        }
    }

}