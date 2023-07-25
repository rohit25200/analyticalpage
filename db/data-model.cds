namespace my.bookshop;

entity Books {
  key ID : Integer @title: 'ID';
  stock  : Integer @title: 'Title';
  stockName  : String@title: 'Stock';

      
 
 OnTheDate: Date @title: 'Published At';
}

