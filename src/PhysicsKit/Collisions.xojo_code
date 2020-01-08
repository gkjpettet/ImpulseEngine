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


End Module
#tag EndModule
