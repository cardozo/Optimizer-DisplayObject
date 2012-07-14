package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import utils.Stats;
	import com.bit101.components.PushButton;
	import com.cardozo.displayObject.optimizer.OptimizerDysplayObject;
	
	/**
	 * ...
	 * @author Rodrigo Cardozo
	 */
	[SWF(width = "690", height = "550", backgroundColor = "#FFFFFF", frameRate = "60", quality = "BEST")]
	public class MainTest extends Sprite 
	{
		private var targetImage:DisplayObject;
		private var listaImagens:Array;
		
		private const NUMBER_IMAGES:int = 35;
		
		private const NORMAL_DISPLAY_OBJECT:String = "normal";
		private const CACHE_DISPLAY_OBJECT:String = "cache";
		private const OPTIMIZED_DISPLAY_OBJECT:String = "optimized";
		
		public function MainTest():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.frameRate = 60;
			addChild(new Stats).y = stage.stageHeight - 20;
			setupUI();
		}
		
		private function setupUI():void 
		{
			var description:Sprite = new Description();
			addChild( description );
			description.x = stage.stageWidth / 2 - description.width / 2;
			var normalMode:PushButton = new PushButton(stage, 200, stage.stageHeight - 50, "NORMAL SPRITE", handleNormalButton);
			var bitmapCacheMode:PushButton = new PushButton(stage, normalMode.x + normalMode.width + 5, normalMode.y, "BITMAP CACHE", handleBitmapCacheButton); 
			var optimizedMode:PushButton = new PushButton(stage, bitmapCacheMode.x + bitmapCacheMode.width + 5, normalMode.y, "OPTIMIZER", handleOptimizedButton); 
			
		}
		
		private function handleNormalButton(e:Event):void 
		{
			stressTestWithOptimizer( NORMAL_DISPLAY_OBJECT );
		}
		private function handleBitmapCacheButton(e:Event):void 
		{
			stressTestWithOptimizer(CACHE_DISPLAY_OBJECT);
		}
		
		private function handleOptimizedButton(e:Event):void 
		{
			stressTestWithOptimizer( OPTIMIZED_DISPLAY_OBJECT );
		}
		
		private function stressTestWithOptimizer( optimizerActiveted:String ):void 
		{
			
			try {
				for ( var k:int = 0 ; k < listaImagens.length ; k++) {
					listaImagens[k].removeEventListener ( Event.ENTER_FRAME, onEnterFrame );	
					removeChild(listaImagens[k]);
				}
			}
			catch (e:Error){}
			
			listaImagens = [];
			
			for ( var q:int = 0 ; q < NUMBER_IMAGES ; q++) {
				
				var image:MovieClip = new Imagem();
				
				if ( optimizerActiveted == NORMAL_DISPLAY_OBJECT) 
					listaImagens.push( image );
					
				else if ( optimizerActiveted == OPTIMIZED_DISPLAY_OBJECT)
					listaImagens.push( OptimizerDysplayObject.compress(image) );
					
				else if ( optimizerActiveted == CACHE_DISPLAY_OBJECT ) {
					image.cacheAsBitmap = true;
					listaImagens.push( image );
				}
			}
			
			for ( var i:int = 0 ; i < listaImagens.length ; i++) {
				targetImage = listaImagens[i];
				addChild( targetImage );
				targetImage.x = Math.random()*(stage.stageWidth - (width/2));
				targetImage.y = 60 + Math.random() * (250 - (height / 2));
				targetImage.addEventListener ( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		private function onEnterFrame ( e:Event ):void 
		{
			for ( var i:int = 0 ; i < listaImagens.length ; i++) {
				listaImagens[i].alpha = Math.random();
				listaImagens[i].x = Math.random()*(stage.stageWidth * 1.33 - (width/2) );
				listaImagens[i].y = 60 + Math.random() * ((600) - (height / 2));
			}	
		}
		
	}
	
}