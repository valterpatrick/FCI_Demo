unit uFrmPrincipal;

interface

uses
  Winapi.Windows, 
  Winapi.Messages, 
  System.SysUtils, 
  System.Variants, 
  System.Classes, 
  Vcl.Graphics,
  Vcl.Controls, 
  Vcl.Forms, 
  Vcl.Dialogs, 
  Vcl.StdCtrls, 
  Vcl.Buttons, 
  Vcl.ExtCtrls, 
  Data.DB, 
  Vcl.Grids,
  Vcl.DBGrids, 
  Datasnap.DBClient, 
  Vcl.ExtDlgs, 
  ACBrFCI;

type
  TFrmPrincipal = class(TForm)
    PnDadosEmpresa: TPanel;
    PnProdutos: TPanel;
    PnBotoes: TPanel;
    PnDados: TPanel;
    Label1: TLabel;
    EdtArquivoRemessa: TEdit;
    Label2: TLabel;
    EdtArquivoRetorno: TEdit;
    BtnPesqArqRem: TBitBtn;
    BtnPesqArqRet: TBitBtn;
    EdtRazaoSocial: TEdit;
    Label3: TLabel;
    EdtCNPJ: TEdit;
    Label4: TLabel;
    EdtInscEstadual: TEdit;
    Label5: TLabel;
    EdtEndereco: TEdit;
    Label6: TLabel;
    EdtCEP: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    CmbUF: TComboBox;
    EdtMunicipio: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    EdtTextoPadraoUTF8: TEdit;
    Label11: TLabel;
    EdtHashCode: TEdit;
    Label12: TLabel;
    EdtDataRecepArq: TEdit;
    Label13: TLabel;
    EdtDataValidArq: TEdit;
    Label14: TLabel;
    EdtCodRecepArq: TEdit;
    Label15: TLabel;
    EdtIndValid: TEdit;
    Label16: TLabel;
    DBGridProdutos: TDBGrid;
    BtnFechar: TBitBtn;
    BtnImportarRetorno: TBitBtn;
    BtnGerarRemessa: TBitBtn;
    EdtVersaoLeiaute: TEdit;
    BtnLimparCampos: TBitBtn;
    DSProdutos: TDataSource;
    CDSProdutos: TClientDataSet;
    CDSProdutosNomeMercadoria: TStringField;
    CDSProdutosNCM: TStringField;
    CDSProdutosCodigoMercadoria: TStringField;
    CDSProdutosCodigoGtin: TStringField;
    CDSProdutosValorSaidaMercadoria: TBCDField;
    CDSProdutosValorParcelaImportada: TBCDField;
    CDSProdutosPercentualConteudoImportacao: TBCDField;
    CDSProdutosCodigoFCI: TStringField;
    CDSProdutosIndicadorValidacaoFicha: TStringField;
    CDSProdutosUnidadeMedida: TStringField;
    OpenTxt: TOpenTextFileDialog;
    SaveTxt: TSaveTextFileDialog;
    BtnSobre: TBitBtn;
    procedure BtnLimparCamposClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnPesqArqRemClick(Sender: TObject);
    procedure BtnPesqArqRetClick(Sender: TObject);
    procedure BtnGerarRemessaClick(Sender: TObject);
    procedure BtnImportarRetornoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSobreClick(Sender: TObject);
  private
    FCI: TACBrFCI;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}


procedure TFrmPrincipal.BtnFecharClick(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja fechar o programa?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_YES then
    Close;
end;

procedure TFrmPrincipal.BtnGerarRemessaClick(Sender: TObject);
var
  LArquivo: String;
begin
  FCI := TACBrFCI.Create(Self);
  try


    FCI.DirArqRemessa := ExtractFileDir(EdtArquivoRemessa.Text);
    FCI.NomeArqRemessa := ExtractFileName(EdtArquivoRemessa.Text);
    FCI.ValidarUnidadeMedida := False;

    FCI.Registro_0000.CNPJContribuinte := EdtCNPJ.Text;
    FCI.Registro_0000.NomeContribuinte := EdtRazaoSocial.Text;

    FCI.Registro_0010.CNPJContribuinte := EdtCNPJ.Text;
    FCI.Registro_0010.RazaoSocial := EdtRazaoSocial.Text;
    FCI.Registro_0010.InscricaoEstadual := EdtInscEstadual.Text;
    FCI.Registro_0010.Endereco := EdtEndereco.Text;
    FCI.Registro_0010.Cep := EdtCEP.Text;
    FCI.Registro_0010.Municipio := EdtMunicipio.Text;
    FCI.Registro_0010.UF := CmbUF.Text;

    CDSProdutos.First;
    while not CDSProdutos.Eof do
    begin
      with FCI.Registros_5020.New do
      begin
        NomeMercadoria := CDSProdutosNomeMercadoria.AsString;
        CodigoNCM := CDSProdutosNCM.AsString;
        CodigoMercadoria := CDSProdutosCodigoMercadoria.AsString;
        CodigoGtin := CDSProdutosCodigoGtin.AsString;
        UnidadeMedida := CDSProdutosUnidadeMedida.AsString;
        ValorSaidaMercadoria := CDSProdutosValorSaidaMercadoria.AsCurrency;
        ValorParcelaImportada := CDSProdutosValorParcelaImportada.AsCurrency;
      end;
      CDSProdutos.Next;
    end;

    LArquivo := FCI.GerarRegistros;
    Application.MessageBox(PWideChar(Format('Arquivo gerado com sucesso. "%s".',[LArquivo])), 'Informação', MB_ICONINFORMATION + MB_OK);
  finally
    FCI.Free;
  end;
end;

procedure TFrmPrincipal.BtnImportarRetornoClick(Sender: TObject);
var
  I: Integer;
begin
  FCI := TACBrFCI.Create(Self);
  try
    FCI.DirArqRetorno := ExtractFileDir(EdtArquivoRetorno.Text);
    FCI.NomeArqRetorno := ExtractFileName(EdtArquivoRetorno.Text);
    FCI.LerRetorno;

    EdtCNPJ.Text := FCI.Registro_0010.CNPJContribuinte;
    EdtRazaoSocial.Text := FCI.Registro_0010.RazaoSocial;
    EdtInscEstadual.Text := FCI.Registro_0010.InscricaoEstadual;
    EdtEndereco.Text := FCI.Registro_0010.Endereco;
    EdtCEP.Text := FCI.Registro_0010.Cep;
    EdtMunicipio.Text := FCI.Registro_0010.Municipio;
    CmbUF.Text := FCI.Registro_0010.UF;
    EdtHashCode.Text := FCI.Registro_0000.HashCode;
    EdtDataRecepArq.Text := DateToStr(FCI.Registro_0000.DataRecepcaoArquivo);
    EdtDataValidArq.Text := DateToStr(FCI.Registro_0000.DataValidacaoArquivo);
    EdtCodRecepArq.Text := FCI.Registro_0000.CodigoRecepcaoArquivo;
    EdtIndValid.Text := FCI.Registro_0000.IndicadorValidacaoArquivo;

    CDSProdutos.Close;
    CDSProdutos.CreateDataSet;
    CDSProdutos.Open;
    for I := 0 to FCI.Registros_5020.Count - 1 do
    begin
      CDSProdutos.Append;
      CDSProdutosNomeMercadoria.AsString := FCI.Registros_5020.Objects[I].NomeMercadoria;
      CDSProdutosCodigoMercadoria.AsString := FCI.Registros_5020.Objects[I].CodigoMercadoria;
      CDSProdutosNCM.AsString := FCI.Registros_5020.Objects[I].CodigoNCM;
      CDSProdutosCodigoGtin.AsString := FCI.Registros_5020.Objects[I].CodigoGtin;
      CDSProdutosUnidadeMedida.AsString := FCI.Registros_5020.Objects[I].UnidadeMedida;
      CDSProdutosValorSaidaMercadoria.AsCurrency := FCI.Registros_5020.Objects[I].ValorSaidaMercadoria;
      CDSProdutosValorParcelaImportada.AsCurrency := FCI.Registros_5020.Objects[I].ValorParcelaImportada;
      CDSProdutosPercentualConteudoImportacao.AsCurrency := FCI.Registros_5020.Objects[I].PercentualConteudoImportacao;
      CDSProdutosCodigoFCI.AsString := FCI.Registros_5020.Objects[I].CodigoFCI;
      CDSProdutosIndicadorValidacaoFicha.AsString := FCI.Registros_5020.Objects[I].IndicadorValidacaoFicha;
      CDSProdutos.Post;
    end;

    Application.MessageBox(PWideChar('Arquivo "' + EdtArquivoRetorno.Text + '" lido com sucesso.'), 'Informação', MB_ICONINFORMATION + MB_OK);
  finally
    FCI.free;  
  end;
end;

procedure TFrmPrincipal.BtnLimparCamposClick(Sender: TObject);
begin
  EdtArquivoRemessa.Clear;
  EdtArquivoRetorno.Clear;
  EdtVersaoLeiaute.Clear;
  EdtTextoPadraoUTF8.Clear;

  EdtRazaoSocial.Clear;
  EdtCNPJ.Clear;
  EdtInscEstadual.Clear;
  EdtEndereco.Clear;
  EdtCEP.Clear;
  CmbUF.Clear;
  EdtMunicipio.Clear;
  EdtHashCode.Clear;
  EdtDataRecepArq.Clear;
  EdtCodRecepArq.Clear;
  EdtDataValidArq.Clear;
  EdtIndValid.Clear;

  CDSProdutos.Close;
  CDSProdutos.CreateDataSet;
  CDSProdutos.Open;
end;

procedure TFrmPrincipal.BtnPesqArqRemClick(Sender: TObject);
begin
  SaveTxt.Title := 'Arquivo de Remessa';
  if SaveTxt.Execute then
    EdtArquivoRemessa.Text := SaveTxt.FileName;
end;

procedure TFrmPrincipal.BtnPesqArqRetClick(Sender: TObject);
begin
  OpenTxt.Title := 'Arquivo de Retorno';
  if OpenTxt.Execute then
    EdtArquivoRetorno.Text := OpenTxt.FileName;
end;

procedure TFrmPrincipal.BtnSobreClick(Sender: TObject);
begin
  Application.MessageBox('Programa gerador e leitor de arquivos FCI desenvolvido por "Valter Patrick Silva Ferreira". Contribuição para o ACBr. Para maiores informações entre em contato pelo e-mail "valterpatrick@hotmail.com".', 'Informação',
    MB_ICONINFORMATION + MB_OK);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  CDSProdutos.Close;
  CDSProdutos.CreateDataSet;
  CDSProdutos.Open;
end;

end.
