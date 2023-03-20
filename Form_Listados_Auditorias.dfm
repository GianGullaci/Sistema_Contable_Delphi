object FListAuditorias: TFListAuditorias
  Left = 854
  Top = 225
  Width = 514
  Height = 474
  BorderIcons = []
  Caption = 'Auditor'#237'as'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 136
    Top = 8
    Width = 262
    Height = 55
    Caption = 'AUDITORIAS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 16
    Top = 418
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
    Top = 418
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
    Top = 396
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
    Top = 396
    Width = 4
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object BAudClientes: TButton
    Left = 8
    Top = 72
    Width = 153
    Height = 153
    Caption = 'Clientes'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BAudClientesClick
  end
  object BAudProvincias: TButton
    Left = 176
    Top = 72
    Width = 153
    Height = 153
    Caption = 'Provincias'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BAudProvinciasClick
  end
  object BAudUsuarios: TButton
    Left = 344
    Top = 72
    Width = 153
    Height = 153
    Caption = 'Usuarios'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = BAudUsuariosClick
  end
  object BAudPerfiles: TButton
    Left = 96
    Top = 232
    Width = 153
    Height = 153
    Caption = 'Perfiles'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = BAudPerfilesClick
  end
  object BAudSalir: TButton
    Left = 264
    Top = 232
    Width = 153
    Height = 153
    Caption = 'Salir'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = BAudSalirClick
  end
end
