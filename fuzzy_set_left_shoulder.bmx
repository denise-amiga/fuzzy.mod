Rem
	bbdoc: Left shoulder shape
	about:
	definition of a fuzzy set that has a left shoulder shape. The minimum value this variable can accept is *any* value less than the midpoint.
End Rem
Type TFuzzySetLeftShoulder Extends TFuzzySet
	'the values that define the shape of this FLV
	Field m_dPeakPoint:Double
	Field m_dRightOffset:Double
	Field m_dLeftOffset:Double
	
	Rem
		bbdoc: Creates a TFuzzySetLeftShoulder object
	End Rem
	Method Create:TFuzzySetLeftShoulder(peak:Double, leftOffset:Double, rightOffset:Double)
		Self.m_dPeakPoint = peak
		Self.m_dLeftOffset = leftOffset
		Self.m_dRightOffset = rightOffset
		Super.CreateBase(((peak - leftOffset) + peak) / 2)
		Return Self
	End Method
	
	Rem
		bbdoc: this method calculates the degree of membership for a particular value
	End Rem
	Method CalculateDOM:Double(val:Double)
		'test for the case where the left or right offsets are zero (to prevent divide by zero errors below)
		If (Self.m_dRightOffset = 0 And Self.m_dPeakPoint = val) Or (Self.m_dLeftOffset = 0 And Self.m_dPeakPoint = val)
			Return 1.0
		'find DOM if right of center
		Else If (val >= Self.m_dPeakPoint) And (val < (Self.m_dPeakPoint + Self.m_dRightOffset))
			Local grad:Double = 1.0 / -Self.m_dRightOffset
			Return grad * (val - Self.m_dPeakPoint) + 1.0
		'find DOM if left of center
		Else If (val < Self.m_dPeakPoint) And (val >= Self.m_dPeakPoint - Self.m_dLeftOffset)
			Return 1.0
		'out of range of this FLV, return zero
		Else
			Return 0.0
		End If
	End Method
End Type
