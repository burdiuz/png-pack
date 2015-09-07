/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 24.01.13
 * Time: 16:54
 */
package data {
	import data.ItemType;
	import data.bin.BinUtils;
	import data.bin.PNGChunk;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	[Bindable]
	public class ListFileItem extends ListInputItem implements IListFileItem{
		public var file:File;
		private var _comment:String;
		private var _attributes:FileAttributes;
		public function ListFileItem(file:File, comment:String="", extendedInfo:Boolean=false):void{
			super(ItemType.FILE);
			this.file = file;
			this._comment = comment;
			this._attributes = FileAttributes.create(file,  extendedInfo);
		}
		override public function compose():PNGChunk{
			const bytes:ByteArray = this.getData();
			const chunk:PNGChunk = new PNGChunk(ItemPNGChunkTypes.byItemType(this._type), bytes);
			return chunk;
		}
		public function get comment():String{
			return this._comment;
		}
		public function get attributes():FileAttributes{
			return this._attributes;
		}
		override public function set password(value:String):void{
			if(this._password != value){
				this._password = value;
				this._type = this._password ? ItemType.FILE_PROTECTED : ItemType.FILE;
			}
		}
		public function getFileData():ByteArray{
			return FileUtils.read(this.file);
		}
		override public function getData():ByteArray{
			const compress:Boolean = Settings.instance.compressFileData;
			const bytes:ByteArray = new ByteArray();
			bytes.writeUnsignedInt(int(compress));
			bytes.writeUnsignedInt(this._date.time/1000);
			const comment:ByteArray = new ByteArray();
			comment.writeUTFBytes(this._comment);
			bytes.writeShort(comment.length); // comment length
			bytes.writeBytes(comment);
			const attributes:ByteArray = new ByteArray();
			attributes.writeObject(this._attributes);
			bytes.writeShort(attributes.length); // attributes length
			bytes.writeBytes(attributes);
			const content:ByteArray = this.getFileData();
			if(this._password) BinUtils.xorByPassPhrase(content, this._password);
			if(compress)  content.compress();
			bytes.writeBytes(content);
			return bytes;
		}
	}
}
