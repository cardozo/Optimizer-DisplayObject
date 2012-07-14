package com.cardozo.displayObject.optimizer 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import com.cardozo.displayObject.optimizer.DisplayObjectCompressed;
	
	/**
	* 
	* OptimizerDysplayObject is an algorithm designed to compress DysplayObjects and optimize the performance of flash Aplications
	* 
	*  @author Rodrigo Cardozo
	*  @version 1.2
	*  mail - rodrigocardozop@gmail.com
	* 
	*   Copyright (c) 2012 Rodrigo Cardozo <rodrigocardozop@gmail.com>
	*
	*	Everyone is permitted to copy and distribute verbatim or modified 
	*	copies of this license document, and changing it is allowed as long 
	*	as the name is changed. Just try to remember the creator.
	*		
	*/
	public class OptimizerDysplayObject { 
		
		public function OptimizerDysplayObject(){}
		
		/**
		 * 
		 * @param	Target DisplayObject. This can be ANY DisplayObject.
		 * @param	Container of target DisplayObject.
		 * @return    Void
		 */
		public static function addon( target:DisplayObject, container:Object ):void
		{
			var bounds:Object = target.getBounds( target );
			var matrix:Matrix = new Matrix();
	        matrix.translate ( -bounds.x, -bounds.y );
			var data:BitmapData = new BitmapData ( target.width+1, target.height+1, true, 0 );
			data.draw ( target, matrix );
			
			var compressed:DisplayObjectCompressed;
			compressed = new DisplayObjectCompressed( data );
			container.addChild ( compressed );
			
			target = null;
		}
		
		/**
		 * 
		 * @param	Target DisplayObject. This can be ANY DisplayObject.
		 * @return    DisplayObjectCompressed 
		 */
		public static function compress( target:DisplayObject ):DisplayObjectCompressed
		{
			var bounds:Object = target.getBounds( target );
			var mat:Matrix = new Matrix();
	        mat.translate ( -bounds.x, -bounds.y );
			var data:BitmapData = new BitmapData ( target.width+1, target.height+1, true, 0 );
			data.draw ( target, mat );
			
			var compressed:DisplayObjectCompressed;
			compressed = new DisplayObjectCompressed( data );
			target = null;
			
			return compressed;
		}
		
	}
}