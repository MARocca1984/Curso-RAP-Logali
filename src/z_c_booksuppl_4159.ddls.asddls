@EndUserText.label: 'Consumption - Booking Supplement'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Z_C_BOOKSUPPL_4159
  as projection on z_i_booksuppl_4159

{

  key TravelId                    as TravelId,
  key BookingId                   as BookingId,
  key BookingSupplementId         as BookingSupplementId,
      @ObjectModel.text.element: ['SupplementDescription']
      SupplementId                as SupplementId,
      _SupplementText.Description as SupplementDescription : localized,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      Price                       as Price,
      @Semantics.currencyCode: true
      Currency                    as CurrencyCode,
      LastChangedAt               as LastChangedAt,
      /* Associations */
      _Travel  : redirected to Z_C_TRAVEL_4159,
      _Booking : redirected to parent Z_C_BOOKING_4159,
      _Product,
      _SupplementText

}
