unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TFrmPrincipal = class(TForm)
    rectAbas: TRectangle;
    imgAba1: TImage;
    imgAba2: TImage;
    imgAba3: TImage;
    TabControl: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Rectangle1: TRectangle;
    Label7: TLabel;
    Image3: TImage;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Image4: TImage;
    Rectangle4: TRectangle;
    Label3: TLabel;
    Image6: TImage;
    rectIndicador: TRectangle;
    lvPedidos: TListView;
    imgEndereco: TImage;
    imgData: TImage;
    imgValor: TImage;
    imgAberto: TImage;
    imgFone: TImage;
    imgPedido: TImage;
    imgCancelado: TImage;
    imgEnttrega: TImage;
    imgFinalizado: TImage;
    rectFiltro: TRectangle;
    rectBtnFiltro: TRectangle;
    btnCriarConta: TSpeedButton;
    rectFiltroData: TRectangle;
    Label2: TLabel;
    Image1: TImage;
    rectFiltroStatus: TRectangle;
    Label4: TLabel;
    Image2: TImage;
    procedure imgAba1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure MudarAba(Img: Timage);
    procedure SetupAbas;
    procedure AddPedido(id_pedido: integer; dt_pedido, fone, endereco,
                        status: string; vl_total: double);
    procedure ListarPedidos(dt, status: string);
    function ImagemStatus(status: string): TBitMap;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

function TFrmPrincipal.ImagemStatus(status: string): TBitMap;
begin
  if (status = 'A') then
    Result := imgAberto.Bitmap
  else
  if (status = 'C') then
    Result := imgCancelado.Bitmap
  else
  if (status = 'E') then
    Result := imgEnttrega.Bitmap
  else
    Result := imgFinalizado.Bitmap;
end;

procedure TFrmPrincipal.AddPedido(id_pedido: integer;
                                  dt_pedido, fone, endereco, status: string;
                                  vl_total: double);
var
  item : TListViewItem;
  txt : TListItemText;
  img : TListItemImage;
begin
  item := lvPedidos.items.Add;
  item.Height := 110;

  TListItemText(item.Objects.FindDrawable('txtPedido')   ).Text := 'Pedido ' + id_pedido.ToString;
  TListItemText(item.Objects.FindDrawable('txtData')     ).Text := dt_pedido;
  TListItemText(item.Objects.FindDrawable('txtFone')     ).Text := 'Fone ' + fone;
  TListItemText(item.Objects.FindDrawable('txtEndereco')).Text := 'Endere�o ' + endereco;
  TListItemText(item.Objects.FindDrawable('txtValor')    ).Text := FormatFloat('R$ #,##0.00', vl_total);

  TListItemImage(item.Objects.FindDrawable('imgPedido')  ).Bitmap := imgPedido.Bitmap;
  TListItemImage(item.Objects.FindDrawable('imgData')    ).Bitmap := imgData.Bitmap;
  TListItemImage(item.Objects.FindDrawable('imgFone')    ).Bitmap := imgFone.Bitmap;
  TListItemImage(item.Objects.FindDrawable('imgEndereco')).Bitmap := imgEndereco.Bitmap;
  TListItemImage(item.Objects.FindDrawable('imgValor')   ).Bitmap := imgValor.Bitmap;

  TListItemImage(item.Objects.FindDrawable('imgStatus')  ).Bitmap := ImagemStatus(status);

end;

procedure TFrmPrincipal.ListarPedidos(dt, status: string);
begin
  lvPedidos.BeginUpdate;
  lvPedidos.Items.Clear;

  AddPedido(55444,'15/03/2024 19:21', '(31) 12345-1126', 'Rua Coronel Braga Junior, 18 - Lajedo', 'A', 44.21);
  AddPedido(55422,'12/03/2024 18:00', '(31) 66666-9544', 'Rua Nelson Hungria, 710 - Tupi', 'C', 33.45);
  AddPedido(55421,'14/03/2024 22:15', '(31) 33333-6426', 'Rua Dlores Duran, 185- Tupi', 'F', 21.12);
  AddPedido(55433,'13/03/2024 23:00', '(31) 23456-2328', 'Av. Waldomiro Lobo, 48 - Guarani', 'E', 65.65);
  AddPedido(55465,'55/03/2024 18:40', '(31) 98765-0987', 'Rua Itaverava, 22 - Floramar', 'A', 45.99);

  lvPedidos.EndUpdate;
end;


procedure TFrmPrincipal.MudarAba(Img: Timage);
begin
  imgAba1.opacity := 0.5;
  imgAba2.opacity := 0.5;
  imgAba3.opacity := 0.5;
  Img.Opacity := 1;

  TAnimator.AnimateFloat(rectIndicador,'Position.x', img.position.x, 0.2,
                         TAnimationType.InOut, TInterpolationType.Circular);

  TabControl.GotovisibleTab(Img.Tag);
end;

procedure TFrmPrincipal.SetupAbas;
begin
  rectIndicador.Width := imgAba1.Width;

  if TabControl.TabIndex = 0 then
    rectIndicador.Position.X := imgAba1.Position.X
  else
  if TabControl.TabIndex = 1 then
    rectIndicador.Position.X := imgAba2.Position.X
  else
    rectIndicador.Position.X := imgAba3.Position.X;


end;

procedure TFrmPrincipal.FormResize(Sender: TObject);
begin
  SetupAbas;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  SetupAbas;
  MudarAba(imgAba1);
  ListarPedidos('','');
end;

procedure TFrmPrincipal.imgAba1Click(Sender: TObject);
begin
  MudarAba(TImage(Sender));
end;

end.
