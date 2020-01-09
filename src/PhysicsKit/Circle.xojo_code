#tag Class
Protected Class Circle
Implements PhysicsKit.Shape
	#tag Method, Flags = &h0
		Function Body() As PhysicsKit.Body
		  // Part of the PhysicsKit.Shape interface.
		  
		  Return mBody
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Body(Assigns b As PhysicsKit.Body)
		  // Part of the PhysicsKit.Shape interface.
		  
		  mBody = b
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As PhysicsKit.Shape
		  // Part of the PhysicsKit.Shape interface.
		  
		  Return New Circle(radius)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeMass(density As Double)
		  // Part of the PhysicsKit.Shape interface.
		  
		  mBody.Mass = Maths.PI * radius * radius * density
		  mBody.InverseMass = If((mBody.Mass <> 0), 1 / mBody.Mass, 0)
		  mBody.Inertia = mBody.Mass * radius * radius
		  mBody.InverseInertia = If((mBody.Inertia <> 0), 1 / mBody.Inertia, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(r As Double)
		  // All classes implementing the `Shape` interface must intialise mU to a new Matrix.
		  mU = New PhysicsKit.Matrix
		  
		  radius = r
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialise()
		  // Part of the PhysicsKit.Shape interface.
		  
		  ComputeMass(1.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Orientation(Assigns radians As Double)
		  // Part of the PhysicsKit.Shape interface.
		  
		  #Pragma Unused radians
		  
		  // Not needed.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Radius() As Double
		  // Part of the PhysicsKit.Shape interface.
		  
		  Return mRadians
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Radius(Assigns r As Double)
		  // Part of the PhysicsKit.Shape interface.
		  
		  mRadians = r
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function U() As PhysicsKit.Matrix
		  // Part of the PhysicsKit.Shape interface.
		  
		  Return mU
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub U(Assigns m As PhysicsKit.Matrix)
		  // Part of the PhysicsKit.Shape interface.
		  
		  mU = m
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBody As PhysicsKit.Body
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRadians As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mU As PhysicsKit.Matrix
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
	#tag EndViewBehavior
End Class
#tag EndClass
