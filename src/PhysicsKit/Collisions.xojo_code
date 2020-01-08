#tag Module
Protected Module Collisions
	#tag Method, Flags = &h1
		Protected Sub CircleCircle(m As PhysicsKit.Manifold, circleBodyA As PhysicsKit.Body, circleBodyB As PhysicsKit.Body)
		  Var circleShapeA As PhysicsKit.Circle = PhysicsKit.Circle(circleBodyA.Shape)
		  Var circleShapeB As PhysicsKit.Circle = PhysicsKit.Circle(circleBodyB.Shape)
		  
		  // Calculate translational vector, which is normal.
		  Var normal As PhysicsKit.Vector = circleBodyB.Position.Subtract(circleBodyA.Position)
		  
		  Var dist_sqr As Double = normal.LengthSquared
		  Var radius As Double = circleShapeA.Radius + circleShapeB.Radius
		  
		  // Not in contact.
		  If dist_sqr >= radius * radius Then
		    m.ContactCount = 0
		    Return
		  End If
		  
		  Var distance As Double = Sqrt(dist_sqr)
		  
		  m.ContactCount = 1
		  
		  If distance = 0 Then
		    m.Penetration = circleShapeA.Radius
		    m.Normal.Set(1, 0)
		    Call m.Contacts(0).Set(circleBodyA.Position)
		  Else
		    m.Penetration = radius - distance
		    Call m.Normal.Set(normal).DivideSelf(distance) // Faster than using Normalized as we already performed sqrt.
		    Call m.Contacts(0).Set(m.Normal).MultiplySelf(circleShapeA.Radius).AddSelf(circleBodyA.Position)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CirclePolygon(m As PhysicsKit.Manifold, circleBody As PhysicsKit.Body, polygonBody As PhysicsKit.Body)
		  Var circleShape As PhysicsKit.Circle = PhysicsKit.Circle(circleBody.Shape) //A
		  Var polygonShape As PhysicsKit.Polygon = PhysicsKit.Polygon(polygonBody.Shape) // B
		  
		  m.ContactCount = 0
		  
		  // Transform circle center to Polygon model space.
		  Var center As PhysicsKit.Vector = polygonShape.U.Transpose.MultiplySelf(circleBody.Position.Subtract(polygonBody.Position))
		  
		  // Find edge with minimum penetration.
		  // Same concept as using support points in Polygon vs Polygon.
		  Var separation As Double = -Maths.FLOAT_MAX_VALUE
		  Var faceNormal As Integer = 0
		  
		  Var i As Integer = 0
		  Var s As Double
		  While i < polygonShape.VertexCount
		    s = Vector.Dot(polygonShape.Normals(i), center.Subtract(polygonShape.Vertices(i)))
		    
		    If s > circleShape.Radius Then Return
		    
		    If s > separation Then
		      separation = s
		      faceNormal = i
		    End If
		    
		    i = i + 1
		  Wend
		  
		  // Grab the face's vertices.
		  Var v1 As PhysicsKit.Vector = polygonShape.Vertices(faceNormal)
		  Var i2 As Integer = If(faceNormal + 1 < polygonShape.VertexCount, faceNormal + 1, 0)
		  Var v2 As PhysicsKit.Vector = polygonShape.Vertices(i2)
		  
		  // Check to see if center is within polygon
		  If separation < Maths.EPSILON Then
		    m.ContactCount = 1
		    Call polygonShape.U.Multiply(polygonShape.Normals(faceNormal), m.Normal).NegateSelf
		    Call m.Contacts(0).Set(m.Normal).MultiplySelf(circleShape.Radius).AddSelf(circleBody.Position)
		    m.Penetration = circleShape.Radius
		    Return
		  End If
		  
		  // Determine which voronoi region of the edge center of circle lies within.
		  Var dot1 As Double = Vector.Dot(center.Subtract(v1), v2.Subtract(v1))
		  Var dot2 As Double = Vector.Dot(center.Subtract(v2), v1.Subtract(v2))
		  m.Penetration = circleShape.Radius - separation
		  
		  // Closest to v1.
		  If dot1 <= 0 Then
		    If Vector.DistanceSquared(center, v1) > circleShape.Radius * circleShape.Radius Then Return
		    
		    m.ContactCount = 1
		    polygonShape.U.MultiplySelf(m.Normal.Set(v1).SubtractSelf(center)).Normalise
		    Call polygonShape.U.Multiply(v1, m.Contacts(0)).AddSelf(polygonBody.Position)
		    
		  ElseIf dot2 <= 0 Then // Closest to v2.
		    If Vector.DistanceSquared(center, v2) > circleShape.Radius * circleShape.Radius Then Return
		    
		    m.ContactCount = 1
		    polygonShape.U.MultiplySelf(m.Normal.Set(v2).SubtractSelf(center)).Normalise
		    Call polygonShape.U.Multiply(v2, m.Contacts(0)).AddSelf(polygonBody.Position)
		    
		  Else // Closest to face.
		    Var n As PhysicsKit.Vector = polygonShape.Normals(faceNormal)
		    
		    If Vector.Dot(center.Subtract(v1), n) > circleShape.Radius Then Return
		    
		    m.ContactCount = 1
		    Call polygonShape.U.Multiply(n, m.Normal).NegateSelf
		    Call m.Contacts(0).Set(circleBody.Position).AddSelf(m.Normal, circleShape.Radius)
		  End If
		  
		End Sub
	#tag EndMethod


End Module
#tag EndModule
