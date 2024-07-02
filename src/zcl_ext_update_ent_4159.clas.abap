CLASS zcl_ext_update_ent_4159 DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_ext_update_ent_4159 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    MODIFY ENTITIES OF z_i_travel_4159
           ENTITY Travel
           UPDATE FIELDS ( AgencyId Description )
           WITH VALUE #( ( TravelId = '00000012'
                           AgencyId = '070017'
                           Description = 'Vacation' ) )
           FAILED DATA(failed)
           REPORTED DATA(reported).

    READ ENTITIES OF z_i_travel_4159
           ENTITY Travel
           FIELDS ( AgencyId Description )
           WITH VALUE #( ( TravelId = '00000012' ) )
           RESULT DATA(result)
           FAILED failed
           REPORTED reported.

    COMMIT ENTITIES.

    IF failed IS INITIAL.
      out->write( 'Commit successfull' ).
    ELSE.
      out->write( 'Commit failed' ).
    ENDIF..

  ENDMETHOD.

ENDCLASS.
