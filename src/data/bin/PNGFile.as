package data.bin{
	import data.bin.PNGChunk;

	import flash.utils.ByteArray;

	public class PNGFile extends Object{
		static private const _header:ByteArray = function():ByteArray{
			const bytes:ByteArray = new ByteArray();
			bytes[0] = 0x89;
			bytes[1] = 0x50;
			bytes[2] = 0x4E;
			bytes[3] = 0x47;
			bytes[4] = 0x0D;
			bytes[5] = 0x0A;
			bytes[6] = 0x1A;
			bytes[7] = 0x0A;
			return bytes;
		}()
		static public const HEADER_LENGTH:uint = 8;
		private var _chunks:Vector.<PNGChunk>;
		public function PNGFile(chunks:Vector.<PNGChunk>):void{
			super();
			_chunks = chunks;
		}
		public function get chunks():Vector.<PNGChunk>{
			return this._chunks;
		}
		public function set chunks(list:Vector.<PNGChunk>):void{
			if(this._chunks!=list){
				this._chunks = list ? list : new <PNGChunk>[];
			}
		}
		public function copy():PNGFile{
			return new PNGFile(this._chunks.slice());
		}
		static public function read(bytes:ByteArray):PNGFile{
			const pos:uint = bytes.position;
			bytes.position = HEADER_LENGTH;
			const list:Vector.<PNGChunk> = new Vector.<PNGChunk>();
			while(bytes.bytesAvailable){
				list.push(PNGChunk.read(bytes));
			}
			return new PNGFile(list);
		}
		static public function write(file:PNGFile, bytes:ByteArray=null):ByteArray{
			if(!bytes) bytes = new ByteArray();
			bytes.writeBytes(_header);
			for each(var chunk:PNGChunk in file._chunks){
				PNGChunk.write(chunk, bytes);
			}
			return bytes;
		}
	}
}