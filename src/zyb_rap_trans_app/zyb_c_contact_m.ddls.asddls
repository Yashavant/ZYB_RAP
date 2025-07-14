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
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      _Gender,
      _Address :redirected to composition child ZYB_C_CONTADDR_M
}
