object FConsultaComprobantes: TFConsultaComprobantes
  Left = 452
  Top = 302
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Consulta Comprobantes'
  ClientHeight = 641
  ClientWidth = 824
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 20
  object GroupBox1: TGroupBox
    Left = 248
    Top = 32
    Width = 321
    Height = 233
    Caption = 'Consulta Comprobantes'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 108
      Height = 16
      Caption = 'Fecha de Emisi'#243'n'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 120
      Width = 82
      Height = 16
      Caption = 'Comprobante'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 47
      Height = 16
      Caption = 'Desde'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 168
      Top = 72
      Width = 42
      Height = 16
      Caption = 'Hasta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 152
      Width = 33
      Height = 16
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EFechaDesde: TMaskEdit
      Left = 72
      Top = 73
      Width = 86
      Height = 24
      EditMask = '!99/99/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
    end
    object EFechaHasta: TMaskEdit
      Left = 224
      Top = 73
      Width = 86
      Height = 24
      EditMask = '!99/99/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
    end
    object CBTipoComp: TComboBox
      Left = 72
      Top = 152
      Width = 185
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 2
    end
    object BBuscar: TButton
      Left = 120
      Top = 192
      Width = 75
      Height = 25
      Caption = 'Buscar'
      TabOrder = 3
      OnClick = BBuscarClick
    end
  end
  object BSalir: TButton
    Left = 432
    Top = 560
    Width = 113
    Height = 65
    Caption = 'Salir'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BSalirClick
  end
  object ListadoComprobantes: TStringGrid
    Left = 63
    Top = 320
    Width = 690
    Height = 185
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object BImprimir: TButton
    Left = 296
    Top = 560
    Width = 113
    Height = 65
    Caption = 'Imprimir'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BImprimirClick
  end
end
