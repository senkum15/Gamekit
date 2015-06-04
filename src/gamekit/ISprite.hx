package gamekit;
import openfl.display.BitmapData;
interface ISprite {
    public function setOrigin(position:Int):Void;
    public function setFrame(i:Int):Void;
    public function getFrame():Int;
    public function getRawFrameCount():Int;
    public function getFrameSequenceLength():Int;
    public function nextFrame():Void;
    public function prevFrame():Void;
    public function setFrameSequence(sequence:Array<Int>=null):Void;
  //  public function setImage(img:BitmapData,frameWidth:Int,frameHeight:Int):Void;
    public function setCollisionRectBound():Void;
    public function setTransform():Void;
    public function collidesWithSpriter(s:Spriter):Bool;
    public function collidesWithTiled(t:TiledLayer,pixelLevel:Bool):Bool;
    public function collidesWithParallex(t:Parallex):Bool;
    public function collidesWithPoint(x:Float,y:Float):Bool;
}
