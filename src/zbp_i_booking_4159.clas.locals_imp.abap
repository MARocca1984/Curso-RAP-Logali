CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateTotalFlightPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalFlightPrice.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateStatus.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Booking RESULT result.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateTotalFlightPrice.

    IF NOT keys IS INITIAL.

      zcl_aux_travel_det_4159=>calculate_price( it_travel_id = VALUE #( FOR GROUPS <booking> OF booking_key IN keys
                                                                            GROUP BY booking_key-TravelId WITHOUT MEMBERS ( <booking> ) ) ).

    ENDIF.

  ENDMETHOD.

  METHOD validateStatus.

    READ ENTITY z_i_travel_4159\\Booking
         FIELDS ( BookingStatus )
         WITH VALUE #( FOR <row_key> IN keys ( %key = <row_key>-%key ) )
         RESULT DATA(lt_booking_result).

    LOOP AT lt_booking_result INTO DATA(ls_booking_result).

      CASE ls_booking_result-BookingStatus.

        WHEN 'N'. ". New

        WHEN 'X'. ". Cancelled

        WHEN 'B'. ". Booked

        WHEN OTHERS.

          APPEND VALUE #( %key = ls_booking_result-%key ) TO failed-travel.

          APPEND VALUE #( %key = ls_booking_result-%key

                          %msg = new_message( id       = 'Z_MC_TRAVEL_4159'
                                              number   = '008'
                                              v1       = ls_booking_result-BookingStatus
                                              severity = if_abap_behv_message=>severity-error )

                          %element-BookingStatus = if_abap_behv=>mk-on ) TO reported-booking.

      ENDCASE.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF z_i_travel_4159
         ENTITY Booking
         FIELDS ( BookingId BookingDate CustomerId BookingStatus )
         WITH VALUE #( FOR keyval IN keys ( %key = keyval-%key ) )
         RESULT DATA(lt_booking_result).

    result = VALUE #( FOR ls_travel IN lt_booking_result ( %key                      = ls_travel-%key
                                                           %assoc-_BookingSupplement = if_abap_behv=>fc-o-enabled ) ).

  ENDMETHOD.

ENDCLASS.
