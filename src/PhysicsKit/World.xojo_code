#tag Class
Protected Class World
	#tag Method, Flags = &h0
		Function Add(shape As PhysicsKit.Shape, x As Integer, y As Integer) As PhysicsKit.Body
		  Var b As PhysicsKit.Body = New PhysicsKit.Body(shape, x, y)
		  Bodies.AddRow(b)
		  Return b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  Contacts.ResizeTo(-1)
		  Bodies.ResizeTo(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(dt As Double, iterations As Integer)
		  Self.DeltaTime = dt
		  Self.Iterations = iterations
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegrateForces(b As PhysicsKit.Body, dt As Double)
		  If b.InvMass = 0 Then Return
		  
		  Var dts As Double = dt * 0.5
		  
		  Call b.Velocity.AddSelf(b.Force, b.InvMass * dts)
		  Call b.Velocity.AddSelf(Maths.GRAVITY, dts)
		  b.AngularVelocity = b.AngularVelocity + (b.Torque * b.InvInertia * dts)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegrateVelocity(b As PhysicsKit.Body, dt As Double)
		  If b.InvMass = 0 Then Return
		  
		  Call b.Position.AddSelf(b.Velocity, dt)
		  b.Orient = b.Orient + (b.AngularVelocity * dt)
		  b.SetOrient(b.Orient)
		  
		  IntegrateForces(b, dt)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  // Generate new collision info.
		  Contacts.ResizeTo(-1)
		  
		  Var A, B As PhysicsKit.Body
		  Var i, j As Integer
		  Var m As PhysicsKit.Manifold
		  i = 0
		  While i < Bodies.Count
		    A = Bodies(i)
		    
		    j = i + 1
		    While j < Bodies.Count
		      B = Bodies(j)
		      
		      If A.InvMass = 0 And B.InvMass = 0 Then
		        j = j + 1
		        Continue
		      End If
		      
		      m = New Manifold(A, B)
		      m.Solve
		      
		      If m.ContactCount > 0 Then Contacts.AddRow(m)
		      
		      j = j + 1
		    Wend
		    
		    i = i + 1
		  Wend
		  
		  // Integrate forces.
		  For Each body As PhysicsKit.Body In Bodies
		    IntegrateForces(body, DeltaTime)
		  Next body
		  
		  // Initialize collision.
		  For Each m In Contacts
		    m.Initialise
		  Next m
		  
		  // Solve collisions.
		  j = 0
		  While j < Iterations
		    i = 0
		    While i < Contacts.Count
		      Contacts(i).ApplyImpulse
		      i = i + 1
		    Wend 
		    j = j + 1
		  Wend
		  
		  // Integrate velocities.
		  For Each body As PhysicsKit.Body In Bodies
		    IntegrateVelocity(body, DeltaTime)
		  Next body
		  
		  // Correct positions.
		  For Each m In Contacts
		    m.PositionalCorrection
		  Next m
		  
		  For Each body As PhysicsKit.Body In Bodies
		    body.Force.Set(0, 0)
		    body.Torque = 0
		  Next body
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Bodies() As PhysicsKit.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		Contacts() As PhysicsKit.Manifold
	#tag EndProperty

	#tag Property, Flags = &h0
		DeltaTime As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Iterations As Integer
	#tag EndProperty


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DeltaTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
