@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Item Child View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SALES_ITEM as select from ztest_sales_item
association to parent ZI_SALES_HEADER as _Header on $projection.sales_order_id = _Header.sales_order_id 
{
  key sales_order_id,
    key item_number,
    material_id,
    material_description,
    @Semantics.quantity.unitOfMeasure: 'uom'
    quantity,
    uom,
    @Semantics.amount.currencyCode: 'currency'
    price,
    currency,
    created_by,
    created_at,
    last_changed_by,
    last_changed_at,
    local_last_changed_at,
    _Header
    
}
