@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Billing Header'
@Metadata.allowExtensions: true
define root view entity ZSAC_C_BillHeader provider contract transactional_query as projection on ZSAC_I_BillHeader
{
key BillId,
BillType,
BillDate,
CustomerId,
@Semantics.amount.currencyCode : 'currency'
NetAmount,
Currency,
SalesOrg,
Locallastchangedat
}
