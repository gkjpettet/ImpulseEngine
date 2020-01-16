#tag Class
Protected Class Manifold
	#tag Method, Flags = &h0
		Sub ApplyImpulse()
		  // Early out and positional correct if both objects have infinite mass
		  If Maths.Equal(A.InverseMass + B.InverseMass, 0) Then
		    InfiniteMassCorrection
		    Return
		  End If
		  
		  Var ra, rb, rv, impulse, t, tangentImpulse As ImpulseEngine.Vector
		  Var raCrossN, rbCrossN, invMassSum, j, jt, contactVel As Double
		  Var contactLimit As Integer = ContactCount - 1
		  For i As Integer = 0 To contactLimit
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
		    invMassSum = A.InverseMass + B.InverseMass + (raCrossN * raCrossN) * A.InverseInertia + _
		    (rbCrossN * rbCrossN) * B.InverseInertia
		    
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
		  Next i
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(a As ImpulseEngine.Body, b As ImpulseEngine.Body, timeStep As Integer)
		  Self.A = a
		  Self.B = b
		  Normal = New Vector(0, 0)
		  Contacts(0) = New Vector(0, 0)
		  Contacts(1) = New Vector(0, 0)
		  mTimeStep = timeStep
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InfiniteMassCorrection()
		  A.Velocity.Set(0, 0)
		  B.Velocity.Set(0, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialise(w As ImpulseEngine.World)
		  // Restitution mixing law. Taken from Box2D. 
		  // The idea is allow for anything to bounce off an inelastic surface.
		  // For example, a superball bounces on anything.
		  Restitution = If(A.Restitution > B.Restitution, A.Restitution, B.Restitution)
		  
		  // Calculate static and dynamic friction.
		  StaticFriction = Sqrt(A.StaticFriction * A.StaticFriction + B.StaticFriction * B.StaticFriction)
		  DynamicFriction = Sqrt(A.DynamicFriction * A.DynamicFriction + B.DynamicFriction * B.DynamicFriction)
		  
		  Var ra, rb, rv As ImpulseEngine.Vector
		  Var contactLimit As Integer = ContactCount - 1
		  For i As Integer = 0 To contactLimit
		    // Calculate radii from COM to contact.
		    ra = contacts(i).Subtract(A.Position)
		    rb = contacts(i).Subtract(B.Position)
		    
		    rv = B.Velocity.Add(Vector.Cross(B.AngularVelocity, rb, New Vector)). _
		    SubtractSelf(A.Velocity).SubtractSelf(Vector.Cross(A.AngularVelocity, ra, New Vector))
		    
		    // Determine if we should perform a resting collision or not.
		    // The idea is that if the only thing moving this object is gravity,
		    // then the collision should be performed without any restitution.
		    If rv.LengthSquared < w.RestingValue Then Restitution = 0
		  Next i
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PositionalCorrection()
		  Var correction As Double = Max(Penetration - Maths.PENETRATION_ALLOWANCE, 0) _
		  / (A.InverseMass + B.InverseMass) * Maths.PENETRATION_CORRECTION
		  
		  Call A.Position.AddSelf(Normal, -A.InverseMass * correction)
		  Call B.Position.AddSelf(normal, B.InverseMass * correction)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44657465726D696E6573206966207468697320636F6C6C6973696F6E2073686F756C6420626520636F6E7369646572656420747275652E2041207472756520636F6C6C6973696F6E2063616E206F6E6C79206F63637572206966206174206C65617374206F6E6520626F6479206973206D6F76696E672E
		Sub RestingCorrection()
		  // Since contacts are created during every worl update, bodies resting against each other 
		  // will always be colliding. We're really only interested in knowing if a body has just 
		  // collided with another, not that it happens to be permanently beside another. 
		  // This method set `mCollisionOccurred` to True if both bodies A and B have at least 
		  // some velocity.
		  
		  If Maths.OutsideRange(A.Velocity.X, -RESTING_THRESHOLD, RESTING_THRESHOLD) Or _
		    Maths.OutsideRange(A.Velocity.Y, -RESTING_THRESHOLD, RESTING_THRESHOLD) Or _
		    Maths.OutsideRange(B.Velocity.X, -RESTING_THRESHOLD, RESTING_THRESHOLD) Or _
		    Maths.OutsideRange(B.Velocity.Y, -RESTING_THRESHOLD, RESTING_THRESHOLD) Then
		    mCollisionOccurred = True
		  Else
		    mCollisionOccurred = False
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Solve()
		  Var shapeA As Variant = A.Shape
		  Var shapeB As Variant = B.Shape
		  
		  If shapeA IsA Circle And shapeB IsA Circle Then
		    Collisions.CircleCircle(Self, A, B)
		    
		  ElseIf shapeA IsA Circle And shapeB IsA Polygon Then
		    Collisions.CirclePolygon(Self, A, B)
		    
		  ElseIf shapeA IsA Polygon And shapeB IsA Circle Then
		    Collisions.PolygonCircle(Self, A, B)
		    
		  ElseIf shapeA IsA Polygon And shapeB IsA Polygon Then
		    Collisions.PolygonPolygon(Self, A, B)
		    
		  Else
		    Raise New InvalidArgumentException("Collision.Solve: Unsupported combination of shapes")
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Manifold objects contain information about a collision.
		
	#tag EndNote


	#tag Property, Flags = &h0
		A As ImpulseEngine.Body
	#tag EndProperty

	#tag Property, Flags = &h0
		B As ImpulseEngine.Body
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686973206D616E69666F6C6420726570726573656E7473206120636F6C6C6973696F6E206265747765656E2074776F20626F64696573207468617420617265204E4F5420617420726573742E
		#tag Getter
			Get
			  Return mCollisionOccurred
			End Get
		#tag EndGetter
		CollisionOccurred As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ContactCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Contacts(1) As ImpulseEngine.Vector
	#tag EndProperty

	#tag Property, Flags = &h0
		DynamicFriction As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCollisionOccurred As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060576F726C642E557064617465602074696D657374657020746861742074686973206D616E69666F6C6420776173206372656174656420696E2E
		Private mTimeStep As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Normal As ImpulseEngine.Vector
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

	#tag ComputedProperty, Flags = &h0, Description = 5468652060576F726C642E557064617465602074696D657374657020746861742074686973206D616E69666F6C6420776173206372656174656420696E2E2052656164206F6E6C792E
		#tag Getter
			Get
			  Return mTimeStep
			End Get
		#tag EndGetter
		TimeStep As Integer
	#tag EndComputedProperty


	#tag Constant, Name = RESTING_THRESHOLD, Type = Double, Dynamic = False, Default = \"1.0", Scope = Private
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
			Name="Penetration"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContactCount"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Restitution"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DynamicFriction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StaticFriction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CollisionOccurred"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TimeStep"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
