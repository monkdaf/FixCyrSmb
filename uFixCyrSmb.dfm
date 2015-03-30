object fFixCyrSmb: TfFixCyrSmb
  Left = 260
  Top = 154
  Width = 803
  Height = 654
  Caption = 
    #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077' '#1082#1080#1088#1080#1083#1080#1095#1077#1089#1082#1080#1093' '#1089#1080#1084#1074#1086#1083#1086#1074' '#1074' '#1083#1072#1090#1080#1085#1089#1082#1080#1077' '#1089#1080#1084#1074#1086#1083#1099' '#1074' '#1090#1072#1073#1083#1080 +
    #1094#1077' '#1089#1080#1084#1074#1086#1083#1086#1074' v0.2 (build 140317)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    787
    616)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 349
    Top = 347
    Width = 94
    Height = 16
    Anchors = [akTop]
    Caption = '<=   '#1048#1051#1048'   =>'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 19
    Width = 17
    Height = 19
    Caption = '1)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 8
    Top = 347
    Width = 17
    Height = 19
    Caption = '2)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 8
    Top = 579
    Width = 17
    Height = 19
    Anchors = [akLeft, akBottom]
    Caption = '3)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bOpenPLC: TButton
    Left = 32
    Top = 8
    Width = 161
    Height = 41
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083' '#13#10#1090#1072#1073#1083#1080#1094#1099' '#1089#1080#1084#1074#1086#1083#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    WordWrap = True
    OnClick = bOpenPLCClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 56
    Width = 770
    Height = 273
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object bClose: TBitBtn
    Left = 601
    Top = 568
    Width = 160
    Height = 41
    Anchors = [akRight, akBottom]
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    Kind = bkClose
  end
  object Memo2: TMemo
    Left = 8
    Top = 384
    Width = 481
    Height = 177
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Memo3: TMemo
    Left = 321
    Top = 8
    Width = 441
    Height = 41
    Anchors = [akTop, akRight]
    Lines.Strings = (
      
        #39'ABCEHKMOPTXaceoxy'#39', -- '#1082#1080#1088#1080#1083#1083#1080#1095#1077#1089#1082#1080'e '#1073#1091#1082#1074#1099' '#1082#1086#1090#1086#1088#1099#1077' '#1074#1099#1075#1083#1103#1076#1103#1090' '#1082#1072#1082 +
        ' '#1072#1085#1075#1083#1080#1081#1089#1082#1080'e'
      
        #39'ABCEHKMOPTXaceoxy'#39'  -- '#1072#1085#1075#1083#1080#1081#1089#1082#1080'e '#1073#1091#1082#1074#1099' '#1082#1086#1090#1086#1088#1099#1077' '#1074#1099#1075#1083#1103#1076#1103#1090' '#1082#1072#1082' '#1082#1080 +
        #1088#1080#1083#1083#1080#1095#1077#1089#1082#1080'e')
    TabOrder = 4
  end
  object bCyrToLat: TButton
    Left = 32
    Top = 336
    Width = 297
    Height = 41
    Caption = 
      #1050#1080#1088#1080#1083#1080#1095#1077#1089#1082#1080#1077' '#1089#1080#1084#1074#1086#1083#1099' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' "'#1087#1086#1093#1086#1078#1080#1077'" '#1083#1072#1090#1080#1085#1089#1082#1080#1077' '#1089#1080#1084#1074#1086#1083#1099 +
      ' ('#1058#1054#1051#1068#1050#1054' '#1048#1061'!)'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    WordWrap = True
    OnClick = bCyrToLatClick
  end
  object bTranslit: TButton
    Left = 464
    Top = 336
    Width = 298
    Height = 41
    Anchors = [akTop, akRight]
    Caption = #1058#1088#1072#1085#1089#1083#1080#1090#1080#1088#1080#1088#1086#1074#1072#1090#1100' '#1082#1080#1088#1080#1083#1080#1095#1077#1089#1082#1080#1077' '#1089#1080#1084#1074#1086#1083#1099' '#1074' '#1083#1072#1090#1080#1085#1089#1082#1080#1077' '#1089#1080#1084#1074#1086#1083#1099
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = bTranslitClick
  end
  object bSaveSmblTbl: TButton
    Left = 32
    Top = 568
    Width = 160
    Height = 41
    Anchors = [akLeft, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1072#1081#1083' '#13#10#1090#1072#1073#1083#1080#1094#1099' '#1089#1080#1084#1074#1086#1083#1086#1074
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    WordWrap = True
    OnClick = bSaveSmblTblClick
  end
  object mmoLog: TMemo
    Left = 496
    Top = 384
    Width = 281
    Height = 177
    Anchors = [akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 8
  end
  object OpenDialogPLC: TOpenDialog
    Filter = #1058#1072#1073#1083#1080#1094#1072' '#1089#1080#1084#1074#1086#1083#1086#1074' S7|*.sdf'
    Left = 704
    Top = 16
  end
end
