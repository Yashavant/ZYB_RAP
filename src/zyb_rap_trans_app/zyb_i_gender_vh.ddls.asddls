@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help Entity for Gender'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS   //Convert F4 Help Pop up to Dropdown list in UI
define view entity ZYB_I_GENDER_VH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'ZYB_DD_GENDER'  )
{
  key domain_name,
  key value_position,
      @Semantics.language: true
  key language,
  @ObjectModel.text.element: [ 'GenderText' ]    //Linking Gender codse with Gender text field
      value_low as GenderCode,
      text      as GenderText
}
