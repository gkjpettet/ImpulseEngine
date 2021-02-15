#tag Class
Protected Class Body
	#tag Method, Flags = &h0, Description = 4164647320746865207061737365642060666F7263656020746F207468697320626F6479277320666F7263652E20546869732077696C6C20616C746572206974732076656C6F6369747920647572696E672068652063757272656E7420776F726C64207570646174652E
		Sub ApplyForce(f As ImpulseEngine.Vector)
		  // Adds the passed `force` to this body's force. This will alter its velocity during 
		  // the current world update.
		  
		  Call Force.AddSelf(f)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473207468652060696D70756C73656020766563746F7220746F207468697320626F647927732076656C6F6369747920616E6420757064617465732069742069747320616E67756C61722076656C6F63697479206261736564206F6E20746865207061737365642060696D70756C73656020616E642060636F6E746163746020766563746F72732E
		Sub ApplyImpulse(impulse As ImpulseEngine.Vector, contact As ImpulseEngine.Vector)
		  // Adds the `impulse` vector to this body's velocity and updates it its angular velocity based 
		  // on the passed `impulse` and `contact` vectors.
		  
		  Call Velocity.AddSelf(impulse, InverseMass)
		  AngularVelocity = AngularVelocity + (InverseInertia * Vector.Cross(contact, impulse))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(w As ImpulseEngine.World, s As ImpulseEngine.Shape, x As Integer, y As Integer)
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

	#tag Method, Flags = &h0, Description = 507573686573207468697320626F647920696E207468652073706563696669656420646972656374696F6E207769746820746865207061737365642060737472656E677468602E20446F6573204E4F542061666665637420616E67756C617220726F746174696F6E2E
		Sub LinearPush(direction As ImpulseEngine.Vector, strength As Double)
		  // Pushes this body in the specified direction with the passed `strength`.
		  // Does NOT affect angular rotation.
		  
		  Call Velocity.AddSelf(direction, strength)
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468697320626F647927732063757272656E7420616E67756C61722076656C6F636974792E
		AngularVelocity As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526570726573656E747320746865206672696374696F6E206265747765656E20626F6469657320696E20636F6E74616374207768656E20746865792061726520696E2072656C6174697665206D6F74696F6E2E
		DynamicFriction As Double = 0.3
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5370656369666965732074686520666F72636520746F206170706C7920696E207468652063757272656E7420737465702E204974206973207A65726F65642061667465722065766572792060576F726C642E557064617465602E
		Force As ImpulseEngine.Vector
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

	#tag Property, Flags = &h0
		IsSleeping As Boolean = False
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
		Position As ImpulseEngine.Vector
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5265737469747574696F6E2028656C617374696369747929206F662074686520626F64792E2030206D65616E7320636F6C6C6973696F6E732061726520706572666563746C7920696E656C617374696320616E64206E6F20626F756E63696E67206D6179206F636375722E20312E30206D65616E732074686520626F647920626F756E636573206261636B20776974682031303025206F6620697473206B696E6574696320656E657267792E
		Restitution As Double = 0.2
	#tag EndProperty

	#tag Property, Flags = &h0
		Shape As ImpulseEngine.Shape
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 526570726573656E7473206672696374696F6E206265747765656E2074776F20626F64696573206E6F7420696E2072656C6174697665206D6F74696F6E2E
		StaticFriction As Double = 0.5
	#tag EndProperty

	#tag Property, Flags = &h0
		Torque As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Velocity As ImpulseEngine.Vector
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
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DynamicFriction"
			Visible=false
			Group="Behavior"
			InitialValue="0.3"
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
			Name="Restitution"
			Visible=false
			Group="Behavior"
			InitialValue="0.2"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StaticFriction"
			Visible=false
			Group="Behavior"
			InitialValue="0.5"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Torque"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsStatic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
	#tag EndViewBehavior
End Class
#tag EndClass
