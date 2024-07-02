@EndUserText.label: 'Consumption - Booking'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Z_C_BOOKING_4159
  as projection on z_i_booking_4159

{

  key TravelId      as TravelId,
  key BookingId     as BookingId,
      BookingDate   as BookingDate,
      CustomerId    as CustomerId,
      @ObjectModel.text.element: ['CarrierName']
      CarrierId     as CarrierId,
      _Carrier.Name as CarrierName,
      ConnectionId  as ConnectionId,
      FlightDate    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice   as FlightPrice,
      @Semantics.currencyCode: true
      CurrencyCode  as CurrencyCode,
      BookingStatus as BookingStatus,
      LastChangeAt  as LastChangeAt,
      
      //Associations
      _Travel            : redirected to parent Z_C_TRAVEL_4159,
      _BookingSupplement : redirected to composition child Z_C_BOOKSUPPL_4159,
      _Carrier,
      _Connection,
      _Customer

}
