#tag Class
Protected Class World
	#tag Method, Flags = &h0, Description = 41646473207468652070617373656420736861706520746F2074686520776F726C6420617420746865207370656369666965642028782C20792920706F736974696F6E2E2028782C207929207370656369666965732074686520706F736974696F6E206F662074686520736861706527732063656E7472652E
		Function Add(x As Integer, y As Integer, shape As PhysicsKit.Shape) As PhysicsKit.Body
		  // Adds the passed shape to the world at the specified (x, y) position.
		  // NB: (x, y) specifies the position of the centre of the shape.
		  
		  Var b As PhysicsKit.Body = New PhysicsKit.Body(Self, shape, x, y)
		  Bodies.AddRow(b)
		  Return b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732061206E657720426F782073686170652077697468206077696474686020616E6420606865696768746020746F2074686520776F726C6420617420746865207370656369666965642028782C20792920706F736974696F6E2E2028782C207929207370656369666965732074686520706F736974696F6E206F662074686520736861706527732063656E7472652E
		Function AddBox(x As Integer, y As Integer, width As Double, height As Double) As PhysicsKit.Body
		  // Adds a new Box shape with `width` and `height` to the world at the specified (x, y) position.
		  // NB: (x, y) specifies the position of the centre of the shape.
		  
		  Var b As PhysicsKit.Body = New PhysicsKit.Body(Self, New Box(width, height), x, y)
		  Bodies.AddRow(b)
		  Return b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732061206E657720436972636C65207368617065207769746820607261646975736020746F2074686520776F726C6420617420746865207370656369666965642028782C20792920706F736974696F6E2E2028782C207929207370656369666965732074686520706F736974696F6E206F662074686520736861706527732063656E7472652E
		Function AddCircle(x As Integer, y As Integer, radius As Double) As PhysicsKit.Body
		  // Adds a new Circle shape with `radius` to the world at the specified (x, y) position.
		  // NB: (x, y) specifies the position of the centre of the shape.
		  
		  Var b As PhysicsKit.Body = New PhysicsKit.Body(Self, New Circle(radius), x, y)
		  Bodies.AddRow(b)
		  Return b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E6420616464732061206E657720706F6C79676F6E2073686170652028636F6E73747275637465642066726F6D207468652070617373656420706F696E74732920746F2074686520776F726C6420617420746865207370656369666965642028782C20792920706F736974696F6E2E2028782C2079292069732074686520706F736974696F6E206F662074686520736861706527732063656E7472652E
		Function AddPolygon(x As Double, y As Double, ParamArray points As Double) As PhysicsKit.body
		  // Creates and adds a new polygon shape (constructed from the passed points) to the world at the 
		  // specified (x, y) position.
		  // NB: (x, y) specifies the position of the centre of the shape.
		  
		  Var b As PhysicsKit.Body = New PhysicsKit.Body(Self, New Polygon(points), x, y)
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
		Sub Constructor(dt As Double, iterations As Integer, gravity As PhysicsKit.Vector = Nil)
		  Self.DeltaTime = dt
		  Self.Iterations = iterations
		  
		  If gravity = Nil Then
		    Self.Gravity = New Vector(0, 50)
		  Else
		    Self.Gravity = New Vector(gravity)
		  End If
		  
		  
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
		  If b.InverseMass = 0 Then Return
		  
		  Var dts As Double = dt * 0.5
		  
		  Call b.Velocity.AddSelf(b.Force, b.InverseMass * dts)
		  Call b.Velocity.AddSelf(Gravity, dts)
		  b.AngularVelocity = b.AngularVelocity + (b.Torque * b.InverseInertia * dts)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegrateVelocity(b As PhysicsKit.Body, dt As Double)
		  If b.InverseMass = 0 Then Return
		  
		  Call b.Position.AddSelf(b.Velocity, dt)
		  b.Orientation = b.Orientation + (b.AngularVelocity * dt)
		  b.Orientation = b.Orientation
		  
		  IntegrateForces(b, dt)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update()
		  mTimeStep = mTimeStep + 1
		  
		  // Generate new collision info.
		  Contacts.ResizeTo(-1)
		  
		  Var A, B As PhysicsKit.Body
		  Var m As PhysicsKit.Manifold
		  
		  For i As Integer = 0 To Bodies.LastRowIndex
		    A = Bodies(i)
		    
		    For j As Integer = i + 1 To Bodies.LastRowIndex
		      B = Bodies(j)
		      
		      If A.InverseMass = 0 And B.InverseMass = 0 Then Continue
		      
		      m = New Manifold(A, B, mTimeStep)
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
		    m.Initialise(Self)
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
		  
		  // Correct positions and fire the `CollisionOccurred` event for each collision if needed.
		  For Each m In Contacts
		    m.PositionalCorrection
		    
		    // If both bodies are resting (i.e not moving) then disregard this collision, otherwise 
		    // fire the `CollisionOccurred` event.
		    m.RestingCorrection
		    If m.CollisionOccurred Then CollisionOccurred(m)
		  Next m
		  
		  For Each body As PhysicsKit.Body In Bodies
		    body.Force.Set(0, 0)
		    body.Torque = 0
		  Next body
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 4120636F6C6C6973696F6E20686173206F63637572726564206265747765656E2074776F20626F646965732E2054686520636F6C6C6973696F6E20646174612069732073746F72656420696E2074686520706173736564204D616E69666F6C642E
		Event CollisionOccurred(m As PhysicsKit.Manifold)
	#tag EndHook


	#tag Property, Flags = &h0
		Bodies() As PhysicsKit.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		Contacts() As PhysicsKit.Manifold
	#tag EndProperty

	#tag Property, Flags = &h0
		DeltaTime As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mGravity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mGravity = New Vector(value)
			  mRestingValue = mGravity.Multiply(DeltaTime).LengthSquared + Maths.EPSILON
			End Set
		#tag EndSetter
		Gravity As PhysicsKit.Vector
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Iterations As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGravity As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNextID As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRestingValue As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E6372656D656E746564206F6E636520647572696E672065766572792060576F726C642E557064617465602E205573656420696E2064657465726D696E696E672069662061206E657720636F6C6C6973696F6E20686173206F636375726564206265747765656E20626F646965732E
		Private mTimeStep As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 52656164206F6E6C792E20507265636F6D70757465642066726F6D2074686520776F726C64277320677261766974792E205573656420627920636F6C6C6973696F6E206D616E69666F6C64732E
		#tag Getter
			Get
			  Return mRestingValue
			End Get
		#tag EndGetter
		RestingValue As Double
	#tag EndComputedProperty


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
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Iterations"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RestingValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
