*&---------------------------------------------------------------------*
*& Report ZPG_TEST_TOP_OF_PAGE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_test_top_of_page2.
DATA : it_spfli TYPE TABLE OF spfli,
       wa_spfli TYPE spfli,
       o_cust   TYPE REF TO cl_gui_custom_container,
       o_spli   TYPE REF TO cl_gui_splitter_container,
       o_ref1   TYPE REF TO cl_gui_container,
       o_ref2   TYPE REF TO cl_gui_container,
       o_alv    TYPE REF TO cl_gui_alv_grid,
       o_docu   TYPE REF TO cl_dd_document,
       ok_code  TYPE sy-ucomm.
CLASS handle_event DEFINITION.
  PUBLIC SECTION.

    CLASS-METHODS : page_head FOR EVENT

      top_of_page OF cl_gui_alv_grid

      IMPORTING e_dyndoc_id table_index.


ENDCLASS.
CLASS handle_event IMPLEMENTATION.

  METHOD page_head.
    DATA : text TYPE sdydo_text_element.
    text = 'FLIGHT DETAILS'.
    CALL METHOD o_docu->add_text
      EXPORTING
        text         = text
        sap_color    = cl_dd_document=>list_positive
        sap_fontsize = cl_dd_document=>large.

    CALL METHOD o_docu->add_picture
      EXPORTING
        picture_id = 'HEADER'.
    CALL METHOD o_docu->display_document
      EXPORTING
        parent = o_ref1.


  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  PERFORM fetch_data_from_spfli.
  CALL SCREEN 100.
*&———————————————————————*
FORM fetch_data_from_spfli .
  SELECT * FROM spfli INTO TABLE it_spfli.
ENDFORM.
*&———————————————————————*

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS'.
  SET TITLEBAR 'TITLE'.
ENDMODULE.

*———————————————————————-*
MODULE split_container OUTPUT.
  IF o_cust IS NOT BOUND.
    CREATE OBJECT o_cust
      EXPORTING
        container_name = 'CONTAINER'.
    CREATE OBJECT o_spli
      EXPORTING
        parent  = o_cust
        rows    = 2
        columns = 1.
    CALL METHOD o_spli->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = o_ref1.
    CALL METHOD o_spli->set_row_height
      EXPORTING
        id     = 1
        height = 35.
    CALL METHOD o_spli->get_container
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = o_ref2.

    CREATE OBJECT o_docu
      EXPORTING
        style = 'ALV_GRID'.
  ENDIF.
ENDMODULE.
*———————————————————————-*
MODULE display_alv OUTPUT.
  IF o_alv IS NOT BOUND.
    CREATE OBJECT o_alv
      EXPORTING
        i_parent = o_ref2.

    SET HANDLER handle_event=>page_head FOR o_alv.

    CALL METHOD o_alv->set_table_for_first_display
      EXPORTING
        i_structure_name = 'SPFLI'
      CHANGING
        it_outtab        = it_spfli.

    CALL METHOD o_alv->list_processing_events
      EXPORTING
        i_event_name = 'TOP_OF_PAGE'
        i_dyndoc_id  = o_docu.
  ENDIF.
ENDMODULE.
*———————————————————————-*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
