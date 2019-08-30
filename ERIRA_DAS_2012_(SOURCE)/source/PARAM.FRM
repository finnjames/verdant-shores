VERSION 5.00
Begin VB.Form Paramfrm 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   Caption         =   "Survey Parameters"
   ClientHeight    =   2535
   ClientLeft      =   6945
   ClientTop       =   1815
   ClientWidth     =   3990
   ControlBox      =   0   'False
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2535
   ScaleWidth      =   3990
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "Cancel"
      Height          =   495
      Left            =   2040
      TabIndex        =   15
      Top             =   1920
      Width           =   1815
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "OK"
      Height          =   495
      Left            =   120
      TabIndex        =   14
      Top             =   1920
      Width           =   1815
   End
   Begin VB.TextBox Text9 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2040
      TabIndex        =   13
      Text            =   "survey"
      Top             =   1560
      Width           =   1815
   End
   Begin VB.TextBox Text8 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2040
      TabIndex        =   12
      Text            =   "degrees"
      Top             =   1200
      Width           =   1815
   End
   Begin VB.TextBox Text7 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2040
      TabIndex        =   11
      Text            =   "degrees"
      Top             =   840
      Width           =   1815
   End
   Begin VB.TextBox Text6 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   3240
      TabIndex        =   10
      Text            =   "secs"
      Top             =   480
      Width           =   495
   End
   Begin VB.TextBox Text5 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2640
      TabIndex        =   9
      Text            =   "mins"
      Top             =   480
      Width           =   495
   End
   Begin VB.TextBox Text4 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2040
      TabIndex        =   7
      Text            =   "hrs"
      Top             =   480
      Width           =   495
   End
   Begin VB.TextBox Text3 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   3240
      TabIndex        =   5
      Text            =   "secs"
      Top             =   120
      Width           =   495
   End
   Begin VB.TextBox Text2 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2640
      TabIndex        =   3
      Text            =   "mins"
      Top             =   120
      Width           =   495
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2040
      TabIndex        =   1
      Text            =   "hrs"
      Top             =   120
      Width           =   495
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "File Name"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   1620
      Width           =   1935
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Maximum Declination"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1260
      Width           =   1935
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Minimum Declination"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   900
      Width           =   1935
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Stop Right Ascension"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   540
      Width           =   1935
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Start Right Ascension"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   180
      Width           =   1935
   End
End
Attribute VB_Name = "Paramfrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Check1_Click()

End Sub

Private Sub Command1_Click()
  RA = 3600 * Val(Text1.Text) + 60 * Val(Text2.Text) + Val(Text3.Text)
  RA = RA - 86400 * Int(RA / 86400)
  RAhr = Int(RA / 3600)
  RAmn = Int((RA - 3600 * RAhr) / 60)
  RAsc = Int((RA - 3600 * RAhr - 60 * RAmn))
  If RAhr = 0 Then
    Text1.Text = "0"
  Else
    Text1.Text = Format$(RAhr, "#")
  End If
  If RAmn = 0 Then
    Text2.Text = "0"
  Else
    Text2.Text = Format$(RAmn, "#")
  End If
  If RAsc = 0 Then
    Text3.Text = "0"
  Else
    Text3.Text = Format$(RAsc, "#")
  End If
  If Paramfrm.Caption = "Spectrum Parameters" Then
    Text6.Text = Text3.Text
    Text5.Text = Str$(Val(Text2.Text) + 3)
    If Val(Text5.Text) > 60 Then
      Text5.Text = Str$(Val(Text5.Text - 60))
      Text4.Text = Str$(Val(Text1.Text + 1))
    Else
      Text4.Text = Text1.Text
    End If
    If Val(Text4.Text) > 24 Then
      Text4.Text = Str$(Val(Text4.Text - 24))
    End If
  End If
  RA = 3600 * Val(Text4.Text) + 60 * Val(Text5.Text) + Val(Text6.Text)
  RA = RA - 86400 * Int(RA / 86400)
  RAhr = Int(RA / 3600)
  RAmn = Int((RA - 3600 * RAhr) / 60)
  RAsc = Int((RA - 3600 * RAhr - 60 * RAmn))
  If RAhr = 0 Then
    Text4.Text = "0"
  Else
    Text4.Text = Format$(RAhr, "#")
  End If
  If RAmn = 0 Then
    Text5.Text = "0"
  Else
    Text5.Text = Format$(RAmn, "#")
  End If
  If RAsc = 0 Then
    Text6.Text = "0"
  Else
    Text6.Text = Format$(RAsc, "#")
  End If
  If Val(Text7.Text) = 0 Then
    Text7.Text = "0"
  Else
    Text7.Text = Format$(Val(Text7.Text), "#.###")
  End If
  If Val(Text8.Text) = 0 Then
    Text8.Text = "0"
  Else
    Text8.Text = Format$(Val(Text8.Text), "#.###")
  End If
  Go$ = "Y"
  If Paramfrm.Caption = "Scan Parameters" And Val(Text8.Text) <= 0 Then
    MsgBox "Data Aquisition Rate Must Be Greater Than Zero", 48, "Scan Parameters Message"
    Go$ = "N"
  End If
  On Error GoTo DirError
  If Paramfrm.Caption <> "Survey Parameters" Then
    Open "data\" + Text9.Text + "a.md1" For Output As #1
    Open "data\" + Text9.Text + "b.md1" For Output As #2
  Else
    Open "data\" + Text9.Text + "a.md2" For Output As #1
    Open "data\" + Text9.Text + "b.md2" For Output As #2
  End If
  If Go$ = "Y" Then
    Opt% = 4 Or 16
    Button% = MsgBox("Are The Entered Parameters Correct?", Opt%, "Scan Parameters Message")
    If Button% = 6 Then
      Erirafrm.Label1.Caption = "Y"
      Paramfrm.Hide
    Else
      Close #1
      Close #2
    End If
  Else
    Close #1
    Close #2
  End If
ExSub:
  Exit Sub
DirError:
  MsgBox Error$, 48, "Scan Parameters Message"
  Go$ = "N"
  Resume ExSub
End Sub

Private Sub Command2_Click()
  Unload Paramfrm
End Sub

