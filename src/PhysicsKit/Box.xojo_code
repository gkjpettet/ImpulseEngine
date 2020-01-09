#tag Class
Protected Class Box
Inherits PhysicsKit.Polygon
Implements PhysicsKit.Shape
	#tag Method, Flags = &h0
		Function Clone() As PhysicsKit.Shape
		  // Part of the PhysicsKit.Shape interface.
		  
		  Var box As PhysicsKit.Box = New PhysicsKit.Box
		  
		  box.U.Set(mU)
		  
		  Var vertexLimit As Integer = VertexCount - 1
		  For i As Integer = 0 To vertexLimit
		    Call box.Vertices(i).Set(Vertices(i))
		    Call box.Normals(i).Set(Normals(i))
		  Next i
		  
		  box.VertexCount = VertexCount
		  
		  Return box
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Internal use.
		  // Provided to allow the `Clone` method to work. Without it, Xojo's compiler can't determine 
		  // which overridden constructor to call.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(width As Double, height As Double)
		  // All classes implementing the `Shape` interface must intialise mU to a new Matrix.
		  mU = New PhysicsKit.Matrix
		  
		  Vertices = Vector.ArrayOf(4)
		  Normals = Vector.ArrayOf(4)
		  
		  // Use our Super (Polygon)'s Setbox method to compute the vertices. 
		  // Remember it takes a half width and half height.
		  SetBox(width / 2, height / 2)
		  
		End Sub
	#tag EndMethod


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
			Name="VertexCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
