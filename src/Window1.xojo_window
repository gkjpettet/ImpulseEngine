#tag Window
Begin Window Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "0"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   True
   Height          =   680
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1930582015
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "PhysicsKit"
   Type            =   "0"
   Visible         =   True
   Width           =   1024
   Begin PushButton ButtonStart
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Start"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   924
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   640
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton ButtonPauseResume
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Pause"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   832
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   640
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton ButtonStop
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Stop"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   740
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   640
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Timer WorldUpdateTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   18
      RunMode         =   "0"
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin Label Info
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   640
      Transparent     =   False
      Underline       =   False
      Value           =   ""
      Visible         =   True
      Width           =   590
   End
   Begin Canvas Display
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   608
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Visible         =   True
      Width           =   984
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function DebugRun() As Boolean Handles DebugRun.Action
			Window1.StartSimulation
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub StartSimulation()
		  Using PhysicsKit
		  
		  PhysicsKit.Initialise
		  
		  Var fps As Integer = 30
		  MyWorld = New World(1 / fps, 10)
		  
		  UpdateCycles = 0
		  
		  Var b As Body
		  Var displayCentreX As Double = Display.Width / 2
		  Var displayCentreY As Double = Display.Height / 2
		  
		  // Add some dynamic circles.
		  // b = MyWorld.Add(New Circle(15), displayCentreX - 10, 0)
		  // b = MyWorld.Add(New Circle(20), displayCentreX, 110)
		  // b = MyWorld.Add(New Circle(35), displayCentreX - 20, 200)
		  // b = MyWorld.Add(New Circle(20), displayCentreX - 100, 100)
		  // b = MyWorld.Add(New Circle(30), displayCentreX - 120, 40)
		  
		  // Dynamic polygon.
		  // b = MyWorld.Add(New Polygon(New Vector(0, 0), New Vector(30, -45), New Vector(60, -20), _
		  // New Vector(75, 20), New Vector(40, 40)), displayCentreX + 50, 50)
		  
		  // Ground.
		  b = MyWorld.Add(New Box(Display.Width - 1, 8), displayCentreX, Display.Height - 9)
		  b.IsStatic = True
		  b.SetOrient(0)
		  b.StaticFriction = 1
		  
		  // Pink box1.
		  b = MyWorld.Add(New Box(25, 25), 600, Display.Height - 27)
		  
		  // Orange circle1.
		  b = MyWorld.Add(New Circle(12.5), 400, Display.Height - 27)
		  // Push the circle rightwards.
		  b.Push(New Vector(50, 0), 5)
		  
		  // // Box2 (orange).
		  // b = MyWorld.Add(New Box(25, 25), 700, 100)
		  // b.SetOrient(Maths.DegreesToRadians(45))
		  // b.StaticFriction = 0
		  
		  // Bigger static circle.
		  b = MyWorld.Add(New Circle(50), displayCentreX, displayCentreY)
		  b.IsStatic = True
		  b.SetOrient(PhysicsKit.Maths.DegreesToRadians(45))
		  
		  ButtonPauseResume.Caption = "Pause"
		  ButtonPauseResume.Enabled = True
		  ButtonStop.Enabled = True
		  ButtonStart.Enabled = False
		  WorldUpdateTimer.RunMode = Timer.RunModes.Multiple
		  WorldUpdateTimer.Period = 1000 / fps
		  WorldUpdateTimer.Enabled = True
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		MyWorld As PhysicsKit.World
	#tag EndProperty

	#tag Property, Flags = &h0
		ShouldUpdateWorld As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		UpdateCycles As Integer = 0
	#tag EndProperty


#tag EndWindowCode

#tag Events ButtonStart
	#tag Event
		Sub Action()
		  StartSimulation
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonPauseResume
	#tag Event
		Sub Action()
		  If Me.Caption = "Pause" Then
		    Me.Caption = "Resume"
		    ButtonStop.Enabled = True
		    WorldUpdateTimer.Enabled = False
		  Else // User wants to resume the simulation.
		    Me.Caption = "Pause"
		    WorldUpdateTimer.Enabled = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonStop
	#tag Event
		Sub Action()
		  Me.Enabled = False
		  ButtonStart.Enabled = True
		  Info.Value = "Simulation not running"
		  WorldUpdateTimer.Enabled = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events WorldUpdateTimer
	#tag Event
		Sub Action()
		  Window1.MyWorld.Update
		  //Window1.UpdateCycles = Window1.UpdateCycles + 1
		  //Window1.Info.Value = "Update cycles: " + Window1.UpdateCycles.ToString
		  
		  Window1.Display.Invalidate
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Display
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  If MyWorld = Nil Then Return
		  
		  Var b As PhysicsKit.Body
		  Var c As PhysicsKit.Circle
		  Var p As PhysicsKit.Polygon
		  For Each b In MyWorld.Bodies
		    If b.Shape IsA PhysicsKit.Circle Then
		      c = PhysicsKit.Circle(b.Shape)
		      
		      Var rx As Double = Cos(b.Orientation) * c.Radius
		      Var ry As Double = Sin(b.Orientation) * c.Radius
		      
		      g.DrawingColor = &cFF0000
		      Var diameter As Double = c.radius * 2
		      g.DrawOval(b.Position.X - c.Radius, b.Position.Y - c.Radius, diameter, diameter)
		      g.DrawLine(b.Position.X, b.Position.Y, b.Position.X + rx, b.Position.Y + ry)
		      
		    ElseIf b.Shape IsA PhysicsKit.Polygon Then
		      p = PhysicsKit.Polygon(b.Shape)
		      
		      If b.ID = 1 Then
		        g.DrawingColor = &cFF31A300 // Pink.
		      ElseIf b.ID = 2 Then
		        g.DrawingColor = &cFFA20000 // Orange.
		      Else
		        g.DrawingColor = &c0000FF
		      End If
		      
		      Var origin As PhysicsKit.Vector = New PhysicsKit.Vector(p.Vertices(0))
		      Call p.U.MultiplySelf(origin)
		      Call origin.AddSelf(b.Position)
		      
		      Var currentPos, previousPos As PhysicsKit.Vector
		      previousPos = origin
		      For i As Integer = 1 To p.VertexCount - 1
		        currentPos = New PhysicsKit.Vector(p.Vertices(i))
		        Call p.U.MultiplySelf(currentPos)
		        Call currentPos.AddSelf(b.Position)
		        
		        g.DrawLine(previousPos.X, previousPos.Y, currentPos.X, currentPos.Y)
		        
		        previousPos = currentPos
		      Next i
		      // g.DrawingColor = &c00FF00
		      g.DrawLine(currentPos.X, currentPos.Y, origin.X, origin.Y)
		      
		    End If
		  Next b
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
