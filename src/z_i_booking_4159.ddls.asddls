@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface - Booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED }

define view entity z_i_booking_4159
  as select from zbooking_4159 as Booking
  association        to parent z_i_travel_4159    as _Travel on $projection.TravelId = _Travel.TravelId
  composition [0..*] of z_i_booksuppl_4159 as _BookingSupplement  
  association [1..1] to /DMO/I_Customer    as _Customer      on $projection.CustomerId = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier     as _Carrier       on $projection.CarrierId = _Carrier.AirlineID
  association [1..*] to /DMO/I_Connection  as _Connection    on $projection.ConnectionId = _Connection.ConnectionID

{

  key travel_id      as TravelId,
  key booking_id     as BookingId,
      booking_date   as BookingDate,
      customer_id    as CustomerId,
      carrier_id     as CarrierId,
      connection_id  as ConnectionId,
      flight_date    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price   as FlightPrice,
      currency_code  as CurrencyCode,
      booking_status as BookingStatus,
      last_change_at as LastChangeAt,    
        
      // Associations
      _Travel,
      _BookingSupplement,
      _Customer,
      _Carrier,
      _Connection
      
}
