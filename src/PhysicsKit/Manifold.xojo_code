#tag Class
Protected Class Manifold
	#tag Method, Flags = &h0
		Sub ApplyImpulse()
		  // Early out and positional correct if both objects have infinite mass
		  If Maths.Equal(A.InvMass + B.InvMass, 0) Then
		    InfiniteMassCorrection
		    Return
		  End If
		  
		  Var ra, rb, rv, impulse, t, tangentImpulse As PhysicsKit.Vector
		  Var raCrossN, rbCrossN, invMassSum, j, jt, contactVel As Double
		  Var i As Integer = 0
		  While i < ContactCount
		    // Calculate radii from COM to contact.
		    ra = Contacts(i).Subtract(A.Position)
		    rb = Contacts(i).Subtract(B.Position)
		    
		    // Relative velocity.
		    rv = B.Velocity.Add(Vector.Cross(B.AngularVelocity, rb, New Vector))._
		    SubtractSelf(A.Velocity).SubtractSelf(Vector.Cross(A.AngularVelocity, ra, New Vector))
		    
		    // Relative velocity along the normal.
		    contactVel = Vector.Dot(rv, Normal)
		    
		    // Do not resolve if velocities are separating.
		    If contactVel > 0 Then Return
		    
		    raCrossN = Vector.Cross(ra, Normal)
		    rbCrossN = Vector.Cross(rb, Normal)
		    invMassSum = A.InvMass + B.InvMass + (raCrossN * raCrossN) * A.InvInertia + _
		    (rbCrossN * rbCrossN) * B.InvInertia
		    
		    // Calculate impulse scalar.
		    j = -(1 + Restitution) * contactVel
		    j = j / invMassSum
		    j = j / contactCount
		    
		    // Apply impulse.
		    impulse = Normal.Multiply(j)
		    A.ApplyImpulse(impulse.Negate, ra)
		    B.ApplyImpulse(impulse, rb)
		    
		    // Friction impulse.
		    rv = B.Velocity.Add(Vector.Cross(B.AngularVelocity, rb, New Vector))._
		    SubtractSelf(A.Velocity).SubtractSelf(Vector.Cross(A.AngularVelocity, ra, New Vector))
		    
		    t = New Vector(rv)
		    Call t.AddSelf(Normal, -Vector.Dot(rv, Normal))
		    t.Normalise
		    
		    // j tangent magnitude.
		    jt = -Vector.Dot(rv, t)
		    jt = jt / invMassSum
		    jt = jt / contactCount
		    
		    // Don't apply tiny friction impulses.
		    If Maths.Equal(jt, 0) Then Return
		    
		    // Coulumb's law.
		    If Abs(jt) < j * StaticFriction Then
		      tangentImpulse = t.Multiply(jt)
		    Else
		      tangentImpulse = t.Multiply(j).MultiplySelf(-DynamicFriction)
		    End If
		    
		    // Apply friction impulse.
		    A.ApplyImpulse(tangentImpulse.Negate, ra)
		    B.ApplyImpulse(tangentImpulse, rb)
		    
		    i = i + 1
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(a As PhysicsKit.Body, b As PhysicsKit.Body)
		  Self.A = a
		  Self.B = b
		  Normal = New Vector(0, 0)
		  Contacts(0) = New Vector(0, 0)
		  Contacts(1) = New Vector(0, 0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InfiniteMassCorrection()
		  A.Velocity.Set(0, 0)
		  B.Velocity.Set(0, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialise()
		  // Calculate average restitution
		  Restitution = Min(A.Restitution, B.Restitution)
		  
		  // Calculate static and dynamic friction.
		  StaticFriction = Sqrt(A.StaticFriction * A.StaticFriction + B.StaticFriction * B.StaticFriction)
		  DynamicFriction = Sqrt(A.DynamicFriction * A.DynamicFriction + B.DynamicFriction * B.DynamicFriction)
		  
		  Var ra, rb, rv As PhysicsKit.Vector
		  Var i As Integer = 0
		  While i < ContactCount
		    // Calculate radii from COM to contact.
		    ra = contacts(i).Subtract(A.Position)
		    rb = contacts(i).Subtract(B.Position)
		    
		    rv = B.Velocity.Add(Vector.Cross(B.AngularVelocity, rb, New Vector)). _
		    SubtractSelf(A.Velocity).SubtractSelf(Vector.Cross(A.AngularVelocity, ra, New Vector))
		    
		    // Determine if we should perform a resting collision or not.
		    // The idea is that if the only thing moving this object is gravity,
		    // then the collision should be performed without any restitution.
		    If rv.LengthSquared < Maths.RESTING Then Restitution = 0
		    
		    i = i + 1
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PositionalCorrection()
		  Var correction As Double = Max(Penetration - Maths.PENETRATION_ALLOWANCE, 0) _
		  / (A.InvMass + B.InvMass) * Maths.PENETRATION_CORRECTION
		  
		  Call A.Position.AddSelf(Normal, -A.InvMass * correction)
		  Call B.Position.AddSelf(normal, B.InvMass * correction)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Solve()
		  If A IsA Circle And B IsA Circle Then
		    Collisions.CircleCircle(Self, A, B)
		    
		  ElseIf A IsA Circle And B IsA Polygon Then
		    Collisions.CirclePolygon(Self, A, B)
		    
		  ElseIf A IsA Polygon And B IsA Circle Then
		    Collisions.PolygonCircle(Self, A, B)
		    
		  ElseIf A IsA Polygon And B IsA Polygon Then
		    #Pragma Warning "TODO"
		    
		  Else
		    Raise New InvalidArgumentException("Collision.Solve: Unsupported combination of shapes")
		  End If
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Manifold objects contain information about a collision.
		
	#tag EndNote


	#tag Property, Flags = &h0
		A As PhysicsKit.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		B As PhysicsKit.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		ContactCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Contacts(1) As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		DynamicFriction As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		Penetration As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41766572616765207265737469747574696F6E2E
		Restitution As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		StaticFriction As Double
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
