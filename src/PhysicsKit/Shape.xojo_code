#tag Interface
Protected Interface Shape
	#tag Method, Flags = &h0
		Function Body() As PhysicsKit.Body
		  
		End Function
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
		Function GetType() As PhysicsKit.ShapeTypes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initalise()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Radius() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOrient(radians As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function U() As PhysicsKit.Matrix
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
