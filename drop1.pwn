#include <a_samp>
#include <ugmp>
#include <sscanf2>
#include <zcmd>
#define MAX_OBJ 100 // <-
// -----------------------------------------------------------------------------
enum dGunEnum
{
	Float:ObjPos[3],
	ObjID,
	ObjData[2]
};
new dGunData[MAX_OBJ][dGunEnum];
// -----------------------------------------------------------------------------
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_GRAD1 0xB4B5B7FF
// -----------------------------------------------------------------------------
new GunObjects[418] = { //fucking hell
	0,331,333,334,335,336,337,338,339,341,321,322,323,324,325,326,342,343,344,
	0,0,0,346,347,348,349,350,351,352,353,355,356,372,357,358,359,360,361,362,
	363,364,365,366,367,368,368,371,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    29000,29001,29002,29003,29004,29005,29006,29007,29008,29009,29010,29011,29012,29013,29014,29015,
    29016,29017,0,29019,29020,29021,29022,29023,29024,29025,29026,29027,29028,29029,29030,29031,29032,
    29033,29034,29035,29036,29037,29038,29039,29040,29041,29042,29043,29045,29047,29048,29049,29050,
    29051,29052,29053,29054,29055,0,29057,29058,29059,29060,29061,0,29082,29069,29064,29085,29097,29297,29065,
    29065,29074,29083,29071,29071,29094,29080,29076,29070,29066,29089,29073,29068,29092,29086,29091,29095,
    29072,29096,29079,29075,29090,29067,29081,29093,29084,29077,29087,29088,29116,29104,29114,29132,29099,
    29119,29100,29131,29298,29109,29117,29115,29128,29106,29101,29110,29105,29123,0,29103,29120,0,29125,
    29127,29129,29107,29130,29112,29121,29124,29118,29126,29111,29122,29134,29135,29136,29137,29138,29139,
    29140,29141,29142,29143,29144,29145,29146,29147,29148,29149,29150,29151,29152,29153,29154,29155,29156,
    29157,29158,29159,29160,29161,29162,29163,29164,29165,29166,29167,29168,29169,0,29171,29172,29173,29174,
    29175,29176,29177,29178,29179,29180,29181,29323,29182,29183,29184,29185,29186,29187,
    29188,29189,29190,29191,29192,29193,29194,29195,29196,29197,29198,29199,29200,29201,
    29202,29203,29204,29205,29206,29207,29208,29209,29210,29211,29212,29213,29214,29215,
    29216,29217,29218,29219,29220,29221,29222,29223,29224,29225,29226,29227,29228,29229,
    29230,29231,29232,29233,29234,29235,29236,29237,29238,29239,29240,29241,29242,29243,
    29244,29245,29246,29272,29273,29247,29248,29249,29250,29251,29252,29253,29254,29255,
    29256,29257,29258,29259,29260,29261,29262,29263,29264,29265,29266,29267,29268,29269,
    29270,29271,29274,29275,29276,29277,29278,29279,29280,29281,29282,29283,29284,29285,
    29286,29287,29288,29289,29290,0,29295,29296,29299,29300,29301,29302,0,29304,29306,
    29307,29309,29312,0,29313,0,29315,29316,29317,29319,29320,29321,29322,29324,29325,
    29326,29327,29328,29329
};
// -----------------------------------------------------------------------------
    CMD:dwep(playerid,params[])
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
        new GunID = GetPlayerWeapon(playerid),GunAmmo = GetPlayerAmmo(playerid),buffer[50],GunNames[32];
        if(GunID > 0 && GunAmmo != 0)
        {
            new f = MAX_OBJ+1;
            for(new a = 0; a < MAX_OBJ; a++)
            {
                if(dGunData[a][ObjPos][0] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_GRAD1, "You dont have a weapon on you.");
			RemovePlayerWeapon(playerid, GunID);
			dGunData[f][ObjData][0] = GunID;
			dGunData[f][ObjData][1] = GunAmmo;
            GetWeaponName(dGunData[f][ObjData][0], GunNames, sizeof(GunNames));
            GetPlayerPos(playerid, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]);
            dGunData[f][ObjID] = CreateObject(GunObjects[GunID], dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 93.7, 120.0, 120.0);
			format(buffer, sizeof(buffer), "You have dropped a %s.", GunNames);
			SendClientMessage(playerid, COLOR_GRAD1, buffer);
        }
        return 1;
    }
    CMD:swep(playerid,params[])
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
        new f = MAX_OBJ+1,buffer[50],GunNames[32];
		for(new a = 0; a < MAX_OBJ; a++)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 2.0, dGunData[a][ObjPos][0], dGunData[a][ObjPos][1], dGunData[a][ObjPos][2]))
		    {
		        f = a;
		        break;
		    }
		}
		if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_GRAD1, "No weapon is near you, please try again.");
		GetWeaponName(dGunData[f][ObjData][0], GunNames, sizeof(GunNames));
		format(buffer, sizeof(buffer), "You have found a %s type /pwep to pick it up.", GunNames);
  		SendClientMessage(playerid, COLOR_GRAD1, buffer);
  		return 1;
    }
    CMD:pwep(playerid,params[])
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
        new f = MAX_OBJ+1,buffer[50],GunNames[32];
		for(new a = 0; a < MAX_OBJ; a++)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 2.0, dGunData[a][ObjPos][0], dGunData[a][ObjPos][1], dGunData[a][ObjPos][2]))
		    {
		        f = a;
		        break;
		    }
		}
		if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_GRAD1, "You are not near a weapon that you can pick up.");
		DestroyObject(dGunData[f][ObjID]);
		GetWeaponName(dGunData[f][ObjData][0], GunNames, sizeof(GunNames));
		GivePlayerWeapon(playerid, dGunData[f][ObjData][0], dGunData[f][ObjData][1]);
		dGunData[f][ObjPos][0] = 0.0;
		dGunData[f][ObjPos][1] = 0.0;
		dGunData[f][ObjPos][2] = 0.0;
		dGunData[f][ObjID] = -1;
		dGunData[f][ObjData][0] = 0;
		dGunData[f][ObjData][1] = 0;
		format(buffer, sizeof(buffer), "You have picked up a %s.", GunNames);
  		SendClientMessage(playerid, COLOR_GRAD1, buffer);
        return 1;
    }
// -----------------------------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
	new Float:pPosX, Float:pPosY, Float:pPosZ;
	GetPlayerPos(playerid, pPosX, pPosY, pPosZ);
    for(new i_slot = 0, gun, ammo; i_slot != 12; i_slot++)
    {
        GetPlayerWeaponData(playerid, i_slot, gun, ammo);
        if(gun != 0 && ammo != 0) CreateDroppedGun(gun, ammo, pPosX+random(2)-random(2), pPosY+random(2)-random(2), pPosZ);
    }
	return 1;
}
stock CreateDroppedGun(GunID, GunAmmo, Float:gPosX, Float:gPosY, Float:gPosZ)
{
	new f = MAX_OBJ+1;
    for(new a = 0; a < MAX_OBJ; a++)
    {
        if(dGunData[a][ObjPos][0] == 0.0)
        {
            f = a;
            break;
        }
    }
    if(f > MAX_OBJ) return;
    dGunData[f][ObjData][0] = GunID;
	dGunData[f][ObjData][1] = GunAmmo;
	dGunData[f][ObjPos][0] = gPosX;
	dGunData[f][ObjPos][1] = gPosY;
	dGunData[f][ObjPos][2] = gPosZ;
	dGunData[f][ObjID] = CreateObject(GunObjects[GunID], dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 93.7, 120.0, random(360));
	return;
}
stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12] = 0,plyAmmo[12] = 0;
	for(new sslot = 0; sslot != 12; sslot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, sslot, wep, ammo);
		if(wep != weaponid && ammo != 0) GetPlayerWeaponData(playerid, sslot, plyWeapons[sslot], plyAmmo[sslot]);
	}
	ResetPlayerWeapons(playerid);
	for(new sslot = 0; sslot != 12; sslot++) if(plyAmmo[sslot] != 0) GivePlayerWeapon(playerid, plyWeapons[sslot], plyAmmo[sslot]);
	return 1;
}
stock split(const strsrc[], strdest[][], delimiter)
{ // Not mine :3
	new i, li,aNum,len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
