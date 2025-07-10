@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Base view for po'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ 
serviceQuality: #X, 
sizeCategory: #S, 
dataClass: #MIXED 
} 
define root view entity zybpo_header_base as select from zybpo_header
{
    key pono as Pono,
    pocompany as Pocompany,
    podate as Podate,
    podesc as Podesc,
    postatus as Postatus
}
