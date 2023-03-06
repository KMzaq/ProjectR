// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Dissolve("Dissolve", Range( -1 , 0)) = 0
		_TX_Smoke("TX_Smoke", 2D) = "white" {}
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Depth_Dis("Depth_Dis", Range( 0 , 10)) = 0
		_Opa_Pow("Opa_Pow", Float) = 10
		[Toggle(_DISSOLVE_PREVIEW_ON)] _Dissolve_Preview("Dissolve_Preview", Float) = 1
		[Toggle(_KEYWORD0_ON)] _Keyword0("Keyword 0", Float) = 0
		_ColorA("ColorA", Color) = (1,1,1,1)
		[HDR]_Edge_Color("Edge_Color", Color) = (0.05335903,0,1,1)
		_Glow_Dissolve("Glow_Dissolve", Range( -1 , -0.1)) = -0.76
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _KEYWORD0_ON
		#pragma shader_feature _DISSOLVE_PREVIEW_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
			float4 screenPos;
		};

		uniform float4 _ColorA;
		uniform float4 _Edge_Color;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Glow_Dissolve;
		uniform sampler2D _TX_Smoke;
		uniform float4 _TX_Smoke_ST;
		uniform float _Main_Pow;
		uniform float4 _Main_Color;
		uniform float _Main_Str;
		uniform float _Opa_Pow;
		uniform float _Dissolve;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth_Dis;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			#ifdef _KEYWORD0_ON
				float staticSwitch38 = _Glow_Dissolve;
			#else
				float staticSwitch38 = i.uv_tex4coord.w;
			#endif
			float2 uv0_TX_Smoke = i.uv_texcoord * _TX_Smoke_ST.xy + _TX_Smoke_ST.zw;
			float4 tex2DNode10 = tex2D( _TX_Smoke, uv0_TX_Smoke );
			float temp_output_2_0 = pow( tex2DNode10.r , _Main_Pow );
			float4 lerpResult26 = lerp( _ColorA , ( _Edge_Color * ( saturate( ( tex2D( _TextureSample0, uv_TextureSample0 ).r + staticSwitch38 ) ) * temp_output_2_0 ) ) , tex2DNode10.r);
			o.Emission = ( lerpResult26 * i.vertexColor ).rgb;
			#ifdef _DISSOLVE_PREVIEW_ON
				float staticSwitch23 = _Dissolve;
			#else
				float staticSwitch23 = i.uv_tex4coord.z;
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth16 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth16 = abs( ( screenDepth16 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Depth_Dis ) );
			o.Alpha = ( ( i.vertexColor * ( _Main_Color * ( temp_output_2_0 * _Main_Str ) ) ) * ( saturate( ( pow( tex2DNode10.r , _Opa_Pow ) + staticSwitch23 ) ) * saturate( distanceDepth16 ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
139;54;1738;1007;2393.919;464.64;1.103435;True;True
Node;AmplifyShaderEditor.RangedFloatNode;31;-2299.026,-53.05875;Float;False;Property;_Glow_Dissolve;Glow_Dissolve;12;0;Create;True;0;0;False;0;-0.76;-0.76;-1;-0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;37;-2279.237,97.78377;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;38;-2046.413,32.68091;Float;False;Property;_Keyword0;Keyword 0;9;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-1948.132,-341.0554;Float;True;Property;_TextureSample0;Texture Sample 0;13;0;Create;True;0;0;False;0;3d98925812a24fa43bb5560dbf559217;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-2063.411,169.5759;Float;False;0;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-1158.075,302.2471;Float;False;Property;_Opa_Pow;Opa_Pow;7;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;24;-1256.28,541.6925;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-1322.266,420.1954;Float;False;Property;_Dissolve;Dissolve;1;0;Create;True;0;0;False;0;0;0;-1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1403.413,61.58681;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1807.032,133.4837;Float;True;Property;_TX_Smoke;TX_Smoke;2;0;Create;True;0;0;False;0;e3a654fb099a6964c97882f5f0da3e8f;e3a654fb099a6964c97882f5f0da3e8f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1664.549,-102.7135;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;42;-1536.551,-193.195;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-641.1105,50.03529;Float;False;Property;_Main_Str;Main_Str;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;21;-1468.14,197.4208;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-1198.565,107.3883;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;23;-1008.008,468.8656;Float;False;Property;_Dissolve_Preview;Dissolve_Preview;8;0;Create;True;0;0;False;0;0;1;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-776.2867,656.4496;Float;False;Property;_Depth_Dis;Depth_Dis;6;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1365.519,-170.023;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;-1481.381,-433.7437;Float;False;Property;_Edge_Color;Edge_Color;11;1;[HDR];Create;True;0;0;False;0;0.05335903,0,1,1;0.05335903,0,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-693.8815,351.0466;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;16;-597.2343,651.6812;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-416.7324,-98.03302;Float;False;Property;_Main_Color;Main_Color;5;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-456.0801,128.1776;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;14;-213.7324,-78.03302;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;15;-469.7324,354.967;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-318.6454,146.7005;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;17;-356.9817,626.6569;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;27;-1292.694,-453.6054;Float;False;Property;_ColorA;ColorA;10;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1208.834,-247.2633;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-402.2224,469.9692;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-190.8017,146.7005;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;26;-994.767,-311.2625;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-264.3772,305.4321;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-443.0488,-302.4351;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;74,-18;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;1;37;4
WireConnection;38;0;31;0
WireConnection;10;1;7;0
WireConnection;40;0;39;1
WireConnection;40;1;38;0
WireConnection;42;0;40;0
WireConnection;21;0;10;1
WireConnection;21;1;22;0
WireConnection;2;0;10;1
WireConnection;2;1;11;0
WireConnection;23;1;24;3
WireConnection;23;0;9;0
WireConnection;41;0;42;0
WireConnection;41;1;2;0
WireConnection;8;0;21;0
WireConnection;8;1;23;0
WireConnection;16;0;19;0
WireConnection;3;0;2;0
WireConnection;3;1;12;0
WireConnection;15;0;8;0
WireConnection;4;0;13;0
WireConnection;4;1;3;0
WireConnection;17;0;16;0
WireConnection;29;0;28;0
WireConnection;29;1;41;0
WireConnection;18;0;15;0
WireConnection;18;1;17;0
WireConnection;5;0;14;0
WireConnection;5;1;4;0
WireConnection;26;0;27;0
WireConnection;26;1;29;0
WireConnection;26;2;10;1
WireConnection;6;0;5;0
WireConnection;6;1;18;0
WireConnection;32;0;26;0
WireConnection;32;1;14;0
WireConnection;0;2;32;0
WireConnection;0;9;6;0
ASEEND*/
//CHKSM=BA6F5C09D3F7D07D1784991520ED942F7F03F85C