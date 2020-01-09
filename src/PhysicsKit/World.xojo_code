#tag Class
Protected Class World
	#tag Method, Flags = &h0, Description = 41646473207468652070617373656420736861706520746F2074686520776F726C6420617420746865207370656369666965642028782C20792920706F736974696F6E2E2028782C207929207370656369666965732074686520706F736974696F6E206F662074686520736861706527732063656E7472652E
		Function Add(shape As PhysicsKit.Shape, x As Integer, y As Integer) As PhysicsKit.Body
		  // Adds the passed shape to the world at the specified (x, y) position.
		  // NB: (x, y) specifies the position of the centre of the shape.
		  
		  Var b As PhysicsKit.Body = New PhysicsKit.Body(Self, shape, x, y)
		  Bodies.AddRow(b)
		  Return b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 46696E647320616E642072657475726E732074686520666972737420626F6479207769746820746865207061737365642049442E2052657475726E73204E696C2069662069742063616E277420626520666F756E642E
		Function BodyWithID(id As Integer) As PhysicsKit.Body
		  // Finds and returns the first body with the passed ID. Returns Nil if it can't be found.
		  
		  For Each b As PhysicsKit.Body In Bodies
		    If b.ID = id Then Return b
		  Next b
		  
		  Return Nil
		  
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

	#tag Method, Flags = &h0, Description = 47656E657261746573206120756E697175652049442E20426F6469657320757365207468697320746F20656E7375726520746865792063616E20626520756E697175656C79206964656E7469666965642077697468696E206120576F726C6420696E7374616E63652E
		Function GenerateID() As Integer
		  // Generates a unique ID. Bodies use this to ensure they can be uniquely identified 
		  // within a World instance.
		  
		  mNextID = mNextID + 1
		  Return mNextID
		End Function
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
		  b.Orientation = b.Orientation + (b.AngularVelocity * dt)
		  b.SetOrient(b.Orientation)
		  
		  IntegrateForces(b, dt)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  // Generate new collision info.
		  Contacts.ResizeTo(-1)
		  
		  Var A, B As PhysicsKit.Body
		  Var m As PhysicsKit.Manifold
		  
		  For i As Integer = 0 To Bodies.LastRowIndex
		    A = Bodies(i)
		    
		    For j As Integer = i + 1 To Bodies.LastRowIndex
		      B = Bodies(j)
		      
		      If A.InvMass = 0 And B.InvMass = 0 Then Continue
		      
		      m = New Manifold(A, B)
		      m.Solve
		      
		      If m.ContactCount > 0 Then Contacts.AddRow(m)
		    Next j
		  Next i
		  
		  // Integrate forces.
		  For Each body As PhysicsKit.Body In Bodies
		    IntegrateForces(body, DeltaTime)
		  Next body
		  
		  // Initialize collision.
		  For Each m In Contacts
		    m.Initialise
		  Next m
		  
		  // Solve collisions.
		  For j As Integer = 1 To Iterations
		    For i As Integer = 0 To Contacts.LastRowIndex
		      Contacts(i).ApplyImpulse
		    Next i
		  Next j
		  
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

	#tag Property, Flags = &h21
		Private mNextID As Integer = -1
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
