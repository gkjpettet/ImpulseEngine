#tag Class
Protected Class Body
	#tag Method, Flags = &h0
		Sub ApplyForce(f As PhysicsKit.Vector)
		  Call Force.AddSelf(f)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ApplyImpulse(impulse As PhysicsKit.Vector, contactVector As PhysicsKit.Vector)
		  Call Velocity.AddSelf(impulse, InverseMass)
		  AngularVelocity = AngularVelocity + (InverseInertia * Vector.Cross(contactVector, impulse))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(w As PhysicsKit.World, s As PhysicsKit.Shape, x As Integer, y As Integer)
		  Self.Shape = s
		  Position = New Vector(x, y)
		  Velocity = New Vector(0, 0)
		  Force = New Vector(0, 0)
		  Orientation = mOrientation
		  mID = w.GenerateID
		  s.Body = Self
		  s.Initialise()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 507573686573207468697320626F647920696E207468652073706563696669656420646972656374696F6E207769746820746865207061737365642060737472656E677468602E
		Sub Push(direction As PhysicsKit.Vector, strength As Double)
		  // Pushes this body in the specified direction with the passed `strength`.
		  
		  Call Velocity.AddSelf(direction, strength)
		  AngularVelocity = AngularVelocity + (InverseInertia * Vector.Cross(New Vector, direction))
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468697320626F647927732063757272656E7420616E67756C61722076656C6F636974792E
		AngularVelocity As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526570726573656E747320746865206672696374696F6E206265747765656E20626F6469657320696E20636F6E74616374207768656E20746865792061726520696E2072656C6174697665206D6F74696F6E2E
		DynamicFriction As Double = 0.3
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5370656369666965732074686520666F72636520746F206170706C7920696E207468652063757272656E7420737465702E204974206973207A65726F65642061667465722065766572792060576F726C642E557064617465602E
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

	#tag Property, Flags = &h0, Description = 446566696E657320746865206D6F6D656E74206F6620696E65727469612028692E652E207365636F6E64206D6F6D656E74206F66206172656129206F662074686520626F64792E204175746F6D61746963616C6C792063616C63756C61746564206279206053686170652E436F6D707574654D617373602E20496620796F75206D6F6469667920746869732076616C75652C20796F75206D75737420616C736F206D6F646966792060426F64792E496E7665727365496E6572746961602E
		Inertia As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 446566696E65732074686520696E7665727365206D6F6D656E74206F6620696E6572746961206F662074686520626F6479202831202F20696E6572746961292E20496620796F75206D6F6469667920746869732076616C75652C20796F75206D75737420616C736F206D6F64696679207468652060426F64792E496E6572746961602070726F70657274792E
		InverseInertia As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 646566696E65732074686520696E7665727365206D617373206F662074686520626F6479202831202F206D617373292E20496620796F75206D6F6469667920746869732076616C75652C20796F75206D75737420616C736F206D6F64696679207468652060426F64792E4D617373602070726F70657274792E
		InverseMass As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E207468697320626F64792077696C6C206D61696E7461696E206120666978656420706F736974696F6E20696E2074686520776F726C642E
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
			    InverseInertia = 0.0
			    Mass = 0.0
			    InverseMass = 0.0
			  Else
			    mIsStatic = False
			    Shape.ComputeMass(1.0)
			  End If
			End Set
		#tag EndSetter
		IsStatic As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 646566696E657320746865206D617373206F662074686520626F64792E20496620796F75206D6F6469667920746869732076616C75652C20796F75206D75737420616C736F206D6F64696679207468652060426F64792E496E76657273654D617373602070726F7065727479202831202F206D617373292E
		Mass As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsStatic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOrientation As Double = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F7269656E746174696F6E206F66207468697320626F647920696E2072616469616E732E
		#tag Getter
			Get
			  Return mOrientation
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mOrientation = value
			  Self.Shape.Orientation = value
			  
			End Set
		#tag EndSetter
		Orientation As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652063757272656E7420776F726C642D737061636520706F736974696F6E206F66207468697320626F64792E
		Position As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5265737469747574696F6E2028656C617374696369747929206F662074686520626F64792E2030206D65616E7320636F6C6C6973696F6E732061726520706572666563746C7920696E656C617374696320616E64206E6F20626F756E63696E67206D6179206F636375722E20312E30206D65616E732074686520626F647920626F756E636573206261636B20776974682031303025206F6620697473206B696E6574696320656E657267792E
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
			Name="InverseInertia"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InverseMass"
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
			Name="mOrientation"
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
