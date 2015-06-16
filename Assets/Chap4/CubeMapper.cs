using UnityEngine;
using System.Collections;

public class CubeMapper : MonoBehaviour {
	/*
	 * Creates a cubemap from a camera and feeds it to a material
	 */
	
	
	public Camera sourceCamera;
	public int cubeMapRes					= 128;
	public bool createMipMaps				= false;
	
	RenderTexture renderTex;
	
	

	public RenderTexture GetRenderTexture() {
		
		if (renderTex != null) return renderTex;
		
		renderTex = new RenderTexture(cubeMapRes, cubeMapRes, 16);
		renderTex.isCubemap = true;
		renderTex.hideFlags = HideFlags.HideAndDontSave;
		renderTex.generateMips = createMipMaps;
		sourceCamera.RenderToCubemap(renderTex);
		return renderTex;
	}
	
	
}