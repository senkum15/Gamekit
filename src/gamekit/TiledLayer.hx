package gamekit;
import openfl.geom.Rectangle;
import openfl.display.Graphics;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
class TiledLayer extends Layer {
    private var _cellHeight:Int;
    private var _cellWidth:Int;
    private var _row:Int;
    private var _col:Int;
    private var _cellMatrix:Array<Array<Int>>;
    private var _sourceImage:Tilesheet;
    private var _numberofTiles:Int;
  //  private var _tileSet:Array<Rect>;
    private var _anim_to_static:Array<Int>;
    private var _numOfAnimTiles:Int;
    public function new(columns:Int,rows:Int,image:BitmapData,tileWidth:Int,tileHeight:Int) {
        super(columns >= 1 && tileWidth >= 1 ? columns * tileWidth: -1, rows >= 1 && tileHeight >= 1 ? rows * tileHeight : -1);
            _col = columns;
            _row = rows;
            _cellMatrix = new Array<Array<Int>>();
            var i1:Int = Math.round((image.width / tileWidth) * (image.height / tileHeight));
            createStaticSet(image, i1 + 1, tileWidth, tileHeight, true);

        }
	public function createAnimatedTile(i:Int):Int {
        if (i < 0 || i >= _numberofTiles) {

        if (_anim_to_static == null) {
            _anim_to_static = new Array<Int>();
            _numOfAnimTiles = 1;
        } //else
       // if (_numOfAnimTiles == _anim_to_static.length) {
         //   int ai[] = new int[anim_to_static.length * 2];
       //     anim_to_static = ai;
      //  }
        _anim_to_static[_numOfAnimTiles] = i;
        _numOfAnimTiles++;
        }
        return -(_numOfAnimTiles - 1);
    }

    public function setAnimatedTile(i:Int, j:Int):Void {
        if (j < 0 || j >= _numberofTiles) {
            return;
        }
        i = -i;
        if (_anim_to_static == null || i <= 0 || i >= _numOfAnimTiles) {
           return;
        } else {
            _anim_to_static[i] = j;
            return;
        }
    }

    public function getAnimatedTile(i:Int):Int {
        i = -i;
        if (_anim_to_static == null || i <= 0 || i >= _numOfAnimTiles) {
            return -1;
        } else {
            return _anim_to_static[i];
        }
    }

    public function setCell(i:Int,j:Int,k:Int):Void {
        if (i < 0 || i >= _col || j < 0 || j >= _row) {
            return;
        }
        if (k > 0) {
            if (k >= _numberofTiles) {
                return;
            }
        } else
      //  if (k < 0 && (anim_to_static == null || -k >= numOfAnimTiles)) {
       //     throw new IndexOutOfBoundsException();
       // }
        _cellMatrix[j][i] = k;
    }

    public function getCell(i:Int,j:Int):Int {
        if (i < 0 || i >= _col || j < 0 || j >= _row) {
          return -1;
        } else {
            return _cellMatrix[j][i];
        }
    }

    public function fillCells(i:Int, j:Int, k:Int, l:Int, i1:Int):Void {
        if (k < 0 || l < 0) {
            return;
        }
        if (i < 0 || i >= _col || j < 0 || j >= _row || i + k > _col || j + l > _row) {
            return;
        }
        if (i1 > 0) {
            if (i1 >= _numberofTiles) {
              return;
            }
        } else
       // if (i1 < 0 && (anim_to_static == null || -i1 >= numOfAnimTiles)) {
     //       throw new IndexOutOfBoundsException();
    //    }
            var j1 = j;
            var k1=i;
             for(j1 in j...j+1)
                 for(k1 in i...i+k)
                     _cellMatrix[j1][k1] = i1;

        }



 /*   public final int getCellWidth() {
        return cellWidth;
    }

    public final int getCellHeight() {
        return cellHeight;
    }

    public final int getColumns() {
        return columns;
    }

    public final int getRows() {
        return rows;
    }*/

    public function setStaticTileSet(image:BitmapData, i:Int, j:Int):Void{
       /* if (i < 1 || j < 1 || image.getWidth() % i != 0 || image.getHeight() % j != 0) {
            throw new IllegalArgumentException();
        }*/
        _width =_col * i;
        _height = _row *j;
       var k:Int = Math.round((image.width/i) *(image.height/j));
       if (k >= _numberofTiles - 1) {
            createStaticSet(image, k + 1, i, j, true);
        } else {
            createStaticSet(image, k + 1, i, j, false);
        }
    }
    override public function draw(g:Graphics):Void {
        if (_visible)
        {

        }
    }
    private function createStaticSet(image:BitmapData,i:Int,width:Int,height:Int,flag:Bool) {
        _cellWidth = width;
        _cellHeight = height;
        var l:Int = image.width;
        var i1:Int = image.height;
        _sourceImage = new Tilesheet(image);
        _numberofTiles = i;
        //_tileSet = new Array<Rect>();
        if (!flag) {
            for (_rows in 0... _cellMatrix.length) {
                var j1:Int = _cellMatrix[_rows].length;
            for (_col in 0... j1) {
                _cellMatrix[_rows][_col] = 0;
                }
            }
       // anim_to_static = null;
        }
        var l1:Float=0;
        var i2:Float=0;
        while(l1<i1) {
            while(i2<l) {
                _sourceImage.addTileRect(new Rectangle(i2,l1,_cellWidth,_cellHeight));
                l1+=height;
                i2+=width;
				
            }
        }
     }

}



