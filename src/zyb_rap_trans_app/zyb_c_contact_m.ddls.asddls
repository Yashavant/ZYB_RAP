@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Contact-Managed'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZYB_C_CONTACT_M
  provider contract transactional_query
  as projection on ZYB_I_CONTACT_M
{
  key ContactId,
      FirstName,
      MiddleName,
      LastName,
      @ObjectModel.text.element: [ 'GenderText' ]    //Display Gender code and text in same field
      Gender,
      GenderText,
      Dob,
      Age,
      Telephone,
      Email,
      Active,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZYB_CL_VIR_ELE_CONTACT_M' //this Anotion Mandatory for VIr ele and class need create with interface-if_sadl_exit_calc_element_read
      virtual CanVote : abap_boolean,     //Virtual elemnt should be on projection view and its data not stored in database table
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      _Gender,
      _Address :redirected to composition child ZYB_C_CONTADDR_M,  //Its manditory for redirect to child complete navigation
      _Attachment :redirected to composition child ZYB_C_CONTATT_M   //Its manditory for redirect to child complete navigation
}
