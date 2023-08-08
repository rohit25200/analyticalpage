namespace my.bookshop;

entity Books {
  key ID : Integer @title: 'ID';
  stock  : Integer @title: 'Title';
  stockName  : String@title: 'Stock';

      
 
 OnTheDate: Date @title: 'Published At';
}
// entity Material {
//     key ID: Integer;
//     Material: String;
//     Stock: Integer;
//     Value: Integer;
// }

// entity Material {
//    Date :Date @title : 'Date';
//    MaterialId: String(10) @title : 'Material Id';
//    Time: Time @title :'Time';
//   MaterialName: String(50) @title : 'MaterialName';
//   Stock: Integer @title : 'Stock'
// }
entity Material {
   key ID: Integer;
  datetime: DateTime @title : 'Date';
  material: String(20) @title : 'Material';
  openingstock: Integer @title : 'openingStock';
  goodissue: Integer;
  goodsreceipt: Integer;
  closingstock: Integer @title : 'Closeingstock';
}


using { API_MATERIAL_STOCK_SRV as external } from '../srv/external/API_MATERIAL_STOCK_SRV';

entity MaterialStock as projection on external.A_MaterialStock {
    *
}
