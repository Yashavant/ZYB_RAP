@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Address-Managed'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZYB_C_CONTADDR_M
  as projection on ZYB_I_CONTADDR_M
{
  key ContactId,
  key AddressId,
      Addr1,
      Addr2,
      City,
      State,
      Pincode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Contact: redirected to parent ZYB_C_CONTACT_M
}
