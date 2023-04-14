// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_SBS_03_19"
{
	Properties
	{
		_Grab_Tex("Grab_Tex", 2D) = "white" {}
		_Grab_Str("Grab_Str", Range( 0 , 1)) = 0.1647059
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _GrabTexture;
		uniform sampler2D _Grab_Tex;
		uniform float4 _Grab_Tex_ST;
		uniform float _Grab_Str;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 uv0_Grab_Tex = i.uv_texcoord * _Grab_Tex_ST.xy + _Grab_Tex_ST.zw;
			float4 screenColor1 = tex2D( _GrabTexture, ( ase_grabScreenPosNorm + float4( ( (tex2D( _Grab_Tex, uv0_Grab_Tex )).rg * _Grab_Str ), 0.0 , 0.0 ) ).xy );
			o.Emission = ( screenColor1 * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-216;900;1738;1073;1261;-154.5;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1470,316.5;Float;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-1235,304.5;Float;True;Property;_Grab_Tex;Grab_Tex;0;0;Create;True;0;0;False;0;d9eee021f8dce7441a6bce56c7e3feeb;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;6;-932,323.5;Float;False;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-889,502.5;Float;False;Property;_Grab_Str;Grab_Str;1;0;Create;True;0;0;False;0;0.1647059;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;2;-931,0.5;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-731,325.5;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-604,117.5;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenColorNode;1;-414,247.5;Float;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;9;-422,498.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-222,320.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2,234;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_SBS_03_19;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;1;8;0
WireConnection;6;0;4;0
WireConnection;5;0;6;0
WireConnection;5;1;7;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;1;0;3;0
WireConnection;10;0;1;0
WireConnection;10;1;9;0
WireConnection;0;2;10;0
WireConnection;0;9;9;4
ASEEND*/
//CHKSM=8A8C064F379CE1A622342C2D1617EBF44DA827AF