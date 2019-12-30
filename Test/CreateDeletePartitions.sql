--TEST Creation / Deletion partitions

-- 1. Create mensual partitions from january 2012 until february 2013 (It only creates whole months)
EXEC [CubesMetadata].[p_CreatePartitions] 'Datawarehouse', 'Fact Sales Order', '2012-01-01', '2013-03-02'

-- Result
-- Created partitions properly from january 2012 until february 2013
-- Partitions data in table [CubesMetadata].[Partition] correct
-- Log in table [Logging].[ETL_Loading] correct

-- 2. Create mensual partitions from january 2012 until june 2013. It is expected to create only from march 2013 to june 2013, because the other months exist already.
EXEC [CubesMetadata].[p_CreatePartitions] 'Datawarehouse', 'Fact Sales Order', '2012-01-01', '2013-07-02'

-- Result
-- Created partitions properly
-- Partitions data in table [CubesMetadata].[Partition] correct
-- Log in table [Logging].[ETL_Loading] correct

-- 3. Delete mensual partitions from january 2012 and february 2012
EXEC [CubesMetadata].[p_DeletePartitions] 'Datawarehouse', 'Fact Sales Order', '2012-01-01', '2012-03-02'

-- Result
-- Created partitions properly
-- Partitions data in table [CubesMetadata].[Partition] correct
-- Log in table [Logging].[ETL_Loading] correct

-- 4. Delete mensual partitions from january 2012 and february 2012. Should remove nothing as long as they were removed before.
EXEC [CubesMetadata].[p_DeletePartitions] 'Datawarehouse', 'Fact Sales Order', '2012-01-01', '2012-03-02'