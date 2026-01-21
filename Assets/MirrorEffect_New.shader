Shader "Fx/MirrorEffect_Test_Kouzou"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MirrorDirection ("Mirror Direction", int) = 0
    }
    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            int _MirrorDirection;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                uv.x = ((!_MirrorDirection) ? 1 - i.uv.x : uv.x);
                uv.y = ((_MirrorDirection) ? 1 - i.uv.y : uv.y);
                return tex2D(_MainTex, uv);
            }
            ENDCG
        }
    }
}