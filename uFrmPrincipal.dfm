object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Programa gerador e leitor de arquivos FCI'
  ClientHeight = 613
  ClientWidth = 645
  Color = clBtnFace
  Constraints.MaxHeight = 642
  Constraints.MaxWidth = 651
  Constraints.MinHeight = 642
  Constraints.MinWidth = 651
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnDadosEmpresa: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 118
    Width = 633
    Height = 220
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 0
    object Label3: TLabel
      Left = 58
      Top = 13
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Raz'#227'o Social:'
    end
    object Label4: TLabel
      Left = 93
      Top = 40
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'CNPJ:'
    end
    object Label5: TLabel
      Left = 331
      Top = 40
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Insc. Estadual:'
    end
    object Label6: TLabel
      Left = 73
      Top = 67
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
    end
    object Label7: TLabel
      Left = 99
      Top = 94
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label8: TLabel
      Left = 225
      Top = 94
      Width = 17
      Height = 13
      Alignment = taRightJustify
      Caption = 'UF:'
    end
    object Label9: TLabel
      Left = 307
      Top = 94
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Munic'#237'pio:'
    end
    object Label12: TLabel
      Left = 66
      Top = 133
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Hash Code:'
    end
    object Label13: TLabel
      Left = 18
      Top = 160
      Width = 104
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data Recep. Arquivo:'
    end
    object Label14: TLabel
      Left = 26
      Top = 187
      Width = 96
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data Valid. Arquivo:'
    end
    object Label15: TLabel
      Left = 299
      Top = 160
      Width = 104
      Height = 13
      Alignment = taRightJustify
      Caption = 'C'#243'd. Recep. Arquivo:'
    end
    object Label16: TLabel
      Left = 306
      Top = 187
      Width = 97
      Height = 13
      Alignment = taRightJustify
      Caption = 'Indicador Valida'#231#227'o:'
    end
    object EdtRazaoSocial: TEdit
      Left = 128
      Top = 10
      Width = 441
      Height = 21
      TabOrder = 0
    end
    object EdtCNPJ: TEdit
      Left = 128
      Top = 37
      Width = 160
      Height = 21
      TabOrder = 1
    end
    object EdtInscEstadual: TEdit
      Left = 409
      Top = 37
      Width = 160
      Height = 21
      TabOrder = 2
    end
    object EdtEndereco: TEdit
      Left = 128
      Top = 64
      Width = 441
      Height = 21
      TabOrder = 3
    end
    object EdtCEP: TEdit
      Left = 128
      Top = 91
      Width = 80
      Height = 21
      TabOrder = 4
    end
    object CmbUF: TComboBox
      Left = 248
      Top = 91
      Width = 40
      Height = 21
      Style = csDropDownList
      DropDownCount = 27
      TabOrder = 5
      Items.Strings = (
        'AC'
        'AL'
        'AM'
        'AP'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MG'
        'MS'
        'MT'
        'PA'
        'PB'
        'PE'
        'PI'
        'PR'
        'RJ'
        'RN'
        'RO'
        'RR'
        'RS'
        'SC'
        'SE'
        'SP'
        'TO')
    end
    object EdtMunicipio: TEdit
      Left = 360
      Top = 91
      Width = 209
      Height = 21
      TabOrder = 6
    end
    object EdtHashCode: TEdit
      Left = 128
      Top = 130
      Width = 441
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object EdtDataRecepArq: TEdit
      Left = 128
      Top = 157
      Width = 160
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object EdtDataValidArq: TEdit
      Left = 128
      Top = 184
      Width = 160
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 10
    end
    object EdtCodRecepArq: TEdit
      Left = 409
      Top = 157
      Width = 160
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
    object EdtIndValid: TEdit
      Left = 409
      Top = 184
      Width = 160
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
    end
  end
  object PnProdutos: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 350
    Width = 633
    Height = 210
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 1
    object DBGridProdutos: TDBGrid
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 611
      Height = 188
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      DataSource = DSProdutos
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NomeMercadoria'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NCM'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CodigoMercadoria'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CodigoGtin'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UnidadeMedida'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorSaidaMercadoria'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorParcelaImportada'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PercentualConteudoImportacao'
          ReadOnly = True
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CodigoFCI'
          ReadOnly = True
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IndicadorValidacaoFicha'
          ReadOnly = True
          Width = 120
          Visible = True
        end>
    end
  end
  object PnBotoes: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 572
    Width = 633
    Height = 35
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 2
    object BtnFechar: TBitBtn
      AlignWithMargins = True
      Left = 12
      Top = 6
      Width = 115
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Fechar'
      TabOrder = 4
      OnClick = BtnFecharClick
    end
    object BtnImportarRetorno: TBitBtn
      AlignWithMargins = True
      Left = 387
      Top = 6
      Width = 115
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Importar Retorno'
      TabOrder = 1
      OnClick = BtnImportarRetornoClick
    end
    object BtnGerarRemessa: TBitBtn
      AlignWithMargins = True
      Left = 512
      Top = 6
      Width = 115
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Gerar Remessa'
      TabOrder = 0
      OnClick = BtnGerarRemessaClick
    end
    object BtnLimparCampos: TBitBtn
      AlignWithMargins = True
      Left = 262
      Top = 6
      Width = 115
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Limpar Campos'
      TabOrder = 2
      OnClick = BtnLimparCamposClick
    end
    object BtnSobre: TBitBtn
      AlignWithMargins = True
      Left = 137
      Top = 6
      Width = 115
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Sobre'
      TabOrder = 3
      OnClick = BtnSobreClick
    end
  end
  object PnDados: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 633
    Height = 100
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 35
      Top = 13
      Width = 87
      Height = 13
      Alignment = taRightJustify
      Caption = 'Arquivo Remessa:'
    end
    object Label2: TLabel
      Left = 39
      Top = 40
      Width = 83
      Height = 13
      Alignment = taRightJustify
      Caption = 'Arquivo Retorno:'
    end
    object Label10: TLabel
      Left = 47
      Top = 68
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vers'#227'o Leiaute:'
    end
    object Label11: TLabel
      Left = 188
      Top = 67
      Width = 97
      Height = 13
      Alignment = taRightJustify
      Caption = 'Texto Padr'#227'o UTF8:'
    end
    object EdtArquivoRemessa: TEdit
      Left = 128
      Top = 10
      Width = 441
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object EdtArquivoRetorno: TEdit
      Left = 128
      Top = 37
      Width = 441
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object BtnPesqArqRem: TBitBtn
      Left = 575
      Top = 10
      Width = 22
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = BtnPesqArqRemClick
    end
    object BtnPesqArqRet: TBitBtn
      Left = 575
      Top = 37
      Width = 22
      Height = 21
      Caption = '...'
      TabOrder = 5
      OnClick = BtnPesqArqRetClick
    end
    object EdtTextoPadraoUTF8: TEdit
      Left = 291
      Top = 64
      Width = 278
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
      Text = 
        'Texto em caracteres UTF-8: (d'#237'grafo BR)'#39#231#227'o'#39',(d'#237'grafo espanhol-e' +
        'nhe)'#39#241#39',(trema)'#39#220#39',(ordinais)'#39#170#186#39',(ligamento s+z alem'#227'o)'#39#223#39'.'
    end
    object EdtVersaoLeiaute: TEdit
      Left = 128
      Top = 64
      Width = 50
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
      Text = '1.0'
    end
  end
  object DSProdutos: TDataSource
    DataSet = CDSProdutos
    Left = 390
    Top = 414
  end
  object CDSProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 416
    object CDSProdutosNomeMercadoria: TStringField
      FieldName = 'NomeMercadoria'
      Size = 255
    end
    object CDSProdutosNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object CDSProdutosCodigoMercadoria: TStringField
      FieldName = 'CodigoMercadoria'
      Size = 50
    end
    object CDSProdutosCodigoGtin: TStringField
      FieldName = 'CodigoGtin'
      Size = 14
    end
    object CDSProdutosUnidadeMedida: TStringField
      FieldName = 'UnidadeMedida'
      Size = 6
    end
    object CDSProdutosValorSaidaMercadoria: TBCDField
      FieldName = 'ValorSaidaMercadoria'
      Precision = 15
      Size = 2
    end
    object CDSProdutosValorParcelaImportada: TBCDField
      FieldName = 'ValorParcelaImportada'
      Precision = 15
      Size = 2
    end
    object CDSProdutosPercentualConteudoImportacao: TBCDField
      FieldName = 'PercentualConteudoImportacao'
      Precision = 6
      Size = 2
    end
    object CDSProdutosCodigoFCI: TStringField
      FieldName = 'CodigoFCI'
      Size = 36
    end
    object CDSProdutosIndicadorValidacaoFicha: TStringField
      FieldName = 'IndicadorValidacaoFicha'
    end
  end
  object OpenTxt: TOpenTextFileDialog
    DefaultExt = '.txt'
    Filter = 'TXT|*.txt|Todos|*.*'
    Left = 104
    Top = 432
  end
  object SaveTxt: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = 'TXT|*.txt|Todos|*.*'
    Encodings.Strings = (
      'UTF-8')
    Left = 166
    Top = 438
  end
end
