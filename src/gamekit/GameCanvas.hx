package gamekit;

import openfl.events.Event;
import openfl.events.TouchEvent;
import openfl.display.Graphics;
import openfl.events.TouchEvent;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.display.Sprite;
class GameCanvas extends Sprite implements ICanvas {
    //Timer
    private var stepRate:Float;
    private var last:Float;
    private var now:Float;
    private var delta:Float;
    //Input
    private var isKeyPress:Bool;
    private var isPointPress:Bool;
    private var FPS:Int;
    public function new(fps:Int=60) {
        super();
        FPS = fps;
        stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
        stage.addEventListener(KeyboardEvent.KEY_UP,onKeyRelease);
#if !mobile
        stage.addEventListener(MouseEvent.MOUSE_DOWN,onMousePress);
        stage.addEventListener(MouseEvent.MOUSE_UP,onMouseRelease);
        stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
#end
#if mobile
        stage.addEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin);
        stage.addEventListener(TouchEvent.TOUCH_END,onTouchEnd);
        stage.addEventListener(TouchEvent.TOUCH_MOVE,onTouchMove);
#end
        addEventListener(Event.ADDED_TO_STAGE,addedToStage);


    }
    private function addedToStage(e:Event = null){
        removeEventListener(Event.ADDED_TO_STAGE, addedToStage);

        stepRate = 1000 / FPS;
        last = flash.Lib.getTimer();
        now = last;
        delta = 0;

        onStage();

        addEventListener(Event.ENTER_FRAME,tick);
    }

    private function tick(e:Event = null){
        now = openfl.Lib.getTimer();
        delta += now - last;
        last = now;

        if(delta >= stepRate){
            while(delta >= stepRate){
                delta -= stepRate;

                update();
            }
             flushGraphics();
             render(graphics);

        }
    }
    private function onKeyPress(event:KeyboardEvent):Void {
        if(!isKeyPress)
        {
            keyPressed(event.keyCode);
            isKeyPress =true;
        }

    }
    private function onKeyRelease(event:KeyboardEvent):Void {
        if(isKeyPress)
        {
            keyReleased(event.keyCode);
            isKeyPress=false;
        }

    }
    private function onMousePress(event:MouseEvent):Void {
        if(!isPointPress)
        {
            pointerPressed(event.stageX,event.stageY);
            isPointPress=true;
        }

    }
    private function onMouseRelease(event:MouseEvent):Void {
        if(isPointPress)
        {
            pointerReleased(event.stageX,event.stageY);
            isPointPress=false;
        }
    }
    private function onMouseMove(event:MouseEvent):Void {
          pointerDragged(event.stageX,event.stageY);
     }
    private function onTouchBegin(event:TouchEvent):Void {
        if(!isPointPress)
        {
            pointerPressed(event.stageX,event.stageY);
            isPointPress=true;
        }

    }
    private function onTouchEnd(event:TouchEvent):Void {
        if(isPointPress)
        {
            pointerReleased(event.stageX,event.stageY);
            isPointPress=false;
        }
    }
    private function onTouchMove(event:TouchEvent):Void {
        pointerDragged(event.stageX,event.stageY);
    }
/**
   * overridable method called when the GameCanvas is added to the stage
   * trying to access the stage before this method is called will not work
   * @method onStage
   */
    function onStage(){
    }
    public function update():Void{

    }
    public function render(g:Graphics):Void{

    }
    public function keyPressed(keyCode:Int):Void{

    }
    public function keyRepeated(keyCode:Int):Void{

    }
    public function keyReleased(keyCode:Int):Void{}
    public function pointerPressed(x:Float,y:Float):Void{}
    public function pointerDragged(x:Float,y:Float):Void{}
    public function pointerReleased(x:Float,y:Float):Void{}
    public function showNotify():Void{}
    public function hideNotify():Void{}
    public function flushGraphics():Void {
        graphics.clear();
    }

}
