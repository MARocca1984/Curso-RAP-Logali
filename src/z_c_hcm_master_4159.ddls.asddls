@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HCM - Master'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define root view entity z_c_hcm_master_4159
  as projection on z_i_hcm_master_4159

{

      @ObjectModel.text.element: [ 'EName' ]
  key ENumber,
      EName,
      EDepartment,
      Status,
      JobTitle,
      StartDate,
      EndDate,
      Email,
      @ObjectModel.text.element: [ 'MName' ]
      MNumber,
      MName,
      MDepartment,
      @Semantics.user.createdBy: true
      CreaDateTime,
      CreaUname,
      @Semantics.user.lastChangedBy: true
      LchgDateTime,
      LchgUname

}
