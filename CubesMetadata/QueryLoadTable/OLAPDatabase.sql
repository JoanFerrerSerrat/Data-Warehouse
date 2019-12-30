INSERT INTO [CubesMetadata].[OLAPDatabase](
    [Id]
    , [OLAPDatabaseId]
    , [OLAPDatabaseName]
    , [DeletePartitionModel])
VALUES(1
       , 'Datawarehouse'
       , 'Datawarehouse'
       , '<Delete xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
               <Object>
                   <DatabaseID>##DatabaseID##</DatabaseID>
                   <CubeID>##CubeID##</CubeID>
                   <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
                   <PartitionID>##PartitionID##</PartitionID>
               </Object>
           </Delete>')
GO
