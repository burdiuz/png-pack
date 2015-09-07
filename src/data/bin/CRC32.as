package data.bin{
	import flash.utils.ByteArray;

	public class CRC32{
		/** The fast CRC table. Computed once when the CRC32 class is loaded. */
		static private const crcTable:Array = function ():Array{
			var crcTable:Array = new Array(256);
			for (var n:int = 0; n < 256; n++) {
				var c:uint = n;
				for (var k:int = 8; --k >= 0; ) {
					if((c & 1) != 0) c = 0xedb88320 ^ (c >>> 1);
					else c = c >>> 1;
				}
				crcTable[n] = c;
			}
			return crcTable;
		}();
		/**
		 * Adds the complete byte array to the data checksum.
		 * 
		 * @param buf the buffer which contains the data
		 */
		static public function calculate(bytes:ByteArray):uint{
			const pos:uint = bytes.position;
			var crc:uint = 0;
			var off:uint = 0;
			bytes.position = 0;
			var len:uint = bytes.length;
			//var c:uint = ~crc;
			while(--len >= 0) crc = crcTable[(crc ^ bytes[off++]) & 0xff]^(crc >>> 8);
			//crc = ~crc;
			bytes.position = pos;
			return crc;
		}
	}
}