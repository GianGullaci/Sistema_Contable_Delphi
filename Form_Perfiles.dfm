object FPerfiles: TFPerfiles
  Left = 1263
  Top = 468
  Width = 649
  Height = 566
  BorderIcons = []
  Caption = 'Perfiles'
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
    Height = 29
    Caption = 'Listado de Perfiles'
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
    Width = 58
    Height = 18
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
    Height = 18
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
    Width = 67
    Height = 18
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
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object BSalirPerfiles: TButton
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
    OnClick = BSalirPerfilesClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 289
    Height = 241
    Caption = 'Datos de Perfil'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 80
      Height = 26
      Caption = 'Nombre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 88
      Top = 72
      Width = 91
      Height = 26
      Caption = 'Permisos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object ENombrePerfil: TEdit
      Left = 144
      Top = 40
      Width = 121
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object BGuardarPerfil: TButton
      Left = 96
      Top = 192
      Width = 89
      Height = 41
      Caption = 'Guardar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BGuardarPerfilClick
    end
    object BGuardarModPerfil: TButton
      Left = 48
      Top = 192
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
      OnClick = BGuardarModPerfilClick
    end
    object BCancelarPerfil: TButton
      Left = 152
      Top = 192
      Width = 89
      Height = 41
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BCancelarPerfilClick
    end
    object HabilitarClientes: TCheckBox
      Left = 24
      Top = 96
      Width = 169
      Height = 17
      Caption = 'Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object HabilitarProvincias: TCheckBox
      Left = 24
      Top = 120
      Width = 169
      Height = 17
      Caption = 'Provincias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object HabilitarAuditoria: TCheckBox
      Left = 24
      Top = 144
      Width = 169
      Height = 17
      Caption = 'Auditor'#237'a'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object HabilitarUsuarios: TCheckBox
      Left = 152
      Top = 104
      Width = 113
      Height = 17
      Caption = 'Usuarios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object HabilitarPerfiles: TCheckBox
      Left = 152
      Top = 136
      Width = 105
      Height = 17
      Caption = 'Perfiles'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object HabilitarBackUp: TCheckBox
      Left = 24
      Top = 168
      Width = 97
      Height = 17
      Caption = 'BackUp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object HabilitarRestore: TCheckBox
      Left = 152
      Top = 168
      Width = 97
      Height = 17
      Caption = 'Restore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 264
    Width = 289
    Height = 185
    Caption = 'Modificar/Eliminar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 80
      Height = 26
      Caption = 'Nombre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
    end
    object EModificarPerfil: TEdit
      Left = 136
      Top = 72
      Width = 121
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object BModificarPerfil: TButton
      Left = 32
      Top = 120
      Width = 97
      Height = 41
      Caption = 'Modificar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BModificarPerfilClick
    end
    object BBorrarPerfil: TButton
      Left = 160
      Top = 120
      Width = 97
      Height = 41
      Caption = 'Borrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BBorrarPerfilClick
    end
  end
  object ListadoPerfiles: TStringGrid
    Left = 312
    Top = 48
    Width = 321
    Height = 401
    ColCount = 2
    DefaultColWidth = 60
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
