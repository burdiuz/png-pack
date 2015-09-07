/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 28.01.13
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package data {
	import flash.filesystem.File;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import settings.PlacementScheme;

	[Bindable]
	public class Settings {
		static public const FILE_NAME:String = "settings.amf";
		static public const instance:Settings = new Settings();
		public var placementScheme:String = PlacementScheme.DEFAULT;
		public var textPNGChunkType:String = ItemPNGChunkTypes.DEFAULT_TEXT;
		public var textProtectedChunkType:String = ItemPNGChunkTypes.DEFAULT_TEXT_PROTECTED;
		public var fileChunkType:String = ItemPNGChunkTypes.DEFAULT_FILE;
		public var fileProtectedChunkType:String = ItemPNGChunkTypes.DEFAULT_FILE_PROTECTED;
		public var compressFileData:Boolean = false;
		public var compressTextData:Boolean = true;
		public var textFileNameGeneral:String = "default";
		public var textFileExtension:String = "txt";
		public var textFileUseDate:Boolean = true;
		public function Settings():void{
			super();
			if(instance) throw new Error("Settings class cannot be instantiated, use static property \"instance\" instead.");
			readInternal(this);
		}
		public function getTextFileName(saveDate:Date=null):String{
			var name:String = this.textFileNameGeneral;
			if(this.textFileUseDate){
				if(!saveDate) saveDate = new Date();
				var month:String = String(saveDate.month+1);
				var date:String = String(saveDate.date);
				name += "_"+saveDate.fullYear+"."+(month.length<2 ? "0" : "")+month+"."+(date.length<2 ? "0" : "")+date;
			}
			return name+"."+this.textFileExtension;
		}
		static public function read():void{
			readInternal(Settings.instance);
		}
		static private function readInternal(target:Settings):void{
			var file:File = File.applicationStorageDirectory.resolvePath(FILE_NAME);
			if(!file.exists || file.isDirectory) return;
			const bytes:ByteArray = FileUtils.read(file);
			bytes.position = 0;
			var object:Object = bytes.readObject();
			for(var property:String in object){
				if(property in target) target[property] = object[property];
			}
		}
		static public function write():void{
			var file:File = File.applicationStorageDirectory.resolvePath(FILE_NAME);
			if(file.exists) file.deleteFile();
			const bytes:ByteArray = new ByteArray();
			bytes.writeObject(instance);
			FileUtils.write(bytes, file);
		}
	}
}
