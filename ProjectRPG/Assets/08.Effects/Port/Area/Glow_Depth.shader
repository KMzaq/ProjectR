// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_T_Glow_01("T_Glow_01", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 2
		_Main_Str("Main_Str", Float) = 1
		_Depth_Dis("Depth_Dis", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 screenPosition13;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _T_Glow_01;
		uniform float4 _T_Glow_01_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth_Dis;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 vertexPos13 = ase_vertex3Pos;
			float4 ase_screenPos13 = ComputeScreenPos( UnityObjectToClipPos( vertexPos13 ) );
			o.screenPosition13 = ase_screenPos13;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_T_Glow_01 = i.uv_texcoord * _T_Glow_01_ST.xy + _T_Glow_01_ST.zw;
			float temp_output_4_0 = ( pow( tex2D( _T_Glow_01, uv_T_Glow_01 ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_4_0 ) ).rgb;
			float4 ase_screenPos13 = i.screenPosition13;
			float4 ase_screenPosNorm13 = ase_screenPos13 / ase_screenPos13.w;
			ase_screenPosNorm13.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm13.z : ase_screenPosNorm13.z * 0.5 + 0.5;
			float screenDepth13 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos13 ))));
			float distanceDepth13 = abs( ( screenDepth13 - LinearEyeDepth( ase_screenPosNorm13.z ) ) / ( _Depth_Dis ) );
			o.Alpha = ( ( temp_output_4_0 * i.vertexColor.a ) * saturate( distanceDepth13 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
143;671;1586;768;963.396;-211.5948;1;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-948.7404,150.0025;Float;True;Property;_T_Glow_01;T_Glow_01;1;0;Create;True;0;0;False;0;ad38897841e4e5840810813ce35141cc;ad38897841e4e5840810813ce35141cc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-713.3962,392.0948;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;3;-640.6556,150.0266;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-539.3962,382.0948;Float;False;Property;_Main_Str;Main_Str;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-573.396,534.5948;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-406.396,663.5948;Float;False;Property;_Depth_Dis;Depth_Dis;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-508.3962,148.0948;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-506.3962,-85.90524;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;8;-266.3962,-124.9052;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;13;-358.396,515.5948;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-373.3962,149.0948;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-267.3962,370.0948;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;16;-119.396,467.5948;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-237.3962,165.0948;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-89.396,348.5948;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;1
WireConnection;3;1;10;0
WireConnection;4;0;3;0
WireConnection;4;1;11;0
WireConnection;13;1;14;0
WireConnection;13;0;15;0
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;12;0;4;0
WireConnection;12;1;8;4
WireConnection;16;0;13;0
WireConnection;6;0;8;0
WireConnection;6;1;5;0
WireConnection;17;0;12;0
WireConnection;17;1;16;0
WireConnection;0;2;6;0
WireConnection;0;9;17;0
ASEEND*/
//CHKSM=48334EF66EA656E3C51788D2C585E3B91680FEEC