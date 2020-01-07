#tag Interface
Protected Interface Shape
	#tag Method, Flags = &h0
		Function Body() As PhysicsKit.Body
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Body(Assigns b As PhysicsKit.Body)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As PhysicsKit.Shape
		  
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
		Function Radius() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Radius(Assigns r As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOrient(radians As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As PhysicsKit.ShapeTypes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function U() As PhysicsKit.Matrix
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub U(Assigns m As PhysicsKit.Matrix)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
