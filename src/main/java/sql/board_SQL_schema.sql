
 <=== main board ==> 

   create table board 
   values(
           board_idx  number  primary key ,
           subject varchar2(50)  not null,
           content varchar2(4000) not null,
           writer varchar2(50) not null,
           ref number(38) not null default 0 ,  
           lev number(38) not null default 0 ,
           lev_me number(38) not null,
           lev_point number(38) ,
           sunbun number(38) not null default 0 ,
           password number(38) not null admin, 
           readnum number(38) default 0,
            writedate date not null dafault sysdate ,
           news number(38),
           del number(38),
           list_idx_pointer varchar2(30)
         )
   
   
  <=== comment ==>
   
   create table comment_board
   values(
           comment_board_idx not null number(38),
           board_idx not null number(38),
           content varchar2(2000),
           writer varchar2(20),
           writedate date,
           password number(10)
         )
   