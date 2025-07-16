@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Address-Managed'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZYB_C_CONTADDR_M
  as projection on ZYB_I_CONTADDR_M
{
  key     ContactId,
  key     AddressId,
          Addr1,
          Addr2,
          City,
          State,
          Pincode,
          CreatedBy,
          CreatedAt,
          LastChangedBy,
          LastChangedAt,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZYB_CL_VIR_ELE_CONTACTADDR_M' //this Anotion Mandatory for VIr ele and class need create with interface-if_sadl_exit_calc_element_read
          virtual IsLocal :abap_boolean, //Virtual elemnt should be on projection view and its data not stored in database table
          /* Associations */
          _Contact : redirected to parent ZYB_C_CONTACT_M //Its Mandatory to redirect to parent projection view to complete navigation
}
