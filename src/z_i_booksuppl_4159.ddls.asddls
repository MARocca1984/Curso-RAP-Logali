@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface - Booking Supplement'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ serviceQuality: #X,
                         sizeCategory: #S,
                         dataClass: #MIXED }

define view entity z_i_booksuppl_4159
  as select from zbooksuppl_4159 as BookingSupplement

  association        to parent z_i_booking_4159 as _Booking        on  $projection.TravelId  = _Booking.TravelId
                                                                   and $projection.BookingId = _Booking.BookingId

  association [1..1] to z_i_travel_4159         as _Travel         on  $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Supplement       as _Product        on  $projection.SupplementId = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText   as _SupplementText on  $projection.SupplementId = _SupplementText.SupplementID

{

  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode : 'Currency'
      price                 as Price,
      currency              as Currency,
      @Semantics.systemDateTime.lastChangedAt: true
      _Travel.LastChangedAt as LastChangedAt,  
      _Booking,
      _Travel,
      _Product,
      _SupplementText

}
