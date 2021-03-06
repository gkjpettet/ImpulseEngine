#tag Class
Protected Class Polygon
Implements ImpulseEngine.Shape
	#tag Method, Flags = &h0
		Function Body() As ImpulseEngine.Body
		  // Part of the ImpulseEngine.Shape interface.
		  
		  Return mBody
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Body(Assigns b As ImpulseEngine.Body)
		  // Part of the ImpulseEngine.Shape interface.
		  
		  mBody = b
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ImpulseEngine.Shape
		  // Part of the ImpulseEngine.Shape interface.
		  
		  Var p As ImpulseEngine.Polygon = New ImpulseEngine.Polygon("")
		  
		  p.U.Set(mU)
		  
		  Var vertexLimit As Integer = VertexCount - 1
		  For i As Integer = 0 To vertexLimit
		    Call p.Vertices(i).Set(Vertices(i))
		    Call p.Normals(i).Set(Normals(i))
		  Next i
		  
		  p.VertexCount = VertexCount
		  
		  Return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeMass(density As Double)
		  // Part of the ImpulseEngine.Shape interface.
		  
		  // Calculate centroid and moment of inertia.
		  Var centroid As ImpulseEngine.Vector = New ImpulseEngine.Vector(0, 0)
		  Var inertia, area As Double = 0
		  Var p1, p2 As ImpulseEngine.Vector
		  Var d, triangleArea, weight, intx2, inty2 As Double
		  
		  Const k_inv3 = 1.0 / 3.0
		  Var vertexLimit As Integer = VertexCount - 1
		  
		  For i As Integer = 0 To vertexLimit
		    // Triangle vertices, third vertex implied as (0, 0)
		    p1 = Vertices(i)
		    p2 = Vertices((i + 1) Mod VertexCount)
		    
		    d = Vector.Cross(p1,p2)
		    triangleArea = 0.5 * d
		    
		    area = area + triangleArea
		    
		    // Use area to weight the centroid average, not just vertex position.
		    weight = triangleArea * k_inv3
		    Call centroid.AddSelf(p1, weight)
		    Call centroid.AddSelf(p2, weight)
		    
		    intx2 = p1.X * p1.X + p2.X * p1.X + p2.X * p2.X
		    inty2 = p1.Y * p1.Y + p2.Y * p1.Y + p2.Y * p2.Y
		    inertia = inertia + ((0.25 * k_inv3 * d) * (intx2 + inty2))
		  Next i
		  
		  Call centroid.MultiplySelf(1.0 / area)
		  
		  // Translate vertices to centroid (make the centroid (0, 0) for the polygon in model space)
		  // Not really necessary, but I like doing this anyway.
		  For Each vert As ImpulseEngine.Vector In Vertices
		    Call vert.SubtractSelf(centroid)
		  Next vert
		  
		  mBody.Mass = density * area
		  mBody.InverseMass = If((mBody.Mass <> 0), 1 / mBody.Mass, 0)
		  mBody.Inertia = inertia * density
		  mBody.InverseInertia = If((mBody.Inertia <> 0), 1 / mBody.Inertia, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(points() As Double)
		  // All classes implementing the `Shape` interface must intialise mU to a new Matrix.
		  mU = New ImpulseEngine.Matrix
		  
		  Vertices = Vector.ArrayOf(MAX_POLY_VERTEX_COUNT)
		  Normals = Vector.ArrayOf(MAX_POLY_VERTEX_COUNT)
		  
		  If points.Count < 3 Then
		    Raise New InvalidArgumentException("The smallest polygon is a triangle which requires at least 6 points.")
		  End If
		  If points.Count Mod 2 <> 0 Then
		    Raise New InvalidArgumentException("Expected an even number of points to construct a polygon from.")
		  End If
		  
		  Var limit As Integer = points.LastRowIndex - 1
		  Var verts() As ImpulseEngine.Vector
		  For i As Integer = 0 To limit
		    verts.AddRow(New Vector(points(i), points(i + 1)))
		    i = i + 1
		  Next i
		  
		  Set(verts)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray points As Double)
		  // Alias to Constructor(points() As Double)
		  Constructor(points)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray verts As ImpulseEngine.Vector)
		  // All classes implementing the `Shape` interface must intialise mU to a new Matrix.
		  mU = New ImpulseEngine.Matrix
		  
		  Vertices = Vector.ArrayOf(MAX_POLY_VERTEX_COUNT)
		  Normals = Vector.ArrayOf(MAX_POLY_VERTEX_COUNT)
		  
		  Set(verts)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(s As String)
		  // Internal use.
		  // Provided to allow the `Clone` method to work. Without it, Xojo's compiler can't determine which
		  // overridden constructor to use.
		  
		  #Pragma Unused s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSupport(dir As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  Var bestProjection As Double = -Maths.FLOAT_MAX_VALUE
		  Var bestVertex As ImpulseEngine.Vector
		  Var projection As Double
		  
		  For Each v As ImpulseEngine.Vector In Vertices
		    projection = Vector.Dot(v, dir)
		    
		    If projection > bestProjection Then
		      bestVertex = v
		      bestProjection = projection
		    End If
		  Next v
		  
		  Return bestVertex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialise()
		  // Part of the ImpulseEngine.Shape interface.
		  
		  ComputeMass(1.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Orientation(Assigns radians As Double)
		  // Part of the ImpulseEngine.Shape interface.
		  
		  mU.Set(radians)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Radius() As Double
		  // Part of the ImpulseEngine.Shape interface.
		  
		  Return mRadius
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Radius(Assigns r As Double)
		  // Part of the ImpulseEngine.Shape interface.
		  
		  mRadius = r
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(verts() As ImpulseEngine.Vector)
		  // Find the right most point on the hull.
		  Var rightMost As Integer = 0
		  Var highestXCoord As Double = verts(0).X
		  
		  Var x As Double
		  For i As Integer = 0 To verts.LastRowIndex
		    x = verts(i).X
		    
		    If x > highestXCoord Then
		      highestXCoord = x
		      rightMost = i
		      
		      // If matching x then take farthest negative y.
		    ElseIf x = highestXCoord Then
		      If verts(i).Y < verts(rightMost).Y Then rightMost = i
		    End If
		  Next i
		  
		  Var hull(MAX_POLY_VERTEX_COUNT) As Integer
		  Var outCount As Integer = 0
		  Var indexHull As Integer = rightMost
		  
		  Var e1, e2 As ImpulseEngine.Vector
		  Do
		    
		    hull(outCount) = indexHull
		    
		    // Search for next index that wraps around the hull by computing cross products
		    // to find the most counter-clockwise vertex in the set, given the previous hull index.
		    Var nextHullIndex As Integer = 0
		    
		    For i As Integer = 0 To verts.LastRowIndex
		      // Skip if same coordinate as we need three unique points in the set to perform a cross product.
		      If nextHullIndex = indexHull Then
		        nextHullIndex = i
		        Continue
		      End If
		      
		      // Cross every set of three unique vertices. Record each counter clockwise third vertex and add
		      // to the output hull. See http://www.oocities.org/pcgpe/math2d.html
		      e1 = verts(nextHullIndex).Subtract(verts(hull(outCount)))
		      e2 = verts(i).Subtract(verts(hull(outCount)))
		      Var c As Double = Vector.Cross(e1, e2)
		      If c < 0 Then nextHullIndex = i
		      
		      // Cross product is zero then e vectors are on same line
		      // therefore want to record vertex farthest along that line
		      If c = 0 And e2.LengthSquared > e1.LengthSquared Then nextHullIndex = i
		    Next i
		    
		    outCount = outCount + 1
		    indexHull = nextHullIndex
		    
		    // Conclude algorithm upon wrap-around.
		    If nextHullIndex = rightMost Then
		      VertexCount = outCount
		      Exit
		    End If
		    
		  Loop
		  
		  For i As Integer = 0 To VertexCount - 1
		    // Copy vertices into shape's vertices.
		    Call Vertices(i).Set(verts(hull(i)))
		  Next i
		  
		  // Compute face normals.
		  Var face As ImpulseEngine.Vector
		  For i As Integer = 0 To VertexCount - 1
		    face = Vertices((i + 1) Mod VertexCount).Subtract(Vertices(i))
		    
		    // Calculate normal with 2D cross product between vector and scalar.
		    Normals(i).Set(face.Y, -face.X)
		    Normals(i).Normalise
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetBox(halfWidth As Double, halfHeight As Double)
		  VertexCount = 4
		  Vertices(0).Set(-halfWidth, -halfHeight)
		  Vertices(1).Set(halfWidth, -halfHeight)
		  Vertices(2).Set(halfWidth, halfHeight)
		  Vertices(3).Set(-halfWidth, halfHeight)
		  Normals(0).Set(0, -1)
		  Normals(1).Set(1, 0)
		  Normals(2).Set(0, 1)
		  Normals(3).Set(-1, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function U() As ImpulseEngine.Matrix
		  // Part of the ImpulseEngine.Shape interface.
		  
		  Return mU
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub U(Assigns m As ImpulseEngine.Matrix)
		  // Part of the ImpulseEngine.Shape interface.
		  
		  mU = m
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mBody As ImpulseEngine.Body
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRadius As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mU As ImpulseEngine.Matrix
	#tag EndProperty

	#tag Property, Flags = &h0
		Normals(MAX_POLY_VERTEX_COUNT) As ImpulseEngine.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		VertexCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Vertices(MAX_POLY_VERTEX_COUNT) As ImpulseEngine.Vector
	#tag EndProperty


	#tag Constant, Name = MAX_POLY_VERTEX_COUNT, Type = Double, Dynamic = False, Default = \"63", Scope = Private
	#tag EndConstant


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
