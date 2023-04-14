// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_02/Crack_Exp/CrackExp_Glow"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 2
		_Main_Str("Main_Str", Float) = 1
		_Depth_Dis("Depth_Dis", Float) = 0
		_Tile_Tex("Tile_Tex", 2D) = "white" {}
		_Tile_US("Tile_US", Float) = 0
		_Tile_VS("Tile_VS", Float) = 0
		[Toggle(_USE_TILETEX_ON)] _Use_TileTex("Use_TileTex", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One , SrcAlpha One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_TILETEX_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 screenPosition13;
		};

		uniform sampler2D _Main_Tex;
		uniform float4 _Main_Tex_ST;
		uniform sampler2D _Tile_Tex;
		uniform float _Tile_US;
		uniform float _Tile_VS;
		uniform float4 _Tile_Tex_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform float4 _Main_Color;
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
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float4 tex2DNode1 = tex2D( _Main_Tex, uv0_Main_Tex );
			float2 appendResult21 = (float2(_Tile_US , _Tile_VS));
			float2 uv0_Tile_Tex = i.uv_texcoord * _Tile_Tex_ST.xy + _Tile_Tex_ST.zw;
			float2 panner20 = ( 1.0 * _Time.y * appendResult21 + uv0_Tile_Tex);
			#ifdef _USE_TILETEX_ON
				float staticSwitch27 = ( ( tex2D( _Tile_Tex, panner20 ).r * tex2DNode1.r ) + tex2DNode1.r );
			#else
				float staticSwitch27 = tex2DNode1.r;
			#endif
			float temp_output_3_0 = ( pow( staticSwitch27 , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( temp_output_3_0 * _Main_Color ) ).rgb;
			float4 ase_screenPos13 = i.screenPosition13;
			float4 ase_screenPosNorm13 = ase_screenPos13 / ase_screenPos13.w;
			ase_screenPosNorm13.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm13.z : ase_screenPosNorm13.z * 0.5 + 0.5;
			float screenDepth13 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos13 ))));
			float distanceDepth13 = abs( ( screenDepth13 - LinearEyeDepth( ase_screenPosNorm13.z ) ) / ( _Depth_Dis ) );
			o.Alpha = ( i.vertexColor.a * ( temp_output_3_0 * saturate( distanceDepth13 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-49;1013;1586;762;1930.935;523.2748;1.29;True;True
Node;AmplifyShaderEditor.RangedFloatNode;22;-1796,-37.39;Float;False;Property;_Tile_US;Tile_US;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1796,58.60999;Float;False;Property;_Tile_VS;Tile_VS;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1684,-37.39;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1892,-197.39;Float;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;20;-1508,-213.39;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1344.585,114.195;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1331.3,-231.3699;Float;True;Property;_Tile_Tex;Tile_Tex;6;0;Create;True;0;0;False;0;8e84dbcdc4fb83e4583958f01ce815d7;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1056.76,111.77;Float;True;Property;_Main_Tex;Main_Tex;1;0;Create;True;0;0;False;0;aa25b8e437a72ef40a99bf49ab685da2;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1015.035,-194.3249;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-793.155,-78.2248;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;27;-606.415,-34.74489;Float;False;Property;_Use_TileTex;Use_TileTex;9;0;Create;True;0;0;False;0;0;1;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-526.6251,641.8;Float;False;Property;_Depth_Dis;Depth_Dis;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-604.6249,460.8;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-636,325;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-472,335;Float;False;Property;_Main_Str;Main_Str;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;13;-403.625,497.8;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-557,138;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-446,-66;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;15;-147.625,483.8;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-402,140;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-251,137;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-178,334;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;6;-184,-84;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-61,292;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-48,151;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;95,-12;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_02/Crack_Exp/CrackExp_Glow;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;8;5;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;22;0
WireConnection;21;1;23;0
WireConnection;20;0;19;0
WireConnection;20;2;21;0
WireConnection;18;1;20;0
WireConnection;1;1;12;0
WireConnection;29;0;18;1
WireConnection;29;1;1;1
WireConnection;30;0;29;0
WireConnection;30;1;1;1
WireConnection;27;1;1;1
WireConnection;27;0;30;0
WireConnection;13;1;14;0
WireConnection;13;0;17;0
WireConnection;2;0;27;0
WireConnection;2;1;10;0
WireConnection;15;0;13;0
WireConnection;3;0;2;0
WireConnection;3;1;11;0
WireConnection;7;0;3;0
WireConnection;7;1;5;0
WireConnection;16;0;3;0
WireConnection;16;1;15;0
WireConnection;9;0;6;4
WireConnection;9;1;16;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;0;2;8;0
WireConnection;0;9;9;0
ASEEND*/
//CHKSM=1B70DA3CE6D20945CA30E1EF68A6AFFE137900D6