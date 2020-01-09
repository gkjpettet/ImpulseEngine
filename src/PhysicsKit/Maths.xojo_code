#tag Module
Protected Module Maths
	#tag Method, Flags = &h1, Description = 52657475726E7320606160206966206974206973206265747765656E20606D696E6020616E6420606D61782C206F74686572776973652072657475726E7320606D696E60202869662060616020697320746F6F20736D616C6C29206F7220606D617860202869662060616020697320746F6F206C61726765292E
		Protected Function Clamp(min As Double, max As Double, a As Double) As Double
		  // Returns `a` if it is between `min` and `max, otherwise returns `min` (if `a` is too small) or 
		  // `max` (if `a` is too large).
		  
		  Return If(a < min, min, If(a > max, max, a))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DegreesToRadians(degrees As Double) As Double
		  // Returns the specified degrees in radians.
		  
		  Return degrees * PI / 180
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732054727565206966207468652074776F20646F75626C65732061726520636F6E7369646572656420657175616C2028616C6C6F77696E6720666F7220746F6C6572616E6365292E
		Protected Function Equal(a As Double, b As Double) As Boolean
		  // Returns True if the two doubles are considered equal (allowing for tolerance).
		  
		  Return Abs(a - b) <= EPSILON
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732054727565206966206061602069732067726561746572207468616E206062602028616C6C6F77696E6720666F7220746F6C6572616E6365292E
		Protected Function Greater(a As Double, b As Double) As Boolean
		  // Returns True if `a` is greater than `b` (allowing for tolerance).
		  
		  Return a >= b * BIAS_RELATIVE + a * BIAS_ABSOLUTE
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Initialise()
		  // Several of the properties in this module must be computed before first use.
		  // This method sets them all up. It is called internally by `PhysicsKit.Initialise`
		  // and only needs to be done once.
		  
		  mGRAVITY = New Vector(0, 50)
		  mRESTING = mGRAVITY.Multiply(DT).LengthSquared + EPSILON
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865207370656369666965642072616469616E7320696E20646567726565732E
		Protected Function RadiansToDegrees(radians As Double) As Double
		  // Returns the specified radians in degrees.
		  
		  Return radians * 180 / PI
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320612072616E646F6D20446F75626C65206265747765656E20606D696E6020616E6420606D6178602E
		Protected Function Random(min As Double, max As Double) As Double
		  // Returns a random Double between `min` and `max`.
		  
		  Return ((max - min) * System.Random.Number + min)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 526F756E6473207468652070617373656420446F75626C6520757020746F20746865206E65617265737420496E74656765722E
		Protected Function Round(a As Double) As Integer
		  // Rounds the passed Double up to the nearest Integer.
		  
		  #Pragma Warning "OPTIMISE: Could this be replaced by Xojo's implementation?"
		  
		  Return a + 0.5
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This module contains additional maths-related helper methods and constants.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return mGRAVITY
			End Get
		#tag EndGetter
		Protected GRAVITY As PhysicsKit.Vector
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGRAVITY As PhysicsKit.Vector
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRESTING As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected PI As Double = 3.14159265359
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return mRESTING
			End Get
		#tag EndGetter
		Protected RESTING As Double
	#tag EndComputedProperty


	#tag Constant, Name = BIAS_ABSOLUTE, Type = Double, Dynamic = False, Default = \"0.01", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BIAS_RELATIVE, Type = Double, Dynamic = False, Default = \"0.95", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DT, Type = Double, Dynamic = False, Default = \"0.01666666", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = EPSILON, Type = Double, Dynamic = False, Default = \"0.0001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = EPSILON_SQ, Type = Double, Dynamic = False, Default = \"0.00000001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FLOAT_MAX_VALUE, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PENETRATION_ALLOWANCE, Type = Double, Dynamic = False, Default = \"0.05", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PENETRATION_CORRECTION, Type = Double, Dynamic = False, Default = \"0.4", Scope = Protected
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
	#tag EndViewBehavior
End Module
#tag EndModule
