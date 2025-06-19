unit frmLogin_u;

{Issues/Things to change:
- The date can be a future date (code to prevent that doesn't work...)
- Use text files instead of code to display help messages
- Tweak password strength meter
- Clean up password strength meter
- Clean up dialog messages
- Take to login page when registered succesfully
- Check the username creation system
- Check validation according to fase 1

}

{INFORMATION
The Help buttons all follow the same template. Instead of explaining each one seperately, I will explain it here, so that I only have to do it once.
The template is as follows:
    procedure [click on button]
    var
      LoginH : TextFile;
      sMessage, sNew : String;
    begin
      WriteLn(Log,TimeToStr(Now)+#9+'Help button on Login form clicked'); //Log the click in the log file

      AssignFile(LoginH,'HelpLogin.txt'); //Open the file
      Reset(LoginH); //Read the file
      sMessage := '';
      WriteLn(Log,TimeToStr(Now)+#9+'Creating Help message'); //Log progress
      while NOT EOF(LoginH) do //Generating string to be displayed
        ReadLn(CreateH, sNew);
        if sMessage = '' then
        begin
          sMessage := sNew; //If we are at the start of the file (the first line), do not add an enter
        end
        else //otherwise, add an anter to create a new line
        begin
          sMessage := sMessage + #10 + sNew;
        end;
      end;
    end;

      WriteLn(Log,TimeToStr(Now)+#9+'Showing Help message'); //log
      ShowMessage(sMessage); //Showing string
      WriteLn(Log,TimeToStr(Now)+#9+'Closing help text file'); //log
      closefile(LoginH); //Close file
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////
How to enable the database on a new computer:  These steps are needed for the program to work properly!
They should be done every time you open the program on a new computer
Detailed instructions in Phase 1 document
1. Open dmUserLogin_u in the frmLogin_p file manager in the top right
2. Click on dmUserLogin_u at the top (go to dmUserLogin_u)
3. Click on ConUserDatabase
4. In the ConnectionString property of ConUserDatabase, click on the three dots next to the text field
5. Select 'Use connection string', and click on build
6. Click on the three dots next to the 'Select or enter a database name''s edit box.
7. Click on UserLogin.mdp and click open
8. When done, click test connection to make sure the connection was succesful, and close the two popus menus.
9. Click on tblData, and in its Active property, make sure that it is activated.
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, Spin, ComCtrls, DateUtils, dmUserLogin_u, math,
  IdMessage, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP;

type
  TfrmLogIn = class(TForm)
    pnlLogin: TPanel;
    lblWelcome: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblUsername: TLabel;
    lblPassword: TLabel;
    imgEye: TImage;
    btnLogin: TButton;
    bmbRegister: TBitBtn;
    lblRegister: TLabel;
    bmbLoginHelp: TBitBtn;
    pnlRegister: TPanel;
    Label1: TLabel;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    edtFirstName: TEdit;
    edtSurname: TEdit;
    lblAge: TLabel;
    dtpBirthDate: TDateTimePicker;
    rgpUserType: TRadioGroup;
    lblEnterPW: TLabel;
    edtEnterPW: TEdit;
    lblPWStrength: TLabel;
    btnDoneRegister: TButton;
    bmbRegisterHelp: TBitBtn;
    bmbPWStrengthHelp: TBitBtn;
    btnRegisterBack: TButton;
    bmbClose: TBitBtn;
    imgRegisterEye: TImage;
    edtRegUserN: TEdit;
    lblRegUseN: TLabel;
    procedure bmbLoginHelpClick(Sender: TObject);
    procedure bmbRegisterClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bmbRegisterHelpClick(Sender: TObject);
    procedure btnDoneRegisterClick(Sender: TObject);
    procedure edtEnterPWKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bmbPWStrengthHelpClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnRegisterBackClick(Sender: TObject);
    procedure imgEyeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure bmbCloseClick(Sender: TObject);
    procedure imgRegisterEyeClick(Sender: TObject);

  private
    { Private declarations }
    bEnterPW, bShow, bRegisterShow : Boolean;
  public
    { Public declarations }
    sUserName : String;
    Log : TextFile;
    sFileName : String;
  end;

var
  frmLogIn: TfrmLogIn;

implementation

uses frmVerify_u, frmEnd_u;

{$R *.dfm}

procedure TfrmLogIn.bmbCloseClick(Sender: TObject);
begin
  WriteLn(Log,'');
  WriteLn(Log,'Program closed on log in panel');
  closefile(Log);
end;

procedure TfrmLogIn.bmbLoginHelpClick(Sender: TObject);
var
  LoginH : TextFile;
  sMessage, sNew : String;
begin
  WriteLn(Log,TimeToStr(Now)+#9+'Help button on Login form clicked');

  AssignFile(LoginH,'Help\HelpLogin.txt');
  Reset(LoginH);
  sMessage := '';
  WriteLn(Log,TimeToStr(Now)+#9+'Creating Help message');
  while NOT EOF(LoginH) do //Generating string
  begin
    ReadLn(LoginH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;

  WriteLn(Log,TimeToStr(Now)+#9+'Showing Help message');
  ShowMessage(sMessage); //Showing string
  WriteLn(Log,TimeToStr(Now)+#9+'Closing help text file');
  closefile(LoginH);
end;

procedure TfrmLogIn.bmbPWStrengthHelpClick(Sender: TObject);
var
  PasswordH : TextFile;
  sMessage, sNew : String;
begin
  WriteLn(Log,TimeToStr(Now)+#9+'Password info button on Register form clicked');

  AssignFile(PasswordH,'Help\HelpPassword.txt');
  Reset(PasswordH);
  sMessage := '';
  writeLn(Log,TimeToStr(Now)+#9+'Creating message to display');
  while not EOF(PasswordH) do
  begin
    ReadLn(PasswordH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;
  WriteLn(Log,TimeToStr(Now)+#9+'Showing message');
  ShowMessage(sMessage);
   WriteLn(Log,TimeToStr(Now)+#9+'Closing text file');
  closefile(PasswordH);
end;

procedure TfrmLogIn.bmbRegisterClick(Sender: TObject);
begin
  //Takes user to Register panel
  WriteLn(Log,TimeToStr(Now)+#9+'Register now button clicked - Taking to register form');

  WriteLn(Log,TimeToStr(Now)+#9+'Hiding log in panel');
  pnlLogin.Visible := False;
  WriteLn(Log,TimeToStr(Now)+#9+'Showing register panel');
  pnlRegister.Visible := True;
  WriteLn(Log,TimeToStr(Now)+#9+'Caption of form changed to "Create your school account:"');
  frmLogin.Caption := 'Create your school account: '; //Change form caption
  WriteLn(Log,TimeToStr(Now)+#9+'Updated DTP date to todays date');
  dtpBirthDate.Date := Date; //Set DTP date to todays date
  lblPWStrength.Caption := 'Waiting for password';
  lblPWStrength.Font.Color := rgb(64,64,64); //gray

end;

procedure TfrmLogIn.bmbRegisterHelpClick(Sender: TObject);
var
  CreateH : TextFile;
  sMessage, sNew : String;
begin
  WriteLn(Log,TimeToStr(Now)+#9+'Help button on Register form clicked');

  AssignFile(CreateH,'Help\HelpCreate.txt');
  Reset(CreateH);
  sMessage := '';

  WriteLn(Log,TimeToStr(Now)+#9+'Creating Help message');
  while NOT EOF(CreateH) do
  begin
    ReadLn(CreateH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;
  WriteLn(Log,TimeToStr(Now)+#9+'Showing Help message');
  ShowMessage(sMessage);
  WriteLn(Log,TimeToStr(Now)+#9+'Closing help text file');
  closefile(CreateH);
end;

procedure TfrmLogIn.btnDoneRegisterClick(Sender: TObject);
var
  sFirstName, sSurname, sEnterPW, sUsername, sDisplayName, sDisplaySur, sDisplayUserN : String;
  dBirthDate : TDate;
  iDateComp, iAge, iName, iSurname, iUsername : Integer;
  cUserType, cDateComp : Char;
begin
  //When the user clicks the button to register an account
  WriteLn(Log,TimeToStr(Now)+#9+'Register new account button clicked');
  //Log
  WriteLn(Log,TimeToStr(Now)+#9+'Data entered:');
  WriteLn(log,#9 + #9 + #9 +'Username: '+edtRegUserN.Text);
  WriteLn(log,#9 + #9 + #9 +'First Name: '+edtFirstName.Text);
  WriteLn(log,#9 + #9 + #9 +'Last Name: '+edtSurname.Text);
  WriteLn(log,#9 + #9 + #9 +'Birt date: '+DateToStr(dtpBirthDate.Date));
  WriteLn(log,#9 + #9 + #9 +'Password: '+edtEnterPW.Text);
  if NOT(rgpUserType.ItemIndex = -1) then
    WriteLn(log,#9 + #9 + #9 +'User type: '+rgpUserType.Items[rgpUserType.ItemIndex])
  else
    WriteLn(log,#9 + #9 + #9 +'User type: None selected');

  //Validation - Is info entered?
  if edtRegUserN.Text = '' then //no username
  begin
    ShowMessage('Validation Error: You need to enter a Username to register a new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: No Username entered');
    Exit;
  end;
  if edtFirstName.Text = '' then //no first name
  begin
    ShowMessage('Validation Error: You need to enter a First Name to register a new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: No First name entered');
    Exit;
  end;
  if edtEnterPW.Text = '' then //no password
  begin
    ShowMessage('Validation Error: You need to enter a Password to register a new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: No Password entered');
    Exit;
  end;
  if edtSurname.Text = '' then //no last name
  begin
    ShowMessage('Validation Error: You need to enter a Last Name to register a new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: No Surname entered');
    Exit;
  end;
  iDateComp := CompareDate(Date, dtpBirthDate.Date); //If the value is -1, it is a future date. Cannot enter future date as Birth Date
  if iDateComp < 0 then
  begin
    ShowMessage('Validation Error: You need to enter a past date to register a new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Future date used as birth date');
    Exit;
  end;
  if rgpUserType.ItemIndex = -1 then //No option in radio group box selected
  begin
    ShowMessage('Validation Error: You need to select which type of user you are (Learner/Teacher/Admin) to register a new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: No User Type selected');
    Exit;
  end;

  //Validation - Is info too long? Determined by length i database
  if length(edtRegUserN.Text) > 30 then //no username
  begin
    ShowMessage('Validation Error: You need to enter a Username to register a new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Username is incorrect length. Length of FN enterred: '+IntToStr(Length(edtRegUserN.Text)));
    Exit;
  end;
  if length(edtFirstName.Text) > 20 then
  begin
    ShowMessage('Validation Error: Your First Name cannot be longer than 20 characters! Please make it shorter to register an account.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: First Name is incorrect length. Length of FN enterred: '+IntToStr(Length(edtFirstName.Text)));
    Exit;
  end;
  if length(edtSurname.Text) > 20 then
  begin
    ShowMessage('Validation Error: Your Last Name cannot be longer than 20 characters! Please make it shorter to register an account.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Last Name is incorrect length. Length of LN enterred: '+IntToStr(Length(edtSurname.Text)));
    Exit;
  end;
  if length(edtEnterPW.Text) > 30 then
  begin
    ShowMessage('Validation Error: Your Password cannot be longer than 30 characters! Please make it shorter to register an account.'+#10+'Please remember that your password should be either “Medium” or “High” strength.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Password is incorrect length. Length of PW enterred: '+IntToStr(Length(edtEnterPW.Text)));
    Exit;
  end;
  //Validation - Is info too short? - 3 needed to correclty generate a username
  if length(edtFirstName.Text) < 3 then //Less than 3
  begin
    ShowMessage('Validation Error: Your First Name cannot be shorter than 3 characters! Please make it longer to register an account.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: First Name is incorrect length. Length of FN enterred: '+IntToStr(Length(edtFirstName.Text)));
    Exit;
  end;
  if length(edtSurname.Text) < 3 then //Less than 3
  begin
    ShowMessage('Validation Error: Your Last Name cannot be shorter than 3 characters! Please make it longer to register an account.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Last Name is incorrect length. Length of LN enterred: '+IntToStr(Length(edtSurname.Text)));
    Exit;
  end;
  //Validation - Does the FN or SN contain a space?
  sDisplayUserN := edtRegUserN.Text;
  iUsername := 1;
  for iUserName := 1 to length(sDisplayUserN) do
  begin
    if sDisplayUserN[iUserName] = ' ' then
    begin
    ShowMessage('Validation Error: Your username cannot contain a space! Please remove the space and try again.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: UserName contains space');
    Exit;
    end;
  end;

  iName := 1;
  for iName := 1 to length(sDisplayName) do
  begin
    if sDisplayName[iName] = ' ' then
    begin
    ShowMessage('Validation Error: Your name cannot contain a space! Please remove the space and try again.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Name contains space');
    Exit;
    end;
  end;

 iSurname := 1;
 sDisplaySur := edtSurName.Text;
  for iName := 1 to length(sDisplaySur) do
  begin
    if sDisplaySur[iSurname] = ' ' then
    begin
    ShowMessage('Validation Error: Your surname cannot contain a space! Please remove the space and try again.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Surame contains space');
    Exit;
    end;
  end;

  //Is username already in the database?
  if dmUserLogin.tblData.Locate('Username',edtRegUserN.Text,[]) = True then //if the username exsists in the database
  begin
    ShowMessage('User Error: The username you entered is already in the database. If you already have an account with that username, click the ''Go Back'' button to log in, otherwise you should enter another username.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Username already in database');
    Exit;
  end;

  //Input
  WriteLn(Log,TimeToStr(Now)+#9+'User input validated succesfully');
  WriteLn(Log,TimeToStr(Now)+#9+'Inputting data from user');

  sUsername := edtRegUserN.Text;
  sFirstName := edtFirstName.Text;
  sSurname := edtSurname.Text;
  sEnterPW := edtEnterPW.Text;
  dBirthDate := dtpBirthDate.Date;


  case rgpUserType.ItemIndex of
    0: cUserType := 'L';
    1: cUserType := 'T';
    2: cUserType := 'A';
  end; //end of Case
  WriteLn(Log,TimeToStr(Now)+#9+'cUserType: '+cUserType);

  //Proccessing
  iAge := YearsBetween(dBirthDate,Date);
  WriteLn(Log,TimeToStr(Now)+#9+'Age calculated: '+IntToStr(iAge));

  //Register in Database if the password is the correct strength
  WriteLn(Log,TimeToStr(Now)+#9+'Starting to register user information into database');
  if bEnterPW = True then //if it is the correct strength
  begin
    dmUserLogin.tblData.Insert;
    dmUserLogin.tblData['Username'] := sUsername;
    dmUserLogin.tblData['First_Name'] := sFirstName;
    dmUserLogin.tblData['Last_Name'] := sSurname;
    dmUserLogin.tblData['Birth_Date'] := dBirthDate;
    dmUserLogin.tblData['User_Type'] := cUserType;
    dmUserLogin.tblData['Password'] := sEnterPW;
    dmUserLogin.tblData.Post;
    WriteLn(Log,TimeToStr(Now)+#9+'Posted user info succesfully into database');
    //Clear register form
    ShowMessage('Welcome '+sFirstName+' '+sSurname+'!'+#10+'You will use this username to log in:'+#10+sUsername+#10+
    ' with password as '+sEnterPW+#10+'Welcome to your new account!');
    WriteLn(Log,TimeToStr(Now)+#9+'Showed welcome message');
    edtFIrstName.Clear;
    edtSurname.Clear;
    edtEnterPW.Clear;
    dtpBirthDate.Date := Date;
    rgpUserType.ItemIndex := -1;
    if bRegisterShow = True then //if the password is visible, make it invisble for next user to register
      begin
        WriteLn(Log,TimeToStr(Now)+#9+'CLicked password eye - Hiding it');
        WriteLn(Log,TimeToStr(Now)+#9+'Changing Password char to *');
        imgEye.Picture.LoadFromFile('imgHide.jpg');
        edtPassword.PasswordChar := '*';
        bShow := False;
      end;
  end
  else //if it ins't the correct strength
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Password strength not meduim or high');
    ShowMessage('Your password needs to be "Medium" or "High" strength!'+#10+'Please make sure it meets the given characteristics. To find the characteristics, you can click on the "Password Strength Info" button.');
  end;

  //Take back to login panel
  WriteLn(Log,TimeToStr(Now)+#9+'Register sussesful - Taking to log in panel');
  pnlRegister.Visible := False;
  WriteLn(Log,TimeToStr(Now)+#9+'Hiding Register panel');
  pnlLogin.Visible := True;
  WriteLn(Log,TimeToStr(Now)+#9+'Showing Log in panel');
  frmLogin.Caption := 'Log into your school account: ';
  WriteLn(Log,TimeToStr(Now)+#9+'Changing form caption to "Log into your school account: "');
end;


procedure TfrmLogIn.btnLoginClick(Sender: TObject);
var
  sEnterUN, sPassword : String;
  cBypass : Char;
begin
  WriteLn(Log,TimeToStr(Now)+#9+'Log in button clicked');

  //Input username and password
  sEnterUN := edtUsername.Text;
  sPassword := edtPassword.Text;
  //Log
  WriteLn(Log,TimeToStr(Now)+#9+'Data entered:');
  WriteLn(log,#9 + #9 + #9 +'Username: '+sEnterUN);
  WriteLn(log,#9 + #9 + #9 +'Password: '+sPassword);

  //Validation
  if sEnterUN = '' then //no username entered
  begin
    ShowMessage('Validation Error: You need to enter a username to log in.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: No Username entered');
    Exit;
  end;

  if sPassword = '' then //no password entered
  begin
    ShowMessage('Validation Error: You need to enter a password to log in.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: No Password entered');
    Exit;
  end;

  if Length(sEnterUN) >30 then //username incorrect length
  begin
    ShowMessage('Validation Error: Your username isn''t the correct legnth. The length of a username is 11 characters.');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Username is incorrect length. Length of username enterred: '+IntToStr(Length(sEnterUN)));
    Exit;
  end;
  if Length(sPassword) > 30 then //password cannot be more than 30 chars - max length in database
  begin
    ShowMessage('Validation Error: Your password cannot be longer than 30 characters. Please re-enter your password');
    WriteLn(Log,TimeToStr(Now)+#9+'Error: Password is more than 30 characters. Length of password enterred: '+IntToStr(Length(sPassword)));
    Exit;
  end;

  //Locate the username in database
  WriteLn(Log,TimeToStr(Now)+#9+'User input validated succesfully');
  if dmUserLogin.tblData.Locate('Username',sEnterUN,[]) = True then //if the username exsists in the database
  begin
  WriteLn(Log,TimeToStr(Now)+#9+'Username has been identified in database');
    if dmUserLogin.tblData['Password'] = sPassword then //if the password of that username is correct - take to verify form
    begin
      WriteLn(Log,TimeToStr(Now)+#9+'Password that corresponds to username is correct');
      WriteLn(Log,TimeToStr(Now)+#9+'Showing frmVerify');
      WriteLn(Log,TimeToStr(Now)+#9+'Hiding frmLogin ');
      sUserName := sEnterUN;
      edtUsername.Clear;
      edtPassword.Clear;
      frmVerify.Show;
      frmLogin.Hide;
      if bShow = True then //if the password is visible, make it invisble for next user
      begin
        WriteLn(Log,TimeToStr(Now)+#9+'CLicked password eye - Hiding it');
        WriteLn(Log,TimeToStr(Now)+#9+'Changing Password char to *');
        imgEye.Picture.LoadFromFile('imgHide.jpg');
        edtPassword.PasswordChar := '*';
        bShow := False;
      end;
    end
    else
    begin
      ShowMessage('LogIn Error: Your username is correct, but your password isn''t. Please enter the correct .'); //if the password of that username isn't correct
      WriteLn(Log,TimeToStr(Now)+#9+'Password entered isn''t correct');
      Exit;
    end;
  end
  else //if the username entered wasn't found in the database
  begin
    ShowMessage('LogIn Error: Your username is invalid! Please enter the correct username.');
    WriteLn(Log,TimeToStr(Now)+#9+'Username has not been found in database');
    Exit;
  end;
  WriteLn(Log,TimeToStr(Now)+#9+'Log In succesful'); //log
  ShowMessage('Both username and password is correct!');

  if dmUserLogin.tblData['User_Type'] = 'A' then //if user is an admin - ask to bypass 2FA
  begin
    cBypass := Upcase(Inputbox('Admin','Welcome '+ dmUserLogin.tblData['First_Name']+'! Would you like to bypass multifactor authentication? <Y/N>', '')[1]);
    WriteLn(Log,TimeToStr(Now)+#9+'User identified as admin');
    WriteLn(Log,TimeToStr(Now)+#9+'Asked if they would like to bypass 2FA. Answer: '+cBypass);
    //Validate answer
    if NOT(cBypass IN['Y','N']) then
    begin
      ShowMessage('Validation Error: You should only enter ''Y'' or ''N''. Please login and try again');
      WriteLn(Log,TimeToStr(Now)+#9+'Answer entered isn''t Y or N. User enterred: '+cBypass);
      frmVerify.Hide;
      WriteLn(Log,TimeToStr(Now)+#9+'Hiding frmVerify');
      frmLogin.Show;
      WriteLn(Log,TimeToStr(Now)+#9+'Showing frmLogin ');
      WriteLn(Log,TimeToStr(Now)+#9+'User should log in again and enter Y or N ');
    end;

  if cBypass = 'Y' then //if they want to bypass 2FA - take to frmEnd, otherwise, do nothing
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'Admin chose to bypass multifactor autentication. Admin entered: '+cBypass);
    WriteLn(Log,TimeToStr(Now)+#9+'Hiding frmLogin ');
    frmLogin.Hide;
    WriteLn(Log,TimeToStr(Now)+#9+'Hiding frmVerify');
    frmVerify.Hide;
    WriteLn(Log,TimeToStr(Now)+#9+'Showing frmEnd');
    frmEnd.Show;

    WriteLn(Log,TimeToStr(Now)+#9+'Showing message that admin succesfully bypassed 2FA');
    ShowMessage('Bypassing multi-factor autehtication');
  end;//if
  end;
end;



procedure TfrmLogIn.btnRegisterBackClick(Sender: TObject);
begin
  //Takes user back to the Login panel
  WriteLn(Log,TimeToStr(Now)+#9+'User clicked Go Back button on register panel');
  WriteLn(Log,TimeToStr(Now)+#9+'Showing login form');
  pnlLogin.Visible := True;
  WriteLn(Log,TimeToStr(Now)+#9+'Hiding register form');
  pnlRegister.Visible := False;
  WriteLn(Log,TimeToStr(Now)+#9+'Changing caption of form to: "Log into your school account: "');
  frmLogin.Caption := 'Log into your school account: ';

  //CLears the components
  edtRegUserN.Clear;
  edtFirstName.Clear;
  edtSurname.Clear;
  edtEnterPW.Clear;
  dtpBirthDate.Date := Date;
  rgpUserType.ItemIndex := -1;
end;

procedure TfrmLogIn.Button1Click(Sender: TObject);
begin
  //For testing!
  frmVerify.Show;
  frmLogin.Hide;
end;

procedure TfrmLogIn.Button2Click(Sender: TObject);
begin
  //For testing!
  frmEnd.Show;
  frmLogin.Hide;
end;

procedure TfrmLogIn.edtEnterPWKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  iHigh, iLow, iSpecial, iNumber, iSpace : Integer;
  k : Integer;
  sTPPassword, sStrength : String;
begin
  //Test Password strength every time you enter a key
  WriteLn(Log,TimeToStr(Now)+#9+'');
  WriteLn(Log,TimeToStr(Now)+#9+'+-+-+-+-+-+-+-+-+-+');
  WriteLn(Log,TimeToStr(Now)+#9+'User enterred a char into password edit box');
  WriteLn(Log,TimeToStr(Now)+#9+'Testing password strength');

  //Criteria:
  bEnterPW := False; //The bEnterPW variable is false until all requirements are met
  //Input
  sTPPassword := edtEnterPW.Text;
  WriteLn(Log,TimeToStr(Now)+#9+'Password enterred so far: '+edtEnterPW.Text);
  //initialize
  iHigh := 0;
  iLow := 0;
  iSpecial := 0;
  iNumber := 0;
  iSPace := 0;
  //Count the number of each characters
  for k := 1 to length(sTPPassword) do
  begin
    if sTPPassword[k] IN ['a'..'z'] then
      inc(iLow)
    else
      if sTPPassword[k] IN ['A'..'Z'] then
        inc(iHigh)
        else
          if sTPPassword[k] in ['0'..'9'] then
            inc(iNumber)
            else
              if sTPPassword[k] = ' ' then
                inc(iSpace)
                else
                  inc(iSpecial);
  end;
  //log
  WriteLn(Log,TimeToStr(Now)+#9+'Number of grouped characters ');
  WriteLn(log,#9 + #9 + #9 +'Lower case: '+IntToStr(iLOw));
  WriteLn(log,#9 + #9 + #9 +'Upper case: '+IntToStr(iHigh));
  WriteLn(log,#9 + #9 + #9 +'Special: '+IntToStr(iSpecial));
  WriteLn(log,#9 + #9 + #9 +'Number: '+IntToStr(iNumber));
  WriteLn(log,#9 + #9 + #9 +'Spaces: '+IntToStr(iSpace));


  //Test if High: ex. aaAA###00aa
  if (iLow>1) AND (iHigh >1) AND (Length(sTPPassword)>10) AND (iSpecial>2) AND (iNumber>1) AND (iSpace = 0) then
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'Password strength high');
    sStrength := 'High';
    WriteLn(Log,TimeToStr(Now)+#9+'Changin label color to green');
    lblPWStrength.Font.Color := rgb(20,95,20); //Green
    WriteLn(Log,TimeToStr(Now)+#9+'User can now register: bEnterPW = True');
    bEnterPW := True;
  end
  else //Test if Medium: ex. aaAA#1a
    if (iLow>1) AND (iHigh >1) AND (Length(sTPPassword)>6) AND (iSpecial>0) AND (iNumber>0) AND (iSpace = 0) then
    begin
      WriteLn(Log,TimeToStr(Now)+#9+'Password strength medium');
      sStrength := 'Medium';
      WriteLn(Log,TimeToStr(Now)+#9+'Changing label color to orange');
      lblPWStrength.Font.Color := rgb(204,102,0); //orange
      WriteLn(Log,TimeToStr(Now)+#9+'User can now register: bEnterPW = True');
      bEnterPW := True;
    end
    else //If not high ot medium it is Low: ex aaaaa
    begin
      WriteLn(Log,TimeToStr(Now)+#9+'Password strengh low');
      sStrength := 'Low';
      WriteLn(Log,TimeToStr(Now)+#9+'Changing label color to red');
      lblPWStrength.Font.Color := rgb(204,0,0); //red
      WriteLn(Log,TimeToStr(Now)+#9+'User cannot register: bEnterPW = False');
      bEnterPW := False;
    end; //if
  WriteLn(Log,TimeToStr(Now)+#9+'Showing strength');
  lblPWStrength.Caption := 'Password strength: '+sStrength; //update label

  if iSpace>0 then //if there is a space
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'Space detected - Cannot log in: bEnterPW = False');
    lblPWStrength.Caption := 'You may not enter a space';
    WriteLn(Log,TimeToStr(Now)+#9+'Changing label color to gray');
    lblPWStrength.Font.Color := rgb(64,64,64); //gray
    bEnterPW := False;
  end;

  if sTPPassword = '' then //if there is no password
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'Nothing enterred yet - Waiting for password: EnterPW = False');
    lblPWStrength.Caption := 'Waiting for Password';
    WriteLn(Log,TimeToStr(Now)+#9+'Changing label color to gray');
    lblPWStrength.Font.Color := rgb(64,64,64); //gray
    bEnterPW := False;
  end;
  WriteLn(Log,TimeToStr(Now)+#9+'+-+-+-+-+-+-+-+-+-+');
  WriteLn(Log,TimeToStr(Now)+#9+'');


end;

procedure TfrmLogIn.FormActivate(Sender: TObject);
begin
  //Log file creation
  sFileName := 'Logs\'+FormatDateTime('yyyy_mm_dd', Date)+' at '+FormatDateTime('hh',Now)+'h'+FormatDateTime('nn',Now)+'.txt'; //saves the file in log folder with the date and time
  AssignFile(Log, sFileName );
  Rewrite(Log); //allows program to write to file
  WriteLn(Log,'File created '+DateToStr(Date)+' at '+TimeToStr(Now));
  writeln(frmLogin.log,'');
  writeln(frmLogin.log,'');
  writeln(frmLogin.log,'*-*-*-*-*-*-*-*-*-*-*-*-*-*');
  WriteLn(Log,TimeToStr(Now)+#9+'frmLogin has been activated');

  dmUserLogin.tblData.Active := True;
  WriteLn(Log,TimeToStr(Now)+#9+'tblData activated');

  //Make form the correct size
  frmLogIn.Width := 456;
  frmLogIn.Height := 287;
  //Move login panel
  pnlLogin.Left := 0;
  pnlLogin.Top := 0;
  pnlRegister.Visible := False;
  frmLogin.Caption := 'Log into your school account: ';

  lblPWStrength.Caption := 'Waiting for Password';
  lblPWStrength.Font.Color := rgb(64,64,64); //gray
  bShow := False;

  sUserName := '';
end;

procedure TfrmLogIn.imgEyeClick(Sender: TObject);
begin
  //Eye image on Login form clicked
  if bShow = False then //If Password isn't visible - make it visible
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'Clicked password eye - Making it visible');
    WriteLn(Log,TimeToStr(Now)+#9+'Changing Password char to #0');
    imgEye.Picture.LoadFromFile('imgShow.jpg');
    edtPassword.PasswordChar := #0;
    bShow := True;
  end
  else //If password is visible - make it invisible
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'CLicked password eye - Hiding it');
    WriteLn(Log,TimeToStr(Now)+#9+'Changing Password char to *');
    imgEye.Picture.LoadFromFile('imgHide.jpg');
    edtPassword.PasswordChar := '*';
    bShow := False;
  end;

end;

procedure TfrmLogIn.imgRegisterEyeClick(Sender: TObject);
begin
  //Eye image on Register form clicked
  if bRegisterShow = False then //If Password isn't visible - make it visible
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'Clicked password eye - Making it visible');
    WriteLn(Log,TimeToStr(Now)+#9+'Changing Password char to #0');
    imgRegisterEye.Picture.LoadFromFile('imgShow.jpg');
    edtEnterPW.PasswordChar := #0;
    bRegisterShow := True;
  end
  else //If password is visible - make it invisible
  begin
    WriteLn(Log,TimeToStr(Now)+#9+'CLicked password eye - Hiding it');
    WriteLn(Log,TimeToStr(Now)+#9+'Changing Password char to *');
    imgRegisterEye.Picture.LoadFromFile('imgHide.jpg');
    edtEnterPW.PasswordChar := '*';
    bRegisterShow := False;
  end;
end;

end.
