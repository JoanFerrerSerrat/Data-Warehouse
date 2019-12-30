WITH Q_StatusOrder AS(
    SELECT 1 AS StatusOrderId, 'In process' AS StatusOrder UNION ALL
    SELECT 2, 'Approved'UNION ALL
    SELECT 3, 'Back ordered'UNION ALL
    SELECT 4, 'Rejected'UNION ALL
    SELECT 5, 'Shipped'UNION ALL
    SELECT 6, 'Canceled'
)
INSERT INTO DWH.DimStatusOrder(
                StatusOrderId,
                StatusOrder )
SELECT *
FROM Q_StatusOrder AS Q
WHERE NOT EXISTS(
    SELECT 1
    FROM DWH.DimStatusOrder AS d
    WHERE Q.StatusOrderId = d.StatusOrderId
          AND Q.StatusOrder = d.StatusOrder )
GO
