*&---------------------------------------------------------------------*
*& Report ZPG_DLL_026
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_DLL_026.
* SELECT *
*      FROM zddl_fir026( p_date = '20230203',
*                        p_bukrs = '1000' )
*      INTO table @data(lt_data)
*      WHERE ( am_credit <> '0' OR am_debit <> '0' ).
DATA: lt_seltab  TYPE TABLE OF rsparams,
      ls_seltab  LIKE LINE OF lt_seltab,
      t_list     TYPE TABLE OF abaplist.

DATA: xlist TYPE TABLE OF abaplist.
DATA: xtext TYPE TABLE OF char200.

ls_seltab-kind    = 'S'.
ls_seltab-sign    = 'I'.
ls_seltab-option  = 'EQ'.

ls_seltab-selname = 'BERDATUM'.          " Name of parameter on submitted program
ls_seltab-low     = '20061231'.
APPEND ls_seltab TO lt_seltab.

ls_seltab-selname = 'BUKRS'.
ls_seltab-low     = '0005'.
APPEND ls_seltab TO lt_seltab.

SUBMIT razuga01 WITH SELECTION-TABLE lt_seltab EXPORTING LIST TO MEMORY AND RETURN.

CALL FUNCTION 'LIST_FROM_MEMORY'
  TABLES
    listobject = xlist.

CALL FUNCTION 'LIST_TO_TXT'
  EXPORTING
    list_index         = -1
  TABLES
    listtxt            = xtext
    listobject         = xlist.
