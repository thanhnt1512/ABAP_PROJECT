*&---------------------------------------------------------------------*
*& Include          ZPG_BC_DG_CONGNO_TOP
*&---------------------------------------------------------------------*
REPORT zpg_bc_dg_congno.
TABLES: knb1, acdoca, zev_cn.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_bukrs TYPE acdoca-rbukrs OBLIGATORY,
*              p_gjahr TYPE acdoca-gjahr OBLIGATORY,
            p_budat TYPE dats DEFAULT sy-datum,
            p_stt   TYPE zdd_ttpd.
SELECT-OPTIONS: s_kunnr FOR knb1-kunnr NO INTERVALS,
                s_segm  FOR acdoca-segment NO INTERVALS OBLIGATORY,
                s_prctr FOR acdoca-prctr,
                s_racct FOR acdoca-racct.
SELECTION-SCREEN END OF BLOCK b1.
TYPES: BEGIN OF gty_excel,
         prctr     TYPE string,
         segment   TYPE string,
         pstcode   TYPE string,
         ten_cn    TYPE string,
         kunnr     TYPE string,
         cpn_n1    TYPE string,
         cpn_n2    TYPE string,
         cpn_n3    TYPE string,
         cpn_n6    TYPE string,
         vpp_n1    TYPE string,
         vpp_n2    TYPE string,
         vpp_n3    TYPE string,
         vpp_n6    TYPE string,
         voso_n1   TYPE string,
         voso_n2   TYPE string,
         voso_n3   TYPE string,
         voso_n6   TYPE string,
         vtsale_n1 TYPE string,
         vtsale_n2 TYPE string,
         vtsale_n3 TYPE string,
         vtsale_n6 TYPE string,
         log_n1    TYPE string,
         log_n2    TYPE string,
         log_n3    TYPE string,
         log_n6    TYPE string,
         thoi_han  TYPE string,
       END OF gty_excel.

TYPES :BEGIN OF gty_fir048.
    INCLUDE STRUCTURE zst_fir048.
TYPES :cell_style  TYPE lvc_t_styl.
TYPES :cell_color  TYPE lvc_t_scol.
TYPES:END OF gty_fir048.

TYPES :BEGIN OF gty_fir045.
    INCLUDE STRUCTURE zst_fir045.
*TYPES :cell_style  TYPE lvc_t_styl.
TYPES :cell_color  TYPE lvc_t_scol.
TYPES:END OF gty_fir045.

TYPES : tt_fir048 TYPE TABLE OF gty_fir048,
        tt_fir045 TYPE TABLE OF gty_fir045.
DATA: gt_excel TYPE TABLE OF gty_excel,
      gs_excel TYPE gty_excel.

DATA: gt_dfies_tab TYPE TABLE OF dfies.
DATA: gt_data1       TYPE TABLE OF zst_fir045,
      gt_data        TYPE TABLE OF gty_fir045,
      gt_data_temp   TYPE TABLE OF gty_excel,
      gt_data_import TYPE TABLE OF gty_excel,
      gt_data_pd     TYPE TABLE OF zst_fir048,
      gs_data        TYPE zst_fir045.

DATA: g_alv              TYPE REF TO cl_gui_alv_grid,
      g_container_header TYPE REF TO cl_gui_container,
      g_doc_header       TYPE REF TO cl_dd_document.
DATA :gt_cong_no        TYPE TABLE OF zdn_congno,
      gw_postg_date_str TYPE string,
      gw_stt_str        TYPE string.
DATA : p_file TYPE rlgrap-filename.
DATA : gw_error TYPE char1.
FIELD-SYMBOLS: <fs_fieldcat> TYPE lvc_t_fcat.
DATA :ref TYPE REF TO data.
DATA :ref_val TYPE string.
DATA gt_container_0100 TYPE REF TO  cl_gui_custom_container.
DATA gt_container_0200 TYPE REF TO  cl_gui_custom_container.
DATA gt_container_main TYPE REF TO  cl_gui_custom_container.
DATA :gt_data_dn           TYPE TABLE OF gty_fir048,
      gt_data_import_valid TYPE TABLE OF gty_fir048.

*DATA :lo_cont_main TYPE REF TO cl_gui_container.
*DATA :lo_container TYPE ref to cl_gui_custom_container.
*DATA: lo_split TYPE ref to cl_gui_splitter_container.
CLASS lcl_event_handler DEFINITION.
  PUBLIC SECTION.
*    METHODS : handle_double_click FOR EVENT double_click OF cl_gui_alv_grid
*      IMPORTING e_row e_column es_row_no.
    METHODS : handle_add_toolbar_alv_0100 FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING e_object e_interactive.
    METHODS : handle_add_toolbar_alv_0200 FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING e_object e_interactive.
    METHODS : handle_add_toolbar_alv_0300 FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING e_object e_interactive.
    METHODS : handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING e_ucomm.
    METHODS:  handle_set_title FOR EVENT top_of_page OF cl_gui_alv_grid
      IMPORTING e_dyndoc_id.
ENDCLASS.
