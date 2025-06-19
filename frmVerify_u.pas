unit frmVerify_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmLogin_u, ExtCtrls, StdCtrls, Buttons, pngimage, math, frmEnd_u, dmUserLogin_u;

type
  TfrmVerify = class(TForm)
    pnlOption: TPanel;
    lblChoose: TLabel;
    btnOTP: TButton;
    btnCaptcha: TButton;
    imgOTP: TImage;
    imgCaptcha: TImage;
    pnlOTP: TPanel;
    bmbOTP: TBitBtn;
    lblOTP: TLabel;
    imgOTPKeypad: TImage;
    memInfo: TMemo;
    pnlOTPCOde: TPanel;
    edtEnterOTP: TEdit;
    lblInfo: TLabel;
    bmbReset: TBitBtn;
    btnOTPBack: TButton;
    pnlCaptcha: TPanel;
    lblCaptcha: TLabel;
    ImgDisplayC: TImage;
    bmbOption: TBitBtn;
    bmbCaptcha: TBitBtn;
    lblCInfo: TLabel;
    edtEnterCaptcha: TEdit;
    lblCInfo2: TLabel;
    bmbCReset: TBitBtn;
    btnCGoBack: TButton;
    lblCInfo3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure bmbOptionClick(Sender: TObject);
    procedure btnOTPClick(Sender: TObject);
    procedure edtEnterOTPKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bmbResetClick(Sender: TObject);
    procedure btnOTPBackClick(Sender: TObject);
    procedure bmbCResetClick(Sender: TObject);
    procedure btnCaptchaClick(Sender: TObject);
    procedure btnCGoBackClick(Sender: TObject);
    procedure bmbOTPClick(Sender: TObject);
    procedure bmbCaptchaClick(Sender: TObject);
    procedure edtEnterCaptchaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    sOTP, sCaptcha : String;
    iCaptchaC, iCLength, iType : Integer;
  public
    { Public declarations }
    sImgName : String;
  end;

var
  frmVerify: TfrmVerify;

implementation

{$R *.dfm}

procedure TfrmVerify.bmbCaptchaClick(Sender: TObject);
var
  CaptchaH : TextFile;
  sMessage, sNew : String;
begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Help button on Captcha form clicked');
  AssignFile(CaptchaH,'Help\HelpCaptcha.txt');
  Reset(CaptchaH);
  sMessage := '';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Creating Help message');
  while NOT EOF(CaptchaH) do
  begin
    ReadLn(CaptchaH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing Help message');
  ShowMessage(sMessage);
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Closing help text file');
  closefile(CaptchaH);
end;

procedure TfrmVerify.bmbCResetClick(Sender: TObject);
var
  k, kLines : Integer;
  cChar : char;
  iWidth, iHeight: Integer;
  sType : String;
begin
  //Same code as when the Text Captcha button is clicked
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Captcha Reset button clicked');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Clearing imgDisplayC');
  imgDisplayC.picture := nil;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Clearing edtEnterCaptcha');
  edtEnterCaptcha.Clear;
   //Code to generate captcha - Copied from reset button
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Clearing imgDisplayC');
  imgDisplayC.picture := nil;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Clearing edtEnterCaptcha');
  edtEnterCaptcha.Clear;
  //Generate lines on canvas  (between 15 - 22 lines)
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generating lines');
  for kLines := 1 to randomrange(15,23) do
  begin
    imgDisplayC.Canvas.Pen.Color := rgb(randomrange(25,61),randomrange(75,111),randomrange(25,61)); //selects random colour of line (green)
    imgDisplayC.Canvas.MoveTo(randomrange(0,imgDisplayC.Width),randomrange(0,imgDisplayC.Height)); //Determines where the line starts
    imgDisplayC.Canvas.LineTo(randomrange(0,imgDisplayC.Width),randomrange(0,imgDisplayC.Height)); //Determines where the line ends
  end;
  imgDisplayC.Canvas.Brush.Style := bsClear; //Deselects line drawer

  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Choosing length of captcha');
  iCLength := randomrange(6,10); //Determines the length of captcha (this will be used in calculations and to test the captcha)
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Captcha length: '+IntToStr(iCLength));
  lblCInfo3.Font.Color := rgb(64,64,64); //make color of label gray
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Displaying length of captcha');
  lblCInfo3.Caption := 'Length of Captcha: '+IntToStr(iCLength); //displays the length

  //Will the captcha be uppercase or lowercase
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Determining type of characters generated');
  iType := randomrange(1,3);
  if iType = 1 then
    sType := 'Uppercase'
  else
    sType := 'Lowercase';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Type being generated: '+sType);
  lblCInfo2.Font.Color := rgb(64,64,64); //make color of label gray
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Displaying type');
  lblCInfo2.Caption := 'Only use '+sType; //Displays type to user

  //Font - Creates the font that will be used on the image component's canvas
  imgDisplayC.canvas.font.name := 'Arial';
  imgDisplayC.Canvas.Font.Size := randomrange(25,36);
  imgDisplayC.Canvas.Font.Style := [fsItalic];
  imgDisplayC.Canvas.Font.Height := 30;


  sCaptcha := ''; //Clears the Captcha
  iWidth := 0;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Starting generation of captcha');
  imgDisplayC.Canvas.MoveTo(10,imgDisplayC.Height div 3);
  for k:= 1 to iCLength do //Starts generation
  begin
    imgDisplayC.Canvas.Font.Color := rgb(25,randomrange(75,111),25); //Random colour of char - green
    SetBKmode(imgDisplayC.canvas.handle,transparent);
    //Will it be uppercase or lowercase?
     if iType = 1 then //uppercase
      cChar := chr(randomrange(65,91))
     else  //Lowercase
      cChar := chr(randomrange(97,123));

    iWidth := imgDisplayC.Canvas.PenPos.X + Randomrange(imgDisplayC.Width DIV (iCLength+20),35); //Decidees where the char will be
    //iWidth := iWidth+6+ randomrange(imgDisplayC.Width DIV (iCLength+10),imgDisplayC.Width DIV iCLength); //Flaw, can be too close to one another!

    sCaptcha := sCaptcha + cChar; //Stores the captcha it generates

    imgDisplayC.Canvas.Font.Orientation := randomrange(-400,400); //Rotates the char

    imgDisplayC.canvas.textout(iWidth,imgDisplayC.Height div 3,cChar); //Displayes the char
end; //for
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generated Captcha: '+sCaptcha);

  //Saves the image in the log folder to be reviewed later if needed
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Saving displayed captcha');
  sImgName := frmLogin.sFileName;
  Delete(sImgName,25,4);
  sImgName := sImgName+' '+IntToStr(iCaptchaC)+'.png';
  imgDisplayC.Picture.SaveToFile(sImgName);
  inc(iCaptchaC); //Adds a counter so that each captcha saved with this log has another name
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Displayed captcha saved as:');
  WriteLn(frmLogin.log,#9+#9+#9+sImgName);

  edtEnterCaptcha.Clear;
end;

procedure TfrmVerify.bmbOptionClick(Sender: TObject);
var
  OptionH : TextFile;
  sMessage, sNew : String;
begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Help button on Option form clicked');
  AssignFile(OptionH,'Help\HelpOption.txt');
  Reset(OptionH);
  sMessage := '';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Creating Help message');
  while NOT EOF(OptionH) do
  begin
    ReadLn(OptionH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing Help message');
  ShowMessage(sMessage);
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Closing help text file');
  closefile(OptionH);


end;

procedure TfrmVerify.bmbOTPClick(Sender: TObject);
var
  OTPH : TextFile;
  sMessage, sNew : String;
begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Help button on OTP form clicked');
  AssignFile(OTPH,'Help\HelpOTP.txt');
  Reset(OTPH);
  sMessage := '';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Creating Help message');
  while NOT EOF(OTPH) do
  begin
    ReadLn(OTPH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing Help message');
  ShowMessage(sMessage);
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Closing help text file');
  closefile(OTPH);
end;

procedure TfrmVerify.bmbResetClick(Sender: TObject);
var
  k : Integer;
  sPhrase : String;
  cRandom : Char;
begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'OTP Reset button clicked');
  edtEnterOTP.Clear;
  edtEnterOTP.SetFocus;

  sOTP := '';
  for k := 1 to 6 do
  begin
    cRandom := chr(randomrange(65,91));
    sPhrase := sPhrase +  cRandom;
    WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generating OTP and Phrase');
    case cRandom of
    'A'..'C':   begin
                  sOTP := sOTP + '2';
                end;
    'D'..'F':   begin
                  sOTP := sOTP + '3';
                end;
    'G'..'I':   begin
                  sOTP := sOTP + '4';
                end;
    'J'..'L':   begin
                  sOTP := sOTP + '5';
                end;
    'M'..'O':   begin
                  sOTP := sOTP + '6';
                end;
    'P'..'S':   begin
                  sOTP := sOTP + '7';
                end;
    'T'..'V':   begin
                  sOTP := sOTP + '8';
                end;
    'W'..'Z':   begin
                  sOTP := sOTP + '9';
                end;
    end;//case
  end;//for
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generated Phrase: '+sPhrase);
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generated Decoded OTP: '+sOTP);
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing Phrase to decode');
  pnlOTPCode.Caption:= 'Decode: '+sPhrase;

  pnlOTPCode.Caption:= 'Decode: '+sPhrase;

end;

procedure TfrmVerify.btnCaptchaClick(Sender: TObject);
var
k, kLines : Integer;
  cChar : char;
  iWidth, iHeight: Integer;
  sType : String;
begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Captcha button on Option form clicked');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Hiding pnlOption');
  pnlOption.Visible := False;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing pnlCaptcha');
  pnlCaptcha.Visible := True;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Moving Captcha panel to 0 0');
  pnlCaptcha.Top := 0;
  pnlCaptcha.Left := 0;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Changed form caption to: "Captcha = Regognize and rewrite the text"');
  frmVerify.Caption := 'Captcha - Recognize and rewrite the text:';

  //Code to generate captcha - Copied from reset button
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Clearing imgDisplayC');
  imgDisplayC.picture := nil;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Clearing edtEnterCaptcha');
  edtEnterCaptcha.Clear;
  //Generate lines on canvas  (between 15 - 22 lines)
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generating lines');
  for kLines := 1 to randomrange(15,23) do
  begin
    imgDisplayC.Canvas.Pen.Color := rgb(randomrange(25,61),randomrange(75,111),randomrange(25,61)); //selects random colour of line (green)
    imgDisplayC.Canvas.MoveTo(randomrange(0,imgDisplayC.Width),randomrange(0,imgDisplayC.Height)); //Determines where the line starts
    imgDisplayC.Canvas.LineTo(randomrange(0,imgDisplayC.Width),randomrange(0,imgDisplayC.Height)); //Determines where the line ends
  end;
  imgDisplayC.Canvas.Brush.Style := bsClear; //Deselects line drawer

  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Choosing length of captcha');
  iCLength := randomrange(6,10); //Determines the length of captcha (this will be used in calculations and to test the captcha)
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Captcha length: '+IntToStr(iCLength));
  lblCInfo3.Font.Color := rgb(64,64,64); //make color of label gray
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Displaying length of captcha');
  lblCInfo3.Caption := 'Length of Captcha: '+IntToStr(iCLength); //displays the length

  //Will the captcha be uppercase or lowercase
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Determining type of characters generated');
  iType := randomrange(1,3);
  if iType = 1 then
    sType := 'Uppercase'
  else
    sType := 'Lowercase';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Type being generated: '+sType);
  lblCInfo2.Font.Color := rgb(64,64,64); //make color of label gray
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Displaying type');
  lblCInfo2.Caption := 'Only use '+sType; //Displays type to user

  //Font - Creates the font that will be used on the image component's canvas
  imgDisplayC.canvas.font.name := 'Arial';
  imgDisplayC.Canvas.Font.Size := randomrange(25,36);
  imgDisplayC.Canvas.Font.Style := [fsItalic];
  imgDisplayC.Canvas.Font.Height := 30;


  sCaptcha := ''; //Clears the Captcha
  iWidth := 0;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Starting generation of captcha');
  imgDisplayC.Canvas.MoveTo(10,imgDisplayC.Height div 3);
  for k:= 1 to iCLength do //Starts generation
  begin
    imgDisplayC.Canvas.Font.Color := rgb(25,randomrange(75,111),25); //Random colour of char - green
    SetBKmode(imgDisplayC.canvas.handle,transparent);
    //Will it be uppercase or lowercase?
     if iType = 1 then //uppercase
      cChar := chr(randomrange(65,91))
     else  //Lowercase
      cChar := chr(randomrange(97,123));

    iWidth := imgDisplayC.Canvas.PenPos.X + Randomrange(imgDisplayC.Width DIV (iCLength+20),35); //Decidees where the char will be
    //iWidth := iWidth+6+ randomrange(imgDisplayC.Width DIV (iCLength+10),imgDisplayC.Width DIV iCLength); //Flaw, can be too close to one another!

    sCaptcha := sCaptcha + cChar; //Stores the captcha it generates

    imgDisplayC.Canvas.Font.Orientation := randomrange(-400,400); //Rotates the char

    imgDisplayC.canvas.textout(iWidth,imgDisplayC.Height div 3,cChar); //Displayes the char
end; //for
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generated Captcha: '+sCaptcha);

  //Saves the image in the log folder to be reviewed later if needed
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Saving displayed captcha');
  sImgName := frmLogin.sFileName;
  Delete(sImgName,25,4);
  sImgName := sImgName+' '+IntToStr(iCaptchaC)+'.png';
  imgDisplayC.Picture.SaveToFile(sImgName);
  inc(iCaptchaC); //Adds a counter so that each captcha saved with this log has another name
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Displayed captcha saved as:');
  WriteLn(frmLogin.log,#9+#9+#9+sImgName);

  edtEnterCaptcha.Clear;
end;

procedure TfrmVerify.btnCGoBackClick(Sender: TObject);
begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Go back button on Captcha form clicked - Taking back to pnlOption');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing pnlOption');
  pnlOption.Visible := True;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Hiding pnlCaptcha');
  pnlCaptcha.Visible := False;
  pnlOption.Top := 0;
  pnlOption.Left := 0;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Changed form caption');
  frmVerify.Caption := 'Select an option to verify your identity: ';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Set focus on btnOTP');
  btnOTP.SetFocus;
end;

procedure TfrmVerify.btnOTPBackClick(Sender: TObject);
begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Go back button on OTP form clicked');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing pnlOption');
  pnlOption.Visible := True;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Hiding pnlVisible');
  pnlOTP.Visible := False;
  pnlOption.Top := 0;
  pnlOption.Left := 0;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Changing form caption to: "Select an option to verify your identity"');
  frmVerify.Caption := 'Select an option to verify your identity: ';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Set the pfocus on btnCaptha');
  btnCaptcha.SetFocus;

end;

procedure TfrmVerify.btnOTPClick(Sender: TObject);
var
  k : Integer;
  sPhrase : String;
  cRandom : char;
begin
  //Takes user to OTP panel
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'OTP button on option form clicked');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Hiding pnlOption');
  pnlOption.Visible := False;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing pnlOTP');
  pnlOTP.Visible := True;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Moving OTP panel to 0 0');
  pnlOTP.Top := 0;
  pnlOTP.Left := 0;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Changed form caption to: "OTP - Decode the phrase in panel:"');
  frmVerify.Caption := 'OTP - Decode the phrase in panel:';
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Set focus on edtEnterOTP');
  edtEnterOTP.SetFocus;

  //Generate and show OTP
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generating OTP and Phrase');
  //Generating phrase to decode with length of 6 chars
  for k := 1 to 6 do
  begin
    cRandom := chr(randomrange(65,91));
    sPhrase := sPhrase +  cRandom;

    case cRandom of
    'A'..'C':   begin //if the char generated is A-C, then the number 2 will be added to the OTP
                  sOTP := sOTP + '2';
                end;
    'D'..'F':   begin //if the char generated is D-F, then the number 3 will be added to the OTP
                  sOTP := sOTP + '3';
                end;
    'G'..'I':   begin //if the char generated is G-I, then the number 4 will be added to the OTP
                  sOTP := sOTP + '4';
                end;
    'J'..'L':   begin //if the char generated is J-L, then the number 5 will be added to the OTP
                  sOTP := sOTP + '5';
                end;
    'M'..'O':   begin //if the char generated is M-O, then the number 6 will be added to the OTP
                  sOTP := sOTP + '6';
                end;
    'P'..'S':   begin//if the char generated is P-S, then the number 7 will be added to the OTP
                  sOTP := sOTP + '7';
                end;
    'T'..'V':   begin //if the char generated is T-V, then the number 8 will be added to the OTP
                  sOTP := sOTP + '8';
                end;
    'W'..'Z':   begin //if the char generated is W-Z, then the number 9 will be added to the OTP
                  sOTP := sOTP + '9';
                end;
    end;//case
  end;//for
  //log
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generated Phrase: '+sPhrase);
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Generated Decoded OTP: '+sOTP);
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing Phrase to decode');
  pnlOTPCode.Caption:= 'Decode: '+sPhrase;

  edtEnterOTP.Clear;
end;



procedure TfrmVerify.edtEnterCaptchaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sEnteredC, sNew, sName : String;
  k : Integer;
begin
  //When the user enters a new character
  sNew := edtEnterCaptcha.Text; //
  for k := 1 to length(edtEnterCaptcha.Text) do //validate input
  if iType = 1 then //If the captcha generated uses Uppercase then the user cannot enter any other char than uppercase chars
  begin
    if NOT(edtEntercAPTCHA.Text[k] IN['A'..'Z']) then
      begin
        WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Error: User enterred a an invalid character (not an uppercase letter)');
        ShowMessage('Validation Error: You cannot enter characters that aren''t Capital letters.');
        //delete the space or other character...
        WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Deleting character');
        Delete(sNew,k,1); //deletes the last char of sNew
        edtEnterCaptcha.Text := sNew; //
        edtEnterCaptcha.SelStart := k-1; //Sets the Focus next to the last character - otherwise, focus will be set at the start of the edtbox
        WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Character deleted. Focus set');
        Exit;
    end;
  end
  else
    if NOT(edtEnterCaptcha.Text[k] IN['a'..'z']) then  //Lowercase - see explanation above
      begin
        WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Error: User enterred a an invalid character (not a lowercase letter)');
        ShowMessage('Validation Error: You cannot enter characters that aren''t Lowercase letters.');
        //delete the space or other character...
        WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Deleting character');
        Delete(sNew,k,1);
        edtEnterCaptcha.Text := sNew;
        edtEnterCaptcha.SelStart := k-1;
        WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Character deleted. Focus set');
    end;

  sEnteredC := edtEnterCaptcha.Text;
  if Length(sEnteredC) = iCLength then //if the captcha is the correct length it wil test if the captcha is correct
  begin
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Length of Captcha entered = Lenght of generated captcha');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Entered captcha: '+sEnteredC);
      if sEnteredC = sCaptcha then //captcha correct
        begin
          dmUserLogin.tblData.Locate('Username',frmLogin.sUserName,[]); //gets first name to display
          sName := dmUserLogin.tblData['First_Name'];
          WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Extracted First Name from database and stored it');
          WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Captcha correct. Showing message with First Name');
          ShowMessage('Your captcha is correct! Welcome '+sName+'!');
          edtEnterCaptcha.Clear;
          //Take to form 3
          WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Showing frmEnd');
          frmEnd.Show;
          WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Hiding frmVerify');
          frmVerify.Hide;
        end
      else //Incorrect
        begin
          WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Entered captcha isn''t correct. Showing message');
          ShowMessage('Verification Error: The Captcha that you enterred isn''t correct');
        end;
  end
  else if Length(edtEnterCaptcha.Text) > iCLength then //if it is longer than the length of the captcha
    begin
      sNew := edtEnterCaptcha.Text; //same code as Uppercase and Lowercase validation - see explanation there
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Error: Captcha is longer than '+IntToStr(iClength)+' chars. Showing message');
      ShowMessage('Validation Error: The Captcha has a length of '+IntToStr(iCLength)+' characters. Do not enter more than '+IntToStr(iCLength)+' characters, because the Capthca will not be valid.');
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Deleting extra character');
      Delete(sNew,Length(edtEnterCaptcha.Text),1);
      edtEnterCaptcha.Text := sNew;
      edtEnterCaptcha.SelStart := iCLength;
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Character deleted. Focus set');
      Exit;
    end;


end;

procedure TfrmVerify.edtEnterOTPKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  k : Integer;
  sNew, sName : String;
begin
  sNew := edtEnterOTP.Text;
  for k := 1 to length(edtEnterOTP.Text) do //validate input
  if NOT(edtEnterOTP.Text[k] IN['0'..'9']) then //if the user entered a char that isn't a number - same code as Uppercase and Lowercase validation of Captcha - see explanation there
    begin
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Error: User enterred a space or a character that isn''t a number');
      ShowMessage('Validation Error: You cannot enter a space or any other character than numbers');
      //delete the space or other character...
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Deleting character');
      Delete(sNew,k,1);
      edtEnterOTP.Text := sNew;
      edtEnterOTP.SelStart := k-1;
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Character deleted. Focus set');
      Exit;
  end;


  if length(edtEnterOTP.Text) = 6 then //if OTP entered is correct length
  begin //if it is the correct length
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'OTP enterred is correct length');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'OTP enterred: '+edtEnterOTP.Text);
    if edtEnterOTP.Text = sOTP then
    begin //OTP correc succefull
      dmUserLogin.tblData.Locate('Username',frmLogin.sUserName,[]); //gets first name to display
      sName := dmUserLogin.tblData['First_Name'];
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Extracted First Name from database and stored it');
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'OTP is verified and correct. Showing message with First Name');
      SHowMessage('The OTP you entered is correct. Welcome '+sName+'!');
      edtEnterOTP.Clear;
      //Take to form 3
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Taking user to frmEnd');
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Shwoing frmEnd');
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Hiding frmVerify');
      frmVerify.Hide;
      frmEnd.Show;
    end
    else
      begin//incorrect OTP entered
        ShowMessage('Verification Error: Wrong decoded OTP enterred');
        WriteLn(frmLogin.log,TimeToStr(Now)+#9+'OTP entered is not correct');
      end;
  end
  else if length(edtEnterOTP.Text) > 6 then //longer than 6 chars - same code as Uppercase and Lowercase validation of Captcha - see explanation there
  begin
    sNew := edtEnterOTP.Text;
    WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Error: OTP is longer than 6 chars. Showing message');
    ShowMessage('Validation Error: The OTP has a length of 6 characters. Do not enter more than 6 characters, because the PIN will not be valid.');
    WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Deleting extra character');
      Delete(sNew,7,1);
      edtEnterOTP.Text := sNew;
      edtEnterOTP.SelStart := 6;
      WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Character deleted. Focus set');
      Exit;
  end;
end;

procedure TfrmVerify.FormActivate(Sender: TObject);
begin
  //Log file update
  writeln(frmLogin.log,'');
  writeln(frmLogin.log,'');
  writeln(frmLogin.log,'*-*-*-*-*-*-*-*-*-*-*-*-*-*');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'frmVerify has been activated');

  pnlOTP.Visible := False;
  pnlCaptcha.Visible := False;
  pnlOption.Visible := True;
  //Make form the correct size
  frmVerify.Width := 456;
  frmVerify.Height := 287;
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'Changed caption of form to "Select an option to verify your identity: "');
  frmVerify.Caption := 'Select an option to verify your identity: ';

  sOTP := '';
  sCaptcha:= '';
  iCaptchaC := 0;
end;




end.
