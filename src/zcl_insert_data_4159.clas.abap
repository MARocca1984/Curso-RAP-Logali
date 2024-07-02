CLASS zcl_insert_data_4159 DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_insert_data_4159 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_travel_4159   TYPE TABLE OF ztravel_4159,
          lt_booking_4159  TYPE TABLE OF zbooking_4159,
          lt_book_sup_4159 TYPE TABLE OF zbooksuppl_4159.

    SELECT travel_id,
    agency_id,
    customer_id,
    begin_date,
    end_date,
    booking_fee,
    total_price,
    currency_code,
    description,
    status AS overall_status,
    createdby AS created_by,
    createdat AS created_at,
    lastchangedby AS last_changed_by,
    lastchangedat AS last_changed_at
    FROM /dmo/travel
    INTO CORRESPONDING FIELDS OF
    TABLE @lt_travel_4159
    UP TO 50 ROWS.

    SELECT *
    FROM /dmo/booking
    FOR ALL ENTRIES IN @lt_travel_4159
    WHERE travel_id EQ @lt_travel_4159-travel_id
    INTO CORRESPONDING FIELDS OF TABLE @lt_booking_4159.

*    SELECT *
*    FROM /dmo/book_suppl
*    FOR ALL ENTRIES IN @lt_booking_4159
*    WHERE travel_id EQ @lt_booking_4159-travel_id
*    AND booking_id EQ @lt_booking_4159-booking_id
*    INTO CORRESPONDING FIELDS OF TABLE @lt_book_sup_4159.

    SELECT travel_id,
           booking_id,
           booking_supplement_id,
           supplement_id,
           price,
           currency_code AS currency
    FROM /dmo/book_suppl
    FOR ALL ENTRIES IN @lt_booking_4159
    WHERE travel_id EQ @lt_booking_4159-travel_id
    AND booking_id EQ @lt_booking_4159-booking_id
    INTO CORRESPONDING FIELDS OF TABLE @lt_book_sup_4159.

    DELETE FROM: ztravel_4159,
                 zbooking_4159,
                 zbooksuppl_4159.

    INSERT: ztravel_4159 FROM TABLE @lt_travel_4159,
            zbooking_4159 FROM TABLE @lt_booking_4159,
            zbooksuppl_4159 FROM TABLE @lt_book_sup_4159.

    out->write( 'DONE!' ).

  ENDMETHOD.
ENDCLASS.
