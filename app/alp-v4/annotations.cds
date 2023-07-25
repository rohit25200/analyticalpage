using CatalogService as service from '../../srv/cat-service';
//using from '../../srv/cat-service-annotations';
using { CatalogService } from '../../db/data-model';

//1. Aggregation and analytical annotations

annotate CatalogService.BooksAnalytics with @(
  Aggregation.ApplySupported: {
    Transformations: [
      'aggregate',
      'topcount',
      'bottomcount',
      'identity',
      'concat',
      'groupby',
      'filter',
      'expand',
      'search'      
    ],
    GroupableProperties: [
      ID,
      stock,
      stockName,
      OnTheDate
    ],
    AggregatableProperties: [{
      $Type : 'Aggregation.AggregatablePropertyType',
      Property: stock
    }]
  },
  Analytics.AggregatedProperty #totalStock: {
    $Type : 'Analytics.AggregatedPropertyType',
    AggregatableProperty : stock,
    AggregationMethod : 'sum',
    Name : 'totalStock',
    ![@Common.Label]: 'Total stock'
  },
);

//2. Main chart
annotate CatalogService.BooksAnalytics with @(
  UI.Chart: {
    $Type : 'UI.ChartDefinitionType',
    Title: 'Stock',
    ChartType : #Line
    ,
    Dimensions: [
      stockName,
      OnTheDate
    ],
    DimensionAttributes: [{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: OnTheDate,
      Role: #Category
    },{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: stockName,
      Role: #Series
    }],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalStock]
    ],
    MeasureAttributes: [{
      $Type: 'UI.ChartMeasureAttributeType',
      Measure: stock,
      Role: #Axis1
    }]
  },
  UI.PresentationVariant: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart',
    ],
  }
);
//3. Visual Filters

annotate service.BooksAnalytics with @(
// UI.DataPoint #Price : {
//     $Type : 'UI.DataPointType',
//     Value : stock,
//     ValueFormat : {
//         $Type : 'UI.NumberFormat',
//         NumberOfFractionalDigits : 1
//     }
// },
  UI.Chart #stockName:{
    $Type : 'UI.ChartDefinitionType',
    ChartType:#Bar,
    Dimensions:[
      stockName
    ],
    DimensionAttributes : [
        {
            $Type : 'UI.ChartDimensionAttributeType',
            Dimension : stockName,
            Role :  #Category,
        },
    ],
    DynamicMeasures :[
      ![@Analytics.AggregatedProperty#totalStock]
    ]
  },
  UI.PresentationVariant #prevstockName:{
    $Type : 'UI.PresentationVariantType',
    Visualizations:[
      ![@UI.Chart#stockName]
    ]
  }
){
  stockName@Common.ValueList #vlstockName:{
    $Type : 'Common.ValueListType',
    CollectionPath:'BooksAnalytics',
    Parameters : [
       {
        $Type : 'Common.ValueListParameterInOut',
        ValueListProperty : 'stockName',
        LocalDataProperty : stockName,
       }
    ],
    PresentationVariantQualifier : 'prevstockName',

  }
};



annotate CatalogService.BooksAnalytics with @(
  UI.Chart #OnTheDate: {
    $Type : 'UI.ChartDefinitionType',
    ChartType: #Line,
    Dimensions: [
      OnTheDate
    ],
    DimensionAttributes: [{
      $Type : 'UI.ChartDimensionAttributeType',
      Dimension: OnTheDate,
      Role: #Category
    }],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalStock]
    ]
  },
  UI.PresentationVariant #prevOnTheDate: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart#OnTheDate',
    ],
  }
){
  OnTheDate@Common.ValueList #vlOnTheDate: {
    $Type : 'Common.ValueListType',
    CollectionPath : 'BooksAnalytics',
    Parameters: [{
      $Type : 'Common.ValueListParameterInOut',
      ValueListProperty : 'OnTheDate',
      LocalDataProperty: OnTheDate
    }],
    PresentationVariantQualifier: 'prevOnTheDate'
  }
}

//4. Selection Fields and Line Item
annotate CatalogService.BooksAnalytics with@(
    UI: {
        SelectionFields  : [
          
        ],
        LineItem: [
            {  $Type : 'UI.DataField', Value : ID, },
          
            {  $Type : 'UI.DataField', Value : stock, },
            {  $Type : 'UI.DataField', Value : OnTheDate, },
            {  $Type : 'UI.DataField', Value : stockName, },
           
        ],
    }
);

// annotate CatalogService.BooksAnalytics with @(
//   UI.KPI #totalStockKPI: {
//     $Type: 'UI.KPIType',
//     Value: ![@Analytics.AggregatedProperty#totalStock],
//     Title: 'Total Stock',
//     Subtitle: 'in units',
//     Scale: #Numerical,
//     Trend: #Target,
//     TargetValue: 1000,
//     Criticality: #Error,
//     ![@Common.Label]: 'Total Stock KPI'
//   }
// );
