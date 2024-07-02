@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define root view entity Z_C_EMPLOYEE_4159 provider contract transactional_query
  as projection on Z_I_employee_4159
  
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
