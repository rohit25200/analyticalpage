using my.bookshop as my from '../db/data-model';

service CatalogService {
    @readonly entity BooksAnalytics as projection on my.Books;
      entity Material as projection on my.Material;
      entity MaterialStock as projection on my.MaterialStock;
}
annotate CatalogService.Material with @(
  Aggregation.ApplySupported: {
    Transformations: [
      'aggregate',
      'groupby',
      'filter'
    ],
    GroupableProperties: [
      material,
      datetime
    ],
    AggregatableProperties: [{
      $Type: 'Aggregation.AggregatablePropertyType',
      Property: openingstock
    }, {
      $Type: 'Aggregation.AggregatablePropertyType',
      Property: goodissue
    }, {
      $Type: 'Aggregation.AggregatablePropertyType',
      Property: goodsreceipt
    }, {
      $Type: 'Aggregation.AggregatablePropertyType',
      Property: closingstock
    }]
  },
  Analytics.AggregatedProperty #totalStock: {
    $Type: 'Analytics.AggregatedPropertyType',
    AggregatableProperty: closingstock,
    AggregationMethod: 'sum',
    Name: 'totalStock',
    ![@Common.Label]: 'Total stock'
  }
);

annotate CatalogService.Material with @(
  UI.Chart: {
    $Type: 'UI.ChartDefinitionType',
    Title: 'Stock',
    ChartType: #Line,
    Dimensions: [
      material,
      datetime
    ],
    DimensionAttributes: [{
      $Type: 'UI.ChartDimensionAttributeType',
      Dimension: material,
      Role: #Series
    }, {
      $Type: 'UI.ChartDimensionAttributeType',
      Dimension: datetime,
      Role: #Category
    }],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalStock]
    ],
    MeasureAttributes: [{
      $Type: 'UI.ChartMeasureAttributeType',
      Measure: closingstock,
      Role: #Axis1
    }]
  },
  UI.PresentationVariant: {
    $Type: 'UI.PresentationVariantType',
    Visualizations: [
      '@UI.Chart'
    ]
  }
);





// annotate CatalogService.Material with @(
//   Aggregation.ApplySupported: {
//     Transformations: [
//       'aggregate',
//       'topcount',
//       'bottomcount',
//       'identity',
//       'concat',
//       'groupby',
//       'filter',
//       'expand',
//       'search'
//     ],
//     GroupableProperties: [
//       MaterialId,
//       MaterialName,
//       Date,
//       Time
//     ],
//     AggregatableProperties: [{
//       $Type: 'Aggregation.AggregatablePropertyType',
//       Property: Stock
//     }]
//   },
//   Analytics.AggregatedProperty #totalStock: {
//     $Type: 'Analytics.AggregatedPropertyType',
//     AggregatableProperty: Stock,
//     AggregationMethod: 'sum',
//     Name: 'totalStock',
//     ![@Common.Label]: 'Total stock'
//   }
// );

// // Main chart by MaterialName and Date
// annotate CatalogService.Material with @(
//   UI.Chart: {
//     $Type: 'UI.ChartDefinitionType',
//     Title: 'Stock',
//     ChartType: #Line,
//     Dimensions: [
//       MaterialName,
//       Time
//     ],
//     DimensionAttributes: [{
//       $Type: 'UI.ChartDimensionAttributeType',
//       Dimension: MaterialName,
//       Role: #Series
//     }, {
//       $Type: 'UI.ChartDimensionAttributeType',
//       Dimension: Time,
//       Role: #Category
//     }],
//     DynamicMeasures: [
//       ![@Analytics.AggregatedProperty#totalStock]
//     ],
//     MeasureAttributes: [{
//       $Type: 'UI.ChartMeasureAttributeType',
//       Measure: Stock,
//       Role: #Axis1
//     }]
//   },
//   UI.PresentationVariant: {
//     $Type: 'UI.PresentationVariantType',
//     Visualizations: [
//       '@UI.Chart'
//     ]
//   }
// );