@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composit view for po'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zybpo_header_composit as select from zybpo_header_base
composition [1..*] of zybpo_item_composit as _item
{
    key Pono,
    Pocompany,
    Podate,
    Podesc,
    Postatus,
    _item // Make association public
}
