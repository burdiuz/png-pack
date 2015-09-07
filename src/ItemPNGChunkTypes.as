/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 18:17
 * To change this template use File | Settings | File Templates.
 */
package {
	import data.ItemType;
	import data.ListStorageItem;
	import data.ListStoredFileItem;
	import data.ListStoredTextItem;
	import data.Settings;
	import data.bin.PNGChunk;

	public class ItemPNGChunkTypes {
		static public const DEFAULT_TEXT:String = "iPTn";
		static public const DEFAULT_TEXT_PROTECTED:String = "iPTp";
		static public const DEFAULT_FILE:String = "iPFn";
		static public const DEFAULT_FILE_PROTECTED:String = "iPFp";

		static public function get text():String{
			return Settings.instance.textPNGChunkType;
		}
		static public function get textProtected():String{
			return Settings.instance.textProtectedChunkType;
		}
		static public function get file():String{
			return Settings.instance.fileChunkType;
		}
		static public function get fileProtected():String{
			return Settings.instance.fileProtectedChunkType;
		}
		static public function toItemType(type:String):int{
			var itemType:int = 0;
			switch(type){
				case text:
					itemType = ItemType.TEXT;
					break;
				case file:
					itemType = ItemType.FILE;
					break;
				case textProtected:
					itemType = ItemType.TEXT_PROTECTED;
					break;
				case fileProtected:
					itemType = ItemType.FILE_PROTECTED;
					break;
			}
			return itemType;
		}
		static public function byItemType(itemType:int):String{
			var type:String;
			switch(itemType){
				case ItemType.TEXT:
					type = text;
					break;
				case ItemType.FILE:
					type = file;
					break;
				case ItemType.TEXT_PROTECTED:
					type = textProtected;
					break;
				case ItemType.FILE_PROTECTED:
					type = fileProtected;
					break;
			}
			return type;
		}
		static public function isValid(type:String):Boolean{
			switch(type){
				case text:
				case file:
				case textProtected:
				case fileProtected:
					return true;
				default:
					return false;
			}
		}
		static public function isProtected(type:String):Boolean{
			return type==textProtected || type==fileProtected;
		}
		static public function isText(type:String):Boolean{
			return type==text || type==textProtected;
		}
		static public function isFile(type:String):Boolean{
			return type==file || type==fileProtected;
		}

		public static function getListItem(chunk:PNGChunk):ListStorageItem{
			var item:ListStorageItem;
			const type:String = chunk.type;
			if(isValid(type)){
				switch(isText(type)){
					case true:
						item = new ListStoredTextItem(chunk);
						break;
					case false:
						item = new ListStoredFileItem(chunk);
						break;
				}
			}
			return item;
		}
	}
}
