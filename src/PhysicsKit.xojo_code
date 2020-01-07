#tag Module
Protected Module PhysicsKit
	#tag CompatibilityFlags = API2Only
	#tag Method, Flags = &h1, Description = 496E697469616C6973657320766172696F757320636F6D706F6E656E74732E204D7573742062652063616C6C6564206265666F726520746865206D6F64756C6520697320666972737420757365642E
		Protected Sub Initialise()
		  // Initialises various components. Must be called before the module is first used.
		  
		  Maths.Initialise
		End Sub
	#tag EndMethod


	#tag Enum, Name = ShapeTypes, Type = Integer, Flags = &h0
		Circle
		  Poly
		Count
	#tag EndEnum


End Module
#tag EndModule
