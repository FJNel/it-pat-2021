unit frmEnd_u;
//TAB STOPS!
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmUserLogin_u, frmLogin_u, StdCtrls, ExtCtrls, Menus, ComCtrls, math, DateUtils,
  Buttons, Spin;

type
  TfrmEnd = class(TForm)
    pnlLearner: TPanel;
    lblLearnerW: TLabel;
    sedTask1: TSpinEdit;
    sedTask2: TSpinEdit;
    sedTask3: TSpinEdit;
    sedTask4: TSpinEdit;
    edtLTask1: TEdit;
    edtLTask2: TEdit;
    edtLTask3: TEdit;
    edtLTask4: TEdit;
    lblLName: TLabel;
    lblMark: TLabel;
    sedTotal1: TSpinEdit;
    lblTotal: TLabel;
    sedTotal2: TSpinEdit;
    sedTotal4: TSpinEdit;
    sedTotal3: TSpinEdit;
    sedWeight1: TSpinEdit;
    lblWeight: TLabel;
    sedWeight2: TSpinEdit;
    sedWeight3: TSpinEdit;
    sedWeight4: TSpinEdit;
    lblPerc: TLabel;
    btnCalc: TButton;
    bmbLReset: TBitBtn;
    bmbLHelp: TBitBtn;
    pnlPerc1: TPanel;
    pnlPerc2: TPanel;
    pnlPerc3: TPanel;
    pnlPerc4: TPanel;
    lblLInfo: TLabel;
    pnlLAverage: TPanel;
    lblLResult: TLabel;
    pnlTeacher: TPanel;
    lblTeacherW: TLabel;
    lblTInfo1: TLabel;
    lblTInfo2: TLabel;
    redTOutput: TRichEdit;
    btnTAdd: TButton;
    btnClassP: TButton;
    pnlClassP: TPanel;
    lblTResult: TLabel;
    bmbTReset: TBitBtn;
    bmbTHelp: TBitBtn;
    pnlAdminView: TPanel;
    lblAdminW: TLabel;
    lblAViewLog: TLabel;
    dtpFileDate: TDateTimePicker;
    lblADate: TLabel;
    lblATime: TLabel;
    edtATime: TEdit;
    btnALOad: TButton;
    redALoad: TRichEdit;
    btnAGoL: TButton;
    btnAGoT: TButton;
    btnABackL: TButton;
    btnABackT: TButton;
    bmbAReset: TBitBtn;
    bmbAClose: TBitBtn;
    bmbTClose: TBitBtn;
    bmbLClose: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure bmbLHelpClick(Sender: TObject);
    procedure bmbLResetClick(Sender: TObject);
    procedure btnTAddClick(Sender: TObject);
    procedure btnClassPClick(Sender: TObject);
    procedure bmbTResetClick(Sender: TObject);
    procedure bmbTHelpClick(Sender: TObject);
    procedure btnALOadClick(Sender: TObject);
    procedure btnAGoLClick(Sender: TObject);
    procedure btnABackLClick(Sender: TObject);
    procedure btnABackTClick(Sender: TObject);
    procedure btnAGoTClick(Sender: TObject);
    procedure bmbAResetClick(Sender: TObject);
    procedure bmbACloseClick(Sender: TObject);
    procedure bmbTCloseClick(Sender: TObject);
    procedure bmbLCloseClick(Sender: TObject);
  private
    { Private declarations }
    iCount : Integer;
    rTotalP : Real;
    sClassName : String;
    bHeadings : Boolean;
  public
    { Public declarations }
  end;

var
  frmEnd: TfrmEnd;

implementation
uses
  frmVerify_u;
{$R *.dfm}

procedure TfrmEnd.bmbTCloseClick(Sender: TObject);
begin
  WriteLn(frmLogin.Log,'');
  WriteLn(frmLogin.Log,'Feedback: '+InputBox('Feedback','If you would like to give us any feedback, please enter it below: ',''));
  WriteLn(frmLogin.Log,'Program closed on teacher panel');
  closefile(frmLogin.Log);
end;

procedure TfrmEnd.bmbTHelpClick(Sender: TObject);
var
  TeacherH: TextFile;
  sMessage, sNew: String;
begin
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 +'Help button on Teacher form clicked');
  AssignFile(TeacherH, 'Help\HelpTeachers.txt');
  Reset(TeacherH);
  sMessage := '';
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 + 'Creating Help message');
  while NOT EOF(TeacherH) do
  begin
    ReadLn(TeacherH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 + 'Showing Help message');
  ShowMessage(sMessage);
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 + 'Closing help text file');
  closefile(TeacherH);
end;

procedure TfrmEnd.bmbACloseClick(Sender: TObject);
begin
  WriteLn(frmLogin.Log,'');
  WriteLn(frmLogin.Log,'Program closed on admin panel');
  closefile(frmLogin.Log);
end;

procedure TfrmEnd.bmbAResetClick(Sender: TObject);
begin
  redALOad.Lines.Clear;
  dtpFileDate.Date := Date;
  edtATIme.Clear;
end;

procedure TfrmEnd.bmbLCloseClick(Sender: TObject);
begin
  WriteLn(frmLogin.Log,'');
  WriteLn(frmLogin.Log,'Feedback: '+InputBox('Feedback','If you would like to give us any feedback, please enter it below: ',''));
  WriteLn(frmLogin.Log,'Program closed on learner panel');
  closefile(frmLogin.Log);
end;

procedure TfrmEnd.bmbLHelpClick(Sender: TObject);
var
  LearnerH: TextFile;
  sMessage, sNew: String;
begin
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 +
      'Help button on Teacher form clicked');
  AssignFile(LearnerH, 'Help\HelpLearners.txt');
  Reset(LearnerH);
  sMessage := '';
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 + 'Creating Help message');
  while NOT EOF(LearnerH) do
  begin
    ReadLn(LearnerH, sNew);
    if sMessage = '' then
    begin
      sMessage := sNew;
    end
    else
    begin
    sMessage := sMessage + #10 + sNew;
    end;
  end;
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 + 'Showing Help message');
  ShowMessage(sMessage);
  WriteLn(frmLogin.log, TimeToStr(Now) + #9 + 'Closing help text file');
  closefile(LearnerH);
end;

procedure TfrmEnd.bmbLResetClick(Sender: TObject);
begin
  edtLTask1.Clear;
  edtLTask2.Clear;
  edtLTask3.Clear;
  edtLTask4.Clear;
  sedTask1.Value := 0;
  sedTask2.Value := 0;
  sedTask3.Value := 0;
  sedTask4.Value := 0;
  sedTotal1.Value := 0;
  sedTotal2.Value := 0;
  sedTotal3.Value := 0;
  sedTotal4.Value := 0;
  sedWeight1.Value := 0;
  sedWeight2.Value := 0;
  sedWeight3.Value := 0;
  sedWeight4.Value := 0;
  pnlPerc1.Caption := '';
  pnlPerc2.Caption := '';
  pnlPerc3.Caption := '';
  pnlPerc4.Caption := '';
  lblLResult.Caption := '';
  pnlLAverage.Caption := '';

end;

procedure TfrmEnd.bmbTResetClick(Sender: TObject);
begin
  iCount := 0;
  rTotalP := 0;
  sClassName := '';
  sClassName := '';
  bHeadings := False;

  redTOutput.Lines.Clear;
  lblTResult.Caption := '';
  pnlClassP.Caption := '';

  redTOutput.Paragraph.TabCount := 3;
  redTOutput.Paragraph.Tab[0] := 25;
  redTOutput.Paragraph.Tab[1] := 95;
  redTOutput.Paragraph.Tab[2] := 165;


end;

procedure TfrmEnd.btnABackLClick(Sender: TObject);
begin
  //Takes back to admin panel
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Back button on learner form clicked by admin');
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Moving Admin panel to 0 0 and Making it visible');
  pnlAdminView.Visible := True;
  pnlAdminView.Left := 0;
  pnlAdminView.Top := 0;
  dtpFileDate.Date := Date;
  frmEnd.Width := 456;
  frmEnd.Height := 343;
  frmEnd.Caption := 'Admin - View log files';
  lblAdminW.Caption := 'Welcome '+dmUserLogin.tblData['First_Name']+' '+dmUserLogin.tblData['Last_Name']+'!';
  pnlLearner.Visible := False;
end;

procedure TfrmEnd.btnABackTClick(Sender: TObject);
begin
  //takes back to admin panel
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Back button on learner form clicked by admin');
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Moving Admin panel to 0 0 and Making it visible');
  pnlAdminView.Visible := True;
  pnlAdminView.Left := 0;
  pnlAdminView.Top := 0;
  dtpFileDate.Date := Date;
  frmEnd.Width := 456;
  frmEnd.Height := 343;
  frmEnd.Caption := 'Admin - View log files';
  lblAdminW.Caption := 'Welcome '+dmUserLogin.tblData['First_Name']+' '+dmUserLogin.tblData['Last_Name']+'!';
  pnlTeacher.Visible := False;
end;

procedure TfrmEnd.btnAGoLClick(Sender: TObject);
begin
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Go to learner panel clicked');
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Moving Learner panel to 0 0 and Making it visible');
  pnlLearner.Visible := True;
  pnlLearner.Left := 0;
  pnlLearner.Top := 0;
  lblLearnerW.Caption := 'Welcome '+dmUserLogin.tblData['First_Name']+' '+dmUserLogin.tblData['Last_Name']+'!';
  frmEnd.Caption := 'Learner - Calculate subject average';
  frmEnd.Width := 456;
  frmEnd.Height := 343;

  pnlAdminView.Visible := False;
  btnABackL.Visible := True;
  btnABackL.Enabled := True;

end;

procedure TfrmEnd.btnAGoTClick(Sender: TObject);
begin
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Go to teacher panel clicked');
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Moving Teacher panel to 0 0 and Making it visible');
  pnlTeacher.Visible := True;
  pnlTeacher.Left := 0;
  pnlTeacher.Top := 0;
  lblTeacherW.Caption := 'Welcome '+dmUserLogin.tblData['First_Name']+' '+dmUserLogin.tblData['Last_Name']+'!';
  frmEnd.Caption := 'Teacher - Calculate class average';
  frmEnd.Width := 456;
  frmEnd.Height := 343;
  iCount := 0;
  bHeadings := False;
  redTOutput.Paragraph.TabCount := 3;
  redTOutput.Paragraph.Tab[0] := 25;
  redTOutput.Paragraph.Tab[1] := 95;
  redTOutput.Paragraph.Tab[2] := 165;
  pnlAdminView.Visible := False;
  btnABackT.Visible := True;
  btnABackT.Enabled := True;
end;

procedure TfrmEnd.btnALOadClick(Sender: TObject);
var
  sFileN, sTime : String;
  dDate : TDate;
  iHours, iMin, iDateComp : Integer;
begin
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Load button clicked');
  //Input
  sTime := edtATime.Text;
  dDate := dtpFileDate.Date;

  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Data entered: sTime = '+sTime+' | dDate = '+DateToStr(dDate));

  //Validate = Time
  if sTime = '' then //no time entered
  begin
    ShowMessage('Validation Error: The time is needed to load a file. Please enter a time');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: No time entered');
    Exit;
  end;

  if length(sTime) > 5 then //time longer than 5 chars
  begin
    ShowMessage('Validation Error: Time cannot be longer than 5 chars');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Time string longer than 5 chars');
    Exit;
  end;

  if TryStrToInt(copy(sTime,1,2),iHours) = False then //cannot convert hours to number
  begin
    ShowMessage('Validation Error: No number entered as hours');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Hours can''t convert to int');
    Exit;
  end
  else
  begin
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Hours converted to int');
  end;

  if upcase(copy(sTime,3,2)[1]) <> 'H' then //3rd char = H/h
  begin
    ShowMessage('Validation Error: 3rd char not h or H');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: 3rd char not h or H');
    Exit;
  end;

  if TryStrToInt(copy(sTime,4,2),iMin) = False then //cannot minutes hours to number
  begin
    ShowMessage('Validation Error: No number entered as minutes');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Minutes can''t convert to int');
    Exit;
  end
  else
  begin
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Minutes converted to int');
    end;
  //Validate - Date
  iDateComp := CompareDate(Date, dDate); //If the value is -1, it is a future date. Cannot enter future date as Birth Date
  if (iDateComp < 0) then
  begin
    ShowMessage('Validation Error: You need to enter today''s date or a past date to load a file');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Future date used');
    Exit;
  end;

  //Generate file name
  sFileN := 'Logs\'+FormatDateTime('yyyy_mm_dd', dDate)+' at '+sTime+'.txt';

  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Trying to load: '+sFileN);
  if sFileN = frmLogin.sFileName then //Cannot load log file that's being written
  begin
    ShowMessage('User Error: You cannot load the text file that''s currecntly being logged. Please load an older file');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Tried to load file thats being written!' );
    Exit;
  end;

  if FileExists(sFileN) then   //if the file exists
  begin
    redALoad.Lines.LoadFromFile(sFileN);
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'File loaded');
  end
  else //if it doesn;t - error
  begin
    ShowMessage('User Error: File '+sFileN+' does not exist!');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: No file found');
    Exit;
  end;


end;


procedure TfrmEnd.btnCalcClick(Sender: TObject);
var
  sName1, sName2, sName3, sName4 : String;
  iMark1, iMark2, iMark3, iMark4 : Integer;
  iTotal1, iTotal2, iTotal3, iTotal4 : Integer;
  iWeight1, iWeight2, iWeight3, iWeight4 : Integer;
  rPerc1, rPerc2, rPerc3, rPerc4 : Real;

  k, iTotalW : Integer;
  rAverage : Real;
  sSubject : String;
begin
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Calculate average button clicked');
  //Input - Subject
  sSubject := InputBox('Subject','Enter the name of this subject: ','');
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Subject entered: '+sSubject);
  //Input - Name
  sName1 := edtLTask1.Text;
  sName2 := edtLTask2.Text;
  sName3 := edtLTask3.Text;
  sName4 := edtLTask4.Text;
  //Input - Mark
  iMark1 := sedTask1.Value;
  iMark2 := sedTask2.Value;
  iMark3 := sedTask3.Value;
  iMark4 := sedTask4.Value;
  //Input - Total
  iTotal1 := sedTotal1.Value;
  iTotal2 := sedTotal2.Value;
  iTotal3 := sedTotal3.Value;
  iTotal4 := sedTotal4.Value;
  //Input - Weight
  iWeight1 := sedWeight1.Value;
  iWeight2 := sedWeight2.Value;
  iWeight3 := sedWeight3.Value;
  iWeight4 := sedWeight4.Value;

  //Show in Log
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Input from user:');
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 1 Name: '+sName1);
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 1 Mark: '+IntToStr(iMark1));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 1 Total: '+IntToStr(iTotal1));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 1 Weight: '+IntToStr(iWeight1));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 2 Name: '+sName2);
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 2 Mark: '+IntToStr(iMark2));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 2 Total: '+IntToStr(iTotal2));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 2 Weight: '+IntToStr(iWeight2));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 3 Name: '+sName3);
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 3 Mark: '+IntToStr(iMark3));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 3 Total: '+IntToStr(iTotal3));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 3 Weight: '+IntToStr(iWeight3));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 4 Name: '+sName4);
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 4 Mark: '+IntToStr(iMark4));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 4 Total: '+IntToStr(iTotal4));
  WriteLn(frmLogin.Log,#9+#9+#9+'Task 4 Weight: '+IntToStr(iWeight4));

  //Validate //if the mark is bigger than the total of the test
  if iMark1 > iTotal1 then
  begin
    ShowMessage('Validation Error: Your Mark for task 1 is bigger than the total of that task. You cannot have more for a task than its total.');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Mark for task 1 higher than task 1 total');
    Exit;
  end;
  if iMark2 > iTotal2 then
  begin
    ShowMessage('Validation Error: Your Mark for task 2 is bigger than the total of that task. You cannot have more for a task than its total.');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Mark for task 2 higher than task 2 total');
    Exit;
  end;
  if iMark3 > iTotal3 then
  begin
    ShowMessage('Validation Error: Your Mark for task 3 is bigger than the total of that task. You cannot have more for a task than its total.');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Mark for task 3 higher than task 3 total');
    Exit;
  end;
  if iMark4 > iTotal4 then
  begin
    ShowMessage('Validation Error: Your Mark for task 4 is bigger than the total of that task. You cannot have more for a task than its total.');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Mark for task 4 higher than task 4 total');
    Exit;
  end;

  //Calculate and display %
  rPerc1 := 0;
  rPerc2 := 0;
  rPerc3 := 0;
  rPerc4 := 0;

  //if the percentage of a task isn't 0, it will be calulated. You cannot divide by 0
  if iTotal1 <> 0 then
  begin
    rPerc1 := iMark1/iTotal1 * 100;
    pnlPerc1.Caption := FloatToStrF(rPerc1,ffFixed,10,2)+'%';
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Task 1 Pecentage: '+FloatToStrF(rPerc1,ffFixed,10,2)+'%');
  end
  else
    pnlPerc1.Caption := 'N/A';

  if iTotal2 <> 0 then
  begin
    rPerc2 := iMark2/iTotal2 * 100;
    pnlPerc2.Caption := FloatToStrF(rPerc2,ffFixed,10,2)+'%';
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Task 2 Pecentage: '+FloatToStrF(rPerc2,ffFixed,10,2)+'%');
  end
  else
    pnlPerc2.Caption := 'N/A';

  if iTotal3 <> 0 then
  begin
    rPerc3 := iMark3/iTotal3 * 100;
    pnlPerc3.Caption := FloatToStrF(rPerc3,ffFixed,10,2)+'%';
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Task 3 Pecentage: '+FloatToStrF(rPerc3,ffFixed,10,2)+'%');
  end
  else
    pnlPerc3.Caption := 'N/A';

  if iTotal4 <> 0 then
  begin
    rPerc4 := iMark4/iTotal4 * 100;
    pnlPerc4.Caption := FloatToStrF(rPerc4,ffFixed,10,2)+'%';
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Task 4 Pecentage: '+FloatToStrF(rPerc4,ffFixed,10,2)+'%');
  end
  else
    pnlPerc4.Caption := 'N/A';

    //Validate weight - if the weight's total isn't 100%
    iTotalW := iWeight1 + iWeight2 + iWeight3 + iWeight4;
    if iTotalW <> 100 then
    begin
      ShowMessage('Validation Error: The total of all your weights combined should be 100%. If you add all the weights you entered, the total is: '+IntToStr(iTotalW)+'%. This means the weights you entered aren''t valid. Please enter valid weights (that will give a total of 100%)');
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Total weight not 100%. Total weight is: '+IntToStr(iTotalW)+'%.');
      Exit;
    end;

    //Calculate average
    rAverage := (rPerc1*iWeight1 + rPerc2*iWeight2 + rPerc3*iWeight3 + rPerc4*iWeight4)/100;
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Calculating average: '+FloatToStrF(rPerc1,ffFixed,10,2)+' * '+IntToStr(iWeight1)+' + '+
    FloatToStrF(rPerc2,ffFixed,10,2)+' * '+IntToStr(iWeight2)+' + '+FloatToStrF(rPerc3,ffFixed,10,2)+' * '+IntToStr(iWeight3)+' + '+FloatToStrF(rPerc4,ffFixed,10,2)+' * '+IntToStr(iWeight4)+
    ' / 100');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Average =  '+FloatToStrF(rAverage,ffFixed,10,4)+'%');
    //Show average
    lblLResult.Caption := 'Your average for '+sSubject+' is:';
    pnlLAverage.Caption := FloatToStrF(rAverage,ffFixed,10,0)+'%';
end;

procedure TfrmEnd.btnClassPClick(Sender: TObject);
var
  rClassAve : Real;
begin
  if rTotalP = 0 then
  begin
    ShowMessage('Validation Error: No Percantages to work with. You need to enter at least one learner''s Percentage to calculate the class average');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'No percentages to work with'+FloatToStrF(rTotalP,ffFixed,10,2)+'%.');
    Exit;
  end;

  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Calculate class average button clicked');
  rClassAve := rTotalP / (iCount*100) * 100;
  pnlClassP.Caption := FloatToStrF(rClassAve,ffFixed,10,2)+'%';
  lblTResult.Caption := sCLassName+'''s Class average: ';
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Class average: '+FloatToStrF(rClassAve,ffFixed,10,2)+'%');
end;

procedure TfrmEnd.btnTAddClick(Sender: TObject);
var
  sName, sSurname, sNumber, sPerc : String;
  k, iNumber : Integer;
  rPerc : Real;
begin
  if bHeadings = False then //if the richedit doesn't have any headings - it will generate headings
  begin
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Generrating headings - not yet generated');
    sClassName := InputBox('Class name','Enter the name of the class (ex: 10-5)','');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Class name entered: '+sClassName);
    redTOutput.Lines.Add('Text generated on: '+DateToStr(Date)+' for class: '+sClassName);
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Top info generated: "Text generated on: '+DateToStr(Date)+' for class: '+sClassName+'"' );
    redTOutput.Lines.Add('Num'+#9+'Name'+#9+'Surname'+#9+'Percentage');
    redTOutput.Lines.Add('');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Headings generated: "Num'+#9+'Name'+#9+'Surname'+#9+'Percentage"');
    bHeadings := True;
  end;

  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Add button clicked');
  sNumber := Inputbox('Add learners','How many learners would you like to add?',''); //how much will we have to loop?
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Number of learners to add: '+sNumber);

  //Validation - if sNumber isn't a number
  if tryStrToInt(sNumber,iNumber) = False then
  begin
    ShowMessage('Validation Error: You need to enter a number. Please try again.');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Didn''t enter number as number of learners!');
    Exit;
  end
  else
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Number of learners converted to integer');

  if iNumber <1 then //if there isn't at least 1 learner to add
  begin
    ShowMessage('Validation Error: There cannot be less than 1 learner in a class!');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: sNumber smaller than 1 - cannot loop!');
    Exit;
  end;

  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Starting loop');
  for k := 1 to iNumber do
  begin
    //Input
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Loop number: '+IntToStr(k));
    sName := InputBox('Name','Enter the name of the learner: ','');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Name of learner:'+sName);
    if sName = '' then //no name entered - exit
    begin
      ShowMessage('Validation Error: You need to enter a name for the learner. Please try again. To continue adding learners, click the "Add More" button.');
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Didn''t enter learner name!');
      Exit;
    end;

    sSurName := InputBox('Surname','Enter the surname of the learner (Name of learner: '+sName+'): ','');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Surname of learner:'+sSurname);
    if sSurname = '' then //no surname entered - exit
    begin
      ShowMessage('Validation Error: You need to enter a surname for the learner. Please try again. To continue adding learners, click the "Add More" button.');
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Didn''t enter learner surname!');
      Exit;
    end;
    rPerc := 0;
    sPerc := InputBox('Percentage','Enter the percantage of the learner ('+sName+' '+sSurname+'): ','');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Percentage of learner: '+sPerc);
    if sPerc = '' then //no % entered - % = 0
      rPerc := 0
    else
    try //if the % entered isn't a valid real number
      rPerc := StrToFLoat(sPerc);
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Percantage converted to real');
    except
      ShowMessage('Validation Error: You need to enter a valid percentage - without a % sign. To continue adding learners, click the "Add More" button.');
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Error: Could not convert % to real number');
      Exit;
    end;

    rTotalP := rTotalP + rPerc; //total percentage of learners
    inc(iCount); //total learners

    //Show
    redTOutput.Lines.Add(IntToStr(iCount)+#9+sName+#9+sSurname+#9+FloatToStrF(rPerc,ffFixed,10,2)+'%');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Added: "'+IntToStr(iCOunt)+#9+sName+#9+sSurname+#9+FloatToStrF(rPerc,ffFixed,10,2)+'%" to richedit');
    ShowMessage(sName+' '+sSurname+' with '+FloatToStrF(rPerc,ffFixed,10,2)+'%, added succesfully. Click OK to continue');
    {WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'');
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'');}
  end;//for
end;

procedure TfrmEnd.FormActivate(Sender: TObject);
var
  cUserType : Char;
begin
  //Log file updated
  writeln(frmLogin.log,'');
  writeln(frmLogin.log,'');
  writeln(frmLogin.log,'*-*-*-*-*-*-*-*-*-*-*-*-*-*');
  WriteLn(frmLogin.log,TimeToStr(Now)+#9+'frmEnd has been activated');

  //Test if the User Type
  dmUserLogin.tblData.Locate('Username',frmLogin.sUserName,[]);
  cUserType := Copy(dmUserLogin.tblData['User_Type'],1,1)[1];
  //Manual override
  //cUserType := 'T';
  WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'User Type = '+cUserType);

  pnlLearner.Visible := False;
  pnlTeacher.Visible := False;
  pnlAdminView.Visible := False;
  //form correct size
  frmEnd.Width := 456;
  frmEnd.Height := 343;

  if cUserType = 'L' then
  begin
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'User identified as Learner. User Type = '+cUserType);
    WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Moving Learner panel to 0 0 and Making it visible');
    pnlLearner.Visible := True;
    pnlLearner.Left := 0;
    pnlLearner.Top := 0;
    lblLearnerW.Caption := 'Welcome '+dmUserLogin.tblData['First_Name']+' '+dmUserLogin.tblData['Last_Name']+'!'; //welome message
    frmEnd.Caption := 'Learner - Calculate subject average';
    frmEnd.Width := 456;
    frmEnd.Height := 343;
    btnABackL.Visible := False;
    btnABackL.Enabled := False;
  end
  else
  begin
    if cUserType = 'T' then
    begin
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'User identified as Teacher. User Type = '+cUserType);
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Moving Teacher panel to 0 0 and Making it visible');
      pnlTeacher.Visible := True;
      pnlTeacher.Left := 0;
      pnlTeacher.Top := 0;
      lblTeacherW.Caption := 'Welcome '+dmUserLogin.tblData['First_Name']+' '+dmUserLogin.tblData['Last_Name']+'!'; //welcome message
      frmEnd.Caption := 'Teacher - Calculate class average';
      iCount := 0;
      bHeadings := False;
      redTOutput.Paragraph.TabCount := 3;
      //Tab stops
      redTOutput.Paragraph.Tab[0] := 25;
      redTOutput.Paragraph.Tab[1] := 95;
      redTOutput.Paragraph.Tab[2] := 165;
      btnABackT.Visible := False;
      btnABackT.Enabled := False;
    end
    else
      if cUserType = 'A' then
      
      begin
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'User identified as Admin. User Type = '+cUserType);
      WriteLn(frmLogin.Log,TimeToStr(Now)+#9+'Moving Admin panel to 0 0 and Making it visible');
      pnlAdminView.Visible := True;
      pnlAdminView.Left := 0;
      pnlAdminView.Top := 0;
      dtpFileDate.Date := Date;
      frmEnd.Caption := 'Admin - View log files';
      lblAdminW.Caption := 'Welcome '+dmUserLogin.tblData['First_Name']+' '+dmUserLogin.tblData['Last_Name']+'!';
      end;
   end;


end;

end.
