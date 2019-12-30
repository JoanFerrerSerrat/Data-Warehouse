INSERT INTO [CubesMetadata].[Measuregroup](
    [CubeID]
    , [MeasureGroupId]
    , [MeasureGroupName]
    , [Frequency]
    , [CreatePartition] 
    , [ProcessQuery]
    , [StartDate]
    , [CreatePartitionModel]
    , [Query])
VALUES( 1
        , 'Fact Currency Rate'
        , 'Fact Currency Rate'
        , 'Unique'
        , 0
        , '<Batch xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
               <Parallel>
                 <Process xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                   <Object>
                     <DatabaseID>##DatabaseID##</DatabaseID>
                     <CubeID>##CubeID##</CubeID>
                     <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
                     <PartitionID>##PartitionID##</PartitionID>
                   </Object>
                   <Type>ProcessFull</Type>
                   <WriteBackTableCreation>UseExisting</WriteBackTableCreation>
                 </Process>
               </Parallel>
             </Batch>'
        , CONVERT(DATETIME, '2011-05-01')
        , '<Create xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
               <ParentObject>
                   <DatabaseID>##DatabaseID##</DatabaseID>
                   <CubeID>##CubeID##</CubeID>
                   <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
               </ParentObject>
               <ObjectDefinition>
                   <Partition xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                       <ID>##PartitionID##</ID>
                       <Name>##PartitionName##</Name>
                       <Source xsi:type="DsvTableBinding">
                           <DataSourceViewID>Datawarehouse</DataSourceViewID>
                           <TableID>##Query##</TableID>
                       </Source>
                       <StorageMode>Molap</StorageMode>
                       <ProcessingMode>Regular</ProcessingMode>
                       <ProactiveCaching>
                           <SilenceInterval>-PT1S</SilenceInterval>
                           <Latency>-PT1S</Latency>
                           <SilenceOverrideInterval>-PT1S</SilenceOverrideInterval>
                           <ForceRebuildInterval>-PT1S</ForceRebuildInterval>
                           <Source xsi:type="ProactiveCachingInheritedBinding" />
                       </ProactiveCaching>
                       <EstimatedRows>13533</EstimatedRows>
                       <AggregationDesignID>AggregationDesign_FactCurrencyRate</AggregationDesignID>
                   </Partition>
               </ObjectDefinition>
           </Create>'
         , 'ExtDWH_FactCurrencyRate'),
      ( 1
        , 'Fact Sales Order'
        , 'Fact Sales Order'
        --, 'FactSalesOrder_##PartitionId##'
        , 'Monthly'
        , 1
        , '<Batch xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
            <Parallel>
              <Process xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                <Object>
                  <DatabaseID>##DatabaseID##</DatabaseID>
                  <CubeID>##CubeID##</CubeID>
                  <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
                  <PartitionID>##PartitionId##</PartitionID>
                </Object>
                <Type>ProcessFull</Type>
                <WriteBackTableCreation>UseExisting</WriteBackTableCreation>
              </Process>
            </Parallel>
          </Batch>'
        , CONVERT(DATETIME, '2011-05-01')
        , '<Create xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
              <ParentObject>
                  <DatabaseID>##DatabaseID##</DatabaseID>
                  <CubeID>##CubeID##</CubeID>
                  <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
              </ParentObject>
              <ObjectDefinition>
                  <Partition xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                      <ID>##PartitionId##</ID>
                      <Name>##MeasureGroupID##_##PartitionId##</Name>
                      <Source xsi:type="QueryBinding">
                          <DataSourceID>Datawarehouse</DataSourceID>
                          <QueryDefinition>##Query##</QueryDefinition>
                      </Source>
                      <StorageMode>Molap</StorageMode>
                      <ProcessingMode>Regular</ProcessingMode>
                      <ProactiveCaching>
                          <SilenceInterval>-PT1S</SilenceInterval>
                          <Latency>-PT1S</Latency>
                          <SilenceOverrideInterval>-PT1S</SilenceOverrideInterval>
                          <ForceRebuildInterval>-PT1S</ForceRebuildInterval>
                          <Source xsi:type="ProactiveCachingInheritedBinding" />
                      </ProactiveCaching>
                  </Partition>
              </ObjectDefinition>
          </Create>'
        , 'SELECT [CurrencyId],[CurrencyRateId],[SalesOrderNumber],[SalesOrderHeaderId],[SalesOrderDetailId],[OrderLineNumber],[ProductId],[CustomerId],[SpecialOfferId],[OrderDate],[DueDate],[ShipDate],[Quantity],[UnitPrice],[UnitPriceLocalCurrency],[UnitPriceDiscountPct],[TaxAmt],[Freight],[TotalDue],[SubTotal],[SalesAmount],[SalesAmountLocalCurrency],[OriginalSalesAmount],[OriginalSalesAmountLocalCurrency],[DiscountAmount],[DiscountAmountLocalCurrency],[ProductStandardCost],[ProductStandardCostLocalCurrency],[TotalProductCost],[TotalProductCostLocalCurrency] FROM [ExtDWH].[FactSalesOrder] WHERE [OrderDate] BETWEEN ##StartDate## AND ##EndDate##')

           --'2011-05-01' AND '2011-05-31'
        
        
        
        
        
























