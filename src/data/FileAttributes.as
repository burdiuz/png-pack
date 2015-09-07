/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 28.01.13
 * Time: 13:09
 * To change this template use File | Settings | File Templates.
 */
package data {
	import flash.filesystem.File;
	import flash.net.registerClassAlias;

	[Bindable]
	[RemoteClass(alias="aw.imagepack.FileAttributes")]
	public class FileAttributes {
		public var name:String;
		public var type:String;
		public var creationDate:Date;
		public var extended:Boolean;
		public var creator:String;
		public var downloaded:Boolean;
		public var modificationDate:Date;
		public var nativePath:String;
		public function FileAttributes():void{
		}
		public function copy(file:File, extended:Boolean=false):void{
			this.name = file.name;
			this.type = file.type;
			this.creationDate = file.creationDate;
			this.extended = extended;
			if(extended){
				this.creator = file.creator;
				this.downloaded = file.downloaded;
				this.modificationDate =  file.modificationDate;
				this.nativePath = file.nativePath;
			}else{
				this.creator = null;
				this.downloaded = false;
				this.modificationDate =  null;
				this.nativePath = null;
			}
		}
		static public function create(file:File, extended:Boolean=false):FileAttributes{
			const attr:FileAttributes = new FileAttributes();
			if(file) attr.copy(file,  extended);
			return attr;
		}
		registerClassAlias("aw.imagepack.FileAttributes", FileAttributes);
	}
}
