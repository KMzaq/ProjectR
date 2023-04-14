// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_Shot_ShotCharge_GlowBackgorund"
{
	Properties
	{
		_T_Glow_01("T_Glow_01", 2D) = "white" {}
		[HDR]_Color("Color", Color) = (1,1,1,1)
		_Pow("Pow", Float) = 1
		_Str("Str", Float) = 1
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
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Color;
		uniform sampler2D _T_Glow_01;
		uniform float4 _T_Glow_01_ST;
		uniform float _Pow;
		uniform float _Str;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_T_Glow_01 = i.uv_texcoord * _T_Glow_01_ST.xy + _T_Glow_01_ST.zw;
			float4 temp_output_3_0 = ( _Color * ( pow( tex2D( _T_Glow_01, uv_T_Glow_01 ).r , _Pow ) * _Str ) );
			o.Emission = ( i.vertexColor * temp_output_3_0 ).rgb;
			float4 temp_output_6_0 = ( i.vertexColor.a * temp_output_3_0 );
			o.Alpha = temp_output_6_0.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
6;1024;1586;801;1095.075;112.0618;1;True;True
Node;AmplifyShaderEditor.SamplerNode;1;-1061.7,109.1;Float;True;Property;_T_Glow_01;T_Glow_01;1;0;Create;True;0;0;False;0;ad38897841e4e5840810813ce35141cc;ad38897841e4e5840810813ce35141cc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-827.0752,290.9382;Float;False;Property;_Pow;Pow;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-773.0752,144.9382;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-635.0752,304.9382;Float;False;Property;_Str;Str;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-530.8177,-87.40087;Float;False;Property;_Color;Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-613.0752,158.9382;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;4;-249.2179,-58.60084;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-462.0178,154.1992;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-271.8179,249.9991;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-162.8179,154.1992;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;7;-152.6068,388.3284;Float;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;139.2,-3.2;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_Shot_ShotCharge_GlowBackgorund;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;1;1
WireConnection;9;1;11;0
WireConnection;10;0;9;0
WireConnection;10;1;12;0
WireConnection;3;0;2;0
WireConnection;3;1;10;0
WireConnection;6;0;4;4
WireConnection;6;1;3;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;7;1;6;0
WireConnection;0;2;5;0
WireConnection;0;9;6;0
ASEEND*/
//CHKSM=A338E20AADD658A148A4EBE62E51935B71D1AFF1