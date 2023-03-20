object FClientes: TFClientes
  Left = 181
  Top = 457
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Clientes'
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
    Width = 180
    Height = 24
    Caption = 'Listado de Clientes'
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
  object BSalirClientes: TButton
    Left = 624
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
    OnClick = BSalirClientesClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 64
    Width = 289
    Height = 401
    Caption = 'Datos de Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 160
      Width = 33
      Height = 22
      Caption = 'DNI'
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
      Width = 78
      Height = 22
      Caption = 'Domicilio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 64
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
    object Label4: TLabel
      Left = 16
      Top = 192
      Width = 77
      Height = 22
      Caption = 'Provincia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 32
      Width = 48
      Height = 22
      Caption = 'Clave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 16
      Top = 224
      Width = 82
      Height = 22
      Caption = 'Localidad'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 16
      Top = 128
      Width = 82
      Height = 22
      Caption = 'Tipo Doc.'
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
      Width = 74
      Height = 22
      Caption = 'Tel'#233'fono'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 16
      Top = 288
      Width = 46
      Height = 22
      Caption = 'EMail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 16
      Top = 320
      Width = 108
      Height = 22
      Caption = 'Tipo Contrib.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object EDni: TEdit
      Left = 144
      Top = 160
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object EDomicilio: TEdit
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
      TabOrder = 2
    end
    object ENombre: TEdit
      Left = 144
      Top = 64
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
    object CBProvincia: TComboBox
      Left = 128
      Top = 192
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
      TabOrder = 5
      OnChange = CBProvinciaChange
    end
    object BGuardarCliente: TButton
      Left = 96
      Top = 352
      Width = 89
      Height = 41
      Caption = 'Guardar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = BGuardarClienteClick
    end
    object EClave: TEdit
      Left = 144
      Top = 32
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
    object CBLocalidad: TComboBox
      Left = 128
      Top = 224
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
      TabOrder = 6
    end
    object CBTipoDoc: TComboBox
      Left = 128
      Top = 128
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
      TabOrder = 3
    end
    object ETelefono: TEdit
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
      TabOrder = 7
    end
    object EMail: TEdit
      Left = 144
      Top = 288
      Width = 121
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object CBTipoContrib: TComboBox
      Left = 128
      Top = 320
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
      TabOrder = 9
    end
  end
  object ListadoClientes: TStringGrid
    Left = 320
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
