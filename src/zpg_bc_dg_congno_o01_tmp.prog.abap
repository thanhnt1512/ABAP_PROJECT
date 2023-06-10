*&---------------------------------------------------------------------*
*& Include          ZPG_BC_DG_CONGNO_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module INIT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_0100 OUTPUT.
  PERFORM setup_alv USING 'ALV_0100' 'ZST_FIR045' CHANGING gt_container_0100 gt_data.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_STATUS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_status OUTPUT.
  SET PF-STATUS 'STT_0100'.
*  SET TITLEBAR 'TT_0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_0200 OUTPUT.
  PERFORM setup_alv USING 'ALV_0200' 'ZST_FIR048' CHANGING gt_container_0200 gt_data_import_valid.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'STT_0200'.
*  SET TITLEBAR 'TT_0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_0300 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_0300 OUTPUT.
  PERFORM setup_alv USING 'ALV_0300' 'ZST_FIR048' CHANGING gt_container_0200 gt_data_import_valid.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0300 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'STT_0300'.
* SET TITLEBAR 'xxx'.
ENDMODULE.