@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Address-Managed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZYB_I_CONTADDR_M
  as select from zyb_contaddr_m
  association to parent ZYB_I_CONTACT_M as _Contact on $projection.ContactId = _Contact.ContactId
{
  key contact_id      as ContactId,
  key address_id      as AddressId,
      addr1           as Addr1,
      addr2           as Addr2,
      city            as City,
      state           as State,
      pincode         as Pincode,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      _Contact
}
