@EndUserText.label: 'Consumption - Travel Approval'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity Z_C_ATRAVEL_4159
  as projection on z_i_travel_4159

{

  key TravelId           as TravelId,
      @ObjectModel.text.element: ['AgencyName']
      AgencyId           as AgencyId,
      _Agency.Name       as AgencyName,
      @ObjectModel.text.element: ['CustomerName']
      CustomerId         as CustomerId,
      _Customer.LastName as CustomerName,
      BeginDate          as BeginDate,
      EndDate            as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee         as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice         as TotalPrice,
      @Semantics.currencyCode: true
      CurrencyCode       as CurrencyCode,
      Description        as Description,
      OverallStatus      as TravelStatus,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt      as LastChangedAt,
      _Booking : redirected to composition child Z_C_ABOOKING_4159,
      _Agency,
      _Customer

}
