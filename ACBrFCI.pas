{ ****************************************************************************** }
{ Projeto: Componentes ACBr }
{ Biblioteca de componentes Delphi para geração e leitura de arquivos FCI }
{ Ficha de Conteúdo de Importação. Versão do Manual: 1.0.8 (20/02/2014) }
{ }
{ Direitos Autorais Reservados (c) 2020 }
{ Valter Patrick Silva Ferreira - valterpatrick@hotmail.com }
{ }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor }
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT) }
{ }
{ ****************************************************************************** }

{ ******************************************************************************
  |* Histórico
  |*
  |* 21/09/2020: Valter Patrick Silva Ferreira
  |*  - Criação e distribuição da Primeira Versão
  ****************************************************************************** }

unit ACBrFCI;

interface

uses Classes, SysUtils, Contnrs, StrUtils, Math;

const
  TEXTO_PADRAO_UTF8 = 'Texto em caracteres UTF-8: (dígrafo BR)''ção'',(dígrafo espanhol-enhe)''ñ'',(trema)''Ü'',(ordinais)''ªº'',(ligamento s+z alemão)''ß''.';
  VERSAO_LEIAUTE = '1.0';
  PIPE = '|';

type
  { Lista das Unidades de Medidas aceitas }
  TACBrUnidadeMedida = (
    umA,
    umAh,
    umASTM,
    umBq,
    um0C,
    umCCD,
    umCg,
    umCm,
    umCm2,
    umCm3,
    umCN,
    umCSt,
    umDCI,
    umG,
    umGbit,
    umGHz,
    umH,
    umHP,
    umHRC,
    umHz,
    umISO,
    umIV,
    umKbit,
    umKcal,
    umKg,
    umKgf,
    umKHz,
    umKN,
    umKPa,
    umKV,
    umKVA,
    umKvar,
    umKW,
    umI,
    umM,
    umM_,
    umM2,
    umM3,
    umMbar,
    umMbit,
    umUCi,
    umMg,
    umMhz,
    umMin,
    umMm,
    umMN,
    umMPa,
    umMW,
    umN,
    umN0,
    umNm,
    umNm_2,
    umNs,
    umO_,
    umP_,
    umPH,
    umS,
    umT,
    umUV,
    umV,
    umVol,
    umW,
    umX0,
    umPorCento,
    umPc,
    umUnid,
    um99
    );

  { BLOCO 0 }
  TRegistro_0000 = class // Abertura de arquivo digital e identificação do Contribuinte
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FCNPJContribuinte: String;
    FNomeContribuinte: String;
    FVersaoLeiaute: String;
    // Preenchido pelo sistema
    FHashCode: String;
    FDataRecepcaoArquivo: TDateTime;
    FCodigoRecepcaoArquivo: String;
    FDataValidacaoArquivo: TDateTime;
    FIndicadorValidacaoArquivo: String;
  public
    property TipoRegistro: String read FTipoRegistro;
    property CNPJContribuinte: String read FCNPJContribuinte write FCNPJContribuinte;
    property NomeContribuinte: String read FNomeContribuinte write FNomeContribuinte;
    property VersaoLeiaute: String read FVersaoLeiaute;
    property HashCode: String read FHashCode;
    property DataRecepcaoArquivo: TDateTime read FDataRecepcaoArquivo;
    property CodigoRecepcaoArquivo: String read FCodigoRecepcaoArquivo;
    property DataValidacaoArquivo: TDateTime read FDataValidacaoArquivo;
    property IndicadorValidacaoArquivo: String read FIndicadorValidacaoArquivo;
  end;

  TRegistro_0001 = class // Abertura do Bloco 0
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FTextoPadraoUTF8: String;
  public
    property TipoRegistro: String read FTipoRegistro;
    property TextoPadraoUTF8: String read FTextoPadraoUTF8;
  end;

  TRegistro_0010 = class // Dados cadastrais do Contribuinte
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FCNPJContribuinte: String;
    FRazaoSocial: String;
    FInscricaoEstadual: String;
    FEndereco: String;
    FCep: String;
    FMunicipio: String;
    FUF: String;
  public
    property TipoRegistro: String read FTipoRegistro;
    property CNPJContribuinte: String read FCNPJContribuinte write FCNPJContribuinte;
    property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property InscricaoEstadual: String read FInscricaoEstadual write FInscricaoEstadual;
    property Endereco: String read FEndereco write FEndereco;
    property Cep: String read FCep write FCep;
    property Municipio: String read FMunicipio write FMunicipio;
    property UF: String read FUF write FUF;
  end;

  TRegistro_0990 = class // Encerramento do Bloco 0
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FQuantidadeLinhas: Integer;
  public
    property TipoRegistro: String read FTipoRegistro;
    property QuantidadeLinhas: Integer read FQuantidadeLinhas;
  end;

  { BLOCO 5 }
  TRegistro_5001 = class // Abertura do Bloco 5
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
  public
    property TipoRegistro: String read FTipoRegistro;
  end;

  TRegistro_5020 = class // Detalhamento das mercadorias
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FNomeMercadoria: String;
    FCodigoNCM: String;
    FCodigoMercadoria: String;
    FCodigoGtin: String;
    FUnidadeMedida: String;
    FValorSaidaMercadoria: Double;
    FValorParcelaImportada: Double;
    FPercentualConteudoImportacao: Double;
    // Preenchido pelo sistema
    FCodigoFCI: String;
    FIndicadorValidacaoFicha: String;
  public
    property TipoRegistro: String read FTipoRegistro;
    property NomeMercadoria: String read FNomeMercadoria write FNomeMercadoria;
    property CodigoNCM: String read FCodigoNCM write FCodigoNCM;
    property CodigoMercadoria: String read FCodigoMercadoria write FCodigoMercadoria;
    property CodigoGtin: String read FCodigoGtin write FCodigoGtin;
    property UnidadeMedida: String read FUnidadeMedida write FUnidadeMedida;
    property ValorSaidaMercadoria: Double read FValorSaidaMercadoria write FValorSaidaMercadoria;
    property ValorParcelaImportada: Double read FValorParcelaImportada write FValorParcelaImportada;
    property PercentualConteudoImportacao: Double read FPercentualConteudoImportacao;
    property CodigoFCI: String read FCodigoFCI;
    property IndicadorValidacaoFicha: String read FIndicadorValidacaoFicha;
    procedure CalcularPercConteudoImp;
  end;

  TRegistros_5020 = class(TObjectList) // Lista de objetos do registro 5020
  protected
    procedure SetObject(Index: Integer; Item: TRegistro_5020);
    function GetObject(Index: Integer): TRegistro_5020;
    procedure Insert(Index: Integer; Obj: TRegistro_5020);
  public
    function New: TRegistro_5020;
    property Objects[Index: Integer]: TRegistro_5020 read GetObject write SetObject; default;
  end;

  TRegistro_5990 = class // Encerramento do Bloco 5
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FQuantidadeLinhas: Integer;
  public
    property TipoRegistro: String read FTipoRegistro;
    property QuantidadeLinhas: Integer read FQuantidadeLinhas;
  end;

  { BLOCO 9 }
  TRegistro_9001 = class // Abertura do Bloco 9
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
  public
    property TipoRegistro: String read FTipoRegistro;
  end;

  TRegistro_9900 = class // Totalizadores de registros anteriores
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FTipoRegistroTotalizado: String;
    FQuantidadeLinhasRegistro: Integer;
  public
    property TipoRegistro: String read FTipoRegistro;
    property TipoRegistroTotalizado: String read FTipoRegistroTotalizado;
    property QuantidadeLinhasRegistro: Integer read FQuantidadeLinhasRegistro;
  end;

  TRegistros_9900 = class(TObjectList) // Lista de objetos do registro 9900
  protected
    procedure SetObject(Index: Integer; Item: TRegistro_9900);
    function GetObject(Index: Integer): TRegistro_9900;
    procedure Insert(Index: Integer; Obj: TRegistro_9900);
  public
    function New: TRegistro_9900;
    property Objects[Index: Integer]: TRegistro_9900 read GetObject write SetObject; default;
  end;

  TRegistro_9990 = class // Encerramento do Bloco 9
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FQuantidadeLinhas: Integer;
  public
    property TipoRegistro: String read FTipoRegistro;
    property QuantidadeLinhas: Integer read FQuantidadeLinhas;
  end;

  TRegistro_9999 = class // Encerramento do arquivo
  private
    // Preenchido pelo usuário
    FTipoRegistro: String;
    FQuantidadeLinhas: Integer;
  public
    property TipoRegistro: String read FTipoRegistro;
    property QuantidadeLinhas: Integer read FQuantidadeLinhas;
  end;

  TACBrFCI = class(TComponent)
  private
    Arquivo: TStrings;
    FNomeArqRemessa: String;
    FNomeArqRetorno: String;
    FDirArqRemessa: String;
    FDirArqRetorno: String;
    FValidarUnidadeMedida: Boolean;

    FRegistro_0000: TRegistro_0000;
    FRegistro_0001: TRegistro_0001;
    FRegistro_0010: TRegistro_0010;
    FRegistro_0990: TRegistro_0990;

    FRegistro_5001: TRegistro_5001;
    FRegistros_5020: TRegistros_5020;
    FRegistro_5990: TRegistro_5990;

    FRegistro_9001: TRegistro_9001;
    FRegistros_9900: TRegistros_9900;
    FRegistro_9990: TRegistro_9990;
    FRegistro_9999: TRegistro_9999;

    procedure GerarRegistro_0000;
    procedure GerarRegistro_0001;
    procedure GerarRegistro_0010;
    procedure GerarRegistro_0990;

    procedure GerarRegistro_5001;
    procedure GerarRegistros_5020;
    procedure GerarRegistro_5990;

    procedure GerarRegistro_9001;
    procedure GerarRegistros_9900;
    procedure GerarRegistro_9990;
    procedure GerarRegistro_9999;
    function ValidarUnidadeProduto(Unidade: String): String;

    procedure GravarRegistro(Registro, Linha: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property NomeArqRemessa: String read FNomeArqRemessa write FNomeArqRemessa;
    property NomeArqRetorno: String read FNomeArqRetorno write FNomeArqRetorno;
    property DirArqRemessa: String read FDirArqRemessa write FDirArqRemessa;
    property DirArqRetorno: String read FDirArqRetorno write FDirArqRetorno;
    property ValidarUnidadeMedida: Boolean read FValidarUnidadeMedida write FValidarUnidadeMedida;

    property Registro_0000: TRegistro_0000 read FRegistro_0000 write FRegistro_0000;
    property Registro_0001: TRegistro_0001 read FRegistro_0001;
    property Registro_0010: TRegistro_0010 read FRegistro_0010 write FRegistro_0010;
    property Registro_0990: TRegistro_0990 read FRegistro_0990;

    property Registro_5001: TRegistro_5001 read FRegistro_5001;
    property Registros_5020: TRegistros_5020 read FRegistros_5020 write FRegistros_5020;
    property Registro_5990: TRegistro_5990 read FRegistro_5990;

    property Registro_9001: TRegistro_9001 read FRegistro_9001;
    property Registros_9900: TRegistros_9900 read FRegistros_9900 write FRegistros_9900;
    property Registro_9990: TRegistro_9990 read FRegistro_9990;
    property Registro_9999: TRegistro_9999 read FRegistro_9999;

    procedure LimparRegistros;
    function GerarRegistros: String;
    procedure LerRetorno;
    procedure CalcularTotalizadores;
    function TipoUnidadeToString(TipoUnidade: TACBrUnidadeMedida): String;
    function StringToTipoUnidade(Unidade: String): TACBrUnidadeMedida;
    function ListaUnidadesMedida: TStringList;
  end;

implementation

{ TACBrFCI }

procedure TACBrFCI.CalcularTotalizadores;
begin
  with FRegistros_9900.New do
  begin
    FTipoRegistroTotalizado := '0000'; // Por padrão é 1
    FQuantidadeLinhasRegistro := 1;
  end;

  with FRegistros_9900.New do
  begin
    FTipoRegistroTotalizado := '0010'; // Por padrão é 1
    FQuantidadeLinhasRegistro := 1;
  end;

  with FRegistros_9900.New do
  begin
    FTipoRegistroTotalizado := '5020';
    FQuantidadeLinhasRegistro := FRegistros_5020.Count;
  end;

  FRegistro_0990.FQuantidadeLinhas := 4; // O bloco 0 tem o registro 0000, 0001 e 0010, além do 0990
  FRegistro_5990.FQuantidadeLinhas := 2 + FRegistros_5020.Count; // O bloco 5 tem o registro 5001 e vários 5020, além do 5990
  FRegistro_9990.FQuantidadeLinhas := 2 + FRegistros_9900.Count; // O bloco 9 tem o registro 9001 e vários 9900, além do 9990. O 9999 não é contabilizado nesta conta
  FRegistro_9999.FQuantidadeLinhas := FRegistro_0990.FQuantidadeLinhas + FRegistro_5990.FQuantidadeLinhas + FRegistro_9990.FQuantidadeLinhas + 1; // O registro 9999 é a soma de todos os outros registros mais ele mesmo
end;

constructor TACBrFCI.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FValidarUnidadeMedida := False;

  FRegistro_0000 := TRegistro_0000.Create;
  FRegistro_0000.FTipoRegistro := '0000';
  FRegistro_0000.FVersaoLeiaute := VERSAO_LEIAUTE;

  FRegistro_0001 := TRegistro_0001.Create;
  FRegistro_0001.FTipoRegistro := '0001';
  FRegistro_0001.FTextoPadraoUTF8 := TEXTO_PADRAO_UTF8;

  FRegistro_0010 := TRegistro_0010.Create;
  FRegistro_0010.FTipoRegistro := '0010';

  FRegistro_0990 := TRegistro_0990.Create;
  FRegistro_0990.FTipoRegistro := '0990';
  FRegistro_0990.FQuantidadeLinhas := 0;

  FRegistro_5001 := TRegistro_5001.Create;
  FRegistro_5001.FTipoRegistro := '5001';

  FRegistros_5020 := TRegistros_5020.Create;

  FRegistro_5990 := TRegistro_5990.Create;
  FRegistro_5990.FTipoRegistro := '5990';
  FRegistro_5990.FQuantidadeLinhas := 0;

  FRegistro_9001 := TRegistro_9001.Create;
  FRegistro_9001.FTipoRegistro := '9001';

  FRegistros_9900 := TRegistros_9900.Create;

  FRegistro_9990 := TRegistro_9990.Create;
  FRegistro_9990.FTipoRegistro := '9990';
  FRegistro_9990.FQuantidadeLinhas := 0;

  FRegistro_9999 := TRegistro_9999.Create;
  FRegistro_9999.FTipoRegistro := '9999';
  FRegistro_9999.FQuantidadeLinhas := 0;

end;

destructor TACBrFCI.Destroy;
begin
  FRegistro_0000.Free;
  FRegistro_0001.Free;
  FRegistro_0010.Free;
  FRegistro_0990.Free;

  FRegistro_5001.Free;
  FRegistros_5020.Free;
  FRegistro_5990.Free;

  FRegistro_9001.Free;
  FRegistros_9900.Free;
  FRegistro_9990.Free;
  FRegistro_9999.Free;

  inherited Destroy;
end;

function TACBrFCI.GerarRegistros: String;
var
  NomeArq: String;
begin
  if not DirectoryExists(DirArqRemessa) and (DirArqRemessa.Trim <> '') then
    ForceDirectories(DirArqRemessa);

  if not DirectoryExists(DirArqRemessa) then
    raise Exception.Create('Diretório inválido: "' + DirArqRemessa + '".');

  if (Trim(NomeArqRemessa) = '') then
    NomeArq := DirArqRemessa + PathDelim + FormatDateTime('yyyymmddhhnnss', Now)
  else
    NomeArq := DirArqRemessa + PathDelim + NomeArqRemessa;

  if LowerCase(ExtractFileExt(NomeArq)) <> '.txt' then
    NomeArq := NomeArq + '.txt';

  Result := NomeArq;
  Arquivo := TStringList.Create;

  try
    CalcularTotalizadores;
    GerarRegistro_0000;
    GerarRegistro_0001;
    GerarRegistro_0010;
    GerarRegistro_0990;

    GerarRegistro_5001;
    GerarRegistros_5020;
    GerarRegistro_5990;

    GerarRegistro_9001;
    GerarRegistros_9900;
    GerarRegistro_9990;
    GerarRegistro_9999;
    Arquivo.SaveToFile(NomeArq, TEncoding.UTF8);
  finally
    Arquivo.Free;
  end;
end;

procedure TACBrFCI.GerarRegistro_0000;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_0000.FTipoRegistro + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0000.FCNPJContribuinte, 1, 14)) + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0000.FNomeContribuinte, 1, 255)) + PIPE;
  vRegistro := vRegistro + FRegistro_0000.FVersaoLeiaute;

  GravarRegistro(FRegistro_0000.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistro_0001;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_0001.FTipoRegistro + PIPE;
  vRegistro := vRegistro + FRegistro_0001.FTextoPadraoUTF8;

  GravarRegistro(FRegistro_0001.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistro_0010;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_0010.FTipoRegistro + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0010.FCNPJContribuinte, 1, 14)) + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0010.FRazaoSocial, 1, 255)) + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0010.FInscricaoEstadual, 1, 20)) + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0010.FEndereco, 1, 255)) + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0010.FCep, 1, 8)) + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0010.FMunicipio, 1, 255)) + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_0010.FUF, 1, 2));

  GravarRegistro(FRegistro_0010.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistro_0990;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_0990.FTipoRegistro + PIPE;
  vRegistro := vRegistro + '4'; // Registro 0000, 0001, 0010 e 0990

  GravarRegistro(FRegistro_0990.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistro_5001;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_5001.FTipoRegistro;

  GravarRegistro(FRegistro_5001.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistros_5020;
var
  vRegistro: String;
  I: Integer;
begin
  for I := 0 to Registros_5020.Count - 1 do
  begin
    Registros_5020[I].CalcularPercConteudoImp;

    vRegistro := Registros_5020[I].FTipoRegistro + PIPE;
    vRegistro := vRegistro + Trim(Copy(Registros_5020[I].FNomeMercadoria, 1, 255)) + PIPE;
    vRegistro := vRegistro + Trim(Copy(Registros_5020[I].FCodigoNCM, 1, 8)) + PIPE;
    vRegistro := vRegistro + Trim(Copy(Registros_5020[I].FCodigoMercadoria, 1, 50)) + PIPE;
    vRegistro := vRegistro + Trim(Copy(Registros_5020[I].FCodigoGtin, 1, 14)) + PIPE;
    vRegistro := vRegistro + ValidarUnidadeProduto(Trim(Copy(Registros_5020[I].FUnidadeMedida, 1, 6))) + PIPE;
    vRegistro := vRegistro + Trim(Copy(FormatFloat(',0.00', Registros_5020[I].FValorSaidaMercadoria), 1, 17)) + PIPE;
    vRegistro := vRegistro + Trim(Copy(FormatFloat(',0.00', Registros_5020[I].FValorParcelaImportada), 1, 17)) + PIPE;
    vRegistro := vRegistro + Trim(Copy(FormatFloat(',0.00', Registros_5020[I].FPercentualConteudoImportacao), 1, 8));

    GravarRegistro('5020', vRegistro);
  end;
end;

procedure TACBrFCI.GerarRegistro_5990;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_5990.FTipoRegistro + PIPE;
  vRegistro := vRegistro + FRegistro_5990.FQuantidadeLinhas.ToString;

  GravarRegistro(FRegistro_5990.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistro_9001;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_9001.FTipoRegistro;

  GravarRegistro(FRegistro_9001.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistros_9900;
var
  vRegistro: String;
  I: Integer;
begin
  for I := 0 to Registros_9900.Count - 1 do
  begin
    vRegistro := Registros_9900[I].FTipoRegistro + PIPE;
    vRegistro := vRegistro + Trim(Copy(Registros_9900[I].FTipoRegistroTotalizado, 1, 4)) + PIPE;
    vRegistro := vRegistro + Trim(Copy(Registros_9900[I].FQuantidadeLinhasRegistro.ToString, 1, 8));

    GravarRegistro('9900', vRegistro);
  end;
end;

procedure TACBrFCI.GerarRegistro_9990;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_9990.FTipoRegistro + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_9990.FQuantidadeLinhas.ToString, 1, 8));

  GravarRegistro(FRegistro_9990.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GerarRegistro_9999;
var
  vRegistro: String;
begin
  vRegistro := FRegistro_9999.FTipoRegistro + PIPE;
  vRegistro := vRegistro + Trim(Copy(FRegistro_9999.FQuantidadeLinhas.ToString, 1, 8));

  GravarRegistro(FRegistro_9999.FTipoRegistro, vRegistro);
end;

procedure TACBrFCI.GravarRegistro(Registro, Linha: String);
begin
  Arquivo.Add(Linha);
end;
           
procedure TACBrFCI.LerRetorno;
var
  ArqRetorno: TStringList;
  NomeArq: String;
  I: Integer;

  function DelimitaLinha(vLinha: String): TStringList;
  begin
    Result := TStringList.Create;
    Result.Delimiter := '|';
    Result.StrictDelimiter := True;
    Result.DelimitedText := vLinha.Trim;
  end;

  procedure PreencherRegistro_0000(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 9 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 0000, linha ' + IntToStr(I + 1) + '.');

    FRegistro_0000.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    FRegistro_0000.FCNPJContribuinte := Copy(LinhaRetorno[1].Trim, 1, 14);
    FRegistro_0000.FNomeContribuinte := Copy(LinhaRetorno[2].Trim, 1, 255);
    FRegistro_0000.FVersaoLeiaute := Copy(LinhaRetorno[3].Trim, 1, 4);
    FRegistro_0000.FHashCode := Copy(LinhaRetorno[4].Trim, 1, 47);
    FRegistro_0000.FDataRecepcaoArquivo := StrToDateTime(Copy(LinhaRetorno[5].Trim, 1, 20));
    FRegistro_0000.FCodigoRecepcaoArquivo := Copy(LinhaRetorno[6].Trim, 1, 36);
    FRegistro_0000.FDataValidacaoArquivo := StrToDateTime(Copy(LinhaRetorno[7].Trim, 1, 20));
    FRegistro_0000.FIndicadorValidacaoArquivo := Copy(LinhaRetorno[8].Trim, 1, 20);
  end;

  procedure PreencherRegistro_0001(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 2 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 0001, linha ' + IntToStr(I + 1) + '.');

    FRegistro_0001.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    FRegistro_0001.FTextoPadraoUTF8 := Copy(LinhaRetorno[1].Trim, 1, 150);
  end;

  procedure PreencherRegistro_0010(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 8 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 0010, linha ' + IntToStr(I + 1) + '.');

    FRegistro_0010.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    FRegistro_0010.FCNPJContribuinte := Copy(LinhaRetorno[1].Trim, 1, 14);
    FRegistro_0010.FRazaoSocial := Copy(LinhaRetorno[2].Trim, 1, 255);
    FRegistro_0010.FInscricaoEstadual := Copy(LinhaRetorno[3].Trim, 1, 20);
    FRegistro_0010.FEndereco := Copy(LinhaRetorno[4].Trim, 1, 255);
    FRegistro_0010.FCep := Copy(LinhaRetorno[5].Trim, 1, 8);
    FRegistro_0010.FMunicipio := Copy(LinhaRetorno[6].Trim, 1, 255);
    FRegistro_0010.FUF := Copy(LinhaRetorno[7].Trim, 1, 2);
  end;

  procedure PreencherRegistro_0990(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 2 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 0990, linha ' + IntToStr(I + 1) + '.');

    FRegistro_0990.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    FRegistro_0990.FQuantidadeLinhas := StrToIntDef(Copy(LinhaRetorno[1].Trim, 1, 2), 4);
  end;

  procedure PreencherRegistro_5001(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 1 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 5001, linha ' + IntToStr(I + 1) + '.');

    FRegistro_5001.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
  end;

  procedure PreencherRegistro_5020(vLinha: String);
  var
    LinhaRetorno: TStringList;
    Reg5020: TRegistro_5020;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 11 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 5020, linha ' + IntToStr(I + 1) + '.');

    Reg5020 := FRegistros_5020.New;
    Reg5020.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    Reg5020.FNomeMercadoria := Copy(LinhaRetorno[1].Trim, 1, 255);
    Reg5020.FCodigoNCM := Copy(LinhaRetorno[2].Trim, 1, 8);
    Reg5020.FCodigoMercadoria := Copy(LinhaRetorno[3].Trim, 1, 50);
    Reg5020.FCodigoGtin := Copy(LinhaRetorno[4].Trim, 1, 14);
    Reg5020.FUnidadeMedida := Copy(LinhaRetorno[5].Trim, 1, 6);
    Reg5020.FValorSaidaMercadoria := StrToFloatDef(Copy(LinhaRetorno[6].Trim, 1, 17), 0);
    Reg5020.FValorParcelaImportada := StrToFloatDef(Copy(LinhaRetorno[7].Trim, 1, 17), 0);
    Reg5020.FPercentualConteudoImportacao := StrToFloatDef(Copy(LinhaRetorno[8].Trim, 1, 8), 0);
    Reg5020.FCodigoFCI := Copy(LinhaRetorno[9].Trim, 1, 36);
    Reg5020.FIndicadorValidacaoFicha := Copy(LinhaRetorno[10].Trim, 1, 20);
  end;

  procedure PreencherRegistro_5990(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 2 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 5990, linha ' + IntToStr(I + 1) + '.');

    FRegistro_5990.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    FRegistro_5990.FQuantidadeLinhas := StrToIntDef(Copy(LinhaRetorno[1].Trim, 1, 6), 0);
  end;

  procedure PreencherRegistro_9001(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 1 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 9001, linha ' + IntToStr(I + 1) + '.');

    FRegistro_9001.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
  end;

  procedure PreencherRegistro_9900(vLinha: String);
  var
    LinhaRetorno: TStringList;
    Reg9900: TRegistro_9900;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 3 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 9900, linha ' + IntToStr(I + 1) + '.');

    Reg9900 := FRegistros_9900.New;
    Reg9900.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    Reg9900.FTipoRegistroTotalizado := Copy(LinhaRetorno[1].Trim, 1, 4);
    Reg9900.FQuantidadeLinhasRegistro := StrToIntDef(Copy(LinhaRetorno[2].Trim, 1, 8), 0);
  end;

  procedure PreencherRegistro_9990(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 2 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 9990, linha ' + IntToStr(I + 1) + '.');

    FRegistro_9990.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    FRegistro_9990.FQuantidadeLinhas := StrToIntDef(Copy(LinhaRetorno[1].Trim, 1, 2), 0);
  end;

  procedure PreencherRegistro_9999(vLinha: String);
  var
    LinhaRetorno: TStringList;
  begin
    LinhaRetorno := DelimitaLinha(vLinha);
    if LinhaRetorno.Count < 2 then // Número total de campos do registro
      raise Exception.Create('"' + NomeArq + '" não é um arquivo de retorno válido. Erro no registro 9999, linha ' + IntToStr(I + 1) + '.');

    FRegistro_9999.FTipoRegistro := Copy(LinhaRetorno[0].Trim, 1, 4);
    FRegistro_9999.FQuantidadeLinhas := StrToIntDef(Copy(LinhaRetorno[1].Trim, 1, 8), 0);
  end;

begin

  ArqRetorno := TStringList.Create;
  try
    if Trim(NomeArqRetorno) = '' then
      raise Exception.Create('"NomeArqRetorno" deve ser informado.');

    if not FileExists(NomeArqRetorno) then
      NomeArq := IncludeTrailingPathDelimiter(FDirArqRetorno) + NomeArqRetorno
    else
      NomeArq := NomeArqRetorno;

    if not FileExists(NomeArq) then
      raise Exception.Create('Arquivo "' + NomeArq + '" não encontrado.');

    ArqRetorno.LoadFromFile(NomeArq);

    if ArqRetorno.Count < 1 then
      raise Exception.Create('O arquivo de retorno "' + NomeArq + '" está vazio. Não há dados para processar.');

    LimparRegistros;

    for I := 0 to ArqRetorno.Count - 1 do
    begin
      case AnsiIndexStr(Copy(ArqRetorno[I], 1, 4), ['0000', '0001', '0010', '0990', '5001', '5020', '5990', '9001', '9900', '9990', '9999']) of
        0:
          PreencherRegistro_0000(ArqRetorno[I]);
        1:
          PreencherRegistro_0001(ArqRetorno[I]);
        2:
          PreencherRegistro_0010(ArqRetorno[I]);
        3:
          PreencherRegistro_0990(ArqRetorno[I]);
        4:
          PreencherRegistro_5001(ArqRetorno[I]);
        5:
          PreencherRegistro_5020(ArqRetorno[I]);
        6:
          PreencherRegistro_5990(ArqRetorno[I]);
        7:
          PreencherRegistro_9001(ArqRetorno[I]);
        8:
          PreencherRegistro_9900(ArqRetorno[I]);
        9:
          PreencherRegistro_9990(ArqRetorno[I]);
        10:
          PreencherRegistro_9999(ArqRetorno[I]);
      else
        raise Exception.Create('Registro "' + Copy(ArqRetorno[I], 1, 1) + '" não identificado.');
      end;
    end;
  finally
    ArqRetorno.Free
  end;
end;

procedure TACBrFCI.LimparRegistros;
begin
  FRegistro_0000.FCNPJContribuinte := '';
  FRegistro_0000.FNomeContribuinte := '';
  FRegistro_0010.FCNPJContribuinte := '';
  FRegistro_0010.FRazaoSocial := '';
  FRegistro_0010.FInscricaoEstadual := '';
  FRegistro_0010.FEndereco := '';
  FRegistro_0010.FCep := '';
  FRegistro_0010.FMunicipio := '';
  FRegistro_0010.FUF := '';
  FRegistro_0990.FQuantidadeLinhas := 0;

  FRegistros_5020.Clear;
  FRegistro_5990.FQuantidadeLinhas := 0;

  FRegistros_9900.Clear;
  FRegistro_9990.FQuantidadeLinhas := 0;
  FRegistro_9999.FQuantidadeLinhas := 0;
end;

function TACBrFCI.ListaUnidadesMedida: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('A');
  Result.Add('Ah');
  Result.Add('ASTM');
  Result.Add('Bq');
  Result.Add('°C');
  Result.Add('CCD');
  Result.Add('cg');
  Result.Add('cm');
  Result.Add('cm2');
  Result.Add('cm3');
  Result.Add('cN');
  Result.Add('cSt');
  Result.Add('DCI');
  Result.Add('g');
  Result.Add('Gbit');
  Result.Add('Ghz');
  Result.Add('h');
  Result.Add('HP');
  Result.Add('HRC');
  Result.Add('Hz');
  Result.Add('ISO');
  Result.Add('IV');
  Result.Add('kbit');
  Result.Add('kcal');
  Result.Add('kg');
  Result.Add('kgf');
  Result.Add('kHz');
  Result.Add('kN');
  Result.Add('kPa');
  Result.Add('kV');
  Result.Add('kVA');
  Result.Add('kvar');
  Result.Add('kW');
  Result.Add('I');
  Result.Add('m');
  Result.Add('m-');
  Result.Add('m2');
  Result.Add('m3');
  Result.Add('mbar');
  Result.Add('Mbit');
  Result.Add('µCi');
  Result.Add('mg');
  Result.Add('Mhz');
  Result.Add('min');
  Result.Add('mm');
  Result.Add('mN');
  Result.Add('MPa');
  Result.Add('MW');
  Result.Add('N');
  Result.Add('n°');
  Result.Add('nm');
  Result.Add('Nm');
  Result.Add('ns');
  Result.Add('o-');
  Result.Add('p-');
  Result.Add('pH');
  Result.Add('s');
  Result.Add('t');
  Result.Add('UV');
  Result.Add('V');
  Result.Add('vol');
  Result.Add('W');
  Result.Add('x°');
  Result.Add('%');
  Result.Add('pç');
  Result.Add('unid');
  Result.Add('99');
end;

function TACBrFCI.StringToTipoUnidade(Unidade: String): TACBrUnidadeMedida;
begin
  Unidade := Unidade.Trim;

  if Unidade = 'A' then
    Result := umA
  else if Unidade = 'Ah' then
    Result := umAh
  else if Unidade = 'ASTM' then
    Result := umASTM
  else if Unidade = 'Bq' then
    Result := umBq
  else if Unidade = '°C' then
    Result := um0C
  else if Unidade = 'CCD' then
    Result := umCCD
  else if Unidade = 'cg' then
    Result := umCg
  else if Unidade = 'cm' then
    Result := umCm
  else if Unidade = 'cm2' then
    Result := umCm2
  else if Unidade = 'cm3' then
    Result := umCm3
  else if Unidade = 'cN' then
    Result := umCN
  else if Unidade = 'cSt' then
    Result := umCSt
  else if Unidade = 'DCI' then
    Result := umDCI
  else if Unidade = 'g' then
    Result := umG
  else if Unidade = 'Gbit' then
    Result := umGbit
  else if Unidade = 'Ghz' then
    Result := umGHz
  else if Unidade = 'h' then
    Result := umH
  else if Unidade = 'HP' then
    Result := umHP
  else if Unidade = 'HRC' then
    Result := umHRC
  else if Unidade = 'Hz' then
    Result := umHz
  else if Unidade = 'ISO' then
    Result := umISO
  else if Unidade = 'IV' then
    Result := umIV
  else if Unidade = 'kbit' then
    Result := umKbit
  else if Unidade = 'kcal' then
    Result := umKcal
  else if Unidade = 'kg' then
    Result := umKg
  else if Unidade = 'kgf' then
    Result := umKgf
  else if Unidade = 'kHz' then
    Result := umKHz
  else if Unidade = 'kN' then
    Result := umKN
  else if Unidade = 'kPa' then
    Result := umKPa
  else if Unidade = 'kV' then
    Result := umKV
  else if Unidade = 'kVA' then
    Result := umKVA
  else if Unidade = 'kvar' then
    Result := umKvar
  else if Unidade = 'kW' then
    Result := umKW
  else if Unidade = 'I' then
    Result := umI
  else if Unidade = 'm' then
    Result := umM
  else if Unidade = 'm-' then
    Result := umM_
  else if Unidade = 'm2' then
    Result := umM2
  else if Unidade = 'm3' then
    Result := umM3
  else if Unidade = 'mbar' then
    Result := umMbar
  else if Unidade = 'Mbit' then
    Result := umMbit
  else if Unidade = 'µCi' then
    Result := umUCi
  else if Unidade = 'mg' then
    Result := umMg
  else if Unidade = 'Mhz' then
    Result := umMhz
  else if Unidade = 'min' then
    Result := umMin
  else if Unidade = 'mm' then
    Result := umMm
  else if Unidade = 'mN' then
    Result := umMN
  else if Unidade = 'MPa' then
    Result := umMPa
  else if Unidade = 'MW' then
    Result := umMW
  else if Unidade = 'N' then
    Result := umN
  else if Unidade = 'n°' then
    Result := umN0
  else if Unidade = 'nm' then
    Result := umNm
  else if Unidade = 'Nm' then
    Result := umNm_2
  else if Unidade = 'ns' then
    Result := umNs
  else if Unidade = 'o-' then
    Result := umO_
  else if Unidade = 'p-' then
    Result := umP_
  else if Unidade = 'pH' then
    Result := umPH
  else if Unidade = 's' then
    Result := umS
  else if Unidade = 't' then
    Result := umT
  else if Unidade = 'UV' then
    Result := umUV
  else if Unidade = 'V' then
    Result := umV
  else if Unidade = 'vol' then
    Result := umVol
  else if Unidade = 'W' then
    Result := umW
  else if Unidade = 'x°' then
    Result := umX0
  else if Unidade = '%' then
    Result := umPorCento
  else if Unidade = 'pç' then
    Result := umPc
  else if Unidade = 'unid' then
    Result := umUnid
  else
    Result := um99;
end;

function TACBrFCI.TipoUnidadeToString(TipoUnidade: TACBrUnidadeMedida): String;
begin
  case TipoUnidade of
    umA:
      Result := 'A';
    umAh:
      Result := 'Ah';
    umASTM:
      Result := 'ASTM';
    umBq:
      Result := 'Bq';
    um0C:
      Result := '°C';
    umCCD:
      Result := 'CCD';
    umCg:
      Result := 'cg';
    umCm:
      Result := 'cm';
    umCm2:
      Result := 'cm2';
    umCm3:
      Result := 'cm3';
    umCN:
      Result := 'cN';
    umCSt:
      Result := 'cSt';
    umDCI:
      Result := 'DCI';
    umG:
      Result := 'g';
    umGbit:
      Result := 'Gbit';
    umGHz:
      Result := 'Ghz';
    umH:
      Result := 'h';
    umHP:
      Result := 'HP';
    umHRC:
      Result := 'HRC';
    umHz:
      Result := 'Hz';
    umISO:
      Result := 'ISO';
    umIV:
      Result := 'IV';
    umKbit:
      Result := 'kbit';
    umKcal:
      Result := 'kcal';
    umKg:
      Result := 'kg';
    umKgf:
      Result := 'kgf';
    umKHz:
      Result := 'kHz';
    umKN:
      Result := 'kN';
    umKPa:
      Result := 'kPa';
    umKV:
      Result := 'kV';
    umKVA:
      Result := 'kVA';
    umKvar:
      Result := 'kvar';
    umKW:
      Result := 'kW';
    umI:
      Result := 'I';
    umM:
      Result := 'm';
    umM_:
      Result := 'm-';
    umM2:
      Result := 'm2';
    umM3:
      Result := 'm3';
    umMbar:
      Result := 'mbar';
    umMbit:
      Result := 'Mbit';
    umUCi:
      Result := 'µCi';
    umMg:
      Result := 'mg';
    umMhz:
      Result := 'Mhz';
    umMin:
      Result := 'min';
    umMm:
      Result := 'mm';
    umMN:
      Result := 'mN';
    umMPa:
      Result := 'MPa';
    umMW:
      Result := 'MW';
    umN:
      Result := 'N';
    umN0:
      Result := 'n°';
    umNm:
      Result := 'nm';
    umNm_2:
      Result := 'Nm';
    umNs:
      Result := 'ns';
    umO_:
      Result := 'o-';
    umP_:
      Result := 'p-';
    umPH:
      Result := 'pH';
    umS:
      Result := 's';
    umT:
      Result := 't';
    umUV:
      Result := 'UV';
    umV:
      Result := 'V';
    umVol:
      Result := 'vol';
    umW:
      Result := 'W';
    umX0:
      Result := 'x°';
    umPorCento:
      Result := '%';
    umPc:
      Result := 'pç';
    umUnid:
      Result := 'unid';
    um99:
      Result := '99';
  else
    Result := '99';
  end;
end;

function TACBrFCI.ValidarUnidadeProduto(Unidade: String): String;
begin
  Result := Unidade.Trim;
  if not FValidarUnidadeMedida then
    Exit;

  Result := TipoUnidadeToString(StringToTipoUnidade(Unidade));
end;

{ TRegistros_5020 }

function TRegistros_5020.GetObject(Index: Integer): TRegistro_5020;
begin
  Result := inherited GetItem(Index) as TRegistro_5020;
end;

procedure TRegistros_5020.Insert(Index: Integer; Obj: TRegistro_5020);
begin
  inherited SetItem(Index, Obj);
end;

function TRegistros_5020.New: TRegistro_5020;
begin
  Result := TRegistro_5020.Create;
  Result.FTipoRegistro := '5020';
  Add(Result);
end;

procedure TRegistros_5020.SetObject(Index: Integer; Item: TRegistro_5020);
begin
  inherited SetItem(Index, Item);
end;

{ TRegistros_9900 }

function TRegistros_9900.GetObject(Index: Integer): TRegistro_9900;
begin
  Result := inherited GetItem(Index) as TRegistro_9900;
end;

procedure TRegistros_9900.Insert(Index: Integer; Obj: TRegistro_9900);
begin
  inherited SetItem(Index, Obj);
end;

function TRegistros_9900.New: TRegistro_9900;
begin
  Result := TRegistro_9900.Create;
  Result.FTipoRegistro := '9900';
  Add(Result);
end;

procedure TRegistros_9900.SetObject(Index: Integer; Item: TRegistro_9900);
begin
  inherited SetItem(Index, Item);
end;

{ TRegistro_5020 }

procedure TRegistro_5020.CalcularPercConteudoImp;
begin
  FPercentualConteudoImportacao := IfThen(FValorSaidaMercadoria <> 0, (FValorParcelaImportada / FValorSaidaMercadoria) * 100, 0);
end;

end.
