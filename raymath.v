module raylibv
import math

pub fn (v Vector3) to_axis_rotation() (Vector3, f32) {
	quat := quaternionfromeuler(v.x, v.y, v.z)
	return quaterniontoaxisangle(quat)
}

pub fn clamp(value f32, min f32, max f32) f32 {
	mut result := if value < min{ min } else {value}
	if result > max {
	result = max
	}
	return result
}

pub fn lerp(start f32, end f32, amount f32) f32 {
	result := start + amount * (end - start)
	return result
}

pub fn normalize(value f32, start f32, end f32) f32 {
	result := (value - start) / (end - start)
	return result
}

pub fn remap(value f32, inputstart f32, inputend f32, outputstart f32, outputend f32) f32 {
	result := (value - inputstart) / (inputend - inputstart) * (outputend - outputstart) + outputstart
	return result
}

pub fn wrap(value f32, min f32, max f32) f32 {
	result := value - (max - min) * math.floor((value - min) / (max - min))
	return f32(result)
}


pub fn floatequals(x f32, y f32) bool {
	result := (math.abs(x - y)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(x), math.abs(y))))
	return result
}


pub fn vector2zero() Vector2 {
	result := Vector2 {
	0, 0}
	
	return result
}


pub fn vector2one() Vector2 {
	result := Vector2 {
	1, 1}
	
	return result
}


pub fn vector2add(v1 Vector2, v2 Vector2) Vector2 {
	result := Vector2 {
	v1.x + v2.x, v1.y + v2.y}
	
	return result
}


pub fn vector2addvalue(v Vector2, add f32) Vector2 {
	result := Vector2 {
	v.x + add, v.y + add}
	
	return result
}


pub fn vector2subtract(v1 Vector2, v2 Vector2) Vector2 {
	result := Vector2 {
	v1.x - v2.x, v1.y - v2.y}
	
	return result
}


pub fn vector2subtractvalue(v Vector2, sub f32) Vector2 {
	result := Vector2 {
	v.x - sub, v.y - sub}
	
	return result
}


pub fn vector2length(v Vector2) f32 {
	result := math.sqrtf((v.x * v.x) + (v.y * v.y))
	return result
}


pub fn vector2lengthsqr(v Vector2) f32 {
	result := (v.x * v.x) + (v.y * v.y)
	return result
}


pub fn vector2dotproduct(v1 Vector2, v2 Vector2) f32 {
	result := (v1.x * v2.x + v1.y * v2.y)
	return result
}


pub fn vector2distance(v1 Vector2, v2 Vector2) f32 {
	result := math.sqrtf((v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y))
	return result
}


pub fn vector2distancesqr(v1 Vector2, v2 Vector2) f32 {
	result := ((v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y))
	return result
}


pub fn vector2angle(v1 Vector2, v2 Vector2) f32 {
	
	result := math.atan2(v2.y, v2.x) - math.atan2(v1.y, v1.x)
	return f32(result)
}


pub fn vector2scale(v Vector2, scale f32) Vector2 {
	result := Vector2 {
	v.x * scale, v.y * scale}
	
	return result
}


pub fn vector2multiply(v1 Vector2, v2 Vector2) Vector2 {
	result := Vector2 {
	v1.x * v2.x, v1.y * v2.y}
	
	return result
}


pub fn vector2negate(v Vector2) Vector2 {
	result := Vector2 {
	-v.x, -v.y}
	
	return result
}


pub fn vector2divide(v1 Vector2, v2 Vector2) Vector2 {
	result := Vector2 {
	v1.x / v2.x, v1.y / v2.y}
	
	return result
}


pub fn vector2normalize(v Vector2) Vector2 {
	mut result := Vector2 {}
	
	length := math.sqrtf((v.x * v.x) + (v.y * v.y))
	if length > 0 {
		ilength := 1 / length
		result.x = v.x * ilength
		result.y = v.y * ilength
	}
	return result
}


pub fn vector2transform(v Vector2, mat Matrix) Vector2 {
	mut result := Vector2 {
	0, 0}
	
	x := v.x
	y := v.y
	z := 0
	result.x = mat.m0 * x + mat.m4 * y + mat.m8 * z + mat.m12
	result.y = mat.m1 * x + mat.m5 * y + mat.m9 * z + mat.m13
	return result
}


pub fn vector2lerp(v1 Vector2, v2 Vector2, amount f32) Vector2 {
	mut result := Vector2 {
	0, 0}
	
	result.x = v1.x + amount * (v2.x - v1.x)
	result.y = v1.y + amount * (v2.y - v1.y)
	return result
}


pub fn vector2reflect(v Vector2, normal Vector2) Vector2 {
	mut result := Vector2 {
	0, 0}
	
	dotproduct := (v.x * normal.x + v.y * normal.y)
	result.x = v.x - (2 * normal.x) * dotproduct
	result.y = v.y - (2 * normal.y) * dotproduct
	return result
}


pub fn vector2rotate(v Vector2, angle f32) Vector2 {
	mut result := Vector2 {
	0, 0}
	
	cosres := math.cosf(angle)
	sinres := math.sinf(angle)
	result.x = v.x * cosres - v.y * sinres
	result.y = v.x * sinres + v.y * cosres
	return result
}


pub fn vector2movetowards(v Vector2, target Vector2, maxdistance f32) Vector2 {
	mut result := Vector2 {
	0, 0}
	
	dx := target.x - v.x
	dy := target.y - v.y
	value := (dx * dx) + (dy * dy)
	if (value == 0) || ((maxdistance >= 0) && (value <= maxdistance * maxdistance)) {
	return target
	}
	dist := math.sqrtf(value)
	result.x = v.x + dx / dist * maxdistance
	result.y = v.y + dy / dist * maxdistance
	return result
}


pub fn vector2invert(v Vector2) Vector2 {
	result := Vector2 {
	1 / v.x, 1 / v.y}
	
	return result
}


pub fn vector2clamp(v Vector2, min Vector2, max Vector2) Vector2 {
	mut result := Vector2 {
	0, 0}
	
	result.x = math.min(max.x, math.max(min.x, v.x))
	result.y = math.min(max.y, math.max(min.y, v.y))
	return result
}


pub fn vector2clampvalue(v Vector2, min f32, max f32) Vector2 {
	mut result := v
	mut length := (v.x * v.x) + (v.y * v.y)
	if length > 0 {
		length = math.sqrtf(length)
		if length < min {
			scale := min / length
			result.x = v.x * scale
			result.y = v.y * scale
		}
		else if length > max {
			scale := max / length
			result.x = v.x * scale
			result.y = v.y * scale
		}
	}
	return result
}


pub fn vector2equals(p Vector2, q Vector2) bool {
	result := ((math.abs(p.x - q.x)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.x), math.abs(q.x))))) && ((math.abs(p.y - q.y)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.y), math.abs(q.y)))))
	return result
}


pub fn vector3zero() Vector3 {
	result := Vector3 {
	0, 0, 0}
	
	return result
}


pub fn vector3one() Vector3 {
	result := Vector3 {
	1, 1, 1}
	
	return result
}


pub fn vector3add(v1 Vector3, v2 Vector3) Vector3 {
	result := Vector3 {
	v1.x + v2.x, v1.y + v2.y, v1.z + v2.z}
	
	return result
}


pub fn vector3addvalue(v Vector3, add f32) Vector3 {
	result := Vector3 {
	v.x + add, v.y + add, v.z + add}
	
	return result
}


pub fn vector3subtract(v1 Vector3, v2 Vector3) Vector3 {
	result := Vector3 {
	v1.x - v2.x, v1.y - v2.y, v1.z - v2.z}
	
	return result
}


pub fn vector3subtractvalue(v Vector3, sub f32) Vector3 {
	result := Vector3 {
	v.x - sub, v.y - sub, v.z - sub}
	
	return result
}


pub fn vector3scale(v Vector3, scalar f32) Vector3 {
	result := Vector3 {
	v.x * scalar, v.y * scalar, v.z * scalar}
	
	return result
}


pub fn vector3multiply(v1 Vector3, v2 Vector3) Vector3 {
	result := Vector3 {
	v1.x * v2.x, v1.y * v2.y, v1.z * v2.z}
	
	return result
}


pub fn vector3crossproduct(v1 Vector3, v2 Vector3) Vector3 {
	result := Vector3 {
	v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x}
	
	return result
}


pub fn vector3perpendicular(v Vector3) Vector3 {
	mut result := Vector3 {}
	
	mut min := f32(math.abs(v.x))
	mut cardinalaxis := Vector3 {
	1, 0, 0}
	
	if math.abs(v.y) < min {
		min = f32(math.abs(v.y))
		tmp := Vector3 {
		0, 1, 0}
		
		cardinalaxis = tmp
	}
	if math.abs(v.z) < min {
		tmp := Vector3 {
		0, 0, 1}
		
		cardinalaxis = tmp
	}
	result.x = v.y * cardinalaxis.z - v.z * cardinalaxis.y
	result.y = v.z * cardinalaxis.x - v.x * cardinalaxis.z
	result.z = v.x * cardinalaxis.y - v.y * cardinalaxis.x
	return result
}


pub fn vector3length(v Vector3) f32 {
	result := math.sqrtf(v.x * v.x + v.y * v.y + v.z * v.z)
	return result
}


pub fn vector3lengthsqr(v Vector3) f32 {
	result := v.x * v.x + v.y * v.y + v.z * v.z
	return result
}


pub fn vector3dotproduct(v1 Vector3, v2 Vector3) f32 {
	result := (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z)
	return result
}


pub fn vector3distance(v1 Vector3, v2 Vector3) f32 {
	mut result := f32(0)
	dx := v2.x - v1.x
	dy := v2.y - v1.y
	dz := v2.z - v1.z
	result = math.sqrtf(dx * dx + dy * dy + dz * dz)
	return result
}


pub fn vector3distancesqr(v1 Vector3, v2 Vector3) f32 {
	mut result := f32(0)
	dx := v2.x - v1.x
	dy := v2.y - v1.y
	dz := v2.z - v1.z
	result = dx * dx + dy * dy + dz * dz
	return result
}


pub fn vector3angle(v1 Vector3, v2 Vector3) f32 {
	mut result := f32(0)
	cross := Vector3 {
	v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x}
	
	len := math.sqrtf(cross.x * cross.x + cross.y * cross.y + cross.z * cross.z)
	dot := (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z)
	result = f32(math.atan2(len, dot))
	return result
}


pub fn vector3negate(v Vector3) Vector3 {
	result := Vector3 {
	-v.x, -v.y, -v.z}
	
	return result
}


pub fn vector3divide(v1 Vector3, v2 Vector3) Vector3 {
	result := Vector3 {
	v1.x / v2.x, v1.y / v2.y, v1.z / v2.z}
	
	return result
}


pub fn vector3normalize(v Vector3) Vector3 {
	mut result := v
	mut length := math.sqrtf(v.x * v.x + v.y * v.y + v.z * v.z)
	if length == 0 {
	length = 1
	}
	ilength := 1 / length
	result.x *= ilength
	result.y *= ilength
	result.z *= ilength
	return result
}


pub fn vector3orthonormalize(mut v1 Vector3, mut v2 Vector3)  {
	mut length := f32(0)
	mut ilength := f32(0)
	mut v := *v1
	length = math.sqrtf(v.x * v.x + v.y * v.y + v.z * v.z)
	if length == 0 {
	length = 1
	}
	ilength = 1 / length
	v1.x *= ilength
	v1.y *= ilength
	v1.z *= ilength
	mut vn1 := Vector3 {
	v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x}
	
	v = vn1
	length = math.sqrtf(v.x * v.x + v.y * v.y + v.z * v.z)
	if length == 0 {
	length = 1
	}
	ilength = 1 / length
	vn1.x *= ilength
	vn1.y *= ilength
	vn1.z *= ilength
	vn2 := Vector3 {
	vn1.y * v1.z - vn1.z * v1.y, vn1.z * v1.x - vn1.x * v1.z, vn1.x * v1.y - vn1.y * v1.x}
	
	unsafe{*v2 = vn2}
}


pub fn vector3transform(v Vector3, mat Matrix) Vector3 {
	mut result := Vector3 {}
	
	x := v.x
	y := v.y
	z := v.z
	result.x = mat.m0 * x + mat.m4 * y + mat.m8 * z + mat.m12
	result.y = mat.m1 * x + mat.m5 * y + mat.m9 * z + mat.m13
	result.z = mat.m2 * x + mat.m6 * y + mat.m10 * z + mat.m14
	return result
}


pub fn vector3rotatebyquaternion(v Vector3, q Quaternion) Vector3 {
	mut result := Vector3 {}
	
	result.x = v.x * (q.x * q.x + q.w * q.w - q.y * q.y - q.z * q.z) + v.y * (2 * q.x * q.y - 2 * q.w * q.z) + v.z * (2 * q.x * q.z + 2 * q.w * q.y)
	result.y = v.x * (2 * q.w * q.z + 2 * q.x * q.y) + v.y * (q.w * q.w - q.x * q.x + q.y * q.y - q.z * q.z) + v.z * (-2 * q.w * q.x + 2 * q.y * q.z)
	result.z = v.x * (-2 * q.w * q.y + 2 * q.x * q.z) + v.y * (2 * q.w * q.x + 2 * q.y * q.z) + v.z * (q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z)
	return result
}


pub fn vector3rotatebyaxisangle(v Vector3, axiss Vector3, anglee f32) Vector3 {
	mut axis := axiss
	mut angle := anglee
	mut result := v
	mut length := math.sqrtf(axis.x * axis.x + axis.y * axis.y + axis.z * axis.z)
	if length == 0 {
	length = 1
	}
	ilength := 1 / length
	axis.x *= ilength
	axis.y *= ilength
	axis.z *= ilength
	angle /= 2
	mut a := math.sinf(angle)
	b := axis.x * a
	c := axis.y * a
	d := axis.z * a
	a = math.cosf(angle)
	w := Vector3 {
	b, c, d}
	
	mut wv := Vector3 {
	w.y * v.z - w.z * v.y, w.z * v.x - w.x * v.z, w.x * v.y - w.y * v.x}
	
	mut wwv := Vector3 {
	w.y * wv.z - w.z * wv.y, w.z * wv.x - w.x * wv.z, w.x * wv.y - w.y * wv.x}
	
	a *= 2
	wv.x *= a
	wv.y *= a
	wv.z *= a
	wwv.x *= 2
	wwv.y *= 2
	wwv.z *= 2
	result.x += wv.x
	result.y += wv.y
	result.z += wv.z
	result.x += wwv.x
	result.y += wwv.y
	result.z += wwv.z
	return result
}


pub fn vector3lerp(v1 Vector3, v2 Vector3, amount f32) Vector3 {
	mut result := Vector3 {}
	
	result.x = v1.x + amount * (v2.x - v1.x)
	result.y = v1.y + amount * (v2.y - v1.y)
	result.z = v1.z + amount * (v2.z - v1.z)
	return result
}


pub fn vector3reflect(v Vector3, normal Vector3) Vector3 {
	mut result := Vector3 {}
	
	dotproduct := (v.x * normal.x + v.y * normal.y + v.z * normal.z)
	result.x = v.x - (2 * normal.x) * dotproduct
	result.y = v.y - (2 * normal.y) * dotproduct
	result.z = v.z - (2 * normal.z) * dotproduct
	return result
}


pub fn vector3min(v1 Vector3, v2 Vector3) Vector3 {
	mut result := Vector3 {}
	
	result.x = math.min(v1.x, v2.x)
	result.y = math.min(v1.y, v2.y)
	result.z = math.min(v1.z, v2.z)
	return result
}


pub fn vector3max(v1 Vector3, v2 Vector3) Vector3 {
	mut result := Vector3 {}
	
	result.x = math.max(v1.x, v2.x)
	result.y = math.max(v1.y, v2.y)
	result.z = math.max(v1.z, v2.z)
	return result
}


pub fn vector3barycenter(p Vector3, a Vector3, b Vector3, c Vector3) Vector3 {
	mut result := Vector3 {}
	
	v0 := Vector3 {
	b.x - a.x, b.y - a.y, b.z - a.z}
	
	v1 := Vector3 {
	c.x - a.x, c.y - a.y, c.z - a.z}
	
	v2 := Vector3 {
	p.x - a.x, p.y - a.y, p.z - a.z}
	
	d00 := (v0.x * v0.x + v0.y * v0.y + v0.z * v0.z)
	d01 := (v0.x * v1.x + v0.y * v1.y + v0.z * v1.z)
	d11 := (v1.x * v1.x + v1.y * v1.y + v1.z * v1.z)
	d20 := (v2.x * v0.x + v2.y * v0.y + v2.z * v0.z)
	d21 := (v2.x * v1.x + v2.y * v1.y + v2.z * v1.z)
	denom := d00 * d11 - d01 * d01
	result.y = (d11 * d20 - d01 * d21) / denom
	result.z = (d00 * d21 - d01 * d20) / denom
	result.x = 1 - (result.z + result.y)
	return result
}


pub fn vector3unproject(source Vector3, projection Matrix, view Matrix) Vector3 {
	mut result := Vector3 {}
	
	matviewproj := Matrix {
	view.m0 * projection.m0 + view.m1 * projection.m4 + view.m2 * projection.m8 + view.m3 * projection.m12, view.m0 * projection.m1 + view.m1 * projection.m5 + view.m2 * projection.m9 + view.m3 * projection.m13, view.m0 * projection.m2 + view.m1 * projection.m6 + view.m2 * projection.m10 + view.m3 * projection.m14, view.m0 * projection.m3 + view.m1 * projection.m7 + view.m2 * projection.m11 + view.m3 * projection.m15, view.m4 * projection.m0 + view.m5 * projection.m4 + view.m6 * projection.m8 + view.m7 * projection.m12, view.m4 * projection.m1 + view.m5 * projection.m5 + view.m6 * projection.m9 + view.m7 * projection.m13, view.m4 * projection.m2 + view.m5 * projection.m6 + view.m6 * projection.m10 + view.m7 * projection.m14, view.m4 * projection.m3 + view.m5 * projection.m7 + view.m6 * projection.m11 + view.m7 * projection.m15, view.m8 * projection.m0 + view.m9 * projection.m4 + view.m10 * projection.m8 + view.m11 * projection.m12, view.m8 * projection.m1 + view.m9 * projection.m5 + view.m10 * projection.m9 + view.m11 * projection.m13, view.m8 * projection.m2 + view.m9 * projection.m6 + view.m10 * projection.m10 + view.m11 * projection.m14, view.m8 * projection.m3 + view.m9 * projection.m7 + view.m10 * projection.m11 + view.m11 * projection.m15, view.m12 * projection.m0 + view.m13 * projection.m4 + view.m14 * projection.m8 + view.m15 * projection.m12, view.m12 * projection.m1 + view.m13 * projection.m5 + view.m14 * projection.m9 + view.m15 * projection.m13, view.m12 * projection.m2 + view.m13 * projection.m6 + view.m14 * projection.m10 + view.m15 * projection.m14, view.m12 * projection.m3 + view.m13 * projection.m7 + view.m14 * projection.m11 + view.m15 * projection.m15}
	
	a00 := matviewproj.m0
a01 := matviewproj.m1
a02 := matviewproj.m2
a03 := matviewproj.m3

	a10 := matviewproj.m4
a11 := matviewproj.m5
a12 := matviewproj.m6
a13 := matviewproj.m7

	a20 := matviewproj.m8
a21 := matviewproj.m9
a22 := matviewproj.m10
a23 := matviewproj.m11

	a30 := matviewproj.m12
a31 := matviewproj.m13
a32 := matviewproj.m14
a33 := matviewproj.m15

	b00 := a00 * a11 - a01 * a10
	b01 := a00 * a12 - a02 * a10
	b02 := a00 * a13 - a03 * a10
	b03 := a01 * a12 - a02 * a11
	b04 := a01 * a13 - a03 * a11
	b05 := a02 * a13 - a03 * a12
	b06 := a20 * a31 - a21 * a30
	b07 := a20 * a32 - a22 * a30
	b08 := a20 * a33 - a23 * a30
	b09 := a21 * a32 - a22 * a31
	b10 := a21 * a33 - a23 * a31
	b11 := a22 * a33 - a23 * a32
	invdet := 1 / (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06)
	matviewprojinv := Matrix {
	(a11 * b11 - a12 * b10 + a13 * b09) * invdet, (-a01 * b11 + a02 * b10 - a03 * b09) * invdet, (a31 * b05 - a32 * b04 + a33 * b03) * invdet, (-a21 * b05 + a22 * b04 - a23 * b03) * invdet, (-a10 * b11 + a12 * b08 - a13 * b07) * invdet, (a00 * b11 - a02 * b08 + a03 * b07) * invdet, (-a30 * b05 + a32 * b02 - a33 * b01) * invdet, (a20 * b05 - a22 * b02 + a23 * b01) * invdet, (a10 * b10 - a11 * b08 + a13 * b06) * invdet, (-a00 * b10 + a01 * b08 - a03 * b06) * invdet, (a30 * b04 - a31 * b02 + a33 * b00) * invdet, (-a20 * b04 + a21 * b02 - a23 * b00) * invdet, (-a10 * b09 + a11 * b07 - a12 * b06) * invdet, (a00 * b09 - a01 * b07 + a02 * b06) * invdet, (-a30 * b03 + a31 * b01 - a32 * b00) * invdet, (a20 * b03 - a21 * b01 + a22 * b00) * invdet}
	
	quat := Quaternion {
	source.x, source.y, source.z, 1}
	
	qtransformed := Quaternion {
	matviewprojinv.m0 * quat.x + matviewprojinv.m4 * quat.y + matviewprojinv.m8 * quat.z + matviewprojinv.m12 * quat.w, matviewprojinv.m1 * quat.x + matviewprojinv.m5 * quat.y + matviewprojinv.m9 * quat.z + matviewprojinv.m13 * quat.w, matviewprojinv.m2 * quat.x + matviewprojinv.m6 * quat.y + matviewprojinv.m10 * quat.z + matviewprojinv.m14 * quat.w, matviewprojinv.m3 * quat.x + matviewprojinv.m7 * quat.y + matviewprojinv.m11 * quat.z + matviewprojinv.m15 * quat.w}
	
	result.x = qtransformed.x / qtransformed.w
	result.y = qtransformed.y / qtransformed.w
	result.z = qtransformed.z / qtransformed.w
	return result
}


pub fn vector3invert(v Vector3) Vector3 {
	result := Vector3 {
	1 / v.x, 1 / v.y, 1 / v.z}
	
	return result
}


pub fn vector3clamp(v Vector3, min Vector3, max Vector3) Vector3 {
	mut result := Vector3 {}
	
	result.x = math.min(max.x, math.max(min.x, v.x))
	result.y = math.min(max.y, math.max(min.y, v.y))
	result.z = math.min(max.z, math.max(min.z, v.z))
	return result
}


pub fn vector3clampvalue(v Vector3, min f32, max f32) Vector3 {
	mut result := v
	mut length := (v.x * v.x) + (v.y * v.y) + (v.z * v.z)
	if length > 0 {
		length = math.sqrtf(length)
		if length < min {
			scale := min / length
			result.x = v.x * scale
			result.y = v.y * scale
			result.z = v.z * scale
		}
		else if length > max {
			scale := max / length
			result.x = v.x * scale
			result.y = v.y * scale
			result.z = v.z * scale
		}
	}
	return result
}


pub fn vector3equals(p Vector3, q Vector3) bool {
	result := ((math.abs(p.x - q.x)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.x), math.abs(q.x))))) && ((math.abs(p.y - q.y)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.y), math.abs(q.y))))) && ((math.abs(p.z - q.z)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.z), math.abs(q.z)))))
	return result
}


pub fn vector3refract(vin Vector3, n Vector3, r f32) Vector3 {
	mut v := vin
	mut result := Vector3 {}
	
	dot := v.x * n.x + v.y * n.y + v.z * n.z
	mut d := 1 - r * r * (1 - dot * dot)
	if d >= 0 {
		d = math.sqrtf(d)
		v.x = r * v.x - (r * dot + d) * n.x
		v.y = r * v.y - (r * dot + d) * n.y
		v.z = r * v.z - (r * dot + d) * n.z
		result = v
	}
	return result
}


pub fn matrixdeterminant(mat Matrix) f32 {
	mut result := f32(0)
	a00 := mat.m0
a01 := mat.m1
a02 := mat.m2
a03 := mat.m3

	a10 := mat.m4
a11 := mat.m5
a12 := mat.m6
a13 := mat.m7

	a20 := mat.m8
a21 := mat.m9
a22 := mat.m10
a23 := mat.m11

	a30 := mat.m12
a31 := mat.m13
a32 := mat.m14
a33 := mat.m15

	result = a30 * a21 * a12 * a03 - a20 * a31 * a12 * a03 - a30 * a11 * a22 * a03 + a10 * a31 * a22 * a03 + a20 * a11 * a32 * a03 - a10 * a21 * a32 * a03 - a30 * a21 * a02 * a13 + a20 * a31 * a02 * a13 + a30 * a01 * a22 * a13 - a00 * a31 * a22 * a13 - a20 * a01 * a32 * a13 + a00 * a21 * a32 * a13 + a30 * a11 * a02 * a23 - a10 * a31 * a02 * a23 - a30 * a01 * a12 * a23 + a00 * a31 * a12 * a23 + a10 * a01 * a32 * a23 - a00 * a11 * a32 * a23 - a20 * a11 * a02 * a33 + a10 * a21 * a02 * a33 + a20 * a01 * a12 * a33 - a00 * a21 * a12 * a33 - a10 * a01 * a22 * a33 + a00 * a11 * a22 * a33
	return result
}


pub fn matrixtrace(mat Matrix) f32 {
	result := (mat.m0 + mat.m5 + mat.m10 + mat.m15)
	return result
}


pub fn matrixtranspose(mat Matrix) Matrix {
	mut result := Matrix {}
	
	result.m0 = mat.m0
	result.m1 = mat.m4
	result.m2 = mat.m8
	result.m3 = mat.m12
	result.m4 = mat.m1
	result.m5 = mat.m5
	result.m6 = mat.m9
	result.m7 = mat.m13
	result.m8 = mat.m2
	result.m9 = mat.m6
	result.m10 = mat.m10
	result.m11 = mat.m14
	result.m12 = mat.m3
	result.m13 = mat.m7
	result.m14 = mat.m11
	result.m15 = mat.m15
	return result
}


pub fn matrixinvert(mat Matrix) Matrix {
	mut result := Matrix {}
	
	a00 := mat.m0
a01 := mat.m1
a02 := mat.m2
a03 := mat.m3

	a10 := mat.m4
a11 := mat.m5
a12 := mat.m6
a13 := mat.m7

	a20 := mat.m8
a21 := mat.m9
a22 := mat.m10
a23 := mat.m11

	a30 := mat.m12
a31 := mat.m13
a32 := mat.m14
a33 := mat.m15

	b00 := a00 * a11 - a01 * a10
	b01 := a00 * a12 - a02 * a10
	b02 := a00 * a13 - a03 * a10
	b03 := a01 * a12 - a02 * a11
	b04 := a01 * a13 - a03 * a11
	b05 := a02 * a13 - a03 * a12
	b06 := a20 * a31 - a21 * a30
	b07 := a20 * a32 - a22 * a30
	b08 := a20 * a33 - a23 * a30
	b09 := a21 * a32 - a22 * a31
	b10 := a21 * a33 - a23 * a31
	b11 := a22 * a33 - a23 * a32
	invdet := 1 / (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06)
	result.m0 = (a11 * b11 - a12 * b10 + a13 * b09) * invdet
	result.m1 = (-a01 * b11 + a02 * b10 - a03 * b09) * invdet
	result.m2 = (a31 * b05 - a32 * b04 + a33 * b03) * invdet
	result.m3 = (-a21 * b05 + a22 * b04 - a23 * b03) * invdet
	result.m4 = (-a10 * b11 + a12 * b08 - a13 * b07) * invdet
	result.m5 = (a00 * b11 - a02 * b08 + a03 * b07) * invdet
	result.m6 = (-a30 * b05 + a32 * b02 - a33 * b01) * invdet
	result.m7 = (a20 * b05 - a22 * b02 + a23 * b01) * invdet
	result.m8 = (a10 * b10 - a11 * b08 + a13 * b06) * invdet
	result.m9 = (-a00 * b10 + a01 * b08 - a03 * b06) * invdet
	result.m10 = (a30 * b04 - a31 * b02 + a33 * b00) * invdet
	result.m11 = (-a20 * b04 + a21 * b02 - a23 * b00) * invdet
	result.m12 = (-a10 * b09 + a11 * b07 - a12 * b06) * invdet
	result.m13 = (a00 * b09 - a01 * b07 + a02 * b06) * invdet
	result.m14 = (-a30 * b03 + a31 * b01 - a32 * b00) * invdet
	result.m15 = (a20 * b03 - a21 * b01 + a22 * b00) * invdet
	return result
}


pub fn matrixidentity() Matrix {
	result := Matrix {
	1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
	
	return result
}


pub fn matrixadd(left Matrix, right Matrix) Matrix {
	mut result := Matrix {}
	
	result.m0 = left.m0 + right.m0
	result.m1 = left.m1 + right.m1
	result.m2 = left.m2 + right.m2
	result.m3 = left.m3 + right.m3
	result.m4 = left.m4 + right.m4
	result.m5 = left.m5 + right.m5
	result.m6 = left.m6 + right.m6
	result.m7 = left.m7 + right.m7
	result.m8 = left.m8 + right.m8
	result.m9 = left.m9 + right.m9
	result.m10 = left.m10 + right.m10
	result.m11 = left.m11 + right.m11
	result.m12 = left.m12 + right.m12
	result.m13 = left.m13 + right.m13
	result.m14 = left.m14 + right.m14
	result.m15 = left.m15 + right.m15
	return result
}


pub fn matrixsubtract(left Matrix, right Matrix) Matrix {
	mut result := Matrix {}
	
	result.m0 = left.m0 - right.m0
	result.m1 = left.m1 - right.m1
	result.m2 = left.m2 - right.m2
	result.m3 = left.m3 - right.m3
	result.m4 = left.m4 - right.m4
	result.m5 = left.m5 - right.m5
	result.m6 = left.m6 - right.m6
	result.m7 = left.m7 - right.m7
	result.m8 = left.m8 - right.m8
	result.m9 = left.m9 - right.m9
	result.m10 = left.m10 - right.m10
	result.m11 = left.m11 - right.m11
	result.m12 = left.m12 - right.m12
	result.m13 = left.m13 - right.m13
	result.m14 = left.m14 - right.m14
	result.m15 = left.m15 - right.m15
	return result
}


pub fn matrixmultiply(left Matrix, right Matrix) Matrix {
	mut result := Matrix {}
	
	result.m0 = left.m0 * right.m0 + left.m1 * right.m4 + left.m2 * right.m8 + left.m3 * right.m12
	result.m1 = left.m0 * right.m1 + left.m1 * right.m5 + left.m2 * right.m9 + left.m3 * right.m13
	result.m2 = left.m0 * right.m2 + left.m1 * right.m6 + left.m2 * right.m10 + left.m3 * right.m14
	result.m3 = left.m0 * right.m3 + left.m1 * right.m7 + left.m2 * right.m11 + left.m3 * right.m15
	result.m4 = left.m4 * right.m0 + left.m5 * right.m4 + left.m6 * right.m8 + left.m7 * right.m12
	result.m5 = left.m4 * right.m1 + left.m5 * right.m5 + left.m6 * right.m9 + left.m7 * right.m13
	result.m6 = left.m4 * right.m2 + left.m5 * right.m6 + left.m6 * right.m10 + left.m7 * right.m14
	result.m7 = left.m4 * right.m3 + left.m5 * right.m7 + left.m6 * right.m11 + left.m7 * right.m15
	result.m8 = left.m8 * right.m0 + left.m9 * right.m4 + left.m10 * right.m8 + left.m11 * right.m12
	result.m9 = left.m8 * right.m1 + left.m9 * right.m5 + left.m10 * right.m9 + left.m11 * right.m13
	result.m10 = left.m8 * right.m2 + left.m9 * right.m6 + left.m10 * right.m10 + left.m11 * right.m14
	result.m11 = left.m8 * right.m3 + left.m9 * right.m7 + left.m10 * right.m11 + left.m11 * right.m15
	result.m12 = left.m12 * right.m0 + left.m13 * right.m4 + left.m14 * right.m8 + left.m15 * right.m12
	result.m13 = left.m12 * right.m1 + left.m13 * right.m5 + left.m14 * right.m9 + left.m15 * right.m13
	result.m14 = left.m12 * right.m2 + left.m13 * right.m6 + left.m14 * right.m10 + left.m15 * right.m14
	result.m15 = left.m12 * right.m3 + left.m13 * right.m7 + left.m14 * right.m11 + left.m15 * right.m15
	return result
}


pub fn matrixtranslate(x f32, y f32, z f32) Matrix {
	result := Matrix {
	1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, z, 0, 0, 0, 1}
	
	return result
}


pub fn matrixrotate(axis Vector3, angle f32) Matrix {
	mut result := Matrix {}
	
	mut x := axis.x
mut y := axis.y
mut z := axis.z

	lengthsquared := x * x + y * y + z * z
	if (lengthsquared != 1) && (lengthsquared != 0) {
		ilength := 1 / math.sqrtf(lengthsquared)
		x *= ilength
		y *= ilength
		z *= ilength
	}
	sinres := math.sinf(angle)
	cosres := math.cosf(angle)
	t := 1 - cosres
	result.m0 = x * x * t + cosres
	result.m1 = y * x * t + z * sinres
	result.m2 = z * x * t - y * sinres
	result.m3 = 0
	result.m4 = x * y * t - z * sinres
	result.m5 = y * y * t + cosres
	result.m6 = z * y * t + x * sinres
	result.m7 = 0
	result.m8 = x * z * t + y * sinres
	result.m9 = y * z * t - x * sinres
	result.m10 = z * z * t + cosres
	result.m11 = 0
	result.m12 = 0
	result.m13 = 0
	result.m14 = 0
	result.m15 = 1
	return result
}


pub fn matrixrotatex(angle f32) Matrix {
	mut result := Matrix {
	1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
	
	cosres := math.cosf(angle)
	sinres := math.sinf(angle)
	result.m5 = cosres
	result.m6 = sinres
	result.m9 = -sinres
	result.m10 = cosres
	return result
}


pub fn matrixrotatey(angle f32) Matrix {
	mut result := Matrix {
	1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
	
	cosres := math.cosf(angle)
	sinres := math.sinf(angle)
	result.m0 = cosres
	result.m2 = -sinres
	result.m8 = sinres
	result.m10 = cosres
	return result
}


pub fn matrixrotatez(angle f32) Matrix {
	mut result := Matrix {
	1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
	
	cosres := math.cosf(angle)
	sinres := math.sinf(angle)
	result.m0 = cosres
	result.m1 = sinres
	result.m4 = -sinres
	result.m5 = cosres
	return result
}


pub fn matrixrotatexyz(angle Vector3) Matrix {
	mut result := Matrix {
	1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
	
	cosz := math.cosf(-angle.z)
	sinz := math.sinf(-angle.z)
	cosy := math.cosf(-angle.y)
	siny := math.sinf(-angle.y)
	cosx := math.cosf(-angle.x)
	sinx := math.sinf(-angle.x)
	result.m0 = cosz * cosy
	result.m1 = (cosz * siny * sinx) - (sinz * cosx)
	result.m2 = (cosz * siny * cosx) + (sinz * sinx)
	result.m4 = sinz * cosy
	result.m5 = (sinz * siny * sinx) + (cosz * cosx)
	result.m6 = (sinz * siny * cosx) - (cosz * sinx)
	result.m8 = -siny
	result.m9 = cosy * sinx
	result.m10 = cosy * cosx
	return result
}


pub fn matrixrotatezyx(angle Vector3) Matrix {
	mut result := Matrix {}
	
	cz := math.cosf(angle.z)
	sz := math.sinf(angle.z)
	cy := math.cosf(angle.y)
	sy := math.sinf(angle.y)
	cx := math.cosf(angle.x)
	sx := math.sinf(angle.x)
	result.m0 = cz * cy
	result.m4 = cz * sy * sx - cx * sz
	result.m8 = sz * sx + cz * cx * sy
	result.m12 = 0
	result.m1 = cy * sz
	result.m5 = cz * cx + sz * sy * sx
	result.m9 = cx * sz * sy - cz * sx
	result.m13 = 0
	result.m2 = -sy
	result.m6 = cy * sx
	result.m10 = cy * cx
	result.m14 = 0
	result.m3 = 0
	result.m7 = 0
	result.m11 = 0
	result.m15 = 1
	return result
}


pub fn matrixscale(x f32, y f32, z f32) Matrix {
	result := Matrix {
	x, 0, 0, 0, 0, y, 0, 0, 0, 0, z, 0, 0, 0, 0, 1}
	
	return result
}


pub fn matrixfrustum(left f64, right f64, bottom f64, top f64, near f64, far f64) Matrix {
	mut result := Matrix {}
	
	rl := f32((right - left))
	tb := f32((top - bottom))
	fan := f32((far - near))
	result.m0 = (f32(near) * 2) / rl
	result.m1 = 0
	result.m2 = 0
	result.m3 = 0
	result.m4 = 0
	result.m5 = (f32(near) * 2) / tb
	result.m6 = 0
	result.m7 = 0
	result.m8 = (f32(right) + f32(left)) / rl
	result.m9 = (f32(top) + f32(bottom)) / tb
	result.m10 = -(f32(far) + f32(near)) / fan
	result.m11 = -1
	result.m12 = 0
	result.m13 = 0
	result.m14 = -(f32(far) * f32(near) * 2) / fan
	result.m15 = 0
	return result
}


pub fn matrixperspective(fovy f64, aspect f64, near f64, far f64) Matrix {
	mut result := Matrix {}
	
	top := near * math.tan(fovy * 0.5)
	bottom := -top
	right := top * aspect
	left := -right
	rl := f32((right - left))
	tb := f32((top - bottom))
	fan := f32((far - near))
	result.m0 = (f32(near) * 2) / rl
	result.m5 = (f32(near) * 2) / tb
	result.m8 = (f32(right) + f32(left)) / rl
	result.m9 = (f32(top) + f32(bottom)) / tb
	result.m10 = -(f32(far) + f32(near)) / fan
	result.m11 = -1
	result.m14 = -(f32(far) * f32(near) * 2) / fan
	return result
}


pub fn matrixortho(left f64, right f64, bottom f64, top f64, near f64, far f64) Matrix {
	mut result := Matrix {}
	
	rl := f32((right - left))
	tb := f32((top - bottom))
	fan := f32((far - near))
	result.m0 = 2 / rl
	result.m1 = 0
	result.m2 = 0
	result.m3 = 0
	result.m4 = 0
	result.m5 = 2 / tb
	result.m6 = 0
	result.m7 = 0
	result.m8 = 0
	result.m9 = 0
	result.m10 = -2 / fan
	result.m11 = 0
	result.m12 = -(f32(left) + f32(right)) / rl
	result.m13 = -(f32(top) + f32(bottom)) / tb
	result.m14 = -(f32(far) + f32(near)) / fan
	result.m15 = 1
	return result
}


pub fn matrixlookat(eye Vector3, target Vector3, up Vector3) Matrix {
	mut result := Matrix {}
	
	mut length := f32(0)
	mut ilength := f32(0)
	mut vz := Vector3 {
	eye.x - target.x, eye.y - target.y, eye.z - target.z}
	
	mut v := vz
	length = math.sqrtf(v.x * v.x + v.y * v.y + v.z * v.z)
	if length == 0 {
	length = 1
	}
	ilength = 1 / length
	vz.x *= ilength
	vz.y *= ilength
	vz.z *= ilength
	mut vx := Vector3 {
	up.y * vz.z - up.z * vz.y, up.z * vz.x - up.x * vz.z, up.x * vz.y - up.y * vz.x}
	
	v = vx
	length = math.sqrtf(v.x * v.x + v.y * v.y + v.z * v.z)
	if length == 0 {
	length = 1
	}
	ilength = 1 / length
	vx.x *= ilength
	vx.y *= ilength
	vx.z *= ilength
	vy := Vector3 {
	vz.y * vx.z - vz.z * vx.y, vz.z * vx.x - vz.x * vx.z, vz.x * vx.y - vz.y * vx.x}
	
	result.m0 = vx.x
	result.m1 = vy.x
	result.m2 = vz.x
	result.m3 = 0
	result.m4 = vx.y
	result.m5 = vy.y
	result.m6 = vz.y
	result.m7 = 0
	result.m8 = vx.z
	result.m9 = vy.z
	result.m10 = vz.z
	result.m11 = 0
	result.m12 = -(vx.x * eye.x + vx.y * eye.y + vx.z * eye.z)
	result.m13 = -(vy.x * eye.x + vy.y * eye.y + vy.z * eye.z)
	result.m14 = -(vz.x * eye.x + vz.y * eye.y + vz.z * eye.z)
	result.m15 = 1
	return result
}

pub fn quaternionadd(q1 Quaternion, q2 Quaternion) Quaternion {
	result := Quaternion {
	q1.x + q2.x, q1.y + q2.y, q1.z + q2.z, q1.w + q2.w}
	
	return result
}


pub fn quaternionaddvalue(q Quaternion, add f32) Quaternion {
	result := Quaternion {
	q.x + add, q.y + add, q.z + add, q.w + add}
	
	return result
}


pub fn quaternionsubtract(q1 Quaternion, q2 Quaternion) Quaternion {
	result := Quaternion {
	q1.x - q2.x, q1.y - q2.y, q1.z - q2.z, q1.w - q2.w}
	
	return result
}


pub fn quaternionsubtractvalue(q Quaternion, sub f32) Quaternion {
	result := Quaternion {
	q.x - sub, q.y - sub, q.z - sub, q.w - sub}
	
	return result
}


pub fn quaternionidentity() Quaternion {
	result := Quaternion {
	0, 0, 0, 1}
	
	return result
}


pub fn quaternionlength(q Quaternion) f32 {
	result := math.sqrtf(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
	return result
}


pub fn quaternionnormalize(q Quaternion) Quaternion {
	mut result := Quaternion {}
	
	mut length := math.sqrtf(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
	if length == 0 {
	length = 1
	}
	ilength := 1 / length
	result.x = q.x * ilength
	result.y = q.y * ilength
	result.z = q.z * ilength
	result.w = q.w * ilength
	return result
}


pub fn quaternioninvert(q Quaternion) Quaternion {
	mut result := q
	lengthsq := q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w
	if lengthsq != 0 {
		invlength := 1 / lengthsq
		result.x *= -invlength
		result.y *= -invlength
		result.z *= -invlength
		result.w *= invlength
	}
	return result
}


pub fn quaternionmultiply(q1 Quaternion, q2 Quaternion) Quaternion {
	mut result := Quaternion {}
	
	qax := q1.x
qay := q1.y
qaz := q1.z
qaw := q1.w

	qbx := q2.x
qby := q2.y
qbz := q2.z
qbw := q2.w

	result.x = qax * qbw + qaw * qbx + qay * qbz - qaz * qby
	result.y = qay * qbw + qaw * qby + qaz * qbx - qax * qbz
	result.z = qaz * qbw + qaw * qbz + qax * qby - qay * qbx
	result.w = qaw * qbw - qax * qbx - qay * qby - qaz * qbz
	return result
}


pub fn quaternionscale(q Quaternion, mul f32) Quaternion {
	mut result := Quaternion {}
	
	result.x = q.x * mul
	result.y = q.y * mul
	result.z = q.z * mul
	result.w = q.w * mul
	return result
}


pub fn quaterniondivide(q1 Quaternion, q2 Quaternion) Quaternion {
	result := Quaternion {
	q1.x / q2.x, q1.y / q2.y, q1.z / q2.z, q1.w / q2.w}
	
	return result
}


pub fn quaternionlerp(q1 Quaternion, q2 Quaternion, amount f32) Quaternion {
	mut result := Quaternion {}
	
	result.x = q1.x + amount * (q2.x - q1.x)
	result.y = q1.y + amount * (q2.y - q1.y)
	result.z = q1.z + amount * (q2.z - q1.z)
	result.w = q1.w + amount * (q2.w - q1.w)
	return result
}


pub fn quaternionnlerp(q1 Quaternion, q2 Quaternion, amount f32) Quaternion {
	mut result := Quaternion {}
	
	result.x = q1.x + amount * (q2.x - q1.x)
	result.y = q1.y + amount * (q2.y - q1.y)
	result.z = q1.z + amount * (q2.z - q1.z)
	result.w = q1.w + amount * (q2.w - q1.w)
	q := result
	mut length := math.sqrtf(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
	if length == 0 {
	length = 1
	}
	ilength := 1 / length
	result.x = q.x * ilength
	result.y = q.y * ilength
	result.z = q.z * ilength
	result.w = q.w * ilength
	return result
}


pub fn quaternionslerp(q1 Quaternion, q22 Quaternion, amount f32) Quaternion {
	mut q2 := q22
	mut result := Quaternion {}
	
	mut coshalftheta := q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w
	if coshalftheta < 0 {
		q2.x = -q2.x
		q2.y = -q2.y
		q2.z = -q2.z
		q2.w = -q2.w
		coshalftheta = -coshalftheta
	}
	if math.abs(coshalftheta) >= 1 {
	result = q1
	}
	else if coshalftheta > 0.949999988 {
	result = quaternionnlerp(q1, q2, amount)
	}
	else {
		halftheta := f32(math.acos(coshalftheta))
		sinhalftheta := math.sqrtf(1 - coshalftheta * coshalftheta)
		if math.abs(sinhalftheta) < 0.00100000005 {
			result.x = (q1.x * 0.5 + q2.x * 0.5)
			result.y = (q1.y * 0.5 + q2.y * 0.5)
			result.z = (q1.z * 0.5 + q2.z * 0.5)
			result.w = (q1.w * 0.5 + q2.w * 0.5)
		}
		else {
			ratioa := math.sinf((1 - amount) * halftheta) / sinhalftheta
			ratiob := math.sinf(amount * halftheta) / sinhalftheta
			result.x = (q1.x * ratioa + q2.x * ratiob)
			result.y = (q1.y * ratioa + q2.y * ratiob)
			result.z = (q1.z * ratioa + q2.z * ratiob)
			result.w = (q1.w * ratioa + q2.w * ratiob)
		}
	}
	return result
}


pub fn quaternionfromvector3tovector3(from Vector3, to Vector3) Quaternion {
	mut result := Quaternion {}
	
	cos2theta := (from.x * to.x + from.y * to.y + from.z * to.z)
	cross := Vector3 {
	from.y * to.z - from.z * to.y, from.z * to.x - from.x * to.z, from.x * to.y - from.y * to.x}
	
	result.x = cross.x
	result.y = cross.y
	result.z = cross.z
	result.w = 1 + cos2theta
	q := result
	mut length := math.sqrtf(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
	if length == 0 {
	length = 1
	}
	ilength := 1 / length
	result.x = q.x * ilength
	result.y = q.y * ilength
	result.z = q.z * ilength
	result.w = q.w * ilength
	return result
}


pub fn quaternionfrommatrix(mat Matrix) Quaternion {
	mut result := Quaternion {}
	
	fourwsquaredminus1 := mat.m0 + mat.m5 + mat.m10
	fourxsquaredminus1 := mat.m0 - mat.m5 - mat.m10
	fourysquaredminus1 := mat.m5 - mat.m0 - mat.m10
	fourzsquaredminus1 := mat.m10 - mat.m0 - mat.m5
	mut biggestindex := 0
	mut fourbiggestsquaredminus1 := fourwsquaredminus1
	if fourxsquaredminus1 > fourbiggestsquaredminus1 {
		fourbiggestsquaredminus1 = fourxsquaredminus1
		biggestindex = 1
	}
	if fourysquaredminus1 > fourbiggestsquaredminus1 {
		fourbiggestsquaredminus1 = fourysquaredminus1
		biggestindex = 2
	}
	if fourzsquaredminus1 > fourbiggestsquaredminus1 {
		fourbiggestsquaredminus1 = fourzsquaredminus1
		biggestindex = 3
	}
	biggestval := math.sqrtf(fourbiggestsquaredminus1 + 1) * 0.5
	mult := 0.25 / biggestval
	match biggestindex {
	 0{ // case comp body kind=BinaryOperator is_enum=false
	result.w = biggestval
	result.x = (mat.m6 - mat.m9) * mult
	result.y = (mat.m8 - mat.m2) * mult
	result.z = (mat.m1 - mat.m4) * mult
	
	}
	 1{ // case comp body kind=BinaryOperator is_enum=false
	result.x = biggestval
	result.w = (mat.m6 - mat.m9) * mult
	result.y = (mat.m1 + mat.m4) * mult
	result.z = (mat.m8 + mat.m2) * mult
	
	}
	 2{ // case comp body kind=BinaryOperator is_enum=false
	result.y = biggestval
	result.w = (mat.m8 - mat.m2) * mult
	result.x = (mat.m1 + mat.m4) * mult
	result.z = (mat.m6 + mat.m9) * mult
	
	}
	 3{ // case comp body kind=BinaryOperator is_enum=false
	result.z = biggestval
	result.w = (mat.m1 - mat.m4) * mult
	result.x = (mat.m8 + mat.m2) * mult
	result.y = (mat.m6 + mat.m9) * mult
	
	}
	else{}
	}
	return result
}


pub fn quaterniontomatrix(q Quaternion) Matrix {
	mut result := Matrix {
	1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
	
	a2 := q.x * q.x
	b2 := q.y * q.y
	c2 := q.z * q.z
	ac := q.x * q.z
	ab := q.x * q.y
	bc := q.y * q.z
	ad := q.w * q.x
	bd := q.w * q.y
	cd := q.w * q.z
	result.m0 = 1 - 2 * (b2 + c2)
	result.m1 = 2 * (ab + cd)
	result.m2 = 2 * (ac - bd)
	result.m4 = 2 * (ab - cd)
	result.m5 = 1 - 2 * (a2 + c2)
	result.m6 = 2 * (bc + ad)
	result.m8 = 2 * (ac + bd)
	result.m9 = 2 * (bc - ad)
	result.m10 = 1 - 2 * (a2 + b2)
	return result
}


pub fn quaternionfromaxisangle(axiss Vector3, anglee f32) Quaternion {
	mut angle := anglee
	mut axis := axiss
	mut result := Quaternion {
	0, 0, 0, 1}
	
	axislength := math.sqrtf(axis.x * axis.x + axis.y * axis.y + axis.z * axis.z)
	if axislength != 0 {
		angle *= 0.5
		mut length := f32(0)
		mut ilength := f32(0)
		v := axis
		length = math.sqrtf(v.x * v.x + v.y * v.y + v.z * v.z)
		if length == 0 {
		length = 1
		}
		ilength = 1 / length
		axis.x *= ilength
		axis.y *= ilength
		axis.z *= ilength
		sinres := math.sinf(angle)
		cosres := math.cosf(angle)
		result.x = axis.x * sinres
		result.y = axis.y * sinres
		result.z = axis.z * sinres
		result.w = cosres
		q := result
		length = math.sqrtf(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
		if length == 0 {
		length = 1
		}
		ilength = 1 / length
		result.x = q.x * ilength
		result.y = q.y * ilength
		result.z = q.z * ilength
		result.w = q.w * ilength
	}
	return result
}


pub fn quaterniontoaxisangle(qq Quaternion) (Vector3, f32){
	mut q := qq
	if math.abs(q.w) > 1 {
		mut length := math.sqrtf(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
		if length == 0 {
		length = 1
		}
		ilength := 1 / length
		q.x = q.x * ilength
		q.y = q.y * ilength
		q.z = q.z * ilength
		q.w = q.w * ilength
	}
	mut resaxis := Vector3 {
	0, 0, 0}
	
	resangle := 2 * f32(math.acos(q.w))
	den := math.sqrtf(1 - q.w * q.w)
	if den > 9.99999974E-5 {
		resaxis.x = q.x / den
		resaxis.y = q.y / den
		resaxis.z = q.z / den
	}
	else {
		resaxis.x = 1
	}
	return resaxis, resangle
}


pub fn quaternionfromeuler(pitch f32, yaw f32, roll f32) Quaternion {
	mut result := Quaternion {}
	
	x0 := math.cosf(pitch * 0.5)
	x1 := math.sinf(pitch * 0.5)
	y0 := math.cosf(yaw * 0.5)
	y1 := math.sinf(yaw * 0.5)
	z0 := math.cosf(roll * 0.5)
	z1 := math.sinf(roll * 0.5)
	result.x = x1 * y0 * z0 - x0 * y1 * z1
	result.y = x0 * y1 * z0 + x1 * y0 * z1
	result.z = x0 * y0 * z1 - x1 * y1 * z0
	result.w = x0 * y0 * z0 + x1 * y1 * z1
	return result
}


pub fn quaterniontoeuler(q Quaternion) Vector3 {
	mut result := Vector3 {}
	
	x0 := 2 * (q.w * q.x + q.y * q.z)
	x1 := 1 - 2 * (q.x * q.x + q.y * q.y)
	result.x = f32(math.atan2(x0, x1))
	mut y0 := 2 * (q.w * q.y - q.z * q.x)
	y0 = if y0 > 1{ 1 } else {y0}
	y0 = if y0 < -1{ -1 } else {y0}
	result.y = f32(math.asin(y0))
	z0 := 2 * (q.w * q.z + q.x * q.y)
	z1 := 1 - 2 * (q.y * q.y + q.z * q.z)
	result.z = f32(math.atan2(z0, z1))
	return result
}


pub fn quaterniontransform(q Quaternion, mat Matrix) Quaternion {
	mut result := Quaternion {}
	
	result.x = mat.m0 * q.x + mat.m4 * q.y + mat.m8 * q.z + mat.m12 * q.w
	result.y = mat.m1 * q.x + mat.m5 * q.y + mat.m9 * q.z + mat.m13 * q.w
	result.z = mat.m2 * q.x + mat.m6 * q.y + mat.m10 * q.z + mat.m14 * q.w
	result.w = mat.m3 * q.x + mat.m7 * q.y + mat.m11 * q.z + mat.m15 * q.w
	return result
}


pub fn quaternionequals(p Quaternion, q Quaternion) bool {
	mut result := (((math.abs(p.x - q.x)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.x), math.abs(q.x))))) && ((math.abs(p.y - q.y)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.y), math.abs(q.y))))) && ((math.abs(p.z - q.z)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.z), math.abs(q.z))))) && ((math.abs(p.w - q.w)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.w), math.abs(q.w)))))) || (((math.abs(p.x + q.x)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.x), math.abs(q.x))))) && ((math.abs(p.y + q.y)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.y), math.abs(q.y))))) && ((math.abs(p.z + q.z)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.z), math.abs(q.z))))) && ((math.abs(p.w + q.w)) <= (9.99999997E-7 * math.max(1.0, math.max(math.abs(p.w), math.abs(q.w))))))
	return result
}

