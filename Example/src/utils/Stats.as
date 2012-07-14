package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class Stats extends Sprite
	{       
		private var _xml:XML;
		private var _text:TextField;
		private var _style:StyleSheet;
		
		private var _timer:uint;
		private var _fps:uint;
		private var _ms:uint;
		private var _ms_prev:uint;
		private var _graph:BitmapData;
		private var _fps_graph:uint;
		
		private var _theme:Object = { bg: 0x03406A, fps: 0x65a5d1}; 
		private var _rectangle:Rectangle;
		private var _square:Sprite;
		
		public function Stats( theme:Object = null ):void
		{
			if (theme)
			{
				if (theme.bg != null) _theme.bg = theme.bg;
				if (theme.fps != null) _theme.fps = theme.fps;
			} 
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}

		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_square = new Sprite();
			addChild(_square);
			_square.graphics.beginFill(_theme.bg);
			_square.graphics.drawRect(0,0,100,20);
			_square.graphics.endFill();
			
			
			_xml = <xml><fps>FPS:</fps></xml>;
			
			_style = new StyleSheet();
			_style.setStyle("xml", {fontSize:'12px', fontFamily:'_sans', leading:'-2px'});
			_style.setStyle("fps", {color: hex2css(_theme.fps)});
			
			addChild(_text = new TextField());	
			_text.width = 70;
			_text.height = 50;
			_text.styleSheet = _style;
			_text.condenseWhite = true;
			_text.selectable = false;
			_text.mouseEnabled = false;
			
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		private function update(e:Event):void
		{
			_timer = getTimer();
               
			if( _timer - 1000 > _ms_prev )
			{
				_ms_prev = _timer;   
				_fps_graph = Math.min(50, ( _fps / stage.frameRate ) * 50);      
				_xml.fps = "FPS: " + _fps + " / " + stage.frameRate;    
				
				_square.width = _fps * 10;
				
				_fps = 0;
				
			}
			_fps++;
			_text.htmlText = _xml;
			
			
			
		}
		
		private function hex2css( color:int ):String
		{
			return "#" + color.toString(16);
		}
	}
}
