*&---------------------------------------------------------------------*
*& Report ZPG_TEST_ZCLVOFF
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_TEST_ZCLVOFF.
DATA :lw_publicKey TYPE STRING.
lw_publicKey = 'ABC'.
DATA(OBJ_VOFF2SAP) = new ZCL_VOFF2SAP( aeskey = '540096fba3662e658ed8314693a5e26bVIAESKEYSPACE062338831fa9f2cb8' publicrsakey = lw_publickey ).
DATA :LS_DATA_LOGIN TYPE ZDT_LOGIN_OUT.
  LS_DATA_LOGIN   = OBJ_VOFF2SAP->login( password = '222222a@' vof2Key = '222222a@' loginName = 'tuandn5' deviceName = 'Trinh ky tu dong').
