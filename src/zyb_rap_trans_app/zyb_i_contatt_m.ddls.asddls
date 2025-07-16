@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Attachment-Managed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZYB_I_CONTATT_M
  as select from zyb_contatt_m
  association to parent ZYB_I_CONTACT_M as _Contact on $projection.ContactId = _Contact.ContactId
{
  key contact_id      as ContactId,
  key attach_id       as AttachId,
      mimetype        as Mimetype,
      filename        as Filename,
      attachment      as Attachment,
      comments        as Comments,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      _Contact
}
