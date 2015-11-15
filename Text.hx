package;

import flash.geom.Point;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/**
 * ...
 * @author Henry D. Fernández B.
 */
class Text extends TextField
{
	var timer : Float;
	var isDead : Bool;
	var rawText : String;
	var initialPos : Point;
	var rawPos : Point;
	var xAlign : String;
	var yAlign : String;
	var order : Int;
	
	public function new(fontName : String, text : String, size : Int, color : Int,letterSpacing : Int, pos : Point = null, xAlign : String = "center",yAlign : String = "middle",bold : Bool,order : Int = 0) 
	{
		super();
		
		var format : TextFormat;
		
		this.order = order;
		isDead = false;
		timer = 0;
		embedFonts = true;
		selectable = false;
		mouseEnabled = false;
		autoSize = TextFieldAutoSize.LEFT;
		format = new TextFormat ();
		format.font = fontName;
		format.color = color;
		format.size = size;
		format.letterSpacing = letterSpacing;
		format.bold = bold;
		defaultTextFormat = format;
		this.text = text;
		rawText = text;
		this.xAlign = xAlign;
		this.yAlign = yAlign;
		rawPos = pos;
		
		Align();
		
		initialPos = new Point(x, y);
	}
	
	private function Align() : Void
	{
		if (rawPos != null)
		{
			switch(xAlign)
			{
				case "left":
					x = rawPos.x;
				case "center":
					x = rawPos.x - width/2;
				case "right":
					x = rawPos.x - width;
				default:
					x = rawPos.x;
			}
			
			switch(yAlign)
			{
				case "up":
					y = rawPos.y;
				case "middle":
					y = rawPos.y - height/2;
				case "down":
					y = rawPos.y - height;
				default:
					y = rawPos.y;
			}
		}
	}
	
	public function GetInitialPos() : Point
	{
		return initialPos;
	}
	
	public function GetRawText() : String
	{
		return rawText;
	}
	
	public function GetOrder() : Int
	{
		return order;
	}
	
	public function SetOrder(order : Int) : Void
	{
		this.order = order;
	}
	
	public function Update(gameTime:Float):Void 
	{
		//Align();
	}
	
	public function IsDead() : Bool
	{
		return isDead;
	}
	
	public function UpdatePos(x : Float, y : Float) : Void
	{
		rawPos.x = x;
		rawPos.y = y;
	}
	
	public function SetX(value : Float) : Void
	{
		rawPos.x = value;
	}
	
	public function SetY(value : Float) : Void
	{
		rawPos.y = value;
		Align();
	}
	
	public function GetPos() : Point
	{
		return rawPos;
	}
}