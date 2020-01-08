#tag Module
Protected Module Collisions
	#tag Method, Flags = &h1
		Protected Sub CircleCircle(m As PhysicsKit.Manifold, a As PhysicsKit.Body, b As PhysicsKit.Body)
		  Var circleA As PhysicsKit.Circle = PhysicsKit.Circle(a.Shape)
		  Var circleB As PhysicsKit.Circle = PhysicsKit.Circle(b.Shape)
		  
		  // Calculate translational vector, which is normal.
		  Var normal As PhysicsKit.Vector = b.Position.Subtract(a.Position)
		  
		  Var dist_sqr As Double = normal.LengthSquared
		  Var radius As Double = circleA.Radius + circleB.Radius
		  
		  // Not in contact.
		  If dist_sqr >= radius * radius Then
		    m.ContactCount = 0
		    Return
		  End If
		  
		  Var distance As Double = Sqrt(dist_sqr)
		  
		  m.ContactCount = 1
		  
		  If distance = 0 Then
		    m.Penetration = circleA.Radius
		    m.Normal.Set(1, 0)
		    Call m.Contacts(0).Set(a.Position)
		  Else
		    m.Penetration = radius - distance
		    Call m.Normal.Set(normal).DivideSelf(distance) // Faster than using Normalized as we already performed sqrt.
		    Call m.Contacts(0).Set(m.Normal).MultiplySelf(circleA.Radius).AddSelf(a.Position)
		  End If
		  
		End Sub
	#tag EndMethod


End Module
#tag EndModule
