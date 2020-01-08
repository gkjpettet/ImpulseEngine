#tag Class
Protected Class Polygon
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
		  
		  Var p As PhysicsKit.Polygon = New PhysicsKit.Polygon()
		  
		  p.U.Set(mU)
		  
		  Var i As Integer = 0
		  While i < VertexCount
		    Call p.Vertices(i).Set(Vertices(i))
		    Call p.Normals(i).Set(Normals(i))
		    i = i + 1
		  Wend
		  
		  p.VertexCount = VertexCount
		  
		  Return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeMass(density As Double)
		  // Part of the PhysicsKit.Shape interface.
		  
		  // Calculate centroid and moment of inertia.
		  Var centroid As PhysicsKit.Vector = New PhysicsKit.Vector(0, 0)
		  Var inertia, area As Double = 0
		  Var i As Integer
		  Var p1, p2 As PhysicsKit.Vector
		  Var d, triangleArea, weight, intx2, inty2 As Double
		  
		  Const k_inv3 = 1.0 / 3.0
		  
		  i = 0
		  While i < VertexCount
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
		    
		    i = i + 1
		  Wend
		  
		  Call centroid.MultiplySelf(1.0 / area)
		  
		  // Translate vertices to centroid (make the centroid (0, 0) for the polygon in model space)
		  // Not really necessary, but I like doing this anyway.
		  i = 0
		  While i < VertexCount
		    Call Vertices(i).SubtractSelf(centroid)
		    i = i + 1
		  Wend
		  
		  mBody.Mass = density * area
		  mBody.InvMass = If((mBody.Mass <> 0), 1 / mBody.Mass, 0)
		  mBody.Inertia = inertia * density
		  mBody.InvInertia = If((mBody.Inertia <> 0), 1 / mBody.Inertia, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray verts As PhysicsKit.Vector)
		  // All classes implementing the `Shape` interface must intialise mU to a new Matrix.
		  mU = New PhysicsKit.Matrix
		  
		  Vertices = Vector.ArrayOf(MAX_POLY_VERTEX_COUNT)
		  Normals = Vector.ArrayOf(MAX_POLY_VERTEX_COUNT)
		  
		  Set(verts)
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
		Function Radius() As Double
		  // Part of the PhysicsKit.Shape interface.
		  
		  Return mRadius
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Radius(Assigns r As Double)
		  // Part of the PhysicsKit.Shape interface.
		  
		  mRadius = r
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(verts() As PhysicsKit.Vector)
		  // Find the right most point on the hull.
		  Var rightMost As Integer = 0
		  Var highestXCoord As Double = verts(0).X
		  
		  Var i As Integer = 0
		  Var x As Double
		  While i < verts.Count
		    x = verts(i).X
		    
		    If x > highestXCoord Then
		      highestXCoord = x
		      rightMost = i
		      
		      // If matching x then take farthest negative y.
		    ElseIf x = highestXCoord Then
		      If verts(i).Y < verts(rightMost).Y Then rightMost = i
		    End If
		    
		    i = i + 1
		  Wend
		  
		  Var hull(MAX_POLY_VERTEX_COUNT) As Integer
		  Var outCount As Integer = 0
		  Var indexHull As Integer = rightMost
		  
		  Var e1, e2 As PhysicsKit.Vector
		  Do
		    
		    hull(outCount) = indexHull
		    
		    // Search for next index that wraps around the hull by computing cross products
		    // to find the most counter-clockwise vertex in the set, given the previous hull index.
		    Var nextHullIndex As Integer = 0
		    
		    i = 0
		    While i < verts.Count
		      // Skip if same coordinate as we need three unique points in the set to perform a cross product.
		      If nextHullIndex = indexHull Then
		        nextHullIndex = i
		        i = i + 1
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
		      
		      i = i + 1
		    Wend
		    
		    outCount = outCount + 1
		    indexHull = nextHullIndex
		    
		    // Conclude algorithm upon wrap-around.
		    If nextHullIndex = rightMost Then
		      VertexCount = outCount
		      Exit
		    End If
		    
		  Loop
		  
		  i = 0
		  While i < VertexCount
		    // Copy vertices into shape's vertices.
		    Call Vertices(i).Set(verts(hull(i)))
		    i = i + 1
		  Wend
		  
		  // Compute face normals.
		  i = 0
		  Var face As PhysicsKit.Vector
		  While i < VertexCount
		    face = Vertices((i + 1) Mod VertexCount).Subtract(Vertices(i))
		    
		    // Calculate normal with 2D cross product between vector and scalar.
		    Normals(i).Set(face.Y, -face.X)
		    Normals(i).Normalise
		    
		    i = i + 1
		  Wend
		  
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
		Sub SetOrient(radians As Double)
		  // Part of the PhysicsKit.Shape interface.
		  
		  mU.Set(radians)
		  
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


	#tag Property, Flags = &h1
		Protected mBody As PhysicsKit.Body
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRadius As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mU As PhysicsKit.Matrix
	#tag EndProperty

	#tag Property, Flags = &h0
		Normals(MAX_POLY_VERTEX_COUNT) As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		VertexCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Vertices(MAX_POLY_VERTEX_COUNT) As PhysicsKit.Vector
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
