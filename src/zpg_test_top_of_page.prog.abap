*&---------------------------------------------------------------------*
*& Report ZPG_TEST_TOP_OF_PAGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_test_top_of_page.
TABLES: marc.

DATA: BEGIN OF itab OCCURS 0.
    INCLUDE STRUCTURE marc.
DATA: END OF itab.


*--ALV Grid
DATA: ok_code LIKE sy-ucomm.
DATA: custom_container TYPE REF TO cl_gui_custom_container.
DATA: mycontainer TYPE scrfname VALUE 'ALV_CONTAINER'.
DATA: gr_grid TYPE REF TO cl_gui_alv_grid.
DATA: gr_docking_container TYPE REF TO cl_gui_docking_container.
DATA: gt_fieldcat TYPE lvc_t_fcat WITH HEADER LINE.
DATA: ls_fcat TYPE lvc_s_fcat .
DATA: lt_fieldcat_slis TYPE slis_t_fieldcat_alv.
DATA: gs_layout TYPE lvc_s_layo.
DATA: gr_document TYPE REF TO cl_dd_document.
DATA: line_header TYPE sdydo_text_element.


*----- selection-screen
SELECTION-SCREEN: BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR marc-matnr,
 s_werks FOR marc-werks.
SELECTION-SCREEN: END OF BLOCK a1.


*---- start-of-selection
START-OF-SELECTION.


*-- read data into internal table
  PERFORM get_data.

  CHECK itab[] IS NOT INITIAL.

  CALL SCREEN 100.



END-OF-SELECTION.
*&---------------------------------------------------------------------

*& Form GET_DATA
*&---------------------------------------------------------------------

* text
*----------------------------------------------------------------------

* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------

FORM get_data .


  SELECT * INTO CORRESPONDING FIELDS OF TABLE itab
  FROM marc
  WHERE matnr IN s_matnr
  AND werks IN s_werks.

ENDFORM. " GET_DATA
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS_100'.

  PERFORM display_table.




ENDMODULE. " STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*& Module USER_COMMAND_0100 INPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'. "Go Back
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      CALL METHOD custom_container->free.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

  CLEAR ok_code.

ENDMODULE. " USER_COMMAND_0100 INPUT
*&---------------------------------------------------------------------*
*& Form DISPLAY_TABLE
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM display_table .

  IF custom_container IS INITIAL.
* create container
    CREATE OBJECT custom_container
      EXPORTING
        container_name              = mycontainer
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5.
    IF sy-subrc <> 0.
      MESSAGE ' erreur container' TYPE 'I'.
    ENDIF.
* create alv grid
    CREATE OBJECT gr_grid
      EXPORTING
        i_parent          = custom_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      MESSAGE ' erreur grid' TYPE 'I'.
    ENDIF.

* prepare Header
    PERFORM prepare_header.
* Prepare Footer
    PERFORM prepare_footer.
* prepare fielfcatalog
    PERFORM prepar_catalog.
* prepare layout
    PERFORM prepar_layout.
* fist display
    PERFORM first_display.

  ELSE .
    CALL METHOD gr_grid->refresh_table_display
      EXCEPTIONS
        finished = 1
        OTHERS   = 2.
  ENDIF.


ENDFORM. " DISPLAY_TABLE
*&---------------------------------------------------------------------*
*& Form PREPAR_CATALOG
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM prepar_catalog .

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-repid
      i_internal_tabname     = 'ITAB'
      i_client_never_display = 'X'
      i_inclname             = sy-repid
    CHANGING
      ct_fieldcat            = lt_fieldcat_slis.

  CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
    EXPORTING
      it_fieldcat_alv = lt_fieldcat_slis
    IMPORTING
      et_fieldcat_lvc = gt_fieldcat[]
    TABLES
      it_data         = itab[]
    EXCEPTIONS
      it_data_missing = 1
      OTHERS          = 2.


ENDFORM. " PREPAR_CATALOG
*&---------------------------------------------------------------------*
*& Form PREPAR_LAYOUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM prepar_layout .

  gs_layout-zebra = 'X' .
  gs_layout-smalltitle = 'X'.

ENDFORM. " PREPAR_LAYOUT
*&---------------------------------------------------------------------*
*& Form FIRST_DISPLAY
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM first_display .

  CALL METHOD gr_grid->set_table_for_first_display
    EXPORTING
      is_layout                     = gs_layout
      i_default                     = 'X'
    CHANGING
      it_fieldcatalog               = gt_fieldcat[]
      it_outtab                     = itab[]
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.

ENDFORM. " FIRST_DISPLAY
*&---------------------------------------------------------------------*
*& Form PREPARE_HEADER
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM prepare_header .

  CREATE OBJECT gr_docking_container
    EXPORTING
      repid = sy-repid
      dynnr = '0100'
      ratio = 20
      side  = gr_docking_container->dock_at_top.

  CREATE OBJECT gr_document.


  PERFORM add_line USING 'Day :' sy-datum.
  PERFORM add_line USING 'Time :' sy-uzeit.


  CALL METHOD gr_document->display_document
    EXPORTING
      parent = gr_docking_container.

ENDFORM. " PREPARE_HEADER
*&---------------------------------------------------------------------*
*& Form ADD_LINE
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* -->P_0363 text
* -->P_SY_DATUM text
*----------------------------------------------------------------------*
FORM add_line USING text1
 text2.
  CLEAR line_header.
  CONCATENATE text1 text2
  INTO line_header RESPECTING BLANKS.

  CALL METHOD gr_document->add_text
    EXPORTING
      text         = line_header
      sap_fontsize = cl_dd_document=>medium
      sap_emphasis = cl_dd_document=>strong.

  CALL METHOD gr_document->new_line.

ENDFORM. "add_line
*&---------------------------------------------------------------------*
*& Form PREPARE_FOOTER
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM prepare_footer .

  CREATE OBJECT gr_docking_container
    EXPORTING
      repid = sy-repid
      dynnr = '0100'
      ratio = 10
      side  = gr_docking_container->dock_at_bottom.

  CREATE OBJECT gr_document.


  PERFORM add_line USING 'Program Name :' sy-repid.



  CALL METHOD gr_document->display_document
    EXPORTING
      parent = gr_docking_container.

ENDFORM. " PREPARE_FOOTER
