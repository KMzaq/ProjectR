// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port/SBS/03_26/ToonExp"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Ramp_Tex("Ramp_Tex", 2D) = "white" {}
		_Light_Dir("Light_Dir", Vector) = (0.23,-5,1.02,0)
		_Shadow_Range("Shadow_Range", Float) = 0
		_Normal_Tex("Normal_Tex", 2D) = "white" {}
		_Normal_Scale("Normal_Scale", Range( 0 , 1)) = 0.8772092
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Ramp_Str("Ramp_Str", Float) = 1
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Depth_Str("Depth_Str", Range( 0 , 5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldNormal;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 screenPosition45;
			float4 uv_tex4coord;
		};

		uniform sampler2D _Ramp_Tex;
		uniform float3 _Light_Dir;
		uniform float _Shadow_Range;
		uniform float _Normal_Scale;
		uniform sampler2D _Normal_Tex;
		uniform float _Ramp_Str;
		uniform float4 _Main_Color;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth_Str;
		uniform sampler2D _Dissolve_Tex;
		uniform float4 _Dissolve_Tex_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 vertexPos45 = ase_vertex3Pos;
			float4 ase_screenPos45 = ComputeScreenPos( UnityObjectToClipPos( vertexPos45 ) );
			o.screenPosition45 = ase_screenPos45;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 clampResult6 = clamp( _Light_Dir , float3( -10,-10,-10 ) , float3( 10,10,10 ) );
			float dotResult4 = dot( ase_vertexNormal , clampResult6 );
			float3 temp_cast_0 = (saturate( ( ( 1.0 - dotResult4 ) + _Shadow_Range ) )).xxx;
			float2 panner19 = ( 1.0 * _Time.y * float3(0.2,0.2,0).xy + i.uv_texcoord);
			float3 lerpResult24 = lerp( float3(0,0,1) , UnpackScaleNormal( tex2D( _Normal_Tex, panner19 ), _Normal_Scale ) , pow( ( ( i.uv_texcoord.y * ( 1.0 - i.uv_texcoord.y ) ) * 4.0 ) , 5.0 ));
			float dotResult26 = dot( temp_cast_0 , lerpResult24 );
			float2 temp_cast_2 = (dotResult26).xx;
			o.Emission = ( ( ( tex2D( _Ramp_Tex, temp_cast_2 ) * _Ramp_Str ) * _Main_Color ) * i.vertexColor ).rgb;
			float4 ase_screenPos45 = i.screenPosition45;
			float4 ase_screenPosNorm45 = ase_screenPos45 / ase_screenPos45.w;
			ase_screenPosNorm45.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm45.z : ase_screenPosNorm45.z * 0.5 + 0.5;
			float screenDepth45 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos45 ))));
			float distanceDepth45 = abs( ( screenDepth45 - LinearEyeDepth( ase_screenPosNorm45.z ) ) / ( _Depth_Str ) );
			o.Alpha = saturate( distanceDepth45 );
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float cos35 = cos( i.uv_tex4coord.w );
			float sin35 = sin( i.uv_tex4coord.w );
			float2 rotator35 = mul( uv0_Dissolve_Tex - float2( 0.5,0.5 ) , float2x2( cos35 , -sin35 , sin35 , cos35 )) + float2( 0.5,0.5 );
			clip( saturate( ( tex2D( _Dissolve_Tex, rotator35 ).r + i.uv_tex4coord.z ) ) - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
67;176;1738;704;1062.026;-402.8155;1.3;True;True
Node;AmplifyShaderEditor.Vector3Node;5;-1600,288.5;Float;False;Property;_Light_Dir;Light_Dir;2;0;Create;True;0;0;False;0;0.23,-5,1.02;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1697.149,995.0064;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;3;-1438,124.5;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;6;-1400,294.5;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;-10,-10,-10;False;2;FLOAT3;10,10,10;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;14;-1477.149,1103.006;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1484.149,882.0064;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;4;-1223,165.5;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;22;-1860.453,762.7052;Float;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;0.2,0.2,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1907.253,575.5053;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-997,422.5;Float;False;Property;_Shadow_Range;Shadow_Range;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1622.553,756.2051;Float;False;Property;_Normal_Scale;Normal_Scale;5;0;Create;True;0;0;False;0;0.8772092;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;19;-1582.253,623.6051;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1276.149,966.0064;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;7;-1008,164.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;-1082.149,969.0064;Float;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;25;-1031.052,519.6051;Float;False;Constant;_Vector1;Vector 1;6;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;17;-1283.253,678.2051;Float;True;Property;_Normal_Tex;Normal_Tex;4;0;Create;True;0;0;False;0;be16ed68839bead46a05797c841163f4;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-805,218.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;10;-596,216.5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;24;-810.0519,691.2053;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-1048.226,1243.529;Float;False;0;30;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;37;-1048.226,1365.529;Float;False;Constant;_Vector2;Vector 2;7;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexCoordVertexDataNode;33;-469.4756,1392.485;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;26;-533.9172,432.7752;Float;False;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-444,195.5;Float;True;Property;_Ramp_Tex;Ramp_Tex;1;0;Create;True;0;0;False;0;9ef13567a7c6a594599618d51b07b6b2;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;40;-378.226,648.5156;Float;False;Property;_Ramp_Str;Ramp_Str;7;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;35;-795.0059,1241.281;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;47;-279.4258,907.2155;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;42;-162.4257,651.1157;Float;False;Property;_Main_Color;Main_Color;8;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;30;-569.0587,1197.443;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;6;0;Create;True;0;0;False;0;a8cdb4639adce744d9e63580e11edf14;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-178.247,476.4378;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-196.2259,1061.916;Float;False;Property;_Depth_Str;Depth_Str;9;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-29.82571,502.9156;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-239.3328,1205.407;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;44;68.97424,670.6156;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;45;-32.42579,883.8154;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;34;-108.4756,1208.485;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;141.7743,509.4155;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;46;224.9743,894.2155;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;481.6775,572.7584;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port/SBS/03_26/ToonExp;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;0
WireConnection;14;0;12;2
WireConnection;13;0;12;2
WireConnection;13;1;14;0
WireConnection;4;0;3;0
WireConnection;4;1;6;0
WireConnection;19;0;20;0
WireConnection;19;2;22;0
WireConnection;15;0;13;0
WireConnection;7;0;4;0
WireConnection;16;0;15;0
WireConnection;17;1;19;0
WireConnection;17;5;18;0
WireConnection;8;0;7;0
WireConnection;8;1;9;0
WireConnection;10;0;8;0
WireConnection;24;0;25;0
WireConnection;24;1;17;0
WireConnection;24;2;16;0
WireConnection;26;0;10;0
WireConnection;26;1;24;0
WireConnection;1;1;26;0
WireConnection;35;0;36;0
WireConnection;35;1;37;0
WireConnection;35;2;33;4
WireConnection;30;1;35;0
WireConnection;39;0;1;0
WireConnection;39;1;40;0
WireConnection;41;0;39;0
WireConnection;41;1;42;0
WireConnection;31;0;30;1
WireConnection;31;1;33;3
WireConnection;45;1;47;0
WireConnection;45;0;48;0
WireConnection;34;0;31;0
WireConnection;43;0;41;0
WireConnection;43;1;44;0
WireConnection;46;0;45;0
WireConnection;0;2;43;0
WireConnection;0;9;46;0
WireConnection;0;10;34;0
ASEEND*/
//CHKSM=5F3631E89BBDF2C43794667820EFB3A064394B21