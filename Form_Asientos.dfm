object FAsientos: TFAsientos
  Left = 550
  Top = 111
  Width = 1347
  Height = 717
  BorderIcons = []
  Caption = 'Asientos'
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
  object BSalir: TButton
    Left = 704
    Top = 640
    Width = 123
    Height = 33
    Caption = 'Salir'
    Font.Charset = GREEK_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BSalirClick
  end
  object PanelAsiento: TPanel
    Left = 24
    Top = 48
    Width = 441
    Height = 81
    Enabled = False
    TabOrder = 1
    object Label1: TLabel
      Left = 72
      Top = 16
      Width = 38
      Height = 16
      Caption = 'Fecha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 168
      Top = 16
      Width = 48
      Height = 16
      Caption = 'N'#250'mero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 256
      Top = 16
      Width = 68
      Height = 16
      Caption = 'Tipo (1/5/9)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EFecha: TMaskEdit
      Left = 48
      Top = 40
      Width = 86
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
    end
    object ENumero: TEdit
      Left = 160
      Top = 40
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object ETipo: TEdit
      Left = 256
      Top = 40
      Width = 65
      Height = 21
      TabOrder = 2
    end
    object BCargarAsiento: TButton
      Left = 352
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Cargar'
      TabOrder = 3
      OnClick = BCargarAsientoClick
    end
  end
  object PanelOperaciones: TPanel
    Left = 24
    Top = 152
    Width = 801
    Height = 201
    Enabled = False
    TabOrder = 2
    object Label4: TLabel
      Left = 24
      Top = 16
      Width = 32
      Height = 16
      Caption = 'Pase'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 80
      Top = 16
      Width = 42
      Height = 16
      Caption = 'Cuenta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 192
      Top = 16
      Width = 62
      Height = 16
      Caption = 'Fecha Op.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 296
      Top = 16
      Width = 64
      Height = 16
      Caption = 'Fecha Vto.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 416
      Top = 16
      Width = 59
      Height = 16
      Caption = 'Comprob.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 520
      Top = 16
      Width = 26
      Height = 16
      Caption = 'Suc.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 568
      Top = 16
      Width = 34
      Height = 16
      Caption = 'Secc.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 672
      Top = 16
      Width = 45
      Height = 16
      Caption = 'Importe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 616
      Top = 16
      Width = 24
      Height = 16
      Caption = 'D/H'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 24
      Top = 104
      Width = 45
      Height = 16
      Caption = 'Cuenta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object NombreCuenta: TLabel
      Left = 80
      Top = 104
      Width = 99
      Height = 17
      Align = alCustom
      Caption = 'NombreCuenta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Montserrat SemiBold'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label14: TLabel
      Left = 24
      Top = 136
      Width = 56
      Height = 16
      Caption = 'Leyenda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EPase: TEdit
      Left = 24
      Top = 40
      Width = 33
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object ECuenta: TEdit
      Left = 72
      Top = 40
      Width = 57
      Height = 21
      TabOrder = 1
      OnExit = ECuentaExit
    end
    object EDV: TEdit
      Left = 136
      Top = 40
      Width = 33
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object EFechaOp: TMaskEdit
      Left = 184
      Top = 40
      Width = 86
      Height = 21
      Enabled = False
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
    end
    object EFechaVto: TMaskEdit
      Left = 288
      Top = 40
      Width = 86
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
    end
    object EComprob: TEdit
      Left = 392
      Top = 40
      Width = 113
      Height = 21
      TabOrder = 5
    end
    object ESuc: TEdit
      Left = 520
      Top = 40
      Width = 33
      Height = 21
      TabOrder = 6
      Text = '0'
    end
    object ESecc: TEdit
      Left = 568
      Top = 40
      Width = 33
      Height = 21
      TabOrder = 7
      Text = '0'
    end
    object EImporte: TEdit
      Left = 664
      Top = 40
      Width = 113
      Height = 21
      TabOrder = 9
      Text = '0.00'
    end
    object EDH: TEdit
      Left = 616
      Top = 40
      Width = 33
      Height = 21
      TabOrder = 8
      Text = '0'
    end
    object ELeyenda: TEdit
      Left = 88
      Top = 136
      Width = 433
      Height = 21
      TabOrder = 10
    end
    object Panel1: TPanel
      Left = 568
      Top = 88
      Width = 217
      Height = 97
      TabOrder = 11
      object Label15: TLabel
        Left = 9
        Top = 8
        Width = 71
        Height = 16
        Caption = 'Total Debe:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 9
        Top = 40
        Width = 75
        Height = 16
        Caption = 'Total Haber:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 41
        Top = 72
        Width = 39
        Height = 16
        Caption = 'Saldo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LTotalDebe: TLabel
        Left = 186
        Top = 8
        Width = 28
        Height = 17
        Align = alCustom
        Alignment = taRightJustify
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Montserrat SemiBold'
        Font.Style = []
        ParentFont = False
      end
      object LTotalHaber: TLabel
        Left = 186
        Top = 40
        Width = 28
        Height = 17
        Align = alCustom
        Alignment = taRightJustify
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Montserrat SemiBold'
        Font.Style = []
        ParentFont = False
      end
      object LSaldo: TLabel
        Left = 186
        Top = 72
        Width = 28
        Height = 17
        Align = alCustom
        Alignment = taRightJustify
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Montserrat SemiBold'
        Font.Style = []
        ParentFont = False
      end
    end
    object BCargarOp: TButton
      Left = 528
      Top = 136
      Width = 33
      Height = 25
      Caption = 'OK'
      TabOrder = 12
      OnClick = BCargarOpClick
    end
  end
  object ListadoOperaciones: TStringGrid
    Left = 24
    Top = 368
    Width = 801
    Height = 257
    TabOrder = 3
  end
  object BNuevo: TButton
    Left = 32
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Nuevo'
    TabOrder = 4
    OnClick = BNuevoClick
  end
  object BRetomar: TButton
    Left = 120
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Retomar'
    TabOrder = 5
    OnClick = BRetomarClick
  end
  object ListadoPlan: TStringGrid
    Left = 840
    Top = 152
    Width = 464
    Height = 401
    DefaultColWidth = 56
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Montserrat SemiBold'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
    ParentFont = False
    TabOrder = 6
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object BListar: TButton
    Left = 384
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Listar'
    TabOrder = 7
    OnClick = BListarClick
  end
  object BMayor: TButton
    Left = 472
    Top = 8
    Width = 89
    Height = 25
    Caption = 'Mayor de Cuenta'
    TabOrder = 8
    OnClick = BMayorClick
  end
  object BRegistrar: TButton
    Left = 296
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Registrar'
    TabOrder = 9
    OnClick = BRegistrarClick
  end
  object BModificar: TButton
    Left = 208
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Modificar'
    TabOrder = 10
    OnClick = BModificarClick
  end
  object ListadoMayor: TStringGrid
    Left = 1344
    Top = 152
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
    TabOrder = 11
    Visible = False
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object ListadoBalance: TStringGrid
    Left = 1344
    Top = 240
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
    TabOrder = 12
    Visible = False
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object BBalance: TButton
    Left = 576
    Top = 8
    Width = 89
    Height = 25
    Caption = 'Balance'
    TabOrder = 13
    OnClick = BBalanceClick
  end
end
