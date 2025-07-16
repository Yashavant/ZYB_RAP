@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Attachment-Managed'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZYB_C_CONTATT_M
  as projection on ZYB_I_CONTATT_M
{
  key ContactId,
  key AttachId,
      Mimetype,
      Filename,
      @Semantics.largeObject: {     //Attachment functionality will by this Anotatio and Mimetype,Filename should same as Projection field name otherwise it will not work
         contentDispositionPreference: #ATTACHMENT,
          mimeType: 'Mimetype',
         fileName: 'Filename' }
      Attachment,

      Comments,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Contact : redirected to parent ZYB_C_CONTACT_M
}
