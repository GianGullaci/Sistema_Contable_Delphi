object FPrincipal: TFPrincipal
  Left = 208
  Top = 564
  Width = 634
  Height = 524
  BorderIcons = []
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Titulo_Empresa: TLabel
    Left = 0
    Top = 0
    Width = 618
    Height = 45
    Align = alTop
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 432
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
    Top = 432
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 112
    Top = 184
    Width = 383
    Height = 36
    Caption = 'SISTEMA DE GESTI'#211'N'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Modern No. 20'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BSalir: TButton
    Left = 440
    Top = 384
    Width = 113
    Height = 65
    Caption = 'Salir'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BSalirClick
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Archivo BackUp|*.bck'
    Left = 320
    Top = 424
  end
  object MainMenu1: TMainMenu
    Left = 352
    Top = 424
    object Productos1: TMenuItem
      Caption = 'Productos'
      OnClick = Productos1Click
    end
    object Clientes1: TMenuItem
      Caption = 'Clientes'
      OnClick = Clientes1Click
    end
    object Auditorias1: TMenuItem
      Caption = 'Auditorias'
      OnClick = Auditorias1Click
    end
    object Respaldo1: TMenuItem
      Caption = 'Respaldo'
      object BackUp1: TMenuItem
        Caption = 'BackUp'
        OnClick = BackUp1Click
      end
      object Restore1: TMenuItem
        Caption = 'Restore'
        OnClick = Restore1Click
      end
    end
    object GestinContable1: TMenuItem
      Caption = 'Gesti'#243'n Contable'
      object PlandeCuentas1: TMenuItem
        Caption = 'Plan de Cuentas'
        OnClick = PlandeCuentas1Click
      end
      object Asientos1: TMenuItem
        Caption = 'Asientos'
        OnClick = Asientos1Click
      end
    end
    object Comprobante1: TMenuItem
      Caption = 'Comprobantes'
      object NuevoComprobante1: TMenuItem
        Caption = 'Nuevo Comprobante'
        OnClick = NuevoComprobante1Click
      end
      object ConsultaComprobantes1: TMenuItem
        Caption = 'Consulta Comprobantes'
        OnClick = ConsultaComprobantes1Click
      end
    end
    object MenAuxiliar1: TMenuItem
      Caption = 'Men'#250' Auxiliar'
      object Provincias1: TMenuItem
        Caption = 'Provincias'
        OnClick = Provincias1Click
      end
      object Localidades1: TMenuItem
        Caption = 'Localidades'
        OnClick = Localidades1Click
      end
      object iposDocumento1: TMenuItem
        Caption = 'Tipos Documento'
        OnClick = iposDocumento1Click
      end
      object TiposComprobante1: TMenuItem
        Caption = 'Tipos Comprobante'
        OnClick = TiposComprobante1Click
      end
      object iposContribuyente1: TMenuItem
        Caption = 'Tipos Contribuyente'
        OnClick = iposContribuyente1Click
      end
      object iposImpuesto1: TMenuItem
        Caption = 'Tipos Impuesto'
        OnClick = iposImpuesto1Click
      end
      object PuntosVenta1: TMenuItem
        Caption = 'Puntos de Venta'
        OnClick = PuntosVenta1Click
      end
      object CondicionesComerciales1: TMenuItem
        Caption = 'Condiciones Comerciales'
        OnClick = CondicionesComerciales1Click
      end
    end
    object ABMUsuarios1: TMenuItem
      Caption = 'Usuarios'
      object Usuarios1: TMenuItem
        Caption = 'Usuarios'
        OnClick = Usuarios1Click
      end
      object Perfiles1: TMenuItem
        Caption = 'Perfiles'
        OnClick = Perfiles1Click
      end
    end
  end
end
