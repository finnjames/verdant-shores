VERSION 5.00
Begin VB.Form Erirafrm 
   Appearance      =   0  'Flat
   BackColor       =   &H0000FF00&
   Caption         =   "ERIRA Data Acquisition System"
   ClientHeight    =   8025
   ClientLeft      =   1440
   ClientTop       =   2100
   ClientWidth     =   11880
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   8025
   ScaleWidth      =   11880
   StartUpPosition =   1  'CenterOwner
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command1 
      Caption         =   "Reset"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   6360
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.OptionButton Option3 
      BackColor       =   &H0000FF00&
      Caption         =   "Faster"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   6000
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.OptionButton Option2 
      BackColor       =   &H0000FF00&
      Caption         =   "Default"
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   5760
      Value           =   -1  'True
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.OptionButton Option1 
      BackColor       =   &H0000FF00&
      Caption         =   "Slower"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   5520
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      Height          =   9495
      Left            =   1440
      ScaleHeight     =   9435
      ScaleWidth      =   17595
      TabIndex        =   10
      Top             =   4560
      Visible         =   0   'False
      Width           =   17655
   End
   Begin VB.CheckBox Check2 
      BackColor       =   &H0000FF00&
      Caption         =   "Channel B"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   4920
      Value           =   1  'Checked
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CheckBox Check1 
      BackColor       =   &H0000FF00&
      Caption         =   "Channel A"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   4560
      Value           =   1  'Checked
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Timer Timer1 
      Left            =   120
      Top             =   120
   End
   Begin VB.Label Label8 
      BackColor       =   &H0000FF00&
      Caption         =   "Speed:"
      Height          =   375
      Left            =   120
      TabIndex        =   11
      Top             =   5280
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label Label9 
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   240
      TabIndex        =   7
      Top             =   3120
      Width           =   7455
   End
   Begin VB.Label Label7 
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   240
      TabIndex        =   6
      Top             =   3840
      Width           =   7335
   End
   Begin VB.Label Label6 
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   240
      TabIndex        =   5
      Top             =   2400
      Width           =   7455
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   240
      TabIndex        =   4
      Top             =   1680
      Width           =   7335
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Top             =   960
      Width           =   7335
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   615
      Left            =   240
      TabIndex        =   2
      Top             =   240
      Width           =   14055
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "N"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   120
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "N"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Visible         =   0   'False
      Width           =   135
   End
   Begin VB.Menu FileMenu 
      Caption         =   "&File"
      Begin VB.Menu AboutMenu 
         Caption         =   "&About ""ERIRA Data Acquisition System"""
      End
      Begin VB.Menu Dummy1 
         Caption         =   "-"
      End
      Begin VB.Menu StopMenu 
         Caption         =   "&Stop "
         Enabled         =   0   'False
      End
      Begin VB.Menu Dummy2 
         Caption         =   "-"
      End
      Begin VB.Menu ExitMenu 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu SurveyMenu 
      Caption         =   "Sur&vey"
      Enabled         =   0   'False
   End
   Begin VB.Menu ScanMenu 
      Caption         =   "&Scan"
      Enabled         =   0   'False
   End
   Begin VB.Menu SpectrumMenu 
      Caption         =   "S&pectrum"
      Enabled         =   0   'False
   End
   Begin VB.Menu CalMenu 
      Caption         =   "&Calibration"
      Begin VB.Menu ClockCalMenu 
         Caption         =   "&Right Ascension"
         Enabled         =   0   'False
      End
      Begin VB.Menu DecCalMenu 
         Caption         =   "&Declination"
      End
   End
End
Attribute VB_Name = "Erirafrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function bytein Lib "xxio.dll" (ByVal ioPort As Integer) As Integer
Private Declare Sub byteout Lib "xxio.dll" (ByVal ioPort As Integer, ByVal oValue As Integer)
'Private Declare Sub sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Dim Cal$
Dim RAo
Dim Tmo
Dim RAmem
Dim Rmem
Dim Scan$
Dim Num%
Dim Total%
Dim RA(3850)
Dim Dec(3850)
Dim Volt(3850)
Dim Volt2(3850)
Dim Place$
Dim Title$
Dim North$
Dim Trigger$
Dim Frst$
Dim Lft$
Dim BpCnt%
Dim DecRd
Dim First
Dim VoltRdMem
Dim DecCal(30)
Dim Swpnmbr%
Dim ioPort As Integer
Dim oValue As Integer
Dim startdate$
Dim starttime$

Dim x(5000)
Dim y(5000)
Dim z(5000)
Dim nmr%
Dim ymin
Dim ymax
Dim yminbox
Dim ymaxbox
Dim zmin
Dim zmax
Dim zminbox
Dim zmaxbox
Dim duration

Dim altColor As Boolean

Dim Sum(3)
Dim reqValue!
Dim actualValue!

Dim handle As Long

'Dim sample%(1), buf%(80), handle&, ret&, flags&, gain&

'trigger constants
Const STARTSOURCE = DatsImmediate
Const STOPSOURCE = DatsScanCount
Const CHANCOUNT = 3
Const SCANS = 1000
Const RATE = 1000 'Hz
'buffer variables
Dim conv_buffer(2 * SCANS * CHANCOUNT)
Dim conv_buffer1(2 * SCANS * CHANCOUNT)
Dim buffer(2 * SCANS * CHANCOUNT) As Integer
Dim maxVolt
Dim scales(CHANCOUNT)
Dim offset(CHANCOUNT)
Dim gains(CHANCOUNT) As Long
Dim channels(CHANCOUNT) As Long
Dim flags(CHANCOUNT) As Long
'used to check acquisition status
Dim active As Long
Dim retCount As Long
'used to stop acquisition
Dim stopacq As Boolean
'returns count of scans completed
Dim scansCollected As Long
'number of scan currently being performed (appears in display window)
Dim scanNumber
'used with autodetection routine
Dim openDevice As String
' Dim deviceType As Integer
Dim compMask As Long
'array holds list of compatible devices connected
Dim deviceName As String


Private Sub AboutMenu_Click()
  Beep
  DanFrm.Show 1
End Sub

Private Sub ClockCalMenu_Click()

'    Open "clock.cal" For Output As #5

  Beep
  RAa$ = ""
  RAa$ = InputBox$("Enter Upcoming Local Right Ascension and Select 'OK' At That Time", "Right Ascension Calibration", "HH:MM:SS")
  If RAa$ <> "" Then
    StopMenu.Enabled = -1
    ExitMenu.Enabled = 0
    DecCalMenu.Enabled = 0
    RAo = 3600 * Val(Left$(RAa$, 2)) + 60 * Val(Right$(Left$(RAa$, 5), 2)) + Val(Right$(RAa$, 2))
    Tmo = Timer
    Timer1.interval = 10
    Timer1.Enabled = -1
    If Cal$ = "N" Then
      Cal$ = "Y1"
    ElseIf (Cal$ = "Y2") Or (Cal$ = "Y") Then
      Cal$ = "Y"
      ScanMenu.Enabled = -1
      SurveyMenu.Enabled = -1
      SpectrumMenu.Enabled = -1
    End If
    
    nmr% = 0
    x(nmr%) = 1
    y(nmr%) = 2
    z(nmr%) = 3
    Label8.Visible = -1
    Option2.value = -1
    Option2.Visible = -1
    Option3.Visible = -1
    Option1.Visible = -1
    Picture1.Visible = -1
    Check1.Visible = -1
    Check2.Visible = -1
    Command1.Visible = -1
    
  End If
End Sub

Private Sub Command1_Click()
    nmr% = 0
    x(nmr%) = 1
    y(nmr%) = 2
    z(nmr%) = 3
    Picture1.Refresh

End Sub

Private Sub DecCalMenu_Click()
  
stopacq = False
goop% = 0
tryagain:
Beep
msg$ = "Use Last Declination Calibration?"
Opt% = 4 Or 32
Button% = MsgBox(msg$, Opt%, "Declination Calibration")
If Button% = 6 Then
  goop% = 0
  Open "dec.cal" For Input As #3
  For Num% = -25 To 100 Step 5
    Input #3, Junk$
    DecCal((Num% + 30) / 5) = Val(Junk$)
    'MsgBox Str$(DecCal((Num% + 30) / 5))
  Next
  Close #3
ElseIf Button% = 7 Then
  If goop% = 0 Then
    Beep
    msg$ = "Make a New Declination Calibration?"
    Opt% = 4 Or 32
    Button1% = MsgBox(msg$, Opt%, "Declination Calibration")
  End If
  If (Button1% = 7) And (goop% = 0) Then
    goop% = 1
  ElseIf (Button = 7) And (goop% = 1) Then
    goop% = 2
  Else
   
'   On Error GoTo ExampleErrorHandler2
'   'gains, flags, and channels defined
'   gains(0) = DgainX2 'X1 = 0-10 V, X2 = 0-5 V
'   flags(0) = DafUnipolar 'all positive, bipolar = neg to pos
'   channels(0) = 0
'      'set number of scans to perform and scan mode
'   Ret = VBdaqAdcSetAcq(handle, DaamNShot, 0, SCANS)
'      'scan settings
'   Ret = VBdaqAdcSetScan(handle, channels(), gains(), flags(), 1)
'      'set scan rate
'   Ret = VBdaqAdcSetFreq(handle, RATE)
'      'set buffer location, size and flag settings
      
gains(0) = DgainX2
gains(1) = DgainX2
gains(2) = DgainX2
flags(0) = DafUnipolar
flags(1) = DafUnipolar
flags(2) = DafUnipolar
channels(0) = 0
channels(1) = 2
channels(2) = 4
scns = SCANS
' Set DaqX error handler to use VB error handler
Ret = VBdaqSetErrorHandler(handle, 100)
On Error GoTo ExampleErrorHandler2
'set number of scans to perform and scan mode
Ret = VBdaqAdcSetAcq(handle, DaamInfinitePost, 0, scns)
'scan settings
Ret = VBdaqAdcSetScan(handle, channels(), gains(), flags(), CHANCOUNT)
'set buffer location, size and flag settings
Ret = VBdaqAdcTransferSetBuffer(handle, buffer(), 100000, DatmDriverBuf + DatmUpdateSingle + DatmCycleOn)
'set to trigger on software trigger
Ret = VBdaqSetTriggerEvent(handle, STARTSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStartEvent)
'set to stop when requested number of scans is completed
Ret = VBdaqSetTriggerEvent(handle, STOPSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStopEvent)
'set scan rate
Ret = VBdaqAdcSetFreq(handle, RATE)
'begin data acquisition
Ret = VBdaqAdcTransferStart(handle)
Ret = VBdaqAdcArm(handle)
Do
    
    For Num% = -25 To 100 Step 5
    Button% = 7
    While Button% = 7
      Beep
      msg$ = "Move The Telescope To " + Str$(Num%) + " Degrees Declination"
      MsgBox msg$, 48, "Declination Calibration"
      Beep
      msg$ = "Is The Telescope At " + Str$(Num%) + " Degrees Declination?"
      Opt% = 4 Or 32
      Button% = MsgBox(msg$, Opt%, "Declination Calibration")
    Wend
   
   Beep
   MsgBox "Wait 1 Second While Declination Calibration Data Are Being Read!!!", 48, "Declination Calibration"
  
      ttt0 = Timer
      While Timer < ttt0 + 1
  Ret = VBdaqAdcTransferGetStat(handle, active, retCount)
      
  If retCount >= scns Then
    Ret = VBdaqAdcTransferBufData(handle, buffer(), scns, DabtmWait, scansCollected)
    DoEvents
    scanNumber = scanNumber + 1
   
q = 0
Sum(q) = 0
For s = 0 To (scansCollected - 1)
  Sum(q) = Sum(q) + buffer(CHANCOUNT * s + q)
Next s
DecCal((Num% + 30) / 5) = Sum(0) / scansCollected

  End If
      Wend
  
 '  Ret = VBdaqAdcTransferSetBuffer(handle, buffer(), SCANS, DatmUpdateSingle + DatmCycleOn)
 '     'set to trigger on software trigger
 '  Ret = VBdaqSetTriggerEvent(handle, STARTSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStartEvent)
 '     'Stop when requested number of scans is completed
 '  Ret = VBdaqSetTriggerEvent(handle, STOPSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStopEvent)
 '     'begin data acquisition
 '  Ret = VBdaqAdcTransferStart(handle)
 '  Ret = VBdaqAdcArm(handle)
 '  Do
 '        'loop until number of scans is completed
 '     Ret = VBdaqAdcTransferGetStat(handle, active&, retCount&)
 '  Loop Until (active And 1) = 0
 '  Ret = VBdaqAdcTransferStop(handle)
 '        'if successful, display message in status label
 '  If Ret = 0 Then
 '    Summ = 0
 '    For nm% = 1 To SCANS
 '      Summ = Summ + buffer(nm% - 1)
 '    Next
 '    DecCal((Num% + 30) / 5) = Summ / SCANS
 '    'MsgBox Str$(Summ / SCANS)
 '  End If
 '     'disarm daq
 '  Ret = VBdaqAdcDisarm(handle)
   
   'Label3.Caption = ""
   
'ioPort = 528
'oValue = 88
'byteout ioPort, oValue
'For Looper = 1 To 100: Next Looper
'MSB = (bytein(529)) And (&HF)
'result = bytein(528) + (MSB * 256)
'If result > 2047 Then dio% = (result - 4095) '* 0.00488 * 0.867
'If result < 2048 Then dio% = result '* 0.00488 * 0.867
'DecCal((Num% + 35) / 10) = dio%

'basadrs% = &H360
'OutByte &H362, &H0
'OutByte &H360, 0
'10 If InByte(basadrs% + 8) >= &H80 Then GoTo 10 'status test loop
'xl% = InByte(basadrs%): xh% = InByte(basadrs% + 1)  'read a/d data
'dio% = 16 * xh% + Int(xl% / 16)                   'COMBINE bytes
'DecCal((Num% + 35) / 10) = dio%
  
  Next
  
stopacq = True

  DoEvents
Loop While (((active And DaafAcqActive&) = DaafAcqActive&) And (stopacq = False))
'disarm daq
Ret = VBdaqAdcDisarm(handle)
Ret = VBdaqAdcTransferStop(handle)
  End If
End If
If goop% = 1 Then
  GoTo tryagain
ElseIf goop% = 0 Then

'MsgBox Str$(button%)
  
  Label2.Caption = "Y"
  ClockCalMenu.Enabled = -1
  If Cal$ = "N" Then
    Cal$ = "Y2"
  ElseIf (Cal$ = "Y1") Or (Cal$ = "Y") Then
    Cal$ = "Y"
    ScanMenu.Enabled = -1
    SurveyMenu.Enabled = -1
    SpectrumMenu.Enabled = -1
  End If
'MsgBox Cal$
  
  On Error GoTo DirError
  Open "dec.cal" For Output As #3
  For Num% = -25 To 100 Step 5
    Print #3, Format$(DecCal((Num% + 30) / 5), "#.######")
  Next
  Close #3
End If
  
ExSub:
  Exit Sub
DirError:
  MsgBox Error$, 48, "Declination Calibration Message"
  Go$ = "N"
  Resume ExSub

ExampleErrorHandler2:
   If daqErrno& > 0 Or Err.Number > 0 Then
          Dim ErrorString$, DaqXErrorString$
          If Err.Number <> 100 Then
                ErrorString$ = "VB Error : " & CStr(Err.Number) & Chr(10) & Err.Description
          Else
                Call VBdaqFormatError(daqErrno&, DaqXErrorString$)
                ErrorString$ = "DaqX Error : " & CStr(daqErrno&) & Chr(10) & DaqXErrorString$
          End If
      MsgBox ErrorString$, , "Error!"
   End If

End Sub


Private Sub ExitMenu_Click()
        'daq closed when exit button is pressed,  only if daq was opened to begin with
    'If handle <> -1 Then
      Ret = VBdaqClose(handle)
      'handle = -1
    'End If ' If ExitMenu.Caption = "&Exit" Then
 '   If Label2.Caption = "N" Then
 '     Unload Paramfrm
 '     Unload MsgFrm
 '     Unload DanFrm
 '     Unload Erirafrm
 '   Else
 '     Opt% = 1 Or 16
 '     button% = MsgBox("Do You Really Want Exit Now?", Opt%, "Exit Message")
 '     If button% = 1 Then
 '       Unload Paramfrm
 '       Unload MsgFrm
 '       Unload DanFrm
 '       Unload Erirafrm
 '     End If
 '   End If
        
    Beep
    Unload Paramfrm
    Unload MsgFrm
    Unload DanFrm
    Unload Erirafrm

  'End If
End Sub

Private Sub Form_Load()

  Cal$ = "N"
  Scan$ = ""
  Place$ = "Beg"
  First = True
      
      'opens first compatible device found
   handle = VBdaqOpen("DaqBoard500_0")
      'if program cannot connect to device, terminate
   If handle = -1 Then
      MsgBox "DAQ board not found... you're screwed!!!", , "Error!!!"
      Exit Sub
   End If
      ' Set DaqX error handler to use VB error handler
   Ret = VBdaqSetErrorHandler(handle, 100)
   On Error GoTo ExampleErrorHandler7
   
ExampleErrorHandler7:
   If daqErrno& > 0 Or Err.Number > 0 Then
          Dim ErrorString$, DaqXErrorString$
          If Err.Number <> 100 Then
                ErrorString$ = "VB Error : " & CStr(Err.Number) & Chr(10) & Err.Description
          Else
                Call VBdaqFormatError(daqErrno&, DaqXErrorString$)
                ErrorString$ = "DaqX Error : " & CStr(daqErrno&) & Chr(10) & DaqXErrorString$
          End If
      MsgBox ErrorString$, , "Error!"
   End If
End Sub

Private Sub HelpMenu_Click()

End Sub

Private Sub Option1_Click()
    duration = 83
    Picture1.Refresh
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next

End Sub

Private Sub Option2_Click()
    duration = 50
    Picture1.Refresh
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next

End Sub

Private Sub Option3_Click()
    duration = 30
    Picture1.Refresh
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next

End Sub

Private Sub ScanMenu_Click()
  Paramfrm.Caption = "Scan Parameters"
  Paramfrm.Label3.Caption = "Declination"
  Paramfrm.Label4.Caption = "Data Acquisition Rate"
  Paramfrm.Text8.Text = "number/second"
  Paramfrm.Text9.Text = "scan"
  Paramfrm.Height = 2940
  Beep
  Paramfrm.Show 1
  If Label1.Caption = "Y" Then
    Label1.Caption = "N"
    'FileMenu.Enabled = 0
    AboutMenu.Enabled = 0
    SurveyMenu.Enabled = 0
    ScanMenu.Enabled = 0
    SpectrumMenu.Enabled = 0
    CalMenu.Enabled = 0
    Title$ = "Scan Message"
    Button% = 7
    While Button% = 7
      Beep
      msg$ = "Move The Telescope To " + Str$(Val(Paramfrm.Text7.Text)) + " Degrees Declination"
      GoSub StopBoard2
      MsgBox msg$, 48, Title$
      Beep
      msg$ = "Is The Telescope At " + Str$(Val(Paramfrm.Text7.Text)) + " Degrees Declination?"
      Opt% = 4 Or 32
      Button% = MsgBox(msg$, Opt%, Title$)
      GoSub StartBoard2
    Wend
      ttty = Timer
      GoSub StopBoard2
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard2
    Scan$ = "CalWarn"
  End If
Exit Sub

StopBoard2:
  Ret = VBdaqAdcDisarm(handle)
  Ret = VBdaqAdcTransferStop(handle)
Return

StartBoard2:
  Ret = VBdaqSetErrorHandler(handle, 100)
  On Error GoTo ExampleErrorHandler4
  Ret = VBdaqAdcSetAcq(handle, DaamInfinitePost, 0, scns)
  Ret = VBdaqAdcSetScan(handle, channels(), gains(), flags(), CHANCOUNT)
  Ret = VBdaqAdcTransferSetBuffer(handle, buffer(), 100000, DatmDriverBuf + DatmUpdateSingle + DatmCycleOn)
  Ret = VBdaqSetTriggerEvent(handle, STARTSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStartEvent)
  Ret = VBdaqSetTriggerEvent(handle, STOPSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStopEvent)
  reqValue = 1000
  Ret = VBdaqAdcSetRate(handle, DarmFrequency, DaasPostTrig, reqValue, actualValue)
  'Ret = VBdaqAdcSetFreq(handle, RATE)
  Ret = VBdaqAdcTransferStart(handle)
  Ret = VBdaqAdcArm(handle)
Return

ExampleErrorHandler4:
   If daqErrno& > 0 Or Err.Number > 0 Then
          Dim ErrorString$, DaqXErrorString$
          If Err.Number <> 100 Then
                ErrorString$ = "VB Error : " & CStr(Err.Number) & Chr(10) & Err.Description
          Else
                Call VBdaqFormatError(daqErrno&, DaqXErrorString$)
                ErrorString$ = "DaqX Error : " & CStr(daqErrno&) & Chr(10) & DaqXErrorString$
          End If
      MsgBox ErrorString$, , "Error!"
   End If


End Sub

Private Sub SpectrumMenu_Click()
  Paramfrm.Caption = "Spectrum Parameters"
  Paramfrm.Label3.Caption = "Declination"
  Paramfrm.Label4.Caption = "Data Acquisition Rate"
  Paramfrm.Text8.Text = "10"                            ' points / second
  Paramfrm.Text9.Text = "spectrum"
  Paramfrm.Height = 2940
  Beep
  Paramfrm.Show 1
  If Label1.Caption = "Y" Then
    Label1.Caption = "N"
    AboutMenu.Enabled = 0
    SurveyMenu.Enabled = 0
    ScanMenu.Enabled = 0
    SpectrumMenu.Enabled = 0
    CalMenu.Enabled = 0
    Title$ = "Spectrum Message"
    Button% = 7
    While Button% = 7
      Beep
      msg$ = "Move The Telescope To " + Str$(Val(Paramfrm.Text7.Text)) + " Degrees Declination"
      GoSub StopBoard4
      MsgBox msg$, 48, Title$
      Beep
      msg$ = "Is The Telescope At " + Str$(Val(Paramfrm.Text7.Text)) + " Degrees Declination?"
      Opt% = 4 Or 32
      Button% = MsgBox(msg$, Opt%, Title$)
      GoSub StartBoard4
    Wend
      ttty = Timer
      GoSub StopBoard4
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard4
    Scan$ = "CalWarn"
  End If
Exit Sub

StopBoard4:
  Ret = VBdaqAdcDisarm(handle)
  Ret = VBdaqAdcTransferStop(handle)
Return

StartBoard4:
  Ret = VBdaqSetErrorHandler(handle, 100)
  On Error GoTo ExampleErrorHandler5
  Ret = VBdaqAdcSetAcq(handle, DaamInfinitePost, 0, scns)
  Ret = VBdaqAdcSetScan(handle, channels(), gains(), flags(), CHANCOUNT)
  Ret = VBdaqAdcTransferSetBuffer(handle, buffer(), 100000, DatmDriverBuf + DatmUpdateSingle + DatmCycleOn)
  Ret = VBdaqSetTriggerEvent(handle, STARTSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStartEvent)
  Ret = VBdaqSetTriggerEvent(handle, STOPSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStopEvent)
  reqValue = 1000
  Ret = VBdaqAdcSetRate(handle, DarmFrequency, DaasPostTrig, reqValue, actualValue)
  'Ret = VBdaqAdcSetFreq(handle, RATE)
  Ret = VBdaqAdcTransferStart(handle)
  Ret = VBdaqAdcArm(handle)
Return

ExampleErrorHandler5:
   If daqErrno& > 0 Or Err.Number > 0 Then
          Dim ErrorString$, DaqXErrorString$
          If Err.Number <> 100 Then
                ErrorString$ = "VB Error : " & CStr(Err.Number) & Chr(10) & Err.Description
          Else
                Call VBdaqFormatError(daqErrno&, DaqXErrorString$)
                ErrorString$ = "DaqX Error : " & CStr(daqErrno&) & Chr(10) & DaqXErrorString$
          End If
      MsgBox ErrorString$, , "Error!"
   End If

End Sub

Private Sub StopMenu_Click()
    'disarm daq
stopacq = True
'Ret = VBdaqAdcDisarm(handle)
'Ret = VBdaqAdcTransferStop(handle)
  Place$ = "Beg"
  First = True

Timer1.Enabled = 0
ExitMenu.Enabled = -1
StopMenu.Enabled = 0
AboutMenu.Enabled = -1
    SurveyMenu.Enabled = 0
    ScanMenu.Enabled = 0
    SpectrumMenu.Enabled = 0
    CalMenu.Enabled = 0
    ClockCalMenu.Enabled = 0
    
    Beep
    Label3.Caption = ""
    Label4.Caption = ""
    Label5.Caption = ""
    Label6.Caption = ""
    Label9.Caption = ""
    Label7.Caption = ""

'MsgBox$ (Cal$)
End Sub

Private Sub SurveyMenu_Click()
  Paramfrm.Caption = "Survey Parameters"
  Paramfrm.Label3.Caption = "Minimum Declination"
  Paramfrm.Label4.Caption = "Maximum Declination"
  Paramfrm.Text8.Text = "degrees"
  Paramfrm.Text9.Text = "survey"
  Paramfrm.Height = 2940
  Beep
  Paramfrm.Show 1
  If Label1.Caption = "Y" Then
    Label1.Caption = "N"
    'FileMenu.Enabled = 0
    AboutMenu.Enabled = 0
    SurveyMenu.Enabled = 0
    ScanMenu.Enabled = 0
    SpectrumMenu.Enabled = 0
    CalMenu.Enabled = 0
    Title$ = "Survey Message"
    Button% = 7
    While Button% = 7
      Beep
      msg$ = "Move The Telescope To " + Str$(Val(Paramfrm.Text7.Text) - 2) + " Degrees Declination"
      GoSub StopBoard3
      MsgBox msg$, 48, Title$
      Beep
      msg$ = "Is The Telescope At " + Str$(Val(Paramfrm.Text7.Text) - 2) + " Degrees Declination?"
      Opt% = 4 Or 32
      Button% = MsgBox(msg$, Opt%, Title$)
      GoSub StartBoard3
    Wend
      ttty = Timer
      GoSub StopBoard3
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard3
    Scan$ = "CalWarn"
    Swpnmbr% = 1
  End If
  
Exit Sub
StopBoard3:
  Ret = VBdaqAdcDisarm(handle)
  Ret = VBdaqAdcTransferStop(handle)
Return
StartBoard3:
  Ret = VBdaqSetErrorHandler(handle, 100)
  On Error GoTo ExampleErrorHandler6
  Ret = VBdaqAdcSetAcq(handle, DaamInfinitePost, 0, scns)
  Ret = VBdaqAdcSetScan(handle, channels(), gains(), flags(), CHANCOUNT)
  Ret = VBdaqAdcTransferSetBuffer(handle, buffer(), 100000, DatmDriverBuf + DatmUpdateSingle + DatmCycleOn)
  Ret = VBdaqSetTriggerEvent(handle, STARTSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStartEvent)
  Ret = VBdaqSetTriggerEvent(handle, STOPSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStopEvent)
  reqValue = 1000
  Ret = VBdaqAdcSetRate(handle, DarmFrequency, DaasPostTrig, reqValue, actualValue)
  'Ret = VBdaqAdcSetFreq(handle, RATE)
  Ret = VBdaqAdcTransferStart(handle)
  Ret = VBdaqAdcArm(handle)
Return
ExampleErrorHandler6:
   If daqErrno& > 0 Or Err.Number > 0 Then
          Dim ErrorString$, DaqXErrorString$
          If Err.Number <> 100 Then
                ErrorString$ = "VB Error : " & CStr(Err.Number) & Chr(10) & Err.Description
          Else
                Call VBdaqFormatError(daqErrno&, DaqXErrorString$)
                ErrorString$ = "DaqX Error : " & CStr(daqErrno&) & Chr(10) & DaqXErrorString$
          End If
      MsgBox ErrorString$, , "Error!"
   End If

End Sub

Private Sub Text1_Change()
If Val(Text1.Text) < 0.01 Then
  Text1.Text = "0.01"
End If
If Val(Text1.Text) > 1 Then
  Text1.Text = "1"
End If
End Sub

Private Sub Timer1_Timer()
'If altColor Then
'    Erirafrm.BackColor = &HFF00DD
'Else
'    Erirafrm.BackColor = &HFF
'End If
'altColor = Not altColor

'startdate$ = ""
'starttime$ = ""
'Label8.Caption = startdate$
'Label10.Caption = Str$(BpCnt)
stopacq = False
gains(0) = DgainX2
gains(1) = DgainX2
gains(2) = DgainX2
flags(0) = DafUnipolar
flags(1) = DafUnipolar
flags(2) = DafUnipolar
channels(0) = 0
channels(1) = 2
channels(2) = 4
If (Scan$ = "CalRead") Or (Scan$ = "BackRead") Then
  scns = 900
ElseIf Scan$ = "ScanRead" Then
  scns = 900 / Val(Paramfrm.Text8.Text)
ElseIf Scan$ = "SweepRead" Then
  scns = 150
Else
  scns = 100
End If
GoSub StartBoard
Do
  Ret = VBdaqAdcTransferGetStat(handle, active, retCount)
 
  If retCount >= scns Then
    Ret = VBdaqAdcTransferBufData(handle, buffer(), scns, DabtmWait, scansCollected)
    DoEvents
    scanNumber = scanNumber + 1

'NEW CODE ABOVE
  
  WindowState = 2
  Delta = Timer - Tmo
  If Delta < 0 Then
    Tmo = Tmo - 86400
    Delta = Delta + 86400
  End If
  Rsec = RAo + Delta * 1.002736111
  'RAmem = RAsec - 1
  
    'Print #5, Format$(RSec, "#.######")
  
  RAsec = Int(Rsec)
  If Scan$ <> "" Then
    If (Title$ = "Scan Message") Or (Title$ = "Spectrum Message") Then
      Rsec = Int(Val(Paramfrm.Text8.Text) * Rsec) / Val(Paramfrm.Text8.Text)
    Else
      Rsec = Int(6 * Rsec) / 6
    End If
  End If
  RARd = RAsec

If (compMask And daq10V) Then
maxVolt = 10 'Max voltage for Daq2K is +/-10V
Else
maxVolt = 5 'Max voltage for Legacy is +/- 5V
End If

'scales and offsets defined
For g = 0 To (CHANCOUNT - 1)
'(flags&DafBipolar) dquals 2 if bipolar or 0 if unipolar
'scales should equal maxVolt/65535 for unipolar, maxVolt/32367 for bipolar
scales(g) = maxVolt / (65535 - (flags(g) And DafBipolar) * 16384)
'offset should equal maxVolt for bipolar, 0 for unipolar
offset(g) = maxVolt * (flags(g) And DafBipolar) / 2
Next g

'conversion routine
For t = 0 To (scansCollected * CHANCOUNT - 1)
'_____
'FOR Visual Basic:
'buffer is defined as a signed integer, which means it has values contained
'between -32768 and +32768;  on the bipolar digital scale of the daq
'say 0 = -5V and 65536=+5V;
'when the buffer value exceeds +32768,  VB records this value
'as the difference between the other end of its integer scale (-32768)
'and the actual value example:  when buffer value is read as -5536 in VB
'this actually means actual reading is at 65536-5536 = 60000
    If buffer(t) >= 0 Then
        conv_buffer(t) = buffer(t) * scales(t Mod CHANCOUNT) - offset(t Mod CHANCOUNT)
    Else
        conv_buffer(t) = Abs(65536 + buffer(t)) * scales(t Mod CHANCOUNT) - offset(t Mod CHANCOUNT)
    End If
Next t

q = 0
Sum(q) = 0
For s = 0 To (scansCollected - 1)
  Sum(q) = Sum(q) + buffer(CHANCOUNT * s + q)
Next s
'Label3.Caption = Str$(Sum(0)) + " " + Str$(scansCollected)
For q = 1 To (CHANCOUNT - 1)
        Sum(q) = 0
        For s = 0 To (scansCollected - 1)
           Sum(q) = Sum(q) + conv_buffer(CHANCOUNT * s + q)
        Next s
Next q
dio = Sum(0) / scansCollected
VoltRd = Sum(1) / scansCollected   ' CH A
VoltRd2 = Sum(2) / scansCollected  ' CH B

'begin plotting code

If (nmr% = 0) And x(nmr%) = 1 And y(nmr%) = 2 And z(nmr%) = 3 Then
  x(nmr%) = 0
  y(nmr%) = VoltRd
  z(nmr%) = VoltRd2
  ymin = y(nmr%) + 1.01
  ymax = y(nmr%) / 1.01
  yminbox = (ymax + ymin) / 2 - (ymax - ymin) / 2 * 1.1
  ymaxbox = (ymax + ymin) / 2 + (ymax - ymin) / 2 * 1.1
  zmin = z(nmr%) + 1.01
  zmax = z(nmr%) / 1.01
  zminbox = (zmax + zmin) / 2 - (zmax - zmin) / 2 * 1.1
  zmaxbox = (zmax + zmin) / 2 + (zmax - zmin) / 2 * 1.1
End If

If Option1.value = True Then
  duration = 83
ElseIf Option2.value = True Then
  duration = 50
Else
  duration = 30
End If

  nmr% = nmr% + 1
  x(nmr%) = x(nmr% - 1) + Timer1.interval / 1000
  y(nmr%) = VoltRd
  z(nmr%) = VoltRd2
  'amp = 100 + 50 * Sin(x(nmr%) / (duration / 2.71) * 2 * 3.14)
  'y(nmr%) = amp * Sin(x(nmr%) / (duration / 2) * 2 * 3.14)
  'amp = 100 + 25 * Sin(x(nmr%) / (duration / 2.71) * 2 * 3.14)
  'z(nmr%) = amp * Sin(x(nmr%) / (duration / 2) * 2 * 3.14)
  If nmr% = duration / (Timer1.interval / 1000) Then
    nmr% = nmr% / 2
    Picture1.Refresh
    ymin = 1000000000000#
    ymax = -1000000000000#
    zmin = 1000000000000#
    zmax = -1000000000000#
    For nmrr% = 0 To nmr%
      x(nmrr%) = x(nmrr% + nmr%)
      y(nmrr%) = y(nmrr% + nmr%)
      z(nmrr%) = z(nmrr% + nmr%)
      If y(nmrr%) < ymin Then
        ymin = y(nmrr%)
      End If
      If y(nmrr%) > ymax Then
        ymax = y(nmrr%)
      End If
      If z(nmrr%) < zmin Then
        zmin = z(nmrr%)
      End If
      If z(nmrr%) > zmax Then
        zmax = z(nmrr%)
      End If
    Next
    yminbox = (ymax + ymin) / 2 - (ymax - ymin) / 2 * 1.1
    ymaxbox = (ymax + ymin) / 2 + (ymax - ymin) / 2 * 1.1
    zminbox = (zmax + zmin) / 2 - (zmax - zmin) / 2 * 1.1
    zmaxbox = (zmax + zmin) / 2 + (zmax - zmin) / 2 * 1.1
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next
  End If
  If y(nmr%) < yminbox Then
    ymin = y(nmr%)
    yminbox = ymax - (ymax - ymin) * 1.2
    Picture1.Refresh
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next
  ElseIf y(nmr%) > ymaxbox Then
    ymax = y(nmr%)
    ymaxbox = ymin + (ymax - ymin) * 1.2
    Picture1.Refresh
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next
  End If
  If z(nmr%) < zminbox Then
    zmin = z(nmr%)
    zminbox = zmax - (zmax - zmin) * 1.2
    Picture1.Refresh
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next
  ElseIf z(nmr%) > zmaxbox Then
    zmax = z(nmr%)
    zmaxbox = zmin + (zmax - zmin) * 1.2
    Picture1.Refresh
    For nmrr% = 1 To nmr%
      xboxold = Picture1.Width - (nmrr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
      xbox = Picture1.Width - nmrr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
      yboxold = Picture1.Height - Picture1.Height * (y(nmrr% - 1) - yminbox) / (ymaxbox - yminbox)
      ybox = Picture1.Height - Picture1.Height * (y(nmrr%) - yminbox) / (ymaxbox - yminbox)
      zboxold = Picture1.Height - Picture1.Height * (z(nmrr% - 1) - zminbox) / (zmaxbox - zminbox)
      zbox = Picture1.Height - Picture1.Height * (z(nmrr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
    Next
  Else
    xboxold = Picture1.Width - (nmr% - 1) / (duration / (Timer1.interval / 1000)) * Picture1.Width
    xbox = Picture1.Width - nmr% / (duration / (Timer1.interval / 1000)) * Picture1.Width
    yboxold = Picture1.Height - Picture1.Height * (y(nmr% - 1) - yminbox) / (ymaxbox - yminbox)
    ybox = Picture1.Height - Picture1.Height * (y(nmr%) - yminbox) / (ymaxbox - yminbox)
    zboxold = Picture1.Height - Picture1.Height * (z(nmr% - 1) - zminbox) / (zmaxbox - zminbox)
    zbox = Picture1.Height - Picture1.Height * (z(nmr%) - zminbox) / (zmaxbox - zminbox)
      If Check1.value = 1 Then
        Picture1.Line (xboxold, yboxold)-(xbox, ybox), vbBlue
      End If
      If Check2.value = 1 Then
        Picture1.Line (xboxold, zboxold)-(xbox, zbox), vbRed
      End If
  End If
  
'end plotting code




'ioPort = 528
'oValue = 88
'byteout ioPort, oValue
'For Looper = 1 To 100: Next Looper
'MSB = (bytein(529)) And (&HF)
'result = bytein(528) + (MSB * 256)
'If result > 2047 Then dio% = (result - 4095) '* 0.00488 * 0.867
'If result < 2048 Then dio% = result '* 0.00488 * 0.867

'basadrs% = &H360
'OutByte &H362, &H0
'OutByte &H360, 0
'20 If InByte(basadrs% + 8) >= &H80 Then GoTo 20 'status test loop
'xl% = InByte(basadrs%): xh% = InByte(basadrs% + 1)  'read a/d data
'dio% = 16 * xh% + Int(xl% / 16)                   'COMBINE bytes

If DecCal(26) > DecCal(1) Then
  If dio < DecCal(2) Then
    DecRd = 5 / (DecCal(2) - DecCal(1)) * (dio - DecCal(1)) - 25
  ElseIf dio < DecCal(3) Then
    DecRd = 5 / (DecCal(3) - DecCal(2)) * (dio - DecCal(2)) - 20
  ElseIf dio < DecCal(4) Then
    DecRd = 5 / (DecCal(4) - DecCal(3)) * (dio - DecCal(3)) - 15
  ElseIf dio < DecCal(5) Then
    DecRd = 5 / (DecCal(5) - DecCal(4)) * (dio - DecCal(4)) - 10
  ElseIf dio < DecCal(6) Then
    DecRd = 5 / (DecCal(6) - DecCal(5)) * (dio - DecCal(5)) - 5
  ElseIf dio < DecCal(7) Then
    DecRd = 5 / (DecCal(7) - DecCal(6)) * (dio - DecCal(6))
  ElseIf dio < DecCal(8) Then
    DecRd = 5 / (DecCal(8) - DecCal(7)) * (dio - DecCal(7)) + 5
  ElseIf dio < DecCal(9) Then
    DecRd = 5 / (DecCal(9) - DecCal(8)) * (dio - DecCal(8)) + 10
  ElseIf dio < DecCal(10) Then
    DecRd = 5 / (DecCal(10) - DecCal(9)) * (dio - DecCal(9)) + 15
  ElseIf dio < DecCal(11) Then
    DecRd = 5 / (DecCal(11) - DecCal(10)) * (dio - DecCal(10)) + 20
  ElseIf dio < DecCal(12) Then
    DecRd = 5 / (DecCal(12) - DecCal(11)) * (dio - DecCal(11)) + 25
  ElseIf dio < DecCal(13) Then
    DecRd = 5 / (DecCal(13) - DecCal(12)) * (dio - DecCal(12)) + 30
  ElseIf dio < DecCal(14) Then
    DecRd = 5 / (DecCal(14) - DecCal(13)) * (dio - DecCal(13)) + 35
  ElseIf dio < DecCal(15) Then
    DecRd = 5 / (DecCal(15) - DecCal(14)) * (dio - DecCal(14)) + 40
  ElseIf dio < DecCal(16) Then
    DecRd = 5 / (DecCal(16) - DecCal(15)) * (dio - DecCal(15)) + 45
  ElseIf dio < DecCal(17) Then
    DecRd = 5 / (DecCal(17) - DecCal(16)) * (dio - DecCal(16)) + 50
  ElseIf dio < DecCal(18) Then
    DecRd = 5 / (DecCal(18) - DecCal(17)) * (dio - DecCal(17)) + 55
  ElseIf dio < DecCal(19) Then
    DecRd = 5 / (DecCal(19) - DecCal(18)) * (dio - DecCal(18)) + 60
  ElseIf dio < DecCal(20) Then
    DecRd = 5 / (DecCal(20) - DecCal(19)) * (dio - DecCal(19)) + 65
  ElseIf dio < DecCal(21) Then
    DecRd = 5 / (DecCal(21) - DecCal(20)) * (dio - DecCal(20)) + 70
  ElseIf dio < DecCal(22) Then
    DecRd = 5 / (DecCal(22) - DecCal(21)) * (dio - DecCal(21)) + 75
  ElseIf dio < DecCal(23) Then
    DecRd = 5 / (DecCal(23) - DecCal(22)) * (dio - DecCal(22)) + 80
  ElseIf dio < DecCal(24) Then
    DecRd = 5 / (DecCal(24) - DecCal(23)) * (dio - DecCal(23)) + 85
  ElseIf dio < DecCal(25) Then
    DecRd = 5 / (DecCal(25) - DecCal(24)) * (dio - DecCal(24)) + 90
  Else
    DecRd = 5 / (DecCal(26) - DecCal(25)) * (dio - DecCal(25)) + 95
  End If
Else
  If dio < DecCal(25) Then
    DecRd = 5 / (DecCal(26) - DecCal(25)) * (dio - DecCal(25)) + 95
  ElseIf dio < DecCal(24) Then
    DecRd = 5 / (DecCal(25) - DecCal(24)) * (dio - DecCal(24)) + 90
  ElseIf dio < DecCal(23) Then
    DecRd = 5 / (DecCal(24) - DecCal(23)) * (dio - DecCal(23)) + 85
  ElseIf dio < DecCal(22) Then
    DecRd = 5 / (DecCal(23) - DecCal(22)) * (dio - DecCal(22)) + 80
  ElseIf dio < DecCal(21) Then
    DecRd = 5 / (DecCal(22) - DecCal(21)) * (dio - DecCal(21)) + 75
  ElseIf dio < DecCal(20) Then
    DecRd = 5 / (DecCal(21) - DecCal(20)) * (dio - DecCal(20)) + 70
  ElseIf dio < DecCal(19) Then
    DecRd = 5 / (DecCal(20) - DecCal(19)) * (dio - DecCal(19)) + 65
  ElseIf dio < DecCal(18) Then
    DecRd = 5 / (DecCal(19) - DecCal(18)) * (dio - DecCal(18)) + 60
  ElseIf dio < DecCal(17) Then
    DecRd = 5 / (DecCal(18) - DecCal(17)) * (dio - DecCal(17)) + 55
  ElseIf dio < DecCal(16) Then
    DecRd = 5 / (DecCal(17) - DecCal(16)) * (dio - DecCal(16)) + 50
  ElseIf dio < DecCal(15) Then
    DecRd = 5 / (DecCal(16) - DecCal(15)) * (dio - DecCal(15)) + 45
  ElseIf dio < DecCal(14) Then
    DecRd = 5 / (DecCal(15) - DecCal(14)) * (dio - DecCal(14)) + 40
  ElseIf dio < DecCal(13) Then
    DecRd = 5 / (DecCal(14) - DecCal(13)) * (dio - DecCal(13)) + 35
  ElseIf dio < DecCal(12) Then
    DecRd = 5 / (DecCal(13) - DecCal(12)) * (dio - DecCal(12)) + 30
  ElseIf dio < DecCal(11) Then
    DecRd = 5 / (DecCal(12) - DecCal(11)) * (dio - DecCal(11)) + 25
  ElseIf dio < DecCal(10) Then
    DecRd = 5 / (DecCal(11) - DecCal(10)) * (dio - DecCal(10)) + 20
  ElseIf dio < DecCal(9) Then
    DecRd = 5 / (DecCal(10) - DecCal(9)) * (dio - DecCal(9)) + 15
  ElseIf dio < DecCal(8) Then
    DecRd = 5 / (DecCal(9) - DecCal(8)) * (dio - DecCal(8)) + 10
  ElseIf dio < DecCal(7) Then
    DecRd = 5 / (DecCal(8) - DecCal(7)) * (dio - DecCal(7)) + 5
  ElseIf dio < DecCal(6) Then
    DecRd = 5 / (DecCal(7) - DecCal(6)) * (dio - DecCal(6))
  ElseIf dio < DecCal(5) Then
    DecRd = 5 / (DecCal(6) - DecCal(5)) * (dio - DecCal(5)) - 5
  ElseIf dio < DecCal(4) Then
    DecRd = 5 / (DecCal(5) - DecCal(4)) * (dio - DecCal(4)) - 10
  ElseIf dio < DecCal(3) Then
    DecRd = 5 / (DecCal(4) - DecCal(3)) * (dio - DecCal(3)) - 15
  ElseIf dio < DecCal(2) Then
    DecRd = 5 / (DecCal(3) - DecCal(2)) * (dio - DecCal(2)) - 20
  Else
    DecRd = 5 / (DecCal(2) - DecCal(1)) * (dio - DecCal(1)) - 25
  End If
End If

'ioPort = 528
'oValue = 89 'try 89 dumbass
'byteout ioPort, oValue
'For Looper = 1 To 100: Next Looper
'MSB = (bytein(529)) And (&HF)
'result = bytein(528) + (MSB * 256)
'If result > 2047 Then dio% = (result - 4095) '* 0.00488 * 0.867
'If result < 2048 Then dio% = result '* 0.00488 * 0.867
'VoltRd = dio * 0.00488

'ioPort = 528
'oValue = 90 '90
'byteout ioPort, oValue
'For Looper = 1 To 100: Next Looper
'MSB = (bytein(529)) And (&HF)
'result = bytein(528) + (MSB * 256)
'If result > 2047 Then dio% = (result - 4095) '* 0.00488 * 0.867
'If result < 2048 Then dio% = result '* 0.00488 * 0.867
'VoltRd2 = dio * 0.00488

'OutByte &H362, &H11
'OutByte &H360, 0
'30 If InByte(basadrs% + 8) >= &H80 Then GoTo 30 'status test loop
'xl% = InByte(basadrs%): xh% = InByte(basadrs% + 1)  'read a/d data
'dio% = 16 * xh% + Int(xl% / 16)                   'COMBINE bytes
'VoltRd = (dio% - 2048) / 2048 * 10
  
  'Label3.Caption = Str$(RAsec) + " " + Str$(RAmem)
  If RAsec > RAmem Then
    RAa = RARd - 86400 * Int(RARd / 86400)
    RAhr = Int(RAa / 3600)
    RAmn = Int((RAa - 3600 * RAhr) / 60)
    RAsc = Int((RAa - 3600 * RAhr - 60 * RAmn))
    If RAhr = 0 Then
      RAS$ = "00:"
    ElseIf RAhr < 10 Then
      RAS$ = "0" + Format$(RAhr, "#") + ":"
    Else
      RAS$ = Format$(RAhr, "#") + ":"
    End If
    If RAmn = 0 Then
      RAS$ = RAS$ + "00:"
    ElseIf RAmn < 10 Then
      RAS$ = RAS$ + "0" + Format$(RAmn, "#") + ":"
    Else
      RAS$ = RAS$ + Format$(RAmn, "#") + ":"
    End If
    If RAsc = 0 Then
      RAS$ = RAS$ + "00"
    ElseIf RAsc < 10 Then
      RAS$ = RAS$ + "0" + Format$(RAsc, "#")
    Else
      RAS$ = RAS$ + Format$(RAsc, "#")
    End If
'Label3.Caption = dio
    Label4.Caption = "Right Ascension: " + RAS$
    Label5.Caption = "Declination: " + Format$(DecRd, "#.####")
    Label6.Caption = "Channel A Voltage: " + Format$(VoltRd, "#.####")
    Label9.Caption = "Channel B Voltage: " + Format$(VoltRd2, "#.####")
    If (Title = "Spectrum Message") And (Scan$ = "ScanRd" Or Scan$ = "ScanRead") Then
      Beep
    End If
  End If
  If (Scan$ <> "ScanRead") And (RAsec > RAmem) Then
    If Scan$ = "CalWarn" Then
      Beep
      If Title$ <> "Spectrum Message" Then
        RAwait$ = Str$(3600 * Val(Paramfrm.Text1.Text) + 60 * Val(Paramfrm.Text2.Text) + Val(Paramfrm.Text3.Text) - 150 - RAsec + 86400 * Int(RAsec / 86400))
      Else
        RAwait$ = Str$(3600 * Val(Paramfrm.Text1.Text) + 60 * Val(Paramfrm.Text2.Text) + Val(Paramfrm.Text3.Text) - 90 - RAsec + 86400 * Int(RAsec / 86400))
      End If
      If (Val(RAwait$) < 0) And (3600 * Val(Paramfrm.Text1.Text) + 60 * Val(Paramfrm.Text2.Text) + Val(Paramfrm.Text3.Text) < 43200) And (RAsec - 86400 * Int(RAsec / 86400) > 43200) Then
        RAwait$ = Str$(Val(RAwait$) + 86400)
      End If
      If Val(RAwait$) <= 1 Then
        If Val(RAwait$) = 1 Then
          Label3.Caption = "CALIBRATION WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
        End If
        Scan$ = "CalRd"
      Else
        Label3.Caption = "CALIBRATION WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
      End If
    ElseIf Scan$ = "CalRd" Then
      If Place$ = "End" Then
        If Title$ <> "Survey Message" Then
          'MsgBox "Gonna save"
          'MsgBox Str$(Total%)
          Beep
          If Title$ = "Scan Message" Then
            Label3.Caption = "SCAN DATA ARE NOW BEING SAVED!!!"
          Else
            Label3.Caption = "SPECTRUM DATA ARE NOW BEING SAVED!!!"
          End If
          Refresh
          For Num% = 1 To Total%
            If RA(Num%) > 86400 Then
              Print #1, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#.##")
              Print #2, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#.##")
            Else
              Print #1, Format$(RA(Num%), "#.##")
              Print #2, Format$(RA(Num%), "#.##")
            End If
            Print #1, Format$(Dec(Num%), "#.####")
            Print #2, Format$(Dec(Num%), "#.####")
            Print #1, Format$(Volt(Num%), "#.####")
            Print #2, Format$(Volt2(Num%), "#.####")
          Next
        End If
        Print #1, "*"
        Print #2, "*"
      End If
      Label3.Caption = ""
      If Title = "Spectrum Message" Then
        Button% = 7
        While Button% = 7
          Beep
          GoSub StopBoard
          MsgBox "Set The Frequency To 110.3 MHz", 48, Title$
          Beep
          Opt% = 4 Or 32
          Button% = MsgBox("Has The Frequency Been Set To 110.3 MHz?", Opt%, Title$)
          GoSub StartBoard
      ttty = Timer
      GoSub StopBoard
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard
        Wend
      End If
      Button% = 7
      While Button% = 7
        Beep
        GoSub StopBoard
        MsgBox "Turn The Calibration Switches On", 48, Title$
        Beep
        Opt% = 4 Or 32
        Button% = MsgBox("Have The Calibration Switches Been Turned On?", Opt%, Title$)
        GoSub StartBoard
      Wend
      ttty = Timer
      GoSub StopBoard
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard
      Beep
      Label3.Caption = "CALIBRATION DATA ARE NOW BEING READ!!!"
      Scan$ = "CalRead"
      Num% = 1
    ElseIf Scan$ = "CalRead" And Title$ <> "Spectrum Message" And Num% <= 60 Then
      RA(Num%) = RAsec
      Dec(Num%) = DecRd
      Volt(Num%) = VoltRd
      Volt2(Num%) = VoltRd2
      'plot data
      Num% = Num% + 1
    ElseIf Scan$ = "CalRead" And Title$ = "Spectrum Message" And Num% <= 20 Then
      RA(Num%) = RAsec
      Dec(Num%) = DecRd
      Volt(Num%) = VoltRd
      Volt2(Num%) = VoltRd2
      'plot data
      Num% = Num% + 1
    ElseIf Scan$ = "CalRead" And Title$ <> "Spectrum Message" And Num% > 60 Then
      Beep
      Label3.Caption = "CALIBRATION DATA ARE NOW BEING SAVED!!!"
      Refresh
      For Num% = 1 To 60
        If RA(Num%) > 86400 Then
          Print #1, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
          Print #2, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
        Else
          Print #1, Format$(RA(Num%), "#")
          Print #2, Format$(RA(Num%), "#")
        End If
        Print #1, Format$(Dec(Num%), "#.####")
        Print #2, Format$(Dec(Num%), "#.####")
        Print #1, Format$(Volt(Num%), "#.####")
        Print #2, Format$(Volt2(Num%), "#.####")
      Next
      Print #1, "*"
      Print #2, "*"
      Label3.Caption = ""
      Button% = 7
      While Button% = 7
        Beep
        GoSub StopBoard
        MsgBox "Turn The Calibration Switches Off", 48, Title$
        Beep
        Opt% = 4 Or 32
        Button% = MsgBox("Have The Calibration Switches Been Turned Off?", Opt%, Title$)
        GoSub StartBoard
      Wend
      ttty = Timer
      GoSub StopBoard
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard
      Beep
      Label3.Caption = "BACKGROUND DATA ARE NOW BEING READ!!!"
      Scan$ = "BackRead"
      Num% = 1
    ElseIf Scan$ = "CalRead" And Title$ = "Spectrum Message" And Num% > 20 Then
      Beep
      Label3.Caption = "CALIBRATION DATA ARE NOW BEING SAVED!!!"
      Refresh
      For Num% = 1 To 20
        For nm% = 1 To 3
          If RA(Num%) > 86400 Then
            Print #1, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
            Print #2, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
          Else
            Print #1, Format$(RA(Num%), "#")
            Print #2, Format$(RA(Num%), "#")
          End If
          Print #1, Format$(Dec(Num%), "#.####")
          Print #2, Format$(Dec(Num%), "#.####")
          Print #1, Format$(Volt(Num%), "#.####")
          Print #2, Format$(Volt2(Num%), "#.####")
        Next
      Next
      Print #1, "*"
      Print #2, "*"
      Label3.Caption = ""
      Button% = 7
      While Button% = 7
        Beep
        GoSub StopBoard
        MsgBox "Turn The Calibration Switches Off", 48, Title$
        Beep
        Opt% = 4 Or 32
        Button% = MsgBox("Have The Calibration Switches Been Turned Off?", Opt%, Title$)
        GoSub StartBoard
      Wend
      ttty = Timer
      GoSub StopBoard
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard
      Beep
      Label3.Caption = "BACKGROUND DATA ARE NOW BEING READ!!!"
      Scan$ = "BackRead"
      Num% = 1
    ElseIf Scan$ = "BackRead" And Title$ <> "Spectrum Message" And Num% <= 60 Then
      RA(Num%) = RAsec
      Dec(Num%) = DecRd
      Volt(Num%) = VoltRd
      Volt2(Num%) = VoltRd2
      'plot data
      Num% = Num% + 1
    ElseIf Scan$ = "BackRead" And Title$ = "Spectrum Message" And Num% <= 20 Then
      RA(Num%) = RAsec
      Dec(Num%) = DecRd
      Volt(Num%) = VoltRd
      Volt2(Num%) = VoltRd2
      'plot data
      Num% = Num% + 1
    ElseIf Scan$ = "BackRead" And Title$ <> "Spectrum Message" And Num% > 60 Then
      Beep
      Label3.Caption = "BACKGROUND DATA ARE NOW BEING SAVED!!!"
      Refresh
      For Num% = 1 To 60
        If RA(Num%) > 86400 Then
          Print #1, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
          Print #2, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
        Else
          Print #1, Format$(RA(Num%), "#")
          Print #2, Format$(RA(Num%), "#")
        End If
        Print #1, Format$(Dec(Num%), "#.####")
        Print #2, Format$(Dec(Num%), "#.####")
        Print #1, Format$(Volt(Num%), "#.####")
        Print #2, Format$(Volt2(Num%), "#.####")
      Next
      Print #1, "*"
      Print #2, "*"
      If Place$ = "Beg" Then
        Scan$ = "ScanWarn"
      Else
        Print #1, "*"
        Print #2, "*"
        GoSub Tailor
        Close #1
        Close #2
        Label3.Caption = ""
        Scan$ = ""
        First = True
        Place$ = "Beg"
        FileMenu.Enabled = -1
        AboutMenu.Enabled = -1
        SurveyMenu.Enabled = -1
        ScanMenu.Enabled = -1
        SpectrumMenu.Enabled = -1
        CalMenu.Enabled = -1
        Unload Paramfrm
        While Tmo < 0
          Tmo = Tmo + 86400
        Wend
      End If
    ElseIf Scan$ = "BackRead" And Title$ = "Spectrum Message" And Num% > 20 Then
      Beep
      Label3.Caption = "BACKGROUND DATA ARE NOW BEING SAVED!!!"
      Refresh
      For Num% = 1 To 20
        For nm% = 1 To 3
          If RA(Num%) > 86400 Then
            Print #1, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
            Print #2, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#")
          Else
            Print #1, Format$(RA(Num%), "#")
            Print #2, Format$(RA(Num%), "#")
          End If
          Print #1, Format$(Dec(Num%), "#.####")
          Print #2, Format$(Dec(Num%), "#.####")
          Print #1, Format$(Volt(Num%), "#.####")
          Print #2, Format$(Volt2(Num%), "#.####")
        Next
      Next
      Print #1, "*"
      Print #2, "*"
      If Place$ = "Beg" Then
        Scan$ = "ScanWarn"
      Else
        Print #1, "*"
        Print #2, "*"
        GoSub Tailor
        Close #1
        Close #2
        Label3.Caption = ""
        Scan$ = ""
        First = True
        Place$ = "Beg"
        FileMenu.Enabled = -1
        AboutMenu.Enabled = -1
        SurveyMenu.Enabled = -1
        ScanMenu.Enabled = -1
        SpectrumMenu.Enabled = -1
        CalMenu.Enabled = -1
        Unload Paramfrm
        While Tmo < 0
          Tmo = Tmo + 86400
        Wend
      End If
    ElseIf Scan$ = "ScanWarn" Then
      Beep
      RAwait$ = Str$(3600 * Val(Paramfrm.Text1.Text) + 60 * Val(Paramfrm.Text2.Text) + Val(Paramfrm.Text3.Text) - RAsec + 86400 * Int(RAsec / 86400))
      If (Val(RAwait$) < 0) And (3600 * Val(Paramfrm.Text1.Text) + 60 * Val(Paramfrm.Text2.Text) + Val(Paramfrm.Text3.Text) < 43200) And (RAsec - 86400 * Int(RAsec / 86400) > 43200) Then
        RAwait$ = Str$(Val(RAwait$) + 86400)
      End If
      If Val(RAwait$) <= 1 Then
        If Title$ = "Scan Message" Then
          If Val(RAwait$) = 1 Then
            Label3.Caption = "SCAN WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
          End If
          Scan$ = "ScanRd"
        ElseIf Title$ = "Spectrum Message" Then
          If Val(RAwait$) = 1 Then
            Label3.Caption = "SPECTRUM WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
          End If
          Scan$ = "ScanRd"
        Else
          If Val(RAwait$) = 1 Then
            Label3.Caption = "SURVEY WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
          End If
          Scan$ = "SweepRd"
        End If
      Else
        If Title$ = "Scan Message" Then
          Label3.Caption = "SCAN WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
        ElseIf Title$ = "Spectrum Message" Then
          Label3.Caption = "SPECTRUM WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
        Else
          Label3.Caption = "SURVEY WILL BEGIN IN" + RAwait$ + " SECONDS!!!"
        End If
      End If
    ElseIf Scan$ = "ScanRd" Then
      Beep
      If Title$ = "Scan Message" Then
        Label3.Caption = "SCAN DATA ARE NOW BEING READ!!!"
      ElseIf Title$ = "Spectrum Message" Then
        Label3.Caption = "SPECTRUM DATA ARE NOW BEING READ!!!"
      End If
      Scan$ = "ScanRead"
      Num% = 1
      startdate$ = "LOCAL START DATE: " + Str$(Date)
      starttime$ = "LOCAL START TIME: " + Str$(Time)
    ElseIf Scan$ = "SweepRd" Then
      Label3.Caption = ""
      Scan$ = "SweepRead"
      Frst$ = "Y"
      Trigger$ = "N"
      North$ = "Y"
      Num% = 1
      BpCnt% = 1
      startdate$ = "LOCAL START DATE: " + Str$(Date)
      starttime$ = "LOCAL START TIME: " + Str$(Time)
      'MsgBox "set", 48, "ok"
    End If
  ElseIf (Scan$ = "ScanRead") And (Rsec > Rmem) Then
    RAwait$ = Str$(3600 * Val(Paramfrm.Text4.Text) + 60 * Val(Paramfrm.Text5.Text) + Val(Paramfrm.Text6.Text) - RAsec + 86400 * Int(RAsec / 86400))
    If (Val(RAwait$) > -600) And (Val(RAwait$) <= 0) Then
      Total% = Num% - 1
      Scan$ = "CalRd"
      Place$ = "End"
    Else
'Label9.Caption = Str$(RSec) + " " + Str$(VoltRd)
      RA(Num%) = Rsec
      Dec(Num%) = DecRd
      Volt(Num%) = VoltRd
      Volt2(Num%) = VoltRd2
      'plot scan Data
      Num% = Num% + 1
    End If
  ElseIf (Scan$ = "SweepRead") And (Rsec > Rmem) Then
    RAwait$ = Str$(3600 * Val(Paramfrm.Text4.Text) + 60 * Val(Paramfrm.Text5.Text) + Val(Paramfrm.Text6.Text) - RAsec + 86400 * Int(RAsec / 86400))
    'Label8.Caption = RAwait$
    'Label10.Caption = Str$(Num%)
    'Label11.Caption = Str$(BpCnt%)
    'Label12.Caption = startdate$
    If (Val(RAwait$) > -600) And (Val(RAwait$) <= 0) Then
      Trigger$ = "Y"
    End If
    If North$ = "Y" And DecRd < Val(Paramfrm.Text7.Text) Then
      If Frst$ = "Y" Then
        Label3.Caption = ""
        If Num% = 1 Then
          MsgFrm.Label1.Caption = "Send The Telescope North At The Maximum Speed"
        Else
          MsgFrm.Label1.Caption = "Stop The Telescope And Send It North At The Maximum Speed"
          Num% = 1
        End If
      Else
        If Num% > 1 Then
          'If Lft$ <> "N" Then
          '  GoSub Survsave
          'Else
            Num% = 1
          'End If
        End If
        Label3.Caption = ""
        MsgFrm.Label1.Caption = "Stop The Telescope And Send It North At The Maximum Speed"
      End If
      If BpCnt% = 1 Then
        Beep
      End If
      If BpCnt% = 6 Then
        BpCnt% = 1
      Else
        BpCnt% = BpCnt% + 1
      End If
      MsgFrm.Show
      'Lft$ = "N"
    ElseIf North$ = "Y" And DecRd > Val(Paramfrm.Text8.Text) And Trigger$ = "N" Then
      Frst$ = "N"
      If Num% > 10 Then
        GoSub Survsave
      End If
      Label3.Caption = ""
      MsgFrm.Label1.Caption = "Stop The Telescope And Send It South At The Maximum Speed"
      If BpCnt% = 1 Then
        Beep
      End If
      If BpCnt% = 6 Then
        BpCnt% = 1
      Else
        BpCnt% = BpCnt% + 1
      End If
      MsgFrm.Show
      North$ = "N"
    ElseIf North$ = "Y" And DecRd > Val(Paramfrm.Text8.Text) And Trigger$ = "Y" Then
      If Num% > 10 Then
        GoSub Survsave
      End If
      Label3.Caption = ""
      Button% = 7
      While Button% = 7
        Beep
        GoSub StopBoard
        MsgBox "Stop The Telescope", 48, Title$
        Beep
        Opt% = 4 Or 32
        Button% = MsgBox("Has The Telescope Been Stopped?", Opt%, Title$)
        GoSub StartBoard
      Wend
      ttty = Timer
      GoSub StopBoard
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      Total% = Num% - 1
      Scan$ = "CalRd"
      Place$ = "End"
    ElseIf North$ = "N" And DecRd > Val(Paramfrm.Text8.Text) Then
      Frst$ = "N"
      If Num% > 1 Then
        'If Lft$ <> "S" Then
        '  GoSub Survsave
        'Else
          Num% = 1
        'End If
      End If
      Label3.Caption = ""
      MsgFrm.Label1.Caption = "Stop The Telescope And Send It South At The Maximum Speed"
      If BpCnt% = 1 Then
        Beep
      End If
      If BpCnt% = 6 Then
        BpCnt% = 1
      Else
        BpCnt% = BpCnt% + 1
      End If
      MsgFrm.Show
      'Lft$ = "S"
    ElseIf North$ = "N" And DecRd < Val(Paramfrm.Text7.Text) And Trigger$ = "N" Then
      Frst$ = "N"
      If Num% > 10 Then
        GoSub Survsave
      End If
      Label3.Caption = ""
      MsgFrm.Label1.Caption = "Stop The Telescope And Send It North At The Maximum Speed"
      If BpCnt% = 1 Then
        Beep
      End If
      If BpCnt% = 6 Then
        BpCnt% = 1
      Else
        BpCnt% = BpCnt% + 1
      End If
      MsgFrm.Show
      North$ = "Y"
    ElseIf North$ = "N" And DecRd < Val(Paramfrm.Text7.Text) And Trigger$ = "Y" Then
      If Num% > 10 Then
        GoSub Survsave
      End If
      Label3.Caption = ""
      Button% = 7
      While Button% = 7
        Beep
        GoSub StopBoard
        MsgBox "Stop The Telescope", 48, Title$
        Beep
        Opt% = 4 Or 32
        Button% = MsgBox("Has The Telescope Been Stopped?", Opt%, Title$)
        GoSub StartBoard
      Wend
      ttty = Timer
      GoSub StopBoard
      Beep
      Label3.Caption = "PLEASE WAIT..."
      Refresh
      While Timer - ttty < 3
      Wend
      Label3.Caption = ""
      GoSub StartBoard
      Total% = Num% - 1
      Scan$ = "CalRd"
      Place$ = "End"
    Else
      MsgFrm.Hide
      Label3.Caption = "SURVEY DATA ARE NOW BEING READ!!!"
      Label7.Caption = "Sweep Number: " + Format$(Swpnmbr%, "#")
      RA(Num%) = Rsec
      Dec(Num%) = DecRd
      Volt(Num%) = VoltRd
      Volt2(Num%) = VoltRd2
      'plot sweep Data
      Num% = Num% + 1
    End If
  End If
  RAmem = RAsec
  Rmem = Rsec
  
'NEW CODE BELOW
  End If
  DoEvents
Loop While (((active And DaafAcqActive&) = DaafAcqActive&) And (stopacq = False))
GoSub StopBoard
  
  Exit Sub

Survsave:
  Total% = Num% - 1
  If Total% < 18 Then
    MsgBox "You're Screwed!!!  Stop, Exit, and Restart!!!", 48, Title$
  End If
  If Num% > 10 Then
    Beep
    Label3.Caption = "SURVEY DATA ARE NOW BEING SAVED!!!"
    Label7.Caption = ""
    Swpnmbr% = Swpnmbr% + 1
    Refresh
    Total% = Int(Total% / 6) * 6
    For Num% = 1 To Total%
      If RA(Num%) > 86400 Then
        Print #1, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#.##")
        Print #2, Format$((RA(Num%) - 86400 * Int(RA(Num%) / 86400)), "#.##")
      Else
        Print #1, Format$(RA(Num%), "#.##")
        Print #2, Format$(RA(Num%), "#.##")
      End If
      Print #1, Format$(Dec(Num%), "#.####")
      Print #2, Format$(Dec(Num%), "#.####")
      Print #1, Format$(Volt(Num%), "#.####")
      Print #2, Format$(Volt2(Num%), "#.####")
    Next
    Print #1, "*"
    Print #2, "*"
    Num% = 1
  End If
  Return
  Exit Sub
  
StopBoard:
  Ret = VBdaqAdcDisarm(handle)
  Ret = VBdaqAdcTransferStop(handle)
Return

StartBoard:
  Ret = VBdaqSetErrorHandler(handle, 100)
  On Error GoTo ExampleErrorHandler3
  Ret = VBdaqAdcSetAcq(handle, DaamInfinitePost, 0, scns)
  Ret = VBdaqAdcSetScan(handle, channels(), gains(), flags(), CHANCOUNT)
  Ret = VBdaqAdcTransferSetBuffer(handle, buffer(), 100000, DatmDriverBuf + DatmUpdateSingle + DatmCycleOn)
  Ret = VBdaqSetTriggerEvent(handle, STARTSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStartEvent)
  Ret = VBdaqSetTriggerEvent(handle, STOPSOURCE, 0, channels(0), gains(0), flags(0), DaqTypeAnalogLocal, 0, 0, DaqStopEvent)
  reqValue = 1000
  Ret = VBdaqAdcSetRate(handle, DarmFrequency, DaasPostTrig, reqValue, actualValue)
  'Ret = VBdaqAdcSetFreq(handle, RATE)
  Ret = VBdaqAdcTransferStart(handle)
  Ret = VBdaqAdcArm(handle)
Return

Tailor:
Print #1, "TELESCOPE: The Mighty Forty"
Print #1, startdate$
Print #1, starttime$
Print #1, "LOCAL STOP DATE: " + Str$(Date)
Print #1, "LOCAL STOP TIME: " + Str$(Time)
Print #2, "TELESCOPE: The Mighty Forty"
Print #2, startdate$
Print #2, starttime$
Print #2, "LOCAL STOP DATE: " + Str$(Date)
Print #2, "LOCAL STOP TIME: " + Str$(Time)
Return

ExampleErrorHandler3:
   If daqErrno& > 0 Or Err.Number > 0 Then
          Dim ErrorString$, DaqXErrorString$
          If Err.Number <> 100 Then
                ErrorString$ = "VB Error : " & CStr(Err.Number) & Chr(10) & Err.Description
          Else
                Call VBdaqFormatError(daqErrno&, DaqXErrorString$)
                ErrorString$ = "DaqX Error : " & CStr(daqErrno&) & Chr(10) & DaqXErrorString$
          End If
      MsgBox ErrorString$, , "Error!  Write Me Down And Then Click Me And See If I Go Away!"
      'MsgBox ErrorString$, , "Error!"
      GoSub StopBoard
      'GoSub StartBoard
   End If
End Sub

