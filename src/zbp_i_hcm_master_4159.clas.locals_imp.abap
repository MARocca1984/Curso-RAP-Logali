CLASS lcl_buffer DEFINITION.

  PUBLIC SECTION.

    CONSTANTS: created TYPE c LENGTH 1 VALUE 'C',
               deleted TYPE c LENGTH 1 VALUE 'D',
               updated TYPE c LENGTH 1 VALUE 'U'.

    TYPES: BEGIN OF ty_buffer_master.
             INCLUDE TYPE zhcm_master_4159 AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer_master.

    TYPES: tt_master TYPE SORTED TABLE OF ty_buffer_master WITH UNIQUE KEY e_number.

    CLASS-DATA mt_buffer_master TYPE tt_master.

ENDCLASS.

CLASS lhc_HCMMaster DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS:

      create FOR MODIFY IMPORTING entities FOR CREATE HCMMaster,
      update FOR MODIFY IMPORTING entities FOR UPDATE HCMMaster,
      delete FOR MODIFY IMPORTING keys     FOR DELETE HCMMaster,
      read   FOR READ IMPORTING keys       FOR READ   HCMMaster RESULT result.

ENDCLASS.

CLASS lhc_HCMMaster IMPLEMENTATION.

  METHOD create.

    GET TIME STAMP FIELD DATA(lv_time_stamp).
    DATA(lv_uname) = cl_abap_context_info=>get_user_technical_name( ).

    SELECT MAX( e_number )
      FROM zhcm_master_4159
      INTO @DATA(lv_mx_emp_number).

    LOOP AT entities INTO DATA(ls_entities).

      ls_entities-%data-CreaDateTime = lv_time_stamp.
      ls_entities-%data-CreaUname    = lv_uname.
      ls_entities-%data-ENumber      = lv_mx_emp_number + 1.

      INSERT VALUE #( flag = lcl_buffer=>created
                      data = CORRESPONDING #( ls_entities-%data ) ) INTO TABLE lcl_buffer=>mt_buffer_master.

      IF ls_entities-%cid IS NOT INITIAL.

        INSERT VALUE #( %cid = ls_entities-%cid
                        ENumber = ls_entities-ENumber ) INTO TABLE mapped-hcmmaster.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_HCMMaster DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_HCMMaster IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    DATA: lt_data_created TYPE STANDARD TABLE OF zhcm_master_4159.

    lt_data_created = VALUE #( FOR <row> IN lcl_buffer=>mt_buffer_master
                      WHERE ( flag = lcl_buffer=>created ) ( <row>-data ) ).

    IF lt_data_created IS NOT INITIAL.
      INSERT zhcm_master_4159 FROM TABLE @lt_data_created.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
