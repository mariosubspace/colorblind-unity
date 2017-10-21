#ifndef COLOR_DEFICIENCY_TOOLS_INCLUDED
#define COLOR_DEFICIENCY_TOOLS_INCLUDED

float3 RgbToLms(float3 colRgb)
{
	float3 colLms;
	colLms.x = 0.31399022 * colRgb.x + 0.63951294 * colRgb.y + 0.04649755 * colRgb.z;
	colLms.y = 0.15537241 * colRgb.x + 0.75789446 * colRgb.y + 0.08670142 * colRgb.z;
	colLms.z = 0.01775239 * colRgb.x + 0.10944209 * colRgb.y + 0.87256922 * colRgb.z;
	return colLms;
}

float3 LmsToRgb(float3 colLms)
{
	float3 colRgb;
	colRgb.x =  5.47221206 * colLms.x - 4.64196010 * colLms.y + 0.16963708 * colLms.z,
	colRgb.y = -1.12524190 * colLms.x + 2.29317094 * colLms.y - 0.16789520 * colLms.z,
	colRgb.z =  0.02980165 * colLms.x - 0.19318073 * colLms.y + 1.16364789 * colLms.z;
	return colRgb;
}

// All-in-one daltonization function.
float3 Daltonize(float3 lmsCol, int def)
{
    switch (def)
    {
    	case 0: // None
    		return lmsCol;
    	case 1: // Protanopia
    		lmsCol.x =  1.05118294 * lmsCol.y - 0.05116099 * lmsCol.z;
    		return lmsCol;
    	case 2: // Deuteranopia
    		lmsCol.y =  0.95130920 * lmsCol.x + 0.04866992 * lmsCol.z;
    		return lmsCol;
    	case 3: // Tritanopia
		    lmsCol.z = -0.86744736 * lmsCol.x + 1.86727089 * lmsCol.y;
		    return lmsCol;
		default: // None
			return lmsCol;
    }
}

// All-in-one simulation function.
// def: 0=None, 1=Protan, 2=Deuteran, 3=Tritan
float3 SimulateDeficiency(float3 rgbCol, float def)
{
    float3 lmsCol;

    // Translate from linear RGB space to LMS space.
    lmsCol = RgbToLms(rgbCol);

    // Daltonize.
    lmsCol = Daltonize(lmsCol, (int)def);

    // Translate from LMS space to linear RGB space.
    rgbCol = LmsToRgb(lmsCol);

    return rgbCol;
}

// Not all-in-one simulation functions, to eliminate branching:
// In theory more efficient than all-in-one, but in practice
// performance seems about the same.

float3 SimulateProtanopia(float3 rgbCol)
{
	float3 lmsCol = RgbToLms(rgbCol);
	lmsCol.x =  1.05118294 * lmsCol.y - 0.05116099 * lmsCol.z;
	return LmsToRgb(lmsCol);
}

float3 SimulateDeuteranopia(float3 rgbCol)
{
	float3 lmsCol = RgbToLms(rgbCol);
	lmsCol.y =  0.95130920 * lmsCol.x + 0.04866992 * lmsCol.z;
    return LmsToRgb(lmsCol);
}

float3 SimulateTritanopia(float3 rgbCol)
{
	float3 lmsCol = RgbToLms(rgbCol);
	lmsCol.z = -0.86744736 * lmsCol.x + 1.86727089 * lmsCol.y;
	return LmsToRgb(lmsCol);
}

#endif // COLOR_DEFICIENCY_TOOLS_INCLUDED