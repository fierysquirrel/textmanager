package fs.textmanager;

import flash.geom.Point;
import openfl.Assets;
import flash.text.Font;

class TextManager
{
	public static var NAME : String = "TEXT_MANAGER";
	
	private static var instance : TextManager;
	
	private static var fonts : Map<String,Font>;
	
	private static var fontsPath : String;
	
	public static function InitInstance(fontsPath : String): TextManager
	{
		if (instance == null)
			instance = new TextManager(fontsPath);
				
		return instance;
	}
	
	/*
	 * Creates and returns a screen manager instance if it's not created yet.
	 * Returns the current instance of this class if it already exists.
	 */
	public static function GetInstance(): TextManager
	{
		if ( instance == null )
			throw "TextManager is not initialized. Use function 'InitInstance'";
		
		return instance;
	}
	
	/*
	 * Constructor
	 */
	private function new(path : String) 
	{
		fontsPath = path;
		fonts = new Map<String,Font>();
	}
	
	public static function LoadFontsFromXML(fileName : String, internalPath : String = "") : Void
	{
		var str,name,id,extension,soundIntPath : String;
		var xml : Xml;
			
		try
		{
			str = Assets.getText(fontsPath + internalPath + fileName + ".xml");
			xml = Xml.parse(str).firstElement();
			for (i in xml.iterator())
			{
				if (i.nodeType == Xml.Element)
				{
					id = i.get("id") == null ? "" : i.get("id");
					name = i.get("name") == null ? "" : i.get("name");
					extension = i.get("extension") == null ? "ttf" : i.get("extension");
					soundIntPath = i.get("path") == null ? "" : i.get("path");
					
					if(id != "" && name != "")
						AddFont(id, name,extension,soundIntPath);
				}
			}
		}
		catch (e : String)
		{
			trace(e);
		}
	}
	
	public static function AddFont(id : String,name : String, extension : String = "ttf", internalPath : String = "") : Void
	{
		var path : String;
		var font : Font;
		
		if (fonts == null)
			throw "Fonts are not initialized. Use function 'InitInstance'";

		path = fontsPath + internalPath + name + "." + extension;
		
		if (!fonts.exists(path))
		{
			font = Assets.getFont(path);
			if (font != null)
				fonts.set(id , font);
		}
	}
	
	public static function GetFont(id : String) : Font
	{
		return fonts.get(id);
	}
	
	public static function CreateText(fontId : String, txt : String = "",pos : Point = null,size : Int = 0, color : Int = 0x000000) : fs.textmanager.Text
	{
		var font : Font;
		var text : fs.textmanager.Text;
		
		font = fonts.get(fontId);
		
		if (font == null)
			text = null;
		else
			text = new fs.textmanager.Text(font.fontName, txt, size, color, 0, pos,"center","center",false);
		
			
		return text;
	}
}