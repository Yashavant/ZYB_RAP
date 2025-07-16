@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Contact-Managed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZYB_I_CONTACT_M
  as select from zyb_contact_m
  association [0..*] to ZYB_I_GENDER_VH  as _Gender on $projection.Gender = _Gender.GenderCode
  composition [1..*] of ZYB_I_CONTADDR_M as _Address //Its Manditory add composition to child Interface
  composition [1..*] of ZYB_I_CONTATT_M as _Attachment //Its Manditory add composition to child Interface
{
  key contact_id         as ContactId,
      first_name         as FirstName,
      middle_name        as MiddleName,
      last_name          as LastName,
      gender             as Gender,
      _Gender.GenderText as GenderText,
      dob                as Dob,
      age                as Age,
      telephone          as Telephone,
      email              as Email,
      active             as Active,
      created_by         as CreatedBy,
      created_at         as CreatedAt,
      last_changed_by    as LastChangedBy,
      last_changed_at    as LastChangedAt,

      _Gender,
      _Address,
      _Attachment

}
