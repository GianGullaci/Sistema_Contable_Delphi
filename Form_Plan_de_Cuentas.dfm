object FPlanCuentas: TFPlanCuentas
  Left = 205
  Top = 449
  Width = 877
  Height = 603
  BorderIcons = []
  Caption = 'Plan de Cuentas'
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
  object Label6: TLabel
    Left = 416
    Top = 8
    Width = 258
    Height = 24
    Caption = 'Listado de Plan de Cuentas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object BSalir: TButton
    Left = 656
    Top = 520
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
    Left = 24
    Top = 64
    Width = 321
    Height = 305
    Caption = 'Datos Plan de Cuenta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 48
      Width = 62
      Height = 22
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 88
      Width = 67
      Height = 22
      Caption = 'N'#250'mero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 128
      Width = 35
      Height = 22
      Caption = 'D.V.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 168
      Width = 68
      Height = 22
      Caption = 'Nombre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 208
      Width = 37
      Height = 22
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object ECodigo: TEdit
      Left = 136
      Top = 48
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
    object ENumero: TEdit
      Left = 136
      Top = 88
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
    object EDV: TEdit
      Left = 136
      Top = 128
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object ENombre: TEdit
      Left = 136
      Top = 168
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object BGuardarPlan: TButton
      Left = 112
      Top = 248
      Width = 89
      Height = 41
      Caption = 'Guardar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BGuardarPlanClick
    end
    object CBTipo: TComboBox
      Left = 136
      Top = 208
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 5
      Items.Strings = (
        '0'
        '1')
    end
  end
  object ListadoPlan: TStringGrid
    Left = 376
    Top = 48
    Width = 481
    Height = 401
    DefaultColWidth = 56
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
    ParentFont = False
    TabOrder = 2
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object BListar: TButton
    Left = 512
    Top = 520
    Width = 129
    Height = 33
    Caption = 'Listar'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BListarClick
  end
  object BNuevo: TButton
    Left = 64
    Top = 8
    Width = 89
    Height = 41
    Caption = 'Nuevo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = BNuevoClick
  end
  object BModificar: TButton
    Left = 200
    Top = 8
    Width = 97
    Height = 41
    Caption = 'Modificar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BModificarClick
  end
end
