/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 19:26
 * To change this template use File | Settings | File Templates.
 */
package data {
	import data.bin.PNGChunk;
	
	import flash.sampler.getSavedThis;
	import flash.utils.ByteArray;

	public class ListStoredFileItem extends ListStorageItem implements IListFileItem{
		private var _comment:String;
		private var _attributes:FileAttributes;
		private var _fileDataPosition:int;
		private var _parsed:Boolean;
		public function ListStoredFileItem(chunk:PNGChunk):void{
			super(chunk);
		}
		override public function get date():Date{
			if(!this._parsed) this.parse();
			return super.date;
		}
		public function get comment():String{
			if(!this._parsed) this.parse();
			return this._comment;
		}
		public function get attributes():FileAttributes{
			if(!this._parsed) this.parse();
			return this._attributes;
		}
		public function getFileData():ByteArray{
			if(!this._parsed) this.parse();
			const content:ByteArray = this._chunk.content;
			const bytes:ByteArray = new ByteArray();
			content.position = this._fileDataPosition;
			content.readBytes(bytes, 0, content.bytesAvailable);
			if(this._compressed){
				bytes.uncompress();
			}
			return bytes;
		}
		private function parse():void{
			const bytes:ByteArray = this.chunk.content;
			this._compressed = Boolean(bytes.readUnsignedInt());
			this._date = new Date(bytes.readUnsignedInt()*1000);
			var length:int = bytes.readUnsignedShort(); // comment length
			this._comment =  bytes.readUTFBytes(length);
			length = bytes.readUnsignedShort(); // attributes length
			this._fileDataPosition = bytes.position + length;
			this._attributes = bytes.readObject() as FileAttributes;
			this._parsed = true;
		}
	}
}
