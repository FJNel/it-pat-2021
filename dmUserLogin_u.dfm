object dmUserLogin: TdmUserLogin
  OldCreateOrder = False
  Height = 150
  Width = 215
  object conUserDatabase: TADOConnection
    CommandTimeout = 1
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=F:\An' +
      'der grade\Gr 10 - 2021\IT PAT\Johan Nel IT PAT 2021 -Ingee\Phase' +
      ' 2 Coding\UserLoginE.mdb;Mode=ReadWrite;Persist Security Info=Fa' +
      'lse;Jet OLEDB:System database="";Jet OLEDB:Registry Path="";Jet ' +
      'OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Dat' +
      'abase Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLE' +
      'DB:Global Bulk Transactions=1;Jet OLEDB:New Database Password=""' +
      ';Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Databa' +
      'se=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:' +
      'Compact Without Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 8
  end
  object tblData: TADOTable
    Connection = conUserDatabase
    CursorType = ctStatic
    TableName = 'tblData'
    Left = 32
    Top = 56
  end
  object dsData: TDataSource
    DataSet = tblData
    Left = 80
    Top = 56
  end
end
