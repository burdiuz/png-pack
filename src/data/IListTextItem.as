package data
{
	import data.IListItem;

	import flash.utils.ByteArray;

	/**
	 * IListTextItem.as
	 * @author: ${AUTHOR_NAME} on 29.01.13
	 */
	public interface IListTextItem extends IListItem
	{
		function getTextData():ByteArray;
		function get text():String;
	}
}
