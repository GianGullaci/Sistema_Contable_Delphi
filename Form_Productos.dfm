object FProductos: TFProductos
  Left = 521
  Top = 443
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Productos'
  ClientHeight = 542
  ClientWidth = 779
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
    Left = 360
    Top = 24
    Width = 199
    Height = 24
    Caption = 'Listado de Productos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 16
    Top = 512
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
    Top = 512
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
    Top = 488
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
    Top = 488
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
    Left = 632
    Top = 488
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
    Top = 64
    Width = 289
    Height = 345
    Caption = 'Datos de Producto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 136
      Width = 119
      Height = 22
      Caption = 'Costo Unitario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 96
      Width = 75
      Height = 22
      Caption = 'Cantidad'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 56
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
    object Label9: TLabel
      Left = 16
      Top = 216
      Width = 80
      Height = 22
      Caption = 'Impuesto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 16
      Top = 256
      Width = 111
      Height = 22
      Caption = 'Impuesto Int.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 176
      Width = 100
      Height = 22
      Caption = 'Precio Neto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object ECostoUnit: TEdit
      Left = 144
      Top = 136
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
    object ECantidad: TEdit
      Left = 144
      Top = 96
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
    object ENombre: TEdit
      Left = 144
      Top = 56
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
      Top = 288
      Width = 89
      Height = 41
      Caption = 'Guardar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BGuardarClick
    end
    object CBImpuesto: TComboBox
      Left = 128
      Top = 216
      Width = 153
      Height = 22
      BiDiMode = bdLeftToRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ItemHeight = 14
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 4
    end
    object EImpuestoInt: TEdit
      Left = 144
      Top = 256
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object EPrecioNeto: TEdit
      Left = 144
      Top = 176
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
  end
  object ListadoProductos: TStringGrid
    Left = 328
    Top = 64
    Width = 433
    Height = 401
    DefaultColWidth = 40
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
  object BNuevo: TButton
    Left = 48
    Top = 8
    Width = 81
    Height = 41
    Caption = 'Nuevo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BNuevoClick
  end
  object BModificar: TButton
    Left = 168
    Top = 8
    Width = 89
    Height = 41
    Caption = 'Modificar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = BModificarClick
  end
end
