#tag Class
Protected Class Matrix
	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D6174726978207468617420697320746865206162736F6C7574652076616C7565206F662074686973206D61747269782E
		Function Abs() As PhysicsKit.Matrix
		  // Returns a new matrix that is the absolute value of this matrix.
		  
		  Var out As PhysicsKit.Matrix = New Matrix
		  
		  out.M00 = Realbasic.Abs(M00)
		  out.M01 = Realbasic.Abs(M01)
		  out.M10 = Realbasic.Abs(M10)
		  out.M11 = Realbasic.Abs(M11)
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206162736F6C7574652076616C7565206F662074686973206D617472697820616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Function Abs(out As PhysicsKit.Matrix) As PhysicsKit.Matrix
		  // Sets `out` to the absolute value of this matrix and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then out = New Matrix
		  
		  out.M00 = Realbasic.Abs(M00)
		  out.M01 = Realbasic.Abs(M01)
		  out.M10 = Realbasic.Abs(M10)
		  out.M11 = Realbasic.Abs(M11)
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C756573206F662074686973206D617472697820746F207468656972206162736F6C7574652076616C75652E
		Sub AbsSelf()
		  // Sets the values of this matrix to their absolute value.
		  
		  M00 = REALbasic.Abs(M00)
		  M01 = REALbasic.Abs(M01)
		  M10 = REALbasic.Abs(M10)
		  M11 = REALbasic.Abs(M11)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(radians As Double)
		  Set(radians)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(a As Double, b As Double, c As Double, d As Double)
		  Set(a, b, c, d)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F7220746861742069732074686520782D61786973202831737420636F6C756D6E29206F662074686973206D61747269782E
		Function GetAxisX() As PhysicsKit.Vector
		  // Returns a new vector that is the x-axis (1st column) of this matrix.
		  
		  Return New Vector(M00, M10)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F2074686520782D61786973202831737420636F6C756D6E29206F662074686973206D617472697820616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Function GetAxisX(out As PhysicsKit.Vector) As PhysicsKit.Vector
		  // Sets `out` to the x-axis (1st column) of this matrix and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    Return New Vector(M00, M10)
		  Else
		    out.X = M00
		    out.Y = M10
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F7220746861742069732074686520792D617869732028326E6420636F6C756D6E29206F662074686973206D61747269782E
		Function GetAxisY() As PhysicsKit.Vector
		  // Returns a new vector that is the y-axis (2nd column) of this matrix.
		  
		  Return New Vector(M01, M11)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F2074686520792D617869732028326E6420636F6C756D6E29206F662074686973206D617472697820616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Function GetAxisY(out As PhysicsKit.Vector) As PhysicsKit.Vector
		  // Sets `out` to the y-axis (2nd column) of this matrix and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    Return New Vector(M01, M11)
		  Else
		    out.X = M01
		    out.Y = M11
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F7574602074686520746F207472616E73666F726D6174696F6E206F66207B782C797D2062792074686973206D617472697820616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Function Multiply(x As Double, y As Double, out As PhysicsKit.Vector) As PhysicsKit.Vector
		  // Sets `out` the to transformation of {x,y} by this matrix and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    Return New Vector(M00 * x + M01 * y, M10 * x + M11 * y)
		  Else
		    out.X = M00 * x + M01 * y
		    out.Y = M10 * x + M11 * y
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D6174726978207468617420697320746865206D756C7469706C69636174696F6E206F66207468697320616E64206078602E
		Function Multiply(x As PhysicsKit.Matrix) As PhysicsKit.Matrix
		  // Returns a new matrix that is the multiplication of this and `x`.
		  
		  Return Multiply(x, New Matrix())
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865206D756C7469706C69636174696F6E206F662074686973206D617472697820616E642060786020616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Function Multiply(x As PhysicsKit.Matrix, out As PhysicsKit.Matrix) As PhysicsKit.Matrix
		  // Sets `out` to the multiplication of this matrix and `x` and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then out = New PhysicsKit.Matrix
		  
		  out.M00 = M00 * x.M00 + M01 * x.M10
		  out.M01 = M00 * x.M01 + M01 * x.M11
		  out.M10 = M10 * x.M00 + M11 * x.M10
		  out.M11 = M10 * x.M01 + M11 * x.M11
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720766563746F72207468617420697320746865207472616E73666F726D6174696F6E206F66206076602062792074686973206D61747269782E
		Function Multiply(v As PhysicsKit.Vector) As PhysicsKit.Vector
		  // Returns a new vector that is the transformation of `v` by this matrix.
		  
		  Return Multiply(v.X, v.Y, New Vector())
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865207472616E73666F726D6174696F6E206F66206076602062792074686973206D61747269782E
		Function Multiply(v As PhysicsKit.Vector, out As PhysicsKit.Vector) As PhysicsKit.Vector
		  // Sets `out` to the transformation of `v` by this matrix.
		  
		  Return Multiply(v.X, v.Y, out)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D756C7469706C6965732074686973206D617472697820627920782E
		Sub MultiplySelf(x As PhysicsKit.Matrix)
		  // Multiplies this matrix by x.
		  
		  Set(M00 * x.M00 + M01 * x.M10, _
		  M00 * x.M01 + M01 * x.M11, _
		  M10 * x.M00 + M11 * x.M10, _
		  M10 * x.M01 + M11 * x.M11)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472616E73666F726D73206076602062792074686973206D61747269782E
		Function MultiplySelf(v As PhysicsKit.Vector) As PhysicsKit.Vector
		  // Transforms `v` by this matrix.
		  
		  Return Multiply(v.X, v.Y, v)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206D617472697820746F206120726F746174696F6E206D617472697820776974682074686520676976656E2072616469616E732E
		Sub Set(radians As Double)
		  // Sets this matrix to a rotation matrix with the given radians.
		  
		  Var c As Double = Cos(radians)
		  Var s As Double = Sin(radians)
		  
		  M00 = c
		  M01 = -s
		  M10 = s
		  M11 = c
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C756573206F6620746865206D61747269782E
		Sub Set(a As Double, b As Double, c As Double, d As Double)
		  // Sets the values of the matrix.
		  
		  M00 = a
		  M01 = b
		  M10 = c
		  M11 = d
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206D617472697820746F2068617665207468652073616D652076616C7565732061732074686520676976656E206D61747269782E
		Sub Set(m As PhysicsKit.Matrix)
		  // Sets this matrix to have the same values as the given matrix.
		  
		  M00 = m.M00
		  M01 = m.M01
		  M10 = m.M10
		  M11 = m.m11
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206D6174726978207468617420697320746865207472616E73706F7365206F662074686973206D61747269782E
		Function Transpose() As PhysicsKit.Matrix
		  // Returns a new matrix that is the transpose of this matrix.
		  
		  Return New PhysicsKit.Matrix(M00, M10, M01, M11)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320606F75746020746F20746865207472616E73706F7365206F662074686973206D617472697820616E642072657475726E7320606F7574602E204372656174657320606F757460206966206E65656465642E
		Function Transpose(out As PhysicsKit.Matrix) As PhysicsKit.Matrix
		  // Sets `out` to the transpose of this matrix and returns `out`.
		  // Creates `out` if needed.
		  
		  If out = Nil Then
		    Return New PhysicsKit.Matrix(M00, M10, M01, M11)
		  Else
		    out.M00 = M00
		    out.M01 = M10
		    out.M10 = M01
		    out.M11 = M11
		  End If
		  
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320746865206D617472697820746F2069742773207472616E73706F73652E
		Sub TransposeSelf()
		  // Sets the matrix to it's transpose.
		  
		  Var t As Double = M01
		  M01 = M10
		  M10 = t
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		M00 As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		M01 As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		M10 As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		M11 As Double
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
			Name="M00"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
