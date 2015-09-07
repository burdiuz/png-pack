/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 18:41
 * To change this template use File | Settings | File Templates.
 */
package data {
	import data.ListItem;
	import data.bin.PNGChunk;

	import flash.utils.ByteArray;

	public class ListStorageItem extends ListItem{
		protected var _chunk:PNGChunk;
		protected var _compressed:Boolean;
		public function ListStorageItem(chunk:PNGChunk):void{
			super(ItemPNGChunkTypes.toItemType(chunk.type));
			_chunk = chunk;
		}
		public function get chunk():PNGChunk{
			return this._chunk;
		}
		override public function getData():ByteArray{
			return this._chunk.content;
		}
	}
}
