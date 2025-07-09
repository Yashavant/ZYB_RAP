@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Header Root'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SALES_HEADER as select from ztest_sales_hdr
composition [1..*] of ZI_SALES_ITEM as _Salesitem 
{
    key sales_order_id,
    order_created_date,
    order_created_user,
    category,
    description,
    customer_id,
    created_by,
    created_at,
    last_changed_by,
    last_changed_at,
    local_last_changed_at,
    _Salesitem
}
