@EndUserText.label: 'Consumption - Travel'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity Z_C_TRAVEL_4159
  as projection on z_i_travel_4159

{

  key     TravelId           as TravelId,
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
          
          @Semantics.amount.currencyCode: 'CurrencyCode'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELEM_4159'
  virtual DiscountPrice : /dmo/total_price,
          
          // Asociations
          _Agency,
          _Booking : redirected to composition child Z_C_BOOKING_4159,
          _Currency,
          _Customer

}
