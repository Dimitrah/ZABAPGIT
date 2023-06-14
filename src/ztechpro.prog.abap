*&---------------------------------------------------------------------*
*& Report ZTECHPRO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztechpro.

DATA: lt_techpro TYPE TABLE OF ztechpro,
      ls_techpro TYPE ztechpro.
DATA: lv_sum TYPE i,
      lv_div TYPE p.

SELECTION-SCREEN BEGIN OF BLOCK B1.
  PARAMETERS: p_int1 TYPE i.
  PARAMETERS: p_int2 TYPE i.
SELECTION-SCREEN END OF BLOCK B1.

SELECT * FROM ztechpro
  INTO TABLE lt_techpro.

LOOP AT lt_techpro INTO ls_techpro.
  WRITE:/ ls_techpro-mandt, ls_techpro-zuser, ls_techpro-age.
  SKIP 1.
ENDLOOP.

PERFORM test.

CALL METHOD zcl_techpro=>division
  EXPORTING
    int_1 = p_int1
    int_2 = p_int1
  IMPORTING
    div   = lv_div.

WRITE: 'Division result:' ,lv_div.




FORM test .
  CALL FUNCTION 'ZF_TECHPRO'
    EXPORTING
      int_1     = p_int1
      int_2     = p_int1
    IMPORTING
      sum       = lv_sum
    EXCEPTIONS
      grater_10 = 1
      OTHERS    = 2.
  IF sy-subrc <> 0.
    IF sy-subrc = 1.
      MESSAGE 'GREATER THAN 10' TYPE 'I'.
    ENDIF.
* Implement suitable error handling here
  ELSE.
    WRITE: 'SUM = ', lv_sum.
  ENDIF.
ENDFORM.
