package com.cardozo.displayObject.optimizer 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Rodrigo Cardozo
	 */
	public class DisplayObjectCompressed extends Bitmap
	{
		
		public function DisplayObjectCompressed( data:BitmapData ) 
		{
			super ( data );
			smoothing = true;
		}
		
	}

}