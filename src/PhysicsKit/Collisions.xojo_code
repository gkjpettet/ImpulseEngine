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

	#tag Method, Flags = &h21
		Private Function Clip(n As PhysicsKit.Vector, c As Double, face() As PhysicsKit.Vector) As Integer
		  Var sp As Integer = 0
		  Var out() As PhysicsKit.Vector
		  out.AddRow(New Vector(face(0)))
		  out.AddRow(New Vector(face(1)))
		  
		  // Retrieve distances from each endpoint to the line.
		  // d = ax + by - c
		  Var d1 As Double = Vector.Dot(n, face(0)) - c
		  Var d2 As Double = Vector.Dot(n, face(1)) - c
		  
		  // If negative (behind plane) clip.
		  If d1 <= 0 Then
		    Call out(sp).Set(face(0))
		    sp = sp + 1
		  End If
		  If d2 <= 0 Then
		    Call out(sp).Set(face(1))
		    sp = sp + 1
		  End If
		  
		  // If the points are on different sides of the plane.
		  If d1 * d2 < 0 Then // Less than to ignore -0.0
		    // Push intersection point.
		    Var alpha As Double = d1 / (d1 - d2)
		    
		    Call out(sp).Set(face(1)).SubtractSelf(face(0)).MultiplySelf(alpha).AddSelf(face(0))
		    sp = sp + 1
		  End If
		  
		  // Assign our new converted values.
		  face(0) = out(0)
		  face(1) = out(1)
		  
		  Return sp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FindAxisLeastPenetration(faceIndex() As Integer, polygonA As PhysicsKit.Polygon, polygonB As PhysicsKit.Polygon) As Double
		  Var bestDistance As Double = -Maths.FLOAT_MAX_VALUE
		  Var bestIndex As Integer = 0
		  
		  Var i As Integer = 0
		  While i < polygonA.VertexCount
		    // Retrieve a face normal from polygonA.
		    Var nw As PhysicsKit.Vector = polygonA.U.Multiply(polygonA.Normals(i))
		    
		    // Transform face normal into polygonB's model space.
		    Var buT As PhysicsKit.Matrix = polygonB.U.Transpose
		    Var n As PhysicsKit.Vector = buT.Multiply(nw)
		    
		    // Retrieve support point from B along -n
		    Var s As PhysicsKit.Vector = polygonB.GetSupport(n.Negate)
		    
		    // Retrieve vertex on face from A, transform into polygonB's model space.
		    Var v As PhysicsKit.Vector = _
		    buT.MultiplySelf(polygonA.U.Multiply(polygonA.Vertices(i)).AddSelf(polygonA.Body.Position)._
		    SubtractSelf(polygonB.Body.Position))
		    
		    // Compute penetration distance (in polygonB's model space).
		    Var d As Double = Vector.Dot(n, s.Subtract(v))
		    
		    // Store greatest distance.
		    If d > bestDistance Then
		      bestDistance = d
		      bestIndex = i
		    End If
		    
		    i = i + 1
		  Wend
		  
		  faceIndex(0) = bestIndex
		  Return bestDistance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FindIncidentFace(v() As PhysicsKit.Vector, refPoly As PhysicsKit.Polygon, incPoly As PhysicsKit.Polygon, referenceIndex As Integer)
		  Var referenceNormal As PhysicsKit.Vector = refPoly.Normals(referenceIndex)
		  
		  // Calculate normal in incident's frame of reference
		  referenceNormal = refPoly.U.Multiply(referenceNormal) // To world space.
		  referenceNormal = incPoly.U.Transpose.Multiply(referenceNormal) // To incident's model space.
		  
		  // Find most anti-normal face on incident polygon.
		  Var incidentFace As Integer = 0
		  Var minDot As Double = Maths.FLOAT_MAX_VALUE
		  
		  Var i As Integer = 0
		  While i < incPoly.VertexCount
		    Var dot As Double = Vector.Dot(referenceNormal, incPoly.Normals(i))
		    
		    If dot < minDot Then
		      minDot = dot
		      incidentFace = i
		    End If
		    
		    i = i + 1
		  Wend
		  
		  // Assign face vertices for incidentFace.
		  v(0) = incPoly.U.Multiply(incPoly.Vertices(incidentFace)).AddSelf(incPoly.Body.Position)
		  incidentFace = If(incidentFace + 1 >= incPoly.VertexCount, 0, incidentFace + 1)
		  v(1) = incPoly.U.Multiply(incPoly.Vertices(incidentFace)).AddSelf(incPoly.Body.Position)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PolygonCircle(m As PhysicsKit.Manifold, a As PhysicsKit.Body, b As PhysicsKit.Body)
		  // Re-use the CirclePolygon method with the arguments reversed.
		  Collisions.CirclePolygon(m, b, a)
		  
		  If m.ContactCount > 0 Then Call m.Normal.NegateSelf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PolygonPolygon(m As PhysicsKit.Manifold, a As PhysicsKit.Body, b As PhysicsKit.Body)
		  Var polygonShapeA As PhysicsKit.Polygon = PhysicsKit.Polygon(a.Shape) //A
		  Var polygonShapeB As PhysicsKit.Polygon = PhysicsKit.Polygon(b.Shape) //B
		  
		  m.ContactCount = 0
		  
		  // Check for a separating axis with polygonShapeA's face planes.
		  Var faceA() As Integer = Array(0)
		  Var penetrationA As Double = FindAxisLeastPenetration(faceA, polygonShapeA, polygonShapeB)
		  If penetrationA >= 0 Then Return
		  
		  // Check for a separating axis with polygonShapeB's face planes.
		  Var faceB() As Integer = Array(0)
		  Var penetrationB As Double = FindAxisLeastPenetration(faceB, polygonShapeB, polygonShapeA)
		  If penetrationB >= 0 Then Return
		  
		  Var referenceIndex As Integer
		  Var flip As Boolean // Always point from bodyA to bodyB.
		  
		  Var RefPoly As PhysicsKit.Polygon // Reference.
		  Var IncPoly As PhysicsKit.Polygon // Incident.
		  
		  // Determine which shape contains reference face.
		  If Maths.Greater(penetrationA, penetrationB) Then
		    RefPoly = polygonShapeA
		    IncPoly = polygonShapeB
		    referenceIndex = faceA(0)
		    flip = False
		  Else
		    RefPoly = polygonShapeB
		    IncPoly = polygonShapeA
		    referenceIndex = faceB(0)
		    flip = True
		  End If
		  
		  // World space incident face.
		  Var incidentFace() As PhysicsKit.Vector = Vector.ArrayOf(2)
		  FindIncidentFace(incidentFace, RefPoly, IncPoly, referenceIndex)
		  
		  // Setup reference face vertices.
		  Var v1 As PhysicsKit.Vector = RefPoly.Vertices(referenceIndex)
		  referenceIndex = If(referenceIndex + 1 = RefPoly.VertexCount, 0, referenceIndex + 1)
		  Var v2 As PhysicsKit.Vector = RefPoly.Vertices(referenceIndex)
		  
		  // Transform vertices to world space.
		  v1 = RefPoly.U.Multiply(v1).AddSelf(RefPoly.Body.Position)
		  v2 = RefPoly.U.Multiply(v2).AddSelf(RefPoly.Body.Position)
		  
		  // Calculate reference face side normal in world space.
		  Var sidePlaneNormal As PhysicsKit.Vector = v2.Subtract(v1)
		  sidePlaneNormal.Normalise
		  
		  // Orthogonalize.
		  Var refFaceNormal As PhysicsKit.Vector = New Vector(sidePlaneNormal.Y, -sidePlaneNormal.X)
		  
		  // ax + by = c
		  // c is distance from origin
		  Var refC As Double = Vector.Dot(refFaceNormal, v1)
		  Var negSide As Double = -Vector.Dot(sidePlaneNormal, v1)
		  Var posSide As Double = Vector.Dot(sidePlaneNormal, v2)
		  
		  // Clip incident face to reference face side planes.
		  If Clip(sidePlaneNormal.Negate, negSide, incidentFace) < 2 Then
		    Return // Due to floating point error, possible to not have required points.
		  End If
		  
		  If Clip(sidePlaneNormal, posSide, incidentFace) < 2 Then
		    Return // Due to floating point error, possible to not have required points.
		  End If
		  
		  // Flip.
		  Call m.Normal.Set(refFaceNormal)
		  If flip Then Call m.Normal.NegateSelf
		  
		  // Keep points behind reference face.
		  Var cp As Integer = 0 // Clipped points behind reference face.
		  Var separation As Double = Vector.Dot(refFaceNormal, incidentFace(0)) - refC
		  If separation <= 0 Then
		    Call m.Contacts(cp).Set(incidentFace(0))
		    m.Penetration = -separation
		    cp = cp + 1
		  Else
		    m.Penetration = 0
		  End If
		  
		  separation = Vector.Dot(refFaceNormal, incidentFace(1)) - refC
		  
		  If separation <= 0 Then
		    Call m.Contacts(cp).Set(incidentFace(1))
		    m.Penetration = m.Penetration + -separation
		    cp = cp + 1
		    
		    // Average penetration.
		    m.Penetration = m.Penetration / cp
		  End If
		  
		  m.ContactCount = cp
		  
		End Sub
	#tag EndMethod


End Module
#tag EndModule
