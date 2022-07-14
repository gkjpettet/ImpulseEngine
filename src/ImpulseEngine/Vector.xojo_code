#tag Class
Protected Class Vector
	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F722074686174206973207468652073756D206265747765656E207468697320766563746F7220616E6420607363616C6172602E
		Function Add(scalar As Double) As ImpulseEngine.Vector
		  // Returns a new vector that is the sum between this vector and `scalar`.
		  
		  Return New Vector(X + scalar, Y + scalar)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F207468652073756D206F66207468697320766563746F7220616E6420607363616C61726020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E20205468697320766563746F7220697320756E616C74657265642E
		Function Add(scalar As Double, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the sum of this vector and `scalar` and returns `out`. 
		  // Creates `out` if needed. 
		  // This vector is unaltered.
		  
		  If out = Nil Then
		    out = New Vector(X + scalar, Y + scalar)
		  Else
		    out.X = X + scalar
		    out.Y = Y + scalar
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F72207468617420697320746865206164646974696F6E206F66207468697320766563746F7220616E64206076602E205468697320766563746F7220697320756E616C74657265642E
		Function Add(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Returns a new vector that is the addition of this vector and `v`.
		  // This vector is unaltered.
		  
		  Return New Vector(X + v.X, Y + v.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F72207468617420697320746865206164646974696F6E206F66207468697320766563746F7220616E6420607660202A20607363616C617260
		Function Add(v As ImpulseEngine.Vector, scalar As Double) As ImpulseEngine.Vector
		  // Returns a new vector that is the addition of this vector and `v` * `scalar`.
		  
		  Return New Vector(X + v.X * scalar, Y + v.Y * scalar)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206164646974696F6E206F66207468697320766563746F7220616E6420607660202A20607363616C61726020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E205468697320766563746F7220697320756E616C74657265642E
		Function Add(v As ImpulseEngine.Vector, scalar As Double, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the addition of this vector and `v` * `scalar` and returns `out`.
		  // Creates `out` if needed. 
		  // This vector is unaltered.
		  
		  If out = Nil Then
		    out = New Vector(X + v.X * scalar, Y + v.Y * scalar)
		  Else
		    out.X = X + v.x * scalar
		    out.Y = Y + v.Y * scalar
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206164646974696F6E206F66207468697320766563746F7220616E642060766020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E205468697320766563746F7220697320756E616C74657265642E
		Function Add(v As ImpulseEngine.Vector, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the addition of this vector and `v` and returns `out`.
		  // Creates `out` if needed.
		  // This vector is unaltered.
		  
		  If out = Nil Then
		    out = New Vector(X + v.X, Y + v.Y)
		  Else
		    out.X = X + v.X
		    out.Y = Y + v.Y
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320607363616C61726020746F207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function AddSelf(scalar As Double) As ImpulseEngine.Vector
		  // Adds `scalar` to this vector and returns itself.
		  
		  X  = X + scalar
		  Y = Y + scalar
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732060766020746F207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function AddSelf(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Adds `v` to this vector and returns itself.
		  
		  X = X + v.X
		  Y = Y + v.Y
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320607660202A20607363616C61726020746F207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function AddSelf(v As ImpulseEngine.Vector, scalar As Double) As ImpulseEngine.Vector
		  // Adds `v` * `scalar` to this vector and returns itself.
		  
		  X = X + v.X * scalar
		  Y = Y + v.Y * scalar
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616C6C6F636174656420566563746F7273206F662074686520726571756573746564206C656E6774682E
		Shared Function ArrayOf(length As Integer) As ImpulseEngine.Vector()
		  // Returns an array of allocated Vectors of the requested length.
		  
		  Var vectors() As ImpulseEngine.Vector
		  
		  Var i As Integer
		  length = length - 1
		  For i = 0 To length
		    vectors.AddRow(New Vector)
		  Next i
		  
		  Return vectors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465732061206E657720766563746F7220696E7374616E6365207769746820746865207370656369666965642028782C20792920636F6F7264696E617465732E
		Sub Constructor(x As Double, y As Double)
		  // Creates a new vector instance with the specified (x, y) coordinates.
		  
		  Self.X = x
		  Self.Y = y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(v As ImpulseEngine.Vector)
		  // Creates a new vector using the value of the passed vector.
		  
		  X = v.X
		  Y = v.Y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320766563746F7220746F207468652063726F7373206265747765656E207363616C61722060616020616E6420766563746F722060766020616E642072657475726E7320697473656C662E
		Function Cross(a As Double, v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets this vector to the cross between scalar `a` and vector `v` and returns itself.
		  
		  X = v.Y * -a
		  Y = v.X * a
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F207468652063726F7373206265747765656E207363616C61722060616020616E6420766563746F722060766020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Shared Function Cross(a As Double, v As ImpulseEngine.Vector, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the cross between scalar `a` and vector `v` and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    out = New Vector(v.Y * -a, v.X * a)
		  Else
		    out.X = v.Y * -a
		    out.Y = v.X * a
		  End If
		  
		  Return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207363616C61722063726F7373206265747765656E207468697320766563746F7220616E64206076602E
		Function Cross(v As ImpulseEngine.Vector) As Double
		  // Returns the scalar cross between this vector and `v`. Essentially
		  // the length of the cross product if this vector were 3D. This can also
		  // indicate which way `v` is facing relative to this vector.
		  
		  Return X * v.Y - Y * v.X
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320766563746F7220746F207468652063726F7373206265747765656E20766563746F722060766020616E64207363616C61722060616020616E642072657475726E7320697473656C662E
		Function Cross(v As ImpulseEngine.Vector, a As Double) As ImpulseEngine.Vector
		  // Sets this vector to the cross between vector `v` and scalar `a` and returns itself.
		  
		  X = v.Y * a
		  Y = v.X * -a
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F207468652063726F7373206265747765656E20766563746F722060766020616E64207363616C61722060616020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Shared Function Cross(v As ImpulseEngine.Vector, a As Double, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the cross between vector `v` and scalar `a` and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    out = New Vector(v.Y * a, v.X * -a)
		  Else
		    out.X = v.Y * a
		    out.Y = v.X * -a
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207363616C61722063726F7373206265747765656E20766563746F72732060616020616E64206062602E
		Shared Function Cross(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector) As Double
		  // Returns the scalar cross between vectors `a` and `b`. Essentially
		  // the length of the cross product if `a` was 3D. This can also
		  // indicate which way `b` is facing relative to this vector.
		  
		  Return a.X * b.Y - a.Y * b.X
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652064697374616E6365206265747765656E207468697320766563746F7220616E6420766563746F72206076602E
		Function Distance(v As ImpulseEngine.Vector) As Double
		  // Returns the distance between this vector and vector `v`.
		  
		  Var dx As Double = X - v.X
		  Var dy As Double = Y - v.Y
		  
		  Return Sqrt(dx * dx + dy * dy)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652064697374616E6365206265747765656E20766563746F722060616020616E6420766563746F72206062602E
		Shared Function Distance(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector) As Double
		  // Returns the distance between vector `a` and vector `b`.
		  
		  Var dx As Double = a.X - b.X
		  Var dy As Double = a.Y - b.Y
		  
		  Return Sqrt(dx * dx + dy * dy)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520737175617265642064697374616E6365206265747765656E207468697320766563746F7220616E6420766563746F72206076602E
		Function DistanceSquared(v As ImpulseEngine.Vector) As Double
		  // Returns the squared distance between this vector and vector `v`.
		  
		  Var dx As Double = X - v.X
		  Var dy As Double = Y - v.Y
		  
		  Return dx * dx + dy * dy
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520737175617265642064697374616E6365206265747765656E20766563746F722060616020616E6420766563746F72206062602E
		Shared Function DistanceSquared(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector) As Double
		  // Returns the squared distance between vector `a` and vector `b`.
		  
		  Var dx As Double = a.X - b.X
		  Var dy As Double = a.Y - b.Y
		  
		  Return dx * dx + dy * dy
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F7220746861742069732061206469766973696F6E206265747765656E207468697320766563746F7220616E6420607363616C6172602E205468697320766563746F7220697320756E616C74657265642E
		Function Divide(scalar As Double) As ImpulseEngine.Vector
		  // Returns a new vector that is a division between this vector and `scalar`.
		  // This vector is unaltered.
		  
		  Return New Vector(X / scalar, Y / scalar)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206469766973696F6E206F66207468697320766563746F7220616E642074686520706173736564207363616C617220616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E20205468697320766563746F7220697320616C74657265642E
		Function Divide(scalar As Double, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the division of this vector and the passed scalar and returns `out`.
		  // Creates `out` if needed. 
		  // This vector is altered.
		  
		  If out = Nil Then
		    out = New Vector(X / scalar, Y / scalar)
		  Else
		    out.X = X / scalar
		    out.Y = Y / scalar
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F72207468617420697320746865206469766973696F6E206F66207468697320766563746F72206279206076602E205468697320766563746F7220697320756E616C74657265642E
		Function Divide(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Returns a new vector that is the division of this vector by `v`.
		  // This vector is unaltered.
		  
		  Return New Vector(X / v.X, Y / v.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206469766973696F6E206F66207468697320766563746F7220616E642060766020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E205468697320766563746F7220697320756E616C74657265642E
		Function Divide(v As ImpulseEngine.Vector, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the division of this vector and `v` and returns `out`.
		  // Creates `out` if needed.
		  // This vector is unaltered.
		  
		  If out = Nil Then
		    out = New Vector(X / v.X, y / v.Y)
		  Else
		    out.X = X / v.X
		    out.Y = Y / v.Y
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44697669646573207468697320766563746F722062792074686520706173736564207363616C617220616E642072657475726E7320697473656C662E
		Function DivideSelf(scalar As Double) As ImpulseEngine.Vector
		  // Divides this vector by the passed scalar and returns itself.
		  
		  X = X / scalar
		  Y = Y / scalar
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44697669646573207468697320766563746F722062792060766020616E642072657475726E7320697473656C662E
		Function DivideSelf(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Divides this vector by `v` and returns itself.
		  
		  X = X / v.X
		  Y = Y / v.Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646F742070726F64756374206265747765656E207468697320766563746F7220616E6420766563746F72206076602E
		Function Dot(v As ImpulseEngine.Vector) As Double
		  // Returns the dot product between this vector and vector `v`.
		  
		  Return X * v.X + Y * v.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646F742070726F64756374206265747765656E20766563746F722060616020616E6420766563746F72206062602E
		Shared Function Dot(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector) As Double
		  // Returns the dot product between vector `a` and vector `b`.
		  
		  Return a.X * b.X + a.Y * b.Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206C656E677468206F66207468697320766563746F722E
		Function Length() As Double
		  // Returns the length of this vector.
		  
		  Return Sqrt(X * X + Y * Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652073717561726564206C656E677468206F66207468697320766563746F722E
		Function LengthSquared() As Double
		  // Returns the squared length of this vector.
		  
		  Return X * X + Y * Y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206D6178696D756D206265747765656E20766563746F72732060616020616E642060626020616E64207468656E2072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Shared Function Max(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the maximum between vectors `a` and `b` and then returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    Return New Vector(Max(a.X, b.X), Max(a.Y, b.Y))
		  Else
		    out.X = Max(a.X, b.X)
		    out.Y = Max(a.Y, b.Y)
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320766563746F7220746F20746865206D6178696D756D206265747765656E20766563746F72732060616020616E642060626020616E64207468656E2072657475726E7320697473656C662E
		Function MaxSelf(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets this vector to the maximum between vectors `a` and `b` and then returns itself.
		  
		  X = Max(a.X, b.X)
		  Y = Max(a.Y, b.Y)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206D696E696D756D206265747765656E20766563746F72732060616020616E642060626020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Shared Function Min(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the minimum between vectors `a` and `b` and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    out = New Vector(Min(a.X, b.X), Min(a.Y, b.Y))
		  Else
		    out.X = Min(a.X, b.X)
		    out.Y = Min(a.Y, b.Y)
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320766563746F7220746F20746865206D696E696D756D206265747765656E20766563746F72732060616020616E642060626020616E642072657475726E7320697473656C662E
		Function MinSelf(a As ImpulseEngine.Vector, b As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets this vector to the minimum between vectors `a` and `b` and returns itself.
		  
		  X = Min(a.X, b.X)
		  Y = Min(a.Y, b.Y)
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F7220746861742069732061206D756C7469706C69636174696F6E206F66207468697320766563746F7220616E642074686520706173736564207363616C61722E205468697320766563746F7220697320756E616C74657265642E
		Function Multiply(scalar As Double) As ImpulseEngine.Vector
		  // Returns a new vector that is a multiplication of this vector and the passed scalar.
		  // This vector is unaltered.
		  
		  Return New Vector(scalar * X, scalar * Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F207468697320766563746F72206D756C7469706C6965642062792074686520706173736564207363616C617220616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E20205468697320766563746F7220697320756E616C74657265642E
		Function Multiply(scalar As Double, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to this vector multiplied by the passed scalar and returns `out`.
		  // Creates `out` if needed. 
		  // This vector is unaltered.
		  
		  If out = Nil Then
		    out = New Vector(scalar * X, scalar * Y)
		  Else
		    out.X = scalar * X
		    out.Y = scalar * Y
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F722074686174206973207468652070726F64756374206F66207468697320766563746F7220616E6420762E205468697320766563746F7220697320756E616C74657265642E
		Function Multiply(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Returns a new vector that is the product of this vector and v.
		  // This vector is unaltered.
		  
		  Return New Vector(X * v.X, Y * v.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F207468652070726F64756374206F66207468697320766563746F7220616E642060766020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E205468697320766563746F7220697320756E616C74657265642E
		Function Multiply(v As ImpulseEngine.Vector, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the product of this vector and `v` and returns `out`.
		  // Creates `out` if needed.
		  // This vector is unaltered.
		  
		  If out = Nil Then
		    out = New Vector(X * v.X, Y * v.Y)
		  Else
		    out.X = X * v.X
		    out.Y = Y * v.Y
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C696573207468697320766563746F722062792074686520706173736564207363616C617220616E642072657475726E7320697473656C662E
		Function MultiplySelf(scalar As Double) As ImpulseEngine.Vector
		  // Multiplies this vector by the passed scalar and returns itself.
		  
		  X = scalar * X
		  y = scalar * Y
		  
		  Return Self
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C696573207468697320766563746F722062792060766020616E642072657475726E7320697473656C662E
		Function MultiplySelf(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Multiplies this vector by `v` and returns itself.
		  
		  X = X * v.X
		  Y = Y * v.Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Negate() As ImpulseEngine.Vector
		  // Returns a new vector that is the negation to this vector.
		  
		  Return New Vector(-X, -Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206E65676174696F6E206F66207468697320766563746F7220616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E20205468697320766563746F7220697320756E616C746572656420627920746865206F7065726174696F6E2E
		Function Negate(out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the negation of this vector and returns `out`.
		  // Creates `out` if needed. 
		  // This vector is unaltered by the operation.
		  
		  If out = Nil Then
		    out = New Vector(-X, -Y)
		  Else
		    out.X = -X
		    out.Y = -Y
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E656761746573207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function NegateSelf() As ImpulseEngine.Vector
		  // Negates this vector and returns itself.
		  
		  X = -X
		  Y = -Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4E6F726D616C69736573207468697320766563746F722C206D616B696E67206974206120756E697420766563746F722E204120756E697420766563746F72206861732061206C656E677468206F6620312E302E
		Sub Normalise()
		  // Normalises this vector, making it a unit vector. A unit vector has a length of 1.0.
		  
		  Var lenSq As Double = LengthSquared
		  
		  If lenSq > MathS.EPSILON_SQ Then
		    Var invLen As Double = 1 / Sqrt(lenSq)
		    X = X * invLen
		    Y = Y * invLen
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526F7461746573207468697320766563746F722062792074686520676976656E2072616469616E732E
		Sub Rotate(radians As Double)
		  // Rotates this vector by the given radians.
		  
		  Var c As Double = Cos(radians)
		  Var s As Double = Sin(radians)
		  
		  Var xp As Double = X * c - Y * s
		  Var yp As Double = X * s + Y * c
		  
		  X = xp
		  Y = yp
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520582C205920636F6D706F6E656E747320746F20746865207061737365642076616C7565732E
		Sub Set(x As Double, y As Double)
		  // Sets the X, Y components to the passed values.
		  
		  Self.X = x
		  Self.Y = y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468697320766563746F72277320636F6D706F6E656E747320746F207468652073616D652076616C756573206173207468652070617373656420766563746F7220616E642072657475726E7320697473656C662E
		Function Set(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets this vector's components to the same values as the passed vector and returns itself.
		  
		  Self.X = v.X
		  Self.Y = v.Y
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F72207468617420697320746865207375627472616374696F6E206F66206076602066726F6D207468697320766563746F722E205468697320766563746F7220697320756E616C74657265642E
		Function Subtract(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Returns a new vector that is the subtraction of `v` from this vector.
		  // This vector is unaltered.
		  
		  Return New Vector(X - v.X, Y - v.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865207375627472616374696F6E206F66206076602066726F6D207468697320766563746F7220616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E20205468697320766563746F7220697320756E616C74657265642E
		Function Subtract(v As ImpulseEngine.Vector, out As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Sets `out` to the subtraction of `v` from this vector and returns `out`.
		  // Creates `out` if needed. 
		  // This vector is unaltered.
		  
		  If out = Nil Then
		    out = New Vector(X - v.X, Y - v.Y)
		  Else
		    out.X = X - v.X
		    out.Y = Y - v.Y
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 537562747261637473206076602066726F6D207468697320766563746F7220616E642072657475726E7320697473656C662E
		Function SubtractSelf(v As ImpulseEngine.Vector) As ImpulseEngine.Vector
		  // Subtracts `v` from this vector and returns itself.
		  
		  X = X - v.X
		  Y = Y - v.Y
		  
		  Return Self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return "{X: " + X.ToString + ", Y: " + Y.ToString + "}"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		X As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Y As Double = 0
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
		#tag ViewProperty
			Name="X"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
