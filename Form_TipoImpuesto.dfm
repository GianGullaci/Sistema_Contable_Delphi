object FTiposImpuesto: TFTiposImpuesto
  Left = 854
  Top = 375
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'FTiposImpuesto'
  ClientHeight = 543
  ClientWidth = 648
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 360
    Top = 8
    Width = 200
    Height = 24
    Caption = 'Listado de Impuestos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 16
    Top = 496
    Width = 52
    Height = 16
    Caption = 'Usuario: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object UsuarioRegistrado: TLabel
    Left = 80
    Top = 496
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 16
    Top = 472
    Width = 60
    Height = 16
    Caption = 'Empresa: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object NombreEmpresa: TLabel
    Left = 88
    Top = 472
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object BSalir: TButton
    Left = 504
    Top = 472
    Width = 129
    Height = 33
    Caption = 'Salir'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BSalirClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 289
    Height = 241
    Caption = 'Datos de Impuesto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 128
      Width = 67
      Height = 22
      Caption = 'Alicuota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 101
      Height = 22
      Caption = 'Descripci'#243'n'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object EAlicuota: TEdit
      Left = 144
      Top = 128
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object EDescripcion: TEdit
      Left = 144
      Top = 72
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object BGuardar: TButton
      Left = 96
      Top = 184
      Width = 89
      Height = 41
      Caption = 'Guardar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BGuardarClick
    end
  end
  object ListadoImpuestos: TStringGrid
    Left = 312
    Top = 48
    Width = 321
    Height = 401
    ColCount = 2
    DefaultColWidth = 40
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
