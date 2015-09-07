package data
{
	import data.bin.PNGChunk;

	/**
	 * IListInputItem.as
	 * @author: ${AUTHOR_NAME} on 29.01.13
	 */
	public interface IListInputItem
	{
		function compose():PNGChunk;
		function get password():String;
	}
}
