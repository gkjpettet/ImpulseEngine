#tag Interface
Protected Interface Shape
	#tag Method, Flags = &h0
		Function Body() As ImpulseEngine.Body
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Body(Assigns b As ImpulseEngine.Body)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ImpulseEngine.Shape
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeMass(density As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialise()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Orientation(Assigns radians As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Radius() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Radius(Assigns r As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function U() As ImpulseEngine.Matrix
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub U(Assigns m As ImpulseEngine.Matrix)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
