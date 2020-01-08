#tag Class
Protected Class Box
Inherits PhysicsKit.Polygon
Implements PhysicsKit.Shape
	#tag Method, Flags = &h0
		Function Clone() As PhysicsKit.Shape
		  // Part of the PhysicsKit.Shape interface.
		  
		  Var box As PhysicsKit.Box = New PhysicsKit.Box
		  
		  box.U.Set(mU)
		  
		  Var i As Integer = 0
		  While i < VertexCount
		    Call box.Vertices(i).Set(Vertices(i))
		    Call box.Normals(i).Set(Normals(i))
		    i = i + 1
		  Wend
		  
		  box.VertexCount = VertexCount
		  
		  Return box
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(width As Double, height As Double)
		  // All classes implementing the `Shape` interface must intialise mU to a new Matrix.
		  mU = New PhysicsKit.Matrix
		  
		  Vertices = Vector.ArrayOf(4)
		  Normals = Vector.ArrayOf(4)
		  
		  // SetBox computes using half width and half heights.
		  SetBox(width / 2, height / 2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSupport(dir As PhysicsKit.Vector) As PhysicsKit.Vector
		  Var bestProjection As Double = -Maths.FLOAT_MAX_VALUE
		  Var bestVertex, v As PhysicsKit.Vector
		  Var projection As Double
		  
		  Var i As Integer = 0
		  While i < VertexCount
		    v = Vertices(i)
		    projection = Vector.Dot(v, dir)
		    
		    If projection > bestProjection Then
		      bestVertex = v
		      bestProjection = projection
		    End If
		    
		    i = i + 1
		  Wend
		  
		  Return bestVertex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialise()
		  // Part of the PhysicsKit.Shape interface.
		  
		  ComputeMass(1.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOrient(radians As Double)
		  // Part of the PhysicsKit.Shape interface.
		  
		  mU.Set(radians)
		  
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
