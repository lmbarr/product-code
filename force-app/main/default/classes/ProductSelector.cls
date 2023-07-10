public with sharing class ProductSelector {
    public static List<AggregateResult> getProductsByName(Set<String> productNames) {
        return [
                SELECT Name, ProductCode, COUNT(Id)counter
                FROM Product2
                WHERE Name IN :productNames
                GROUP BY Name, ProductCode
        ];
    }

    public static Integer getCountByName(String productName) {
        return [SELECT Count() FROM Product2 WHERE Name = :productName];
    }
}