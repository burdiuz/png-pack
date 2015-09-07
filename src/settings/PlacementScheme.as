/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 28.01.13
 * Time: 13:36
 * To change this template use File | Settings | File Templates.
 */
package settings {
	import mx.charts.styles.HaloDefaults;
	import mx.collections.ArrayList;

	public class PlacementScheme {
		static public const START_OF_FILE:String = "startOfFile";
		static public const BALANCED_THROUGH_CHUNKS:String = "balancedThroughChunks";
		static public const END_OF_FILE:String = "endOfFile";
		static public const DEFAULT:String = BALANCED_THROUGH_CHUNKS;
		static public function createDataProvider():ArrayList{
			return new ArrayList([
				{label: "Start of Storage file", value: START_OF_FILE},
				{label: "Balanced between PNG chunks", value: BALANCED_THROUGH_CHUNKS},
				{label: "End of Storage file", value: END_OF_FILE}
			]);
		}

		public static function mixin(target:*, source:Array, placementScheme:String=null): *
		{
			source = source.slice();
			switch(placementScheme){
				case START_OF_FILE:
					source.unshift(1, 0);
					target.splice.apply(target, source);
					break;
				case END_OF_FILE:
					source.unshift(target.length-1, 0);
					target.splice.apply(target, source);
					break;
				case BALANCED_THROUGH_CHUNKS:
				default:
					const targetCount:int = target.length-1;
					const sourceCount:int = source.length;
					const targetPart:* = target.splice(1, targetCount);// all items should be between first and last chunk
					if(targetCount>=sourceCount){
						var chunksPerItem:int = Math.ceil(targetCount/sourceCount);
						while(source.length){
							target.push(source.shift());
							for(var index:int=0; index<chunksPerItem  && targetPart.length; index++) target.push(targetPart.shift());
						}
					}else{
						while(source.length){
							var itemsPerChunk:int = Math.ceil(sourceCount/targetCount);
							target.push.apply(target,  source.splice(0, itemsPerChunk));
							target.push(targetPart.shift());
						}
					}
					while(targetPart.length) target.push(targetPart.shift());// all chunks over the count will be added at the end of the storage file
					break;
			}
			return target;
		}
	}
}
