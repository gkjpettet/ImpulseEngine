#tag Class
Protected Class Body
	#tag Method, Flags = &h0
		Sub ApplyForce(f As PhysicsKit.Vector)
		  Call Force.AddSelf(f)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ApplyImpulse(impulse As PhysicsKit.Vector, contactVector As PhysicsKit.Vector)
		  Call Velocity.AddSelf(impulse, invMass)
		  AngularVelocity = AngularVelocity + (invInertia * Vector.Cross(contactVector, impulse))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(s As PhysicsKit.Shape, x As Integer, y As Integer)
		  Self.Shape = s
		  Position = New Vector(x, y)
		  Velocity = New Vector(0, 0)
		  AngularVelocity = 0
		  Torque = 0
		  Orient = Maths.Random(-Maths.PI, Maths.PI)
		  Force = New Vector(0, 0)
		  StaticFriction = 0.5
		  DynamicFriction = 0.3
		  Restitution = 0.2
		  
		  s.Body = Self
		  s.Initialise()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOrient(radians_ As Double)
		  Orient = radians_
		  Self.Shape.SetOrient(radians_)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStatic()
		  Inertia = 0.0
		  InvInertia = 0.0
		  Mass = 0.0
		  InvMass = 0.0
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AngularVelocity As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		DynamicFriction As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Force As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		Inertia As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		InvInertia As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		InvMass As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Mass As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Orient As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Position As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		Restitution As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Shape As PhysicsKit.Shape
	#tag EndProperty

	#tag Property, Flags = &h0
		StaticFriction As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Torque As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Velocity As PhysicsKit.Vector
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
			Name="Position"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
