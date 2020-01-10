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
      Left            =   144
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
      Width           =   584
   End
   Begin Canvas Display
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   628
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
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
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1024
   End
   Begin CheckBox CheckBoxWeightless
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Weightless?"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   640
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   "0"
      Width           =   112
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
		Sub CollisionOccurred(sender As PhysicsKit.World, m As PhysicsKit.Manifold)
		  #Pragma Unused sender
		  #Pragma Unused m
		  
		  System.DebugLog("Collision occurred")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartSimulation()
		  Const FPS = 60
		  
		  MyWorld = New PhysicsKit.World(1/FPS, 5)
		  AddHandler MyWorld.CollisionOccurred, AddressOf CollisionOccurred
		  
		  Var b As PhysicsKit.Body
		  Var dh As Double = Display.Height
		  Var dw As Double = Display.Width
		  Var dcx As Double = dw / 2
		  Var dcy As Double = dh / 2
		  
		  // Ground.
		  b = MyWorld.AddBox(dcx, dh - 9, dw - 1, 8)
		  b.IsStatic = True
		  
		  // Left wall.
		  b = MyWorld.AddBox(5, dh / 2 - 7, dh - 14, 10)
		  b.IsStatic = True
		  b.Orientation = PhysicsKit.Maths.DegreesToRadians(90)
		  
		  // Right wall.
		  b = MyWorld.AddBox(dw - 6, dh / 2 - 7, dh - 14, 10)
		  b.IsStatic = True
		  b.Orientation = PhysicsKit.Maths.DegreesToRadians(270)
		  
		  // Triangle.
		  b = MyWorld.AddPolygon(700, dh - 47, 0, 0, 250, 0, 250, -100)
		  b.IsStatic = True
		  
		  // Pink circle (bouncy)
		  b = MyWorld.AddCircle(dcx - 30, 0, 15)
		  b.Restitution = 0.9
		  PinkID = b.ID
		  
		  // Orange circle
		  b = MyWorld.AddCircle(dw - 50, 100, 25)
		  OrangeID = b.ID
		  
		  // Bigger static circle.
		  b = MyWorld.AddCircle(dcx, dcy, 50)
		  b.IsStatic = True
		  b.Orientation = PhysicsKit.Maths.DegreesToRadians(45)
		  
		  // Add some dynamic circles.
		  b = MyWorld.AddCircle(55, 60, 25)
		  b = MyWorld.AddCircle(dcx, 110, 20)
		  b = MyWorld.AddCircle(dcx - 100, 100, 20)
		  b = MyWorld.AddCircle(dcx - 120, 40, 30)
		  b = MyWorld.AddCircle(dw - 220, 200, 35)
		  
		  // Add 10 little boxes.
		  For i As Integer = 1 To 10
		    Call MyWorld.AddBox((i * 25) + 5, 15, 20, 20)
		  Next i
		  
		  // Add a polygon with some spin.
		  b = MyWorld.AddPolygon(dcx + 165, 50, 0, 0, 30, -50, 60, -20, 75, 20, 40, 40)
		  b.AngularVelocity = 0.55
		  
		  ButtonPauseResume.Caption = "Pause"
		  ButtonPauseResume.Enabled = True
		  ButtonStop.Enabled = True
		  ButtonStart.Enabled = False
		  CheckboxWeightless.Enabled = True
		  WorldUpdateTimer.RunMode = Timer.RunModes.Multiple
		  WorldUpdateTimer.Period = 1000 / FPS
		  WorldUpdateTimer.Enabled = True
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		MyWorld As PhysicsKit.World
	#tag EndProperty

	#tag Property, Flags = &h0
		OrangeID As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		PinkID As Integer = -1
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
		  CheckBoxWeightless.Enabled = False
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
		  #Pragma Unused areas
		  
		  If MyWorld = Nil Then Return
		  
		  Var b As PhysicsKit.Body
		  Var c As PhysicsKit.Circle
		  Var p As PhysicsKit.Polygon
		  For Each b In MyWorld.Bodies
		    If b.Shape IsA PhysicsKit.Circle Then
		      c = PhysicsKit.Circle(b.Shape)
		      
		      Var rx As Double = Cos(b.Orientation) * c.Radius
		      Var ry As Double = Sin(b.Orientation) * c.Radius
		      
		      Select Case b.ID
		      Case PinkID
		        g.DrawingColor = &cFF31A3
		      Case OrangeID
		        g.DrawingColor = &cFFA200
		      Else
		        g.DrawingColor = &c00FF00 // Green.
		      End Select
		      
		      Var diameter As Double = c.radius * 2
		      g.DrawOval(b.Position.X - c.Radius, b.Position.Y - c.Radius, diameter, diameter)
		      g.DrawLine(b.Position.X, b.Position.Y, b.Position.X + rx, b.Position.Y + ry)
		      
		    ElseIf b.Shape IsA PhysicsKit.Polygon Then
		      p = PhysicsKit.Polygon(b.Shape)
		      
		      Select Case b.ID
		      Case PinkID
		        g.DrawingColor = &cFF31A3
		      Case OrangeID
		        g.DrawingColor = &cFFA200
		      Else
		        g.DrawingColor = &c0000FF // Blue.
		      End Select
		      
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
		  
		  g.DrawingColor = &cFF0000 // Red.
		  For Each m As PhysicsKit.Manifold In MyWorld.Contacts
		    If Not m.CollisionOccurred Then Continue
		    Var n As PhysicsKit.Vector = m.Normal
		    for Each v As PhysicsKit.Vector In m.Contacts
		      g.DrawLine(v.X, v.Y, v.X + n.X * 4, v.Y + n.Y * 4)
		    Next v
		  Next m
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxWeightless
	#tag Event
		Sub Action()
		  If Me.Value Then
		    MyWorld.Gravity.Y = -Abs(MyWorld.Gravity.Y)
		  Else
		    MyWorld.Gravity.Y = Abs(MyWorld.Gravity.Y)
		  End If
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
	#tag ViewProperty
		Name="PinkID"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="OrangeID"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
