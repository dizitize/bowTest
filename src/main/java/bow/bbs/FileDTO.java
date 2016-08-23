package bow.bbs;

import java.sql.Timestamp;

public class FileDTO {

	private int file_idx;
	private int board_idx ;
	private String origin_file_name;
	private String stored_file_name;
	private int file_size;
	private Timestamp create_date;
	private String del_gb ;
	
	
	public FileDTO() {
		// TODO Auto-generated constructor stub
	}


	protected FileDTO(int file_idx, int board_idx, String origin_file_name, String stored_file_name, int file_size,
			Timestamp create_date, String del_gb) {
		super();
		this.file_idx = file_idx;
		this.board_idx = board_idx;
		this.origin_file_name = origin_file_name;
		this.stored_file_name = stored_file_name;
		this.file_size = file_size;
		this.create_date = create_date;
		this.del_gb = del_gb;
	}


	public int getFile_idx() {
		return file_idx;
	}


	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}


	public int getBoard_idx() {
		return board_idx;
	}


	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}


	public String getOrigin_file_name() {
		return origin_file_name;
	}


	public void setOrigin_file_name(String origin_file_name) {
		this.origin_file_name = origin_file_name;
	}


	public String getStored_file_name() {
		return stored_file_name;
	}


	public void setStored_file_name(String stored_file_name) {
		this.stored_file_name = stored_file_name;
	}


	public int getFile_size() {
		return file_size;
	}


	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}


	public Timestamp getCreate_date() {
		return create_date;
	}


	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}


	public String getDel_gb() {
		return del_gb;
	}


	public void setDel_gb(String del_gb) {
		this.del_gb = del_gb;
	}
	
	
	
	
}

