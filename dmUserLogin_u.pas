unit dmUserLogin_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmUserLogin = class(TDataModule)
    conUserDatabase: TADOConnection;
    tblData: TADOTable;
    dsData: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmUserLogin: TdmUserLogin;

implementation

{$R *.dfm}

end.
