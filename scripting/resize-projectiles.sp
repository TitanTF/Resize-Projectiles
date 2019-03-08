#include <sdkhooks>

ConVar
	cvSize;
	
float
	g_flSize;

public Plugin myinfo = 
{
	name = "Resize Projectiles",
	author = "myst",
	description = "All projectiles are resized.",
	version = "1.0",
	url = "https://titan.tf"
}

public void OnPluginStart()
{
	cvSize 		= CreateConVar("sm_resizeprojectile_size", "2.0", "Change the size of projectiles being resized to.", _, true, 0.1, true, 100.0);
	g_flSize 	= cvSize.FloatValue;
	
	cvSize.AddChangeHook(OnCvarChanged);
}

public int OnCvarChanged(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	g_flSize = cvSize.FloatValue;
}

public void OnEntityCreated(int iEntity, const char[] sClassname)
{
	if (IsValidEntity(iEntity))
	{
		if (StrContains(sClassname, "tf_projectile_") != -1)
		{
			SetEntPropFloat(iEntity, Prop_Send, "m_flModelScale", g_flSize);
		}
	}
}