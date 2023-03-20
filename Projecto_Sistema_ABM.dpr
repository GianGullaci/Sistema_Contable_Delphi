program Projecto_Sistema_ABM;

uses
  Forms,
  Sistema_ABM in 'Sistema_ABM.pas' {FPrincipal},
  Unidad_Empresas in 'Unidad_Empresas.pas',
  Unidad_Aud_Perfiles in 'Unidad_Aud_Perfiles.pas',
  Form_Clientes in 'Form_Clientes.pas' {FClientes},
  Form_Provincias in 'Form_Provincias.pas' {FProvincias},
  Form_Ingreso in 'Form_Ingreso.pas' {FIngreso},
  Form_Usuarios in 'Form_Usuarios.pas' {FUsuarios},
  Form_Perfiles in 'Form_Perfiles.pas' {FPerfiles},
  Form_Listados_Auditorias in 'Form_Listados_Auditorias.pas' {FListAuditorias},
  Form_Aud_Perfiles in 'Form_Aud_Perfiles.pas' {FAudPerfiles},
  Form_Aud_Usuarios in 'Form_Aud_Usuarios.pas' {FAudUsuarios},
  Form_Aud_Provincias in 'Form_Aud_Provincias.pas' {FAudProvincias},
  Form_Aud_Clientes in 'Form_Aud_Clientes.pas' {FAudClientes},
  Form_Plan_de_Cuentas in 'Form_Plan_de_Cuentas.pas' {FPlanCuentas},
  Form_Asientos in 'Form_Asientos.pas' {FAsientos},
  Form_Reporte_Asientos in 'Form_Reporte_Asientos.pas' {FReporteAsientos},
  Form_Reporte_PDC in 'Form_Reporte_PDC.pas' {FReportePDC},
  Form_Reporte_Mayor in 'Form_Reporte_Mayor.pas' {FReporteMayor},
  Form_Reporte_Balance in 'Form_Reporte_Balance.pas' {FReporteBalance},
  Form_Localidades in 'Form_Localidades.pas' {FLocalidades},
  Form_TipoDocumento in 'Form_TipoDocumento.pas' {FTiposDocumento},
  Form_TipoComprobante in 'Form_TipoComprobante.pas' {FTiposComprobante},
  Form_TipoContribuyente in 'Form_TipoContribuyente.pas' {FTiposContribuyente},
  Form_TipoImpuesto in 'Form_TipoImpuesto.pas' {FTiposImpuesto},
  Form_Puntos_Venta in 'Form_Puntos_Venta.pas' {FPuntosVenta},
  Form_CondicionesComerciales in 'Form_CondicionesComerciales.pas' {FCondicionesComerciales},
  Form_Productos in 'Form_Productos.pas' {FProductos},
  Form_Comprobantes in 'Form_Comprobantes.pas' {FComprobante},
  Form_Reporte_Comprobantes in 'Form_Reporte_Comprobantes.pas' {FReporteComprobantes},
  Form_Consulta_Comprobantes in 'Form_Consulta_Comprobantes.pas' {FConsultaComprobantes},
  Form_Reporte_Listado_Comprobantes in 'Form_Reporte_Listado_Comprobantes.pas' {FListadoComprobantes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFIngreso, FIngreso);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFClientes, FClientes);
  Application.CreateForm(TFProvincias, FProvincias);
  Application.CreateForm(TFUsuarios, FUsuarios);
  Application.CreateForm(TFPerfiles, FPerfiles);
  Application.CreateForm(TFListAuditorias, FListAuditorias);
  Application.CreateForm(TFAudPerfiles, FAudPerfiles);
  Application.CreateForm(TFAudUsuarios, FAudUsuarios);
  Application.CreateForm(TFAudProvincias, FAudProvincias);
  Application.CreateForm(TFAudClientes, FAudClientes);
  Application.CreateForm(TFPlanCuentas, FPlanCuentas);
  Application.CreateForm(TFAsientos, FAsientos);
  Application.CreateForm(TFReporteAsientos, FReporteAsientos);
  Application.CreateForm(TFReportePDC, FReportePDC);
  Application.CreateForm(TFReporteMayor, FReporteMayor);
  Application.CreateForm(TFReporteBalance, FReporteBalance);
  Application.CreateForm(TFLocalidades, FLocalidades);
  Application.CreateForm(TFTiposDocumento, FTiposDocumento);
  Application.CreateForm(TFTiposComprobante, FTiposComprobante);
  Application.CreateForm(TFTiposContribuyente, FTiposContribuyente);
  Application.CreateForm(TFTiposImpuesto, FTiposImpuesto);
  Application.CreateForm(TFPuntosVenta, FPuntosVenta);
  Application.CreateForm(TFCondicionesComerciales, FCondicionesComerciales);
  Application.CreateForm(TFProductos, FProductos);
  Application.CreateForm(TFComprobante, FComprobante);
  Application.CreateForm(TFReporteComprobantes, FReporteComprobantes);
  Application.CreateForm(TFConsultaComprobantes, FConsultaComprobantes);
  Application.CreateForm(TFListadoComprobantes, FListadoComprobantes);
  Application.Run;
end.
