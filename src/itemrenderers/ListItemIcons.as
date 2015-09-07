/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 13:39
 * To change this template use File | Settings | File Templates.
 */
package itemrenderers {
	import data.ItemType;

	import flash.display.DisplayObject;

	public class ListItemIcons {
		[Embed(source="../icons/file_icon.png")]
		static public const FILE:Class;
		[Embed(source="../icons/file_protected_icon.png")]
		static public const FILE_PROTECTED:Class;
		[Embed(source="../icons/text_icon.png")]
		static public const TEXT:Class;
		[Embed(source="../icons/text_protected_icon.png")]
		static public const TEXT_PROTECTED:Class;
		static public function getIconByType(type:int):DisplayObject{
			var definition:Class;
			switch(type){
				case ItemType.FILE:
					definition = FILE;
					break;
				case ItemType.FILE_PROTECTED:
					definition = FILE_PROTECTED;
					break;
				case ItemType.TEXT:
					definition = TEXT;
					break;
				case ItemType.TEXT_PROTECTED:
					definition = TEXT_PROTECTED;
					break;
			}
			return  new definition();
		}
	}
}
