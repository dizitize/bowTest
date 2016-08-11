package bow.bbs.service;

import bow.bbs.BbsDTOnorm;



public interface BbsService {

	/*RequestParam Or Attribute status*/
	public final static int SQL_GET_DATA_OK    =  1;
	public final static int SQL_GET_NO_DATA    =  0;
	
	/*RequestParam Or Attribute status*/
	public final static int REQ_DATA_NULL      = -8;
	public final static int REQ_DATA_PARSE_ERR = -9;

	
	
	public BbsDTOnorm content_for_edit(int board_idx);
	public BbsDTOnorm content_for_show(int board_idx);

	
	public int passwordCheck(String board_idx , String password);

}
