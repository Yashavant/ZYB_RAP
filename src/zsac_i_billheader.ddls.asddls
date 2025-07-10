@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Root Entity Billing Header'
@Metadata.allowExtensions: true

define root view entity ZSAC_I_BillHeader
as select from zsac_bill_header
{
key bill_id     as BillId,
bill_type   as BillType,
bill_date   as BillDate,
customer_id as CustomerId,
@Semantics.amount.currencyCode : 'currency'
net_amount  as NetAmount,
currency    as Currency,
sales_org   as SalesOrg,
local_last_changed_at as Locallastchangedat
}
