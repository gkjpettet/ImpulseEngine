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
		Sub Constructor(w As PhysicsKit.World, s As PhysicsKit.Shape, x As Integer, y As Integer)
		  Self.Shape = s
		  Position = New Vector(x, y)
		  Velocity = New Vector(0, 0)
		  'Orient = Maths.Random(-Maths.PI, Maths.PI)
		  Force = New Vector(0, 0)
		  mID = w.GenerateID
		  s.Body = Self
		  s.Initialise()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 507573686573207468697320626F647920696E207468652073706563696669656420646972656374696F6E207769746820746865207061737365642060737472656E677468602E
		Sub Push(direction As PhysicsKit.Vector, strength As Double)
		  // Pushes this body in the specified direction with the passed `strength`.
		  
		  Call Velocity.AddSelf(direction, strength)
		  AngularVelocity = AngularVelocity + (invInertia * Vector.Cross(New Vector, direction))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOrient(radians_ As Double)
		  Orientation = radians_
		  Self.Shape.SetOrient(radians_)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AngularVelocity As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526570726573656E747320746865206672696374696F6E206265747765656E20626F6469657320696E20636F6E74616374207768656E20746865792061726520696E2072656C6174697665206D6F74696F6E2E
		DynamicFriction As Double = 0.3
	#tag EndProperty

	#tag Property, Flags = &h0
		Force As PhysicsKit.Vector
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mID
			End Get
		#tag EndGetter
		ID As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Inertia As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		InvInertia As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		InvMass As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mIsStatic
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = True Then
			    mIsStatic = True
			    Inertia = 0.0
			    InvInertia = 0.0
			    Mass = 0.0
			    InvMass = 0.0
			  Else
			    mIsStatic = False
			    Shape.ComputeMass(1.0)
			  End If
			End Set
		#tag EndSetter
		IsStatic As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Mass As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		mID As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsStatic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Orientation As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Position As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		Restitution As Double = 0.2
	#tag EndProperty

	#tag Property, Flags = &h0
		Shape As PhysicsKit.Shape
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526570726573656E7473206672696374696F6E206265747765656E2074776F20626F64696573206E6F7420696E2072656C6174697665206D6F74696F6E2E
		StaticFriction As Double = 0.5
	#tag EndProperty

	#tag Property, Flags = &h0
		Torque As Double = 0
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
			Name="AngularVelocity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DynamicFriction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Inertia"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvInertia"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvMass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Orientation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Restitution"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StaticFriction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Torque"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
