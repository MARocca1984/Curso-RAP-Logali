FUNCTION zfm_suppl_4159.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IT_SUPPLEMENTS) TYPE  ZTT_SUPPL_4159
*"     REFERENCE(IV_OP_TYPE) TYPE  ZDE_FLAG_4159
*"  EXPORTING
*"     REFERENCE(EV_UPDATED) TYPE  ZDE_FLAG_4159
*"----------------------------------------------------------------------
  CASE iv_op_type.

    WHEN 'C'.
      INSERT zbooksuppl_4159 FROM TABLE @it_supplements.

    WHEN 'U'.
      UPDATE zbooksuppl_4159 FROM TABLE @it_supplements.

    WHEN 'D'.
      DELETE zbooksuppl_4159 FROM TABLE @it_supplements.

  ENDCASE.

  IF sy-subrc EQ 0.
    ev_updated = abap_true.
  ENDIF.

ENDFUNCTION.
