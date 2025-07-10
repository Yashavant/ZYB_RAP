@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Base view for po item'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zybpo_item_base as select from zybpo_item
{
    key pono as Pono,
    key poitem as Poitem,
    @Semantics.quantity.unitOfMeasure : 'Unit'
    quantity as Quantity,
    unit as Unit
}
