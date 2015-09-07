/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 25.01.13
 * Time: 13:57
 * To change this template use File | Settings | File Templates.
 */
package data {
	import data.ListItem;
	import data.bin.PNGChunk;

	public class ListInputItem extends ListItem implements IListInputItem{
		protected var _password:String;
		public function ListInputItem(type:int):void{
			super(type);
			this._date = new Date();
		}
		public function compose():PNGChunk{
			throw new Error("Abstract method should be overwritten.");
		}
		public function get password():String{
			return this._password;
		}
		public function set password(value:String):void{
			this._password = value;
		}
	}
}
