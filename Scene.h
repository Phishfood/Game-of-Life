#pragma once

#define chair *

#include <windows.h>
#include <d3d10.h>
#include <d3dx10.h>
#include <atlbase.h>
#include <sstream>
#include <iostream>
#include "resource.h"

#include "Defines.h" // General definitions shared by all source files
#include "Model.h"   // Model class - encapsulates working with vertex/index data and world matrix
#include "Camera.h"  // Camera class - encapsulates the camera's view and projection matrix
#include "CTimer.h"  // Timer class - not DirectX
#include "Input.h"   // Input functions - not DirectX

#include "Light.h"			// Light class.
#include "RenderObject.h"	// Render class.

#include "Colours.h"		// Functions to adjust colours

class CScene
{
private:
	// DX Device pointer
	ID3D10Device* mpd3dDevice;

	//Viewport details - static because the message handler is static. 
	static int mViewportWidth, mViewportHeight;	

	static const int MAX_LIGHTS = 30;
	static const int MAX_SHADER_LIGHTS = 12;
	static const int MAX_OBJECTS = 2000;
	static const int GRIDSIZE = 30;

	// Models and cameras encapsulated in classes for flexibity and convenience
	// The CModel class collects together geometry and world matrix, and provides functions to control the model and render it
	// The CCamera class handles the view and projections matrice, and provides functions to control the camera
	CCamera* Camera;

	CRenderObject* mpObjects[MAX_OBJECTS];
	int miNumObjects;

	CLight* mpLights[MAX_LIGHTS];
	int miNumLights;

	// Textures - no texture class yet so using DirectX variables
	// * 2 since each object can potentially have 2 textures, although this is likely overkill.
	ID3D10ShaderResourceView* mpMaps[MAX_OBJECTS*2];
	int miNumMaps;

	// Ambient Light
	D3DXVECTOR3 AmbientColour;

	//defines the object to be controlled via keyboard
	int mControlObject;

	// Note: There are move & rotation speed constants in Defines.h


	//--------------------------------------------------------------------------------------
	// Shader Variables
	//--------------------------------------------------------------------------------------
	// Variables to connect C++ code to HLSL shaders

	// Effects / techniques
	ID3D10Effect*          Effect;
	ID3D10EffectTechnique* mTechniques[30];
	ID3D10EffectTechnique* mTechniquesMirror[30];
	int miNumTechniques;

	// Matrices
	ID3D10EffectMatrixVariable* WorldMatrixVar;
	ID3D10EffectMatrixVariable* ViewMatrixVar;
	ID3D10EffectMatrixVariable* ProjMatrixVar;
	ID3D10EffectMatrixVariable* ViewProjMatrixVar;

	// Textures
	ID3D10EffectShaderResourceVariable* DiffuseMapVar;
	ID3D10EffectShaderResourceVariable* NormalMapVar;

	// Miscellaneous
	ID3D10EffectVectorVariable* ModelColourVar;

	//Positions
	ID3D10EffectVectorVariable* dxLightPosA;
	ID3D10EffectVectorVariable* dxCameraPos;

	//Lights
	ID3D10EffectVectorVariable* dxLightColourA;
	ID3D10EffectVectorVariable* dxAmbientColour;
	ID3D10EffectVariable*		dxLightBrightnessA;

	ID3D10EffectVariable*		dxWiggle;
	ID3D10EffectVariable*		dxOutlineThickness;

	ID3D10EffectVectorVariable* ClipPlaneVar;

	//--------------------------------------------------------------------------------------
	// DirectX Variables
	//--------------------------------------------------------------------------------------

	// Variables used to setup D3D
	IDXGISwapChain*         SwapChain;
	ID3D10Texture2D*        DepthStencil;
	ID3D10DepthStencilView* DepthStencilView;
	ID3D10RenderTargetView* RenderTargetView;

	// Variables used to setup the Window
	HINSTANCE HInst;
	HWND      HWnd;

	// Functions to load items into the scene - purely for neatness
	bool BasicItems();  
	bool SceneItems();
	bool TestItems();

	bool CellStuff();

	void SetLive(int i, int j);
	void SetDead(int i, int j);
	struct sCell{
		int val;
		int adjcell;
		CRenderObject chair myObject;
	};

	void CalcNeighbours();
	sCell cells[GRIDSIZE][GRIDSIZE];

	// Choose the lights to send to the shader
	void SetLights( D3DXVECTOR3 source, CLight* lightsSource[MAX_LIGHTS], int lightCount);
	// Sort function for the lights - static for function pointer.
	static inline int compareLights( const void* a, const void* b);

	// Message Handler - static for function pointer.
	static LRESULT CALLBACK WndProc( HWND, UINT, WPARAM, LPARAM );

	inline void DrawObject(int i, bool mirror = false);
	inline void DrawAllObjects(bool mirror);
public:
	CScene(void);
	~CScene(void);


	bool InitDevice();
	void ReleaseResources();
	bool LoadEffectFile();
	bool InitScene();
	void UpdateScene( float frameTime );
	void RenderScene();
	void RenderMirrors();
	bool InitWindow( HINSTANCE hInstance, int nCmdShow );

};

