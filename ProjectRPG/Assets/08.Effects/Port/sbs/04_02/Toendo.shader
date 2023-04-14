// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port/SBS/04_02/Tonedo"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Main_US("Main_US", Float) = -1
		_Main_VS("Main_VS", Float) = 0
		_Noise_Val("Noise_Val", Range( 0 , 1)) = 0.4235294
		_Color_A("Color_A", Color) = (0.2216981,0.339202,1,0)
		_High_Range("High_Range", Range( 0.1 , 0.5)) = 0.1
		_High_Str("High_Str", Range( 1 , 10)) = 7.611764
		_t("t", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Vertex_Normal_Tex("Vertex_Normal_Tex", 2D) = "white" {}
		_Vertex_Noraml("Vertex_Noraml", Range( 0 , 5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		AlphaToMask On
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Vertex_Normal_Tex;
		uniform float _Main_US;
		uniform float _Main_VS;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Vertex_Noraml;
		uniform float4 _Color_A;
		uniform float _Noise_Val;
		uniform float _High_Range;
		uniform float _t;
		uniform float _High_Str;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 appendResult11 = (float2(_Main_US , _Main_VS));
			float2 uv0_TextureSample0 = v.texcoord.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 appendResult6 = (float2(uv0_TextureSample0.x , ( uv0_TextureSample0.x + ( uv0_TextureSample0.y * -2.0 ) )));
			float2 panner4 = ( 1.0 * _Time.y * appendResult11 + appendResult6);
			float2 temp_output_2_0 = (panner4*float2( 1,1 ) + 0.0);
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( tex2Dlod( _Vertex_Normal_Tex, float4( temp_output_2_0, 0, 0.0) ).r * _Vertex_Noraml ) * ase_vertexNormal );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color21 = IsGammaSpace() ? float4(0.4575472,0.8028962,1,1) : float4(0.1768298,0.608748,1,1);
			float2 appendResult11 = (float2(_Main_US , _Main_VS));
			float2 uv0_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 appendResult6 = (float2(uv0_TextureSample0.x , ( uv0_TextureSample0.x + ( uv0_TextureSample0.y * -2.0 ) )));
			float2 panner4 = ( 1.0 * _Time.y * appendResult11 + appendResult6);
			float2 temp_output_2_0 = (panner4*float2( 1,1 ) + 0.0);
			float4 tex2DNode1 = tex2D( _TextureSample0, temp_output_2_0 );
			float4 lerpResult19 = lerp( _Color_A , color21 , step( 0.0 , ( tex2DNode1.r - _Noise_Val ) ));
			o.Emission = ( lerpResult19 + ( step( _High_Range , pow( ( tex2DNode1.r - _t ) , 2.5 ) ) * _High_Str ) ).rgb;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 tex2DNode31 = tex2D( _TextureSample1, uv_TextureSample1 );
			o.Alpha = tex2DNode31.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
22;257;1738;1013;1749.389;234.0301;2.295306;True;True
Node;AmplifyShaderEditor.RangedFloatNode;10;-1816,340.5;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1816,41.5;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1624,271.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1480,157.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1472,410.5;Float;False;Property;_Main_VS;Main_VS;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1469,324.5;Float;False;Property;_Main_US;Main_US;2;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-1333,42.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-1334,321.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;4;-1155,85.5;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;5;-1126,202.5;Float;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;2;-937,133.5;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-447,505.5;Float;False;Property;_t;t;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-673,75.5;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;0b779106d9cbca54e93beb7d3e190e97;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-269,458.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-603,296.5;Float;False;Property;_Noise_Val;Noise_Val;4;0;Create;True;0;0;False;0;0.4235294;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-327,599.5;Float;True;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;2.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;23;-106,451.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-6,364.5;Float;False;Property;_High_Range;High_Range;6;0;Create;True;0;0;False;0;0.1;0;0.1;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;15;-351,138.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;286.1426,935.5832;Float;False;Property;_Vertex_Noraml;Vertex_Noraml;11;0;Create;True;0;0;False;0;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;243.0734,713.889;Float;True;Property;_Vertex_Normal_Tex;Vertex_Normal_Tex;10;0;Create;True;0;0;False;0;0b779106d9cbca54e93beb7d3e190e97;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;197,232.5;Float;False;Property;_High_Str;High_Str;7;0;Create;True;0;0;False;0;7.611764;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;17;-190,122.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;-163,-257.5;Float;False;Property;_Color_A;Color_A;5;0;Create;True;0;0;False;0;0.2216981,0.339202,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;-164,-74.5;Float;False;Constant;_Color_B;Color_B;5;0;Create;True;0;0;False;0;0.4575472,0.8028962,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;25;238,426.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;19;60,-30.5;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;458,267.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;44;574.4332,970.6885;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;599.9642,752.6092;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-562.8502,712.7548;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;31;-959.8501,646.7548;Float;True;Property;_TextureSample1;Texture Sample 1;9;0;Create;True;0;0;False;0;399a63db38ef73a47bba5cf4295a4640;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-907.8501,966.7544;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1028.85,964.7544;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;35;-1153.851,849.7548;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-1374.851,899.7547;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;29;476,-0.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;38;-701.8502,967.7544;Float;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;802.7,804.8453;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;838,6;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port/SBS/04_02/Tonedo;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;3;2
WireConnection;9;1;10;0
WireConnection;8;0;3;1
WireConnection;8;1;9;0
WireConnection;6;0;3;1
WireConnection;6;1;8;0
WireConnection;11;0;12;0
WireConnection;11;1;13;0
WireConnection;4;0;6;0
WireConnection;4;2;11;0
WireConnection;2;0;4;0
WireConnection;2;1;5;0
WireConnection;1;1;2;0
WireConnection;22;0;1;1
WireConnection;22;1;30;0
WireConnection;23;0;22;0
WireConnection;23;1;24;0
WireConnection;15;0;1;1
WireConnection;15;1;16;0
WireConnection;40;1;2;0
WireConnection;17;1;15;0
WireConnection;25;0;26;0
WireConnection;25;1;23;0
WireConnection;19;0;20;0
WireConnection;19;1;21;0
WireConnection;19;2;17;0
WireConnection;27;0;25;0
WireConnection;27;1;28;0
WireConnection;41;0;40;1
WireConnection;41;1;42;0
WireConnection;39;0;31;1
WireConnection;39;1;38;0
WireConnection;37;0;36;0
WireConnection;36;0;35;0
WireConnection;36;1;34;2
WireConnection;35;0;34;2
WireConnection;29;0;19;0
WireConnection;29;1;27;0
WireConnection;38;0;37;0
WireConnection;43;0;41;0
WireConnection;43;1;44;0
WireConnection;0;2;29;0
WireConnection;0;9;31;1
WireConnection;0;11;43;0
ASEEND*/
//CHKSM=066B6C1A58B32CA8D02557853BC18AC75FEA05EF