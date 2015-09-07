package data.bin{
	import data.bin.CRC32;

	import flash.utils.ByteArray;

	public class PNGChunk extends Object{
		private var _type:String;
		private var _content:ByteArray;
		private var _crc:uint;
		public function PNGChunk(type:String, content:ByteArray, crc:uint=0):void{
			super();
			_type = type;
			_content = content;
			_crc = crc ? crc : (content ? CRC32.calculate(content) : 0);
		}
		public function get type():String{
			return this._type;
		}
		public function set type(value:String):void{
			this._type = value;
		}
		public function get content():ByteArray{
			return this._content;
		}
		public function set content(value:ByteArray):void{
			if(this._content != value){
				this._content = value;
				this.calculateCRC();
			}
		}
		public function get crc():uint{
			return this._crc;
		}
		public function get length():uint{
			return this._content ? this._content.length : 0;
		}
		public function calculateCRC():uint{
			if(!this._content) return 0;
			const bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(this._type, "ascii");
			bytes.writeBytes(this._content);
			this._crc = CRC32.calculate(bytes);
			return this._crc;
		}
		static public function read(bytes:ByteArray, offset:uint=0):PNGChunk{
			if(offset) bytes.position = offset;
			else offset = bytes.position;
			const length:uint = bytes.readUnsignedInt();
			var type:String = "";
			while(type.length<4) type += String.fromCharCode(bytes.readUnsignedByte());
			const content:ByteArray = new ByteArray();
			if(length){
				bytes.readBytes(content, 0, length);
			}
			const crc:uint = bytes.readUnsignedInt();
			return new PNGChunk(type, content, crc);
		}
		static public function write(chunk:PNGChunk, bytes:ByteArray=null):ByteArray{
			if(!bytes) bytes = new ByteArray();
			const length:uint = chunk.length;
			bytes.writeUnsignedInt(length);
			bytes.writeMultiByte(chunk._type, "ascii");
			if(length){
				bytes.writeBytes(chunk._content);
			}
			bytes.writeUnsignedInt(chunk._crc);
			return bytes;
		}
	}
}