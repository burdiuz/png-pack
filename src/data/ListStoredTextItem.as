/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 19:26
 * To change this template use File | Settings | File Templates.
 */
package data {
	import data.IListTextItem;
	import data.ListStorageItem;
	import data.bin.PNGChunk;
	
	import flash.utils.ByteArray;

	public class ListStoredTextItem extends ListStorageItem implements IListTextItem{
		private var _text:String;
		private var _parsed:Boolean;
		private var _textDataPosition:uint;
		public function ListStoredTextItem(chunk:PNGChunk):void{
			super(chunk);
		}
		override public function get date():Date{
			if(!this._parsed) this.parse();
			return super.date;
		}
		public function getTextData():ByteArray{
			if(!this._parsed) this.parse();
			return ListStoredTextItem.getTextData(this._chunk.content, this._compressed, this._textDataPosition);
		}
		public function get text():String{
			if(!this._parsed) this.parse();
			return this._text;
		}
		private function parse():void{
			const bytes:ByteArray = this.chunk.content;
			this._compressed = Boolean(bytes.readUnsignedInt());
			this._date = new Date(bytes.readUnsignedInt()*1000);
			this._textDataPosition = bytes.position;
			const content:ByteArray = ListStoredTextItem.getTextData(this._chunk.content, this._compressed);
			content.position = 0;
			this._text = content.readUTFBytes(content.length);
			this._parsed = true;
		}
		static public function getTextData(bytes:ByteArray, compressed:Boolean, position:int=-1):ByteArray{
			if(position>=0) bytes.position = position;
			const content:ByteArray = new ByteArray();
			bytes.readBytes(content, 0, bytes.bytesAvailable);
			if(compressed) content.uncompress();
			return content;
		}
	}
}
