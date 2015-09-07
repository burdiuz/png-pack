/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 24.01.13
 * Time: 16:56
 * To change this template use File | Settings | File Templates.
 */
package data {
	import data.IListTextItem;
	import data.ItemType;
	import data.ListInputItem;
	import data.bin.BinUtils;
	import data.bin.PNGChunk;
	
	import flash.utils.ByteArray;

	[Bindable]
	public class ListTextItem extends ListInputItem implements IListTextItem{
		private var _text:String;
		public function ListTextItem(text:String):void{
			super(ItemType.TEXT);
			this._text = text;
		}
		override public function compose():PNGChunk{
			const bytes:ByteArray = this.getData();
			const chunk:PNGChunk = new PNGChunk(ItemPNGChunkTypes.byItemType(this._type), bytes);
			return chunk;
		}
		public function get text():String{
			return this._text;
		}
		public function getTextData():ByteArray{
			const bytes:ByteArray =  new ByteArray();
			bytes.writeUTFBytes(this._text);
			return bytes;
		}
		override public function set password(value:String):void{
			if(this._password != value){
				this._password = value;
				this._type = this._password ? ItemType.TEXT_PROTECTED : ItemType.TEXT;
			}
		}
		override public function getData():ByteArray{
			const compress:Boolean = Settings.instance.compressTextData;
			const bytes:ByteArray =  new ByteArray();
			bytes.writeUnsignedInt(int(compress));
			bytes.writeUnsignedInt(this._date.time/1000);
			const content:ByteArray = new ByteArray();
			content.writeUTFBytes(this._text);
			if(this._password) BinUtils.xorByPassPhrase(content, this._password);
			if(compress) content.compress();
			bytes.writeBytes(content);
			return bytes;
		}
	}
}
