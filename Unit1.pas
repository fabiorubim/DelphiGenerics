unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmGenerics = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPessoa = class
    private
    FNome: String;
    procedure SetNome(const Value: String);

    public
      property Nome: String read FNome write SetNome;
  end;

var
  frmGenerics: TfrmGenerics;

implementation

uses
  System.Generics.Collections;

{$R *.dfm}

procedure TfrmGenerics.Button1Click(Sender: TObject);
var
  LListaPessoa : TList;
  LPessoa : TPessoa;
  LNomePessoa : String;
begin
  //Este modo cria uma lista de pessoas, sem o uso de generics. O problema � que n�o � avisado pelo compilador
  //em tempo de projeto, que pode ter sido adicionado um objeto diferente de TPessoa, ele n�o faz essa verifica��o.
  //O par�metro passado para ele � do tipo ponteiro.
  LListaPessoa := TList.Create;
  LPessoa      := TPessoa.Create;
  try
    LPessoa.Nome := 'Fabio Rubim';
    LListaPessoa.Add(LPessoa);
    //LListaPessoa.Add(frmGenerics); //Funciona
    LNomePessoa:=  TPessoa(LListaPessoa[0]).Nome;
    //LNomePessoa:=  TFOrm(LListaPessoa[0]).Name;  //Funciona
    ShowMessage(LNomePessoa);
  finally
    LPessoa.Free;
    LListaPessoa.Free;
  end;

end;

{ TPessoa }

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TfrmGenerics.Button2Click(Sender: TObject);
var
  LListaPessoas : TList<TPessoa>; //Adicionado na uses System.Generics.Collections
  LPessoa : TPessoa;
  LNomePessoa : String;
begin
  //Gra�as ao Generics temos um verifica��o da classe/objeto adicioando com .Add e ao mesmo tempo
  //n�o precisamo fazer typecast, pois j� se sabe que LListaPessoa � do tipo TPessoa
  LListaPessoas := TList<TPessoa>.Create;
  LPessoa := TPessoa.Create;
  try
    LPessoa.Nome := 'Fabio Rubim';
    LListaPessoas.Add(LPessoa);
    //LListaPessoas.Add(frmGenerics);//N�o compila

    ShowMessage(LListaPessoas[0].Nome);
  finally
    LListaPessoas.Free;
  end;

end;

procedure TfrmGenerics.Button3Click(Sender: TObject);
var
  x: TDictionary<string, Integer>; // � uma lista de TPair
  p: TPair<String,Integer>;
begin
  x:= TDictionary<String,Integer>.Create;

  try
    x.Add('a',1);
    x.Add('b',2);
    x.Add('c',3);

    Showmessage(x.Items['b'].ToString);
  finally
    x.free;
  end;
end;

end.
