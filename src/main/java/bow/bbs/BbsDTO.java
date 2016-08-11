package bow.bbs;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

public class BbsDTO {

	private int board_idx;
	private String subject;
	private String content;
	private String writer;
	private String password;
	private Date writedate;
	private String datechar;

	private int readnum;
	private int ref;
	private int lev;
	private int sunbun;
	private int news;
	private List<CommentDTO> commentDto;

	public BbsDTO() {
		// TODO Auto-generated constructor stub
	}
    
	protected BbsDTO(int board_idx, String subject, String content, String writer, String password, Date writedate,
			String datechar, int readnum, int ref, int lev, int sunbun, int news, List<CommentDTO> commentDto) {
		super();
		this.board_idx = board_idx;
		this.subject = subject;
		this.content = content;
		this.writer = writer;
		this.password = password;
		this.writedate = writedate;
		this.datechar = datechar;
		this.readnum = readnum;
		this.ref = ref;
		this.lev = lev;
		this.sunbun = sunbun;
		this.news = news;
		this.commentDto = commentDto;
	}

	protected BbsDTO(int board_idx, String subject, String content, String writer, String password, Date writedate,
			int readnum, int ref, int lev, int sunbun, int news, ArrayList<CommentDTO> commentDto) {
		super();
		this.board_idx = board_idx;
		this.subject = subject;
		this.content = content;
		this.writer = writer;
		this.password = password;
		this.writedate = writedate;
		this.readnum = readnum;
		this.ref = ref;
		this.lev = lev;
		this.sunbun = sunbun;
		this.news = news;
		this.commentDto = commentDto;
	}

	protected BbsDTO(int board_idx, String subject, String content, String writer, String password, Date writedate,
			int readnum, int ref, int lev, int sunbun, int news) {
		super();
		this.board_idx = board_idx;
		this.subject = subject;
		this.content = content;
		this.writer = writer;
		this.password = password;
		this.writedate = writedate;
		this.readnum = readnum;
		this.ref = ref;
		this.lev = lev;
		this.sunbun = sunbun;
		this.news = news;
	}

	protected BbsDTO(int board_idx, String subject, String content, String writer, Date writedate, int ref,
			int lev, int sunbun) {
		super();
		this.board_idx = board_idx;
		this.subject = subject;
		this.content = content;
		this.writer = writer;
		this.writedate = writedate;
		this.ref = ref;
		this.lev = lev;
		this.sunbun = sunbun;
	}
    
	
	
  

	public String getDatechar() {
		return datechar;
	}

	public void setDatechar(String datechar) {
		this.datechar = datechar;
	}

	public int getBoard_idx() {
		return board_idx;
	}

	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getLev() {
		return lev;
	}

	public void setLev(int lev) {
		this.lev = lev;
	}

	public int getSunbun() {
		return sunbun;
	}

	public void setSunbun(int sunbun) {
		this.sunbun = sunbun;
	}

	public int getNews() {
		return news;
	}

	public void setNews(int news) {
		this.news = news;
	}

	public List<CommentDTO> getCommentDto() {
		return commentDto;
	}

	public void setCommentDto(List<CommentDTO> commentDto) {
		this.commentDto = commentDto;
	}


	
}