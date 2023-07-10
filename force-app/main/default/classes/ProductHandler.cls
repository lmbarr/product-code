public with sharing class ProductHandler extends BaseTriggerHandler{
    private List<Product2> products = new List<Product2>();
    private Map<Id, Product2> oldMap = new Map<Id, Product2>();
    private List<AggregateResult> productData;
    public Map<String, Integer> newProductData = new Map<String, Integer>();

    public ProductHandler() {
        oldMap = (Map<Id, Product2>) Trigger.oldMap;
        products = (List<Product2>) (Trigger.isDelete ? Trigger.old : Trigger.new);
        productData = ProductSelector.getProductsByName(getProductNames());
    }

    public override void beforeInsert() {
        for (Product2 product : products) {
            if (String.isBlank(product.ProductCode)) {
                try {
                    product.ProductCode = getProductCode(product.Name);
                }
                catch (Exception ex) {
                    System.debug(ex.getMessage() + ex.getStackTraceString());
                    product.ProductCode.addError(ex.getMessage());
                }
            }
        }
    }

    public Set<String> getProductNames() {
        Set<String> productNames = new Set<String>();
        for (Product2 product : products) {
            if (String.isBlank(product.ProductCode)) {
                productNames.add(product.Name);
            }
        }
        return productNames;
    }

    public AggregateResult getProductCodeByName(String productName) {
        for (AggregateResult productDatum : productData) {
            if (productName == productDatum.get('Name')) {
                return productDatum;
            }
        }
        return null;
    }

    public String getProductCode(String productName) {
        AggregateResult productResult = getProductCodeByName(productName);
        if (productResult != null) {
            String familyCode = ((String) productResult.get('ProductCode')).replace('\\d', '');
            setCounter(familyCode, ((Integer) productResult.get('counter')) + 1);
            return familyCode + String.valueOf(newProductData.get(familyCode));
        }
        else {
            String familyCode = createFamilyCode(productName);
            setCounter(familyCode, 1);
            return familyCode + String.valueOf(newProductData.get(familyCode));
        }
    }

    public void setCounter(String familyCode, Integer initValue) {
        if (newProductData.get(familyCode) == null) {
            newProductData.put(familyCode, initValue);
        }
        else {
            newProductData.put(familyCode,  newProductData.get(familyCode) + 1);
        }
    }

    public String createFamilyCode(String productName) {
        List<String> firstLetters = new List<String>();
        Pattern pattern = Pattern.compile('\\b(\\p{L})');
        Matcher matcher = pattern.matcher(productName);

        while (matcher.find()) {
            String firstLetter = matcher.group(1);
            firstLetters.add(firstLetter);
        }

        if (!firstLetters.isEmpty() && firstLetters.size() >= 2) {
            return firstLetters[0] + firstLetters[1];
        }
        else {
            return firstLetters[0];
        }
    }
}