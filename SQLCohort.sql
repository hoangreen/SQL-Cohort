WITH ListOrder AS (
    SELECT DISTINCT CustomerKey
        , OrderDate
    FROM FactInternetSales
)
, ListMinPurchase AS (
    SELECT CustomerKey
        , MIN(OrderDate) AS FirstPurchaseDate
        , FORMAT(MIN(OrderDate), 'yyyy-MM') AS FirstPurchaseMonth
    FROM ListOrder
    GROUP BY CustomerKey
)

, CohortIndex as(
SELECT DISTINCT LO.CustomerKey,
LMP.FirstPurchaseMonth,
DATEDIFF(MONTH, FirstPurchaseDate, OrderDate) as cohortIndex
FROM ListOrder as LO
left join ListMinPurchase as LMP
on LO.CustomerKey = LMP.CustomerKey)

SELECT FirstPurchaseMonth
, [0]
, [1]
, [2]
, [3]
, [4]
, [5]
, [6]
, [7]
, [8]
, [9]
, [10]
, [11]
, [12]
INTO #CohortPivot
FROM CohortIndex
PIVOT(Count(Customerkey) for CohortIndex IN([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PVT 
WHERE FirstPurchaseMonth >= '2020 - 01'
ORDER BY FirstPurchaseMonth

SELECT *
FROM #CohortPivot
ORDER BY FirstPurchaseMonth

SELECT FirstPurchaseMonth
, FORMAT(1.0* [0]/[0], 'P') as [0]
, FORMAT(1.0* [1]/[0], 'P') as [1]
, FORMAT(1.0* [2]/[0], 'P') as [2]
, FORMAT(1.0* [3]/[0], 'P') as [3]
, FORMAT(1.0* [4]/[0], 'P') as [4]
, FORMAT(1.0* [5]/[0], 'P') as [5]
, FORMAT(1.0* [6]/[0], 'P') as [6]
, FORMAT(1.0* [7]/[0], 'P') as [7]
, FORMAT(1.0* [8]/[0], 'P') as [8]
, FORMAT(1.0* [9]/[0], 'P') as [9]
, FORMAT(1.0* [10]/[0], 'P') as [10]
, FORMAT(1.0* [11]/[0], 'P') as [11]
, FORMAT(1.0* [12]/[0], 'P') as [12]
FROM #CohortPivot
