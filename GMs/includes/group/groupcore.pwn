/*

	 /$$   /$$  /$$$$$$          /$$$$$$$  /$$$$$$$
	| $$$ | $$ /$$__  $$        | $$__  $$| $$__  $$
	| $$$$| $$| $$  \__/        | $$  \ $$| $$  \ $$
	| $$ $$ $$| $$ /$$$$ /$$$$$$| $$$$$$$/| $$$$$$$/
	| $$  $$$$| $$|_  $$|______/| $$__  $$| $$____/
	| $$\  $$$| $$  \ $$        | $$  \ $$| $$
	| $$ \  $$|  $$$$$$/        | $$  | $$| $$
	|__/  \__/ \______/         |__/  |__/|__/

						Dynamic Group Core

				Next Generation Gaming, LLC
	(created by Next Generation Gaming Development Team)
					
	* Copyright (c) 2014, Next Generation Gaming, LLC
	*
	* All rights reserved.
	*
	* Redistribution and use in source and binary forms, with or without modification,
	* are not permitted in any case.
	*
	*
	* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
	* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
	* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
	* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
	* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
	* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
	* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
	* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
#include <YSI\y_hooks>

stock IsACop(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_LEA)) return 1;
	return 0;
}

stock IsAHitman(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_CONTRACT)) return 1;
	return 0;
}

stock IsAMedic(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_MEDIC)) return 1;
	return 0;
}

stock IsAReporter(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_NEWS)) return 1;
	return 0;
}

stock IsAGovernment(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_GOV)) return 1;
	return 0;
}

stock IsAJudge(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_JUDICIAL)) return 1;
	return 0;
}

stock IsATaxiDriver(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_TAXI))	return 1;
	return 0;
}

stock IsATowman(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_TOWING)) return 1;
	return 0;
}

stock IsARacer(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_RACE)) return 1;
	return 0;
}

stock IsACriminal(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_CRIMINAL)) return 1;
	return 0;
}

stock IsADocGuard(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iDoCAccess])) return 1;
	return 0;
}

stock IsFirstAid(playerid)
{
	if((0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS) && (PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iMedicAccess])) return 1;
	return 0;
}

stock IsMDCPermitted(playerid)
{
	if(IsACop(playerid) || IsAJudge(playerid))
	{
		return 1;
	}
	return 0;
}

stock GetPlayerGroupInfo(targetid, rank[], division[], employer[])
{
	new
		iGroupID = PlayerInfo[targetid][pMember],
	 	iRankID = PlayerInfo[targetid][pRank];

	if (0 <= iGroupID < MAX_GROUPS)
	{
	    if(0 <= iRankID < MAX_GROUP_RANKS)
	    {
		    if(arrGroupRanks[iGroupID][iRankID][0]) {
				format(rank, (GROUP_MAX_RANK_LEN), "%s", arrGroupRanks[iGroupID][iRankID]);
			}
			else format(rank, (GROUP_MAX_RANK_LEN), "undefined");
		}
	    if(0 <= PlayerInfo[targetid][pDivision] < MAX_GROUP_DIVS)
		{
			if(arrGroupDivisions[iGroupID][PlayerInfo[targetid][pDivision]][0]) { format(division, (GROUP_MAX_DIV_LEN), "%s", arrGroupDivisions[iGroupID][PlayerInfo[targetid][pDivision]]); }
			else format(division, (GROUP_MAX_DIV_LEN), "undefined");
		}
	    else format(division, (GROUP_MAX_DIV_LEN), "G.D.");
	    if(arrGroupData[iGroupID][g_szGroupName][0]) {
			format(employer, (GROUP_MAX_NAME_LEN), "%s", arrGroupData[iGroupID][g_szGroupName]);
		}
		else
		{
		    format(employer, (GROUP_MAX_NAME_LEN), "undefined");
		}
	}
	else
	{
	    format(rank, (GROUP_MAX_RANK_LEN), "N/A");
	    format(division, (GROUP_MAX_DIV_LEN), "None");
	    format(employer, (GROUP_MAX_NAME_LEN), "None");
	}
	return 1;
}

Group_GetMaxRank(iGroupID) {

	new
		iCount = MAX_GROUP_RANKS;

	while(iCount--) if(arrGroupRanks[iGroupID][iCount][0]) return iCount;
	return MAX_GROUP_RANKS-1;
}

Group_GetMaxDiv(iGroupID) {

	new
		iCount = MAX_GROUP_DIVS;

	while(iCount--) if(arrGroupDivisions[iGroupID][iCount][0]) return iCount;
	return MAX_GROUP_DIVS;
}

Group_ListGroups(iPlayerID, iDialogID = DIALOG_LISTGROUPS) {

	new
		szDialogStr[MAX_GROUPS * (GROUP_MAX_NAME_LEN + 16)],
		iCount;

	while(iCount < MAX_GROUPS) {
		if(arrGroupData[iCount][g_szGroupName][0])
			format(szDialogStr, sizeof szDialogStr, "%s\n(%i) {%s}%s{FFFFFF}", szDialogStr, iCount+1, Group_NumToDialogHex(arrGroupData[iCount][g_hDutyColour]), arrGroupData[iCount][g_szGroupName]);

		else
			format(szDialogStr, sizeof szDialogStr, "%s\n(%i) (empty)", szDialogStr, iCount+1);

		++iCount;
	}
	if(iDialogID == DIALOG_MAKELEADER)
	{
		new diagTitle[64];
		format(diagTitle, sizeof(diagTitle), "Group List - Set Leadership for %s", GetPlayerNameEx(GetPVarInt(iPlayerID, "MakingLeader")));
		return ShowPlayerDialog(iPlayerID, iDialogID, DIALOG_STYLE_LIST, diagTitle, szDialogStr, "Select", "Cancel");
	}
	else return ShowPlayerDialog(iPlayerID, iDialogID, DIALOG_STYLE_LIST, "Group List", szDialogStr, "Select", "Cancel");
}

Group_ReturnAllegiance(iAllegianceID) {

	new
		szResult[16] = "None";

	switch(iAllegianceID) {
		case 1: szResult = "San Andreas";
		case 2: szResult = "Tierra Robada";
	}
	return szResult;
}

Group_ReturnType(iGroupType) {

	new
		szResult[32] = "None";

	switch(iGroupType) {
		case 1: szResult = "Law Enforcement";
		case 2: szResult = "Contract Agency";
		case 3: szResult = "Fire/Medic";
		case 4: szResult = "News Agency";
		case 5: szResult = "Government";
		case 6: szResult = "Judicial";
		case 7: szResult = "Transport";
		case 8: szResult = "Towing";
		case 9: szResult = "URL";
		case 10: szResult = "Criminal";
	}
	return szResult;
}

Group_DisplayDialog(iPlayerID, iGroupID) {

	new
		szTitle[22 + GROUP_MAX_NAME_LEN],
		szDialog[2048];

	format(szDialog, sizeof(szDialog),
		"{BBBBBB}Name:{FFFFFF} %s\n\
		{BBBBBB}Type:{FFFFFF} %s\n\
		{BBBBBB}Allegiance:{FFFFFF} %s\n\
		{BBBBBB}Jurisdiction\n\
		{BBBBBB}Duty colour: {%s}(edit)\n\
		{BBBBBB}Radio colour: {%s}(edit)\n\
		{BBBBBB}Radio access:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Department radio access:{FFFFFF} %s (rank %i)\n",
		arrGroupData[iGroupID][g_szGroupName],
		Group_ReturnType(arrGroupData[iGroupID][g_iGroupType]),
		Group_ReturnAllegiance(arrGroupData[iGroupID][g_iAllegiance]),
		Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]),
		Group_NumToDialogHex(arrGroupData[iGroupID][g_hRadioColour]),
		(arrGroupData[iGroupID][g_iRadioAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iRadioAccess],
		(arrGroupData[iGroupID][g_iDeptRadioAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iDeptRadioAccess]
	);

	format(szDialog, sizeof(szDialog), "%s\
		{BBBBBB}Int radio access:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Bug access:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Government announcement:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Free name change:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Spike Strips:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Barricades:{FFFFFF} %s (rank %i)\n",
		szDialog,
		(arrGroupData[iGroupID][g_iIntRadioAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iIntRadioAccess],
		(arrGroupData[iGroupID][g_iBugAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iBugAccess],
		(arrGroupData[iGroupID][g_iGovAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iGovAccess],
		(arrGroupData[iGroupID][g_iFreeNameChange] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iFreeNameChange],
		(arrGroupData[iGroupID][g_iSpikeStrips] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iSpikeStrips],
		(arrGroupData[iGroupID][g_iBarricades] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iBarricades]
	);
	
	format(szDialog, sizeof(szDialog), "%s\
		{BBBBBB}Cones:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Flares:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Barrels:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Ladders:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Crate Island Control:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit Locker Stock:{FFFFFF} (%i)\n\
		{BBBBBB}Edit Locker Weapons (%i defined)\n",
		szDialog,
		(arrGroupData[iGroupID][g_iCones] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iCones],
		(arrGroupData[iGroupID][g_iFlares] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iFlares],
		(arrGroupData[iGroupID][g_iBarrels] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iBarrels],
		(arrGroupData[iGroupID][g_iLadders] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iLadders],
		(arrGroupData[iGroupID][g_iCrateIsland] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iCrateIsland],
		arrGroupData[iGroupID][g_iLockerStock],
		Array_Count(arrGroupData[iGroupID][g_iLockerGuns], MAX_GROUP_WEAPONS)
	);

	format(szDialog, sizeof(szDialog),
		"%s\
		{BBBBBB}Edit Payments\n\
		{BBBBBB}Edit Divisions (%i defined)\n\
		{BBBBBB}Edit Ranks (%i defined)\n\
		{BBBBBB}Edit Lockers\n\
		{BBBBBB}Edit Crate Delivery Position (current distance: %.0f)\n\
		{BBBBBB}Locker Cost Type: %s\n\
		{BBBBBB}Edit the Garage Position (current distance: %.0f)\n\
		{BBBBBB}Edit Tackle Access:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit Wheel Clamps Access:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit DoC Access:{FFFFFF} %s (rank %i)\n",
		szDialog,
		String_Count(arrGroupDivisions[iGroupID], MAX_GROUP_DIVS),
		String_Count(arrGroupRanks[iGroupID], MAX_GROUP_RANKS),
		GetPlayerDistanceFromPoint(iPlayerID, arrGroupData[iGroupID][g_fCratePos][0], arrGroupData[iGroupID][g_fCratePos][1], arrGroupData[iGroupID][g_fCratePos][2]),
		lockercosttype[arrGroupData[iGroupID][g_iLockerCostType]],
		GetPlayerDistanceFromPoint(iPlayerID, arrGroupData[iGroupID][g_fGaragePos][0], arrGroupData[iGroupID][g_fGaragePos][1], arrGroupData[iGroupID][g_fGaragePos][2]),
		(arrGroupData[iGroupID][g_iTackleAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iTackleAccess],
		(arrGroupData[iGroupID][g_iWheelClamps] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iWheelClamps],
		(arrGroupData[iGroupID][g_iDoCAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iDoCAccess]
	);
	
	format(szDialog, sizeof(szDialog),
		"%s\
		{BBBBBB}Edit Medic Access:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit DMV Release:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit OOC Chat Access:{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit OOC Chat Color: {%s}(edit)\n\
		{BBBBBB}Edit Group Clothes\n\
		{BBBBBB}Edit Turf Cap Rank{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit Point Cap Rank {FFFFFF} %s (rank %i)",
		szDialog,
		(arrGroupData[iGroupID][g_iMedicAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iMedicAccess],
		(arrGroupData[iGroupID][g_iDMVAccess] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iDMVAccess], 
		(arrGroupData[iGroupID][g_iOOCChat] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iOOCChat],
		Group_NumToDialogHex(arrGroupData[iGroupID][g_hOOCColor]),
		(arrGroupData[iGroupID][g_iTurfCapRank] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iTurfCapRank],
		(arrGroupData[iGroupID][g_iPointCapRank] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iPointCapRank]
	);
		
	if(PlayerInfo[iPlayerID][pAdmin] >= 1337) strcat(szDialog, "\nDisband Group");
	format(szTitle, sizeof szTitle, "{FFFFFF}Edit {%s}%s", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
	return ShowPlayerDialog(iPlayerID, DIALOG_EDITGROUP, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
}

stock GroupLog(groupid, string[])
{
	new month, day, year, file[32];
	getdate(year, month, day);
	format(file, sizeof(file), "grouplogs/%d/%d-%02d-%02d.log", groupid, year, month, day);
	return Log(file, string);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new sendername[MAX_PLAYER_NAME];
	new string[128];
	szMiscArray[0] = 0;
	
	switch(dialogid)
	{
		// BEGIN DYNAMIC GROUP CODE
		case G_LOCKER_MAIN: if(response)
		{
			new iGroupID = PlayerInfo[playerid][pMember];
			switch(listitem)
			{
				case 0:
				{
					if(IsACriminal(playerid))
					{
						format(szMiscArray, sizeof(szMiscArray), "%s reaches into the locker grabbing their clothes", GetPlayerNameEx(playerid));
						ProxDetector(30.0, playerid, szMiscArray, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						PlayerInfo[playerid][pModel] = arrGroupData[iGroupID][g_iClothes][PlayerInfo[playerid][pRank]];
						return SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
					}
					if(PlayerInfo[playerid][pDuty]==0)
					{
						if (IsAReporter(playerid) || IsATaxiDriver(playerid))
							format(string, sizeof(string), "* %s %s takes a badge from their locker.", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid));
						else
							format(string, sizeof(string), "* %s %s takes a badge and a gun from their locker.", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid));

						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SetHealth(playerid, 100.0);
						if(IsAMedic(playerid))
						{
							Medics += 1;
						}
						if(arrGroupData[iGroupID][g_iLockerStock] > 1 && arrGroupData[iGroupID][g_iLockerCostType] == 0)
						{
							SetArmour(playerid, 100);
							arrGroupData[iGroupID][g_iLockerStock] -= 1;
							new str[128], file[32];
							format(str, sizeof(str), "%s took a vest out of the %s locker at a cost of 1 HG Material.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
							new month, day, year;
							getdate(year,month,day);
							format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
							Log(file, str);
						}
						else if(arrGroupData[iGroupID][g_iLockerCostType] != 0)
						{
							SetArmour(playerid, 100.0);
						}
						else
						{
							SendClientMessageEx(playerid, COLOR_RED, "The locker doesn't have the stock for your armor vest.");
							SendClientMessageEx(playerid, COLOR_GRAD2, "Contact your supervisor or the SAAS and organize a crate delivery.");
						}
						PlayerInfo[playerid][pDuty] = 1;
						SetPlayerToTeamColor(playerid);
						SendClientMessageEx(playerid, COLOR_GRAD2, "You may now select your weapons from the equipment locker");
					}
					else if(PlayerInfo[playerid][pDuty]==1)
					{
						format(string, sizeof(string), "* %s %s places their badge and gun in their locker.", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid));
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						if(IsAMedic(playerid))
						{
							Medics -= 1;
						}
						SetHealth(playerid, 100.0);
						RemoveArmor(playerid);
						PlayerInfo[playerid][pDuty] = 0;
						SetPlayerToTeamColor(playerid);
					}
				}
				case 1:
				{
					if((PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pUndercover] >= 1) && PlayerInfo[playerid][pTogReports] == 0) 
						return SendClientMessageEx(playerid, COLOR_GRAD2, "Locker weapons have been restricted from admins, /togreports to gain access.");
					if(IsACriminal(playerid))
					{
						for(new i=0; i != 50; ++i)
						{
							if(arrGroupData[iGroupID][g_iWeapons][i] != 0)
							{
								format(szMiscArray, sizeof(szMiscArray), "%s\n%s (%i)", szMiscArray, Weapon_ReturnName(arrGroupData[iGroupID][g_iWeapons][i]), arrGroupData[iGroupID][g_iWeapons][i]);
							}
							else
							{
								format(szMiscArray, sizeof(szMiscArray), "%s\nUndefined", szMiscArray);
							}						
						}
						strcat(szMiscArray, "\nDeposit Weapon");
						return ShowPlayerDialog(playerid, DIALOG_GROUP_WEAPONSAFE, DIALOG_STYLE_LIST, "Weapon Safe", szMiscArray, "Select", "Cancel");
					}
					if(PlayerInfo[playerid][pTogReports] == 1 || PlayerInfo[playerid][pAdmin] < 2)
					{
						new
							szDialog[(32 + 8) * (MAX_GROUP_WEAPONS+1)];

						for(new i = 0; i != MAX_GROUP_WEAPONS; ++i) {
							if(arrGroupData[iGroupID][g_iLockerGuns][i]) {
								format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, arrGroupData[iGroupID][g_iLockerGuns][i], Weapon_ReturnName(arrGroupData[iGroupID][g_iLockerGuns][i]));
								if (arrGroupData[iGroupID][g_iLockerCostType] == 2) format(szDialog, sizeof szDialog, "%s    $%d", szDialog, arrGroupData[iGroupID][g_iLockerCost][i]);
							}
							else strcat(szDialog, "\n(empty)");
						}
						strcat(szDialog, "\nAccessories");
						format(string, sizeof(string), "%s Weapon Locker", arrGroupData[iGroupID][g_szGroupName]);
						ShowPlayerDialog(playerid, G_LOCKER_EQUIPMENT, DIALOG_STYLE_LIST, string, szDialog, "Purchase", "Cancel");
					}
				}
				case 2:
				{
					if(IsACriminal(playerid))
					{
						SetPVarInt(playerid, "GSafe_Opt", 2);
						return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_LIST, "Gang Safe: Pot Safe", "Deposit\nWithdraw", "Select", "Back");
					}
					else ShowPlayerDialog(playerid, G_LOCKER_UNIFORM, DIALOG_STYLE_INPUT, "Uniform","Choose a skin (by ID).", "Select", "Cancel");
				}
				case 3:
				{
					if(IsACriminal(playerid))
					{
						SetPVarInt(playerid, "GSafe_Opt", 3);
						return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_LIST, "Gang Safe: Crack Safe", "Deposit\nWithdraw", "Select", "Back");
					}
					if(IsAMedic(playerid) || IsAGovernment(playerid) || IsATowman(playerid)) {
						if(GetPVarInt(playerid, "MedVestKit") == 1) {
							return SendClientMessageEx(playerid, COLOR_GRAD1, "You're already carrying a med kit.");
						}
						if(arrGroupData[iGroupID][g_iLockerStock] > 1 && arrGroupData[iGroupID][g_iLockerCostType] == 0)
						{
							SendClientMessageEx(playerid, COLOR_GRAD1, "You are now carrying a med kit.  /placekit to store it in your backpack/vehicle.");
							SetPVarInt(playerid, "MedVestKit", 1);
							arrGroupData[iGroupID][g_iLockerStock] -= 1;
							new str[128], file[32];
							format(str, sizeof(str), "%s took a med kit & vest out of the %s locker at a cost of 1 HG Material.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
							new month, day, year;
							getdate(year,month,day);
							format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
							Log(file, str);
						}
						else if(arrGroupData[iGroupID][g_iLockerCostType] == 1)
						{
							if(arrGroupData[iGroupID][g_iBudget] > 3000)
							{
								SendClientMessageEx(playerid, COLOR_GRAD1, "You are now carrying a med kit.  /placekit to store it in your backpack/vehicle.");
								SetPVarInt(playerid, "MedVestKit", 1);
								arrGroupData[iGroupID][g_iBudget] -= 3000;
								new str[128], file[32];
								format(str, sizeof(str), "%s took a med kit & vest out of the %s locker at a cost of $3,000 to the budget fund.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
								new month, day, year;
								getdate(year,month,day);
								format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
								Log(file, str);
							}
							else return SendClientMessageEx(playerid, COLOR_GRAD2, " Your agency cannot afford the vest. ($3,000)");
						}
						else if(arrGroupData[iGroupID][g_iLockerCostType] == 2)
						{
							if(GetPlayerCash(playerid) > 3000)
							{
								SendClientMessageEx(playerid, COLOR_GRAD1, "You are now carrying a med kit.  /placekit to store it in your backpack/vehicle.");
								SetPVarInt(playerid, "MedVestKit", 1);
								GivePlayerCash(playerid, -3000);
								new str[128], file[32];
								format(str, sizeof(str), "%s took a med kit & vest out of the %s locker at a personal cost of $3,000.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
								new month, day, year;
								getdate(year,month,day);
								format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
								Log(file, str);
							}
							else return SendClientMessageEx(playerid, COLOR_GRAD2, " You cannot afford the vest. ($3,000)");
						}
						else
						{
							SendClientMessageEx(playerid, COLOR_RED, "The locker doesn't have the stock for your trunk kit.");
							SendClientMessageEx(playerid, COLOR_GRAD2, "Contact your supervisor or the SAAS and organize a crate delivery.");
						}
					}
					else {
						ShowPlayerDialog(playerid, G_LOCKER_CLEARSUSPECT,DIALOG_STYLE_INPUT, arrGroupData[iGroupID][g_szGroupName]," Who would you like to clear?","Clear","Return");
					}
				}
				case 4: // LEOs - HP + Armour
				{
					if(IsACriminal(playerid))
					{
						SetPVarInt(playerid, "GSafe_Opt", 4);
						return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_LIST, "Gang Safe: Heroin Safe", "Deposit\nWithdraw", "Select", "Back");
					}
					if(arrGroupData[iGroupID][g_iLockerStock] > 1 && arrGroupData[iGroupID][g_iLockerCostType] == 0)
					{
						SetArmour(playerid, 100);
						SetHealth(playerid, 100.0);
						arrGroupData[iGroupID][g_iLockerStock] -= 1;
						new str[128], file[32];
						format(str, sizeof(str), "%s took a vest out of the %s locker at a cost of 1 HG Material.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
						new month, day, year;
						getdate(year,month,day);
						format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
						Log(file, str);
					}
					else if(arrGroupData[iGroupID][g_iLockerCostType] == 1)
					{
						if(arrGroupData[iGroupID][g_iBudget] > 2500)
						{
							SetArmour(playerid, 100);
							SetHealth(playerid, 100.0);
							arrGroupData[iGroupID][g_iBudget] -= 2500;
							new str[128], file[32];
							format(str, sizeof(str), "%s took a vest out of the %s locker at a cost of $2,500.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
							new month, day, year;
							getdate(year,month,day);
							format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
							Log(file, str);
						}
						else return SendClientMessageEx(playerid, COLOR_GRAD2, " Your agency cannot afford the vest. ($2,500)");
					}
					else if(arrGroupData[iGroupID][g_iLockerCostType] == 2)
					{
						if(GetPlayerCash(playerid) > 2500)
						{
							SetArmour(playerid, 100);
							SetHealth(playerid, 100.0);
							GivePlayerCash(playerid, -2500);
							new str[128], file[32];
							format(str, sizeof(str), "%s took a vest out of the %s locker at a personal cost of $2,500.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
							new month, day, year;
							getdate(year,month,day);
							format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
							Log(file, str);
						}
						else return SendClientMessageEx(playerid, COLOR_GRAD2, " You cannot afford the vest. ($2,500)");
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_RED, "The locker doesn't have the stock for your armor vest.");
						SendClientMessageEx(playerid, COLOR_GRAD2, "Contact your supervisor or the SAAS and organize a crate delivery.");
					}
				}
				case 5: // LEOs - HP + Armour Car/Backpack Kit
				{
					if(IsACriminal(playerid))
					{
						SetPVarInt(playerid, "GSafe_Opt", 5);
						return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_LIST, "Gang Safe: Syringes Safe", "Deposit\nWithdraw", "Select", "Back");
					}
					if(GetPVarInt(playerid, "MedVestKit") == 1) {
						return SendClientMessageEx(playerid, COLOR_GRAD1, "You're already carrying a med kit.");
					}
					if(arrGroupData[iGroupID][g_iLockerStock] > 1 && arrGroupData[iGroupID][g_iLockerCostType] == 0)
					{
						SendClientMessageEx(playerid, COLOR_GRAD1, "You are now carrying a med kit.  /placekit to store it in your backpack/vehicle.");
						SetPVarInt(playerid, "MedVestKit", 1);
						arrGroupData[iGroupID][g_iLockerStock] -= 1;
						new str[128], file[32];
						format(str, sizeof(str), "%s took a med kit & vest out of the %s locker at a cost of 1 HG Material.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
						new month, day, year;
						getdate(year,month,day);
						format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
						Log(file, str);
					}
					else if(arrGroupData[iGroupID][g_iLockerCostType] == 1)
					{
						if(arrGroupData[iGroupID][g_iBudget] > 3000)
						{
							SendClientMessageEx(playerid, COLOR_GRAD1, "You are now carrying a med kit.  /placekit to store it in your backpack/vehicle.");
							SetPVarInt(playerid, "MedVestKit", 1);
							arrGroupData[iGroupID][g_iBudget] -= 3000;
							new str[128], file[32];
							format(str, sizeof(str), "%s took a med kit & vest out of the %s locker at a cost of $3,000 to the budget fund.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
							new month, day, year;
							getdate(year,month,day);
							format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
							Log(file, str);
						}
						else return SendClientMessageEx(playerid, COLOR_GRAD2, " Your agency cannot afford the vest. ($3,000)");
					}
					else if(arrGroupData[iGroupID][g_iLockerCostType] == 2)
					{
						if(GetPlayerCash(playerid) > 3000)
						{
							SendClientMessageEx(playerid, COLOR_GRAD1, "You are now carrying a med kit.  /placekit to store it in your backpack/vehicle.");
							SetPVarInt(playerid, "MedVestKit", 1);
							GivePlayerCash(playerid, -3000);
							new str[128], file[32];
							format(str, sizeof(str), "%s took a med kit & vest out of the %s locker at a personal cost of $3,000.", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
							new month, day, year;
							getdate(year,month,day);
							format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
							Log(file, str);
						}
						else return SendClientMessageEx(playerid, COLOR_GRAD2, " You cannot afford the vest. ($3,000)");
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_RED, "The locker doesn't have the stock for your trunk kit.");
						SendClientMessageEx(playerid, COLOR_GRAD2, "Contact your supervisor or the SAAS and organize a crate delivery.");
					}
				}
				case 6: //Tazer
				{
					if(IsACriminal(playerid))
					{
						SetPVarInt(playerid, "GSafe_Opt", 6);
						return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_LIST, "Gang Safe: Opium Safe", "Deposit\nWithdraw", "Select", "Back");
					}
					if(PlayerInfo[playerid][pHasTazer] == 0)
					{
						new szMessage[128];
						format(szMessage, sizeof(szMessage), "%s reaches towards their locker, taking a tazer and cuffs out.", GetPlayerNameEx(playerid));
						ProxDetector(30.0, playerid, szMessage, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SendClientMessageEx(playerid, COLOR_WHITE, "You're now carrying a tazer and cuffs on you.");
						PlayerInfo[playerid][pHasTazer] = 1;
						PlayerInfo[playerid][pHasCuff] = 1;
					}
					else return SendClientMessageEx(playerid, COLOR_WHITE, "You're already carrying a tazer and pair of cuffs");
				}
				case 7: // free namechanges in lockers - DGA scripting request
				{
					if(IsACriminal(playerid))
					{
						SetPVarInt(playerid, "GSafe_Opt", 7);
						return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_LIST, "Gang Safe: Material Safe", "Deposit\nWithdraw", "Select", "Back");
					}
					else ShowPlayerDialog( playerid, DIALOG_NAMECHANGE, DIALOG_STYLE_INPUT, "Name Change","Please enter your new desired name!\n\nNote: Name Changes are free for your faction.", "Change", "Cancel" );
				}
				case 8: 
				{
					if(IsACriminal(playerid))
					{
						SetPVarInt(playerid, "GSafe_Opt", 8);
						return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_LIST, "Gang Safe: Money Vault", "Deposit\nWithdraw", "Select", "Back");
					}
				}
			}
		}
		case G_LOCKER_EQUIPMENT: if(response)
		{
			new	iGroupID = PlayerInfo[playerid][pMember];

			if (listitem == 16)
			{
				ShowPlayerDialog(playerid, BUYTOYSCOP, DIALOG_STYLE_MSGBOX, "Accessories", "Welcome to the law enforcement accessory locker!\n\n(As with regular toys, VIP unlocks more slots.)","Continue", "Cancel");
			}
			else
			{
				if(PlayerInfo[playerid][pAccountRestricted] != 0) return SendClientMessageEx(playerid, COLOR_GRAD1, "Your account is restricted!");
				new iGunID = arrGroupData[iGroupID][g_iLockerGuns][listitem];
				if(arrGroupData[iGroupID][g_iLockerCostType] == 0)
				{
					if(arrGroupData[iGroupID][g_iLockerStock] >= arrGroupData[iGroupID][g_iLockerCost][listitem])
					{
						arrGroupData[iGroupID][g_iLockerStock] -= arrGroupData[iGroupID][g_iLockerCost][listitem];
						new str[128], file[32];
						format(str, sizeof(str), "%s took a %s out of the %s locker at a cost of %d HG Materials.", GetPlayerNameEx(playerid), GetWeaponNameEx(iGunID), arrGroupData[iGroupID][g_szGroupName], arrGroupData[iGroupID][g_iLockerCost][listitem]);
						new month, day, year;
						getdate(year,month,day);
						format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
						Log(file, str);
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_RED, "The locker doesn't have the stock for that weapon.");
						SendClientMessageEx(playerid, COLOR_GRAD2, "Contact your supervisor or the SAAS and organize a crate delivery.");
						return 1;
					}
				}
				else if(arrGroupData[iGroupID][g_iLockerCostType] == 1)
				{
					if (arrGroupData[iGroupID][g_iBudget] < arrGroupData[iGroupID][g_iLockerCost][listitem])
					{
						SendClientMessageEx(playerid, COLOR_WHITE, "Your group cannot afford that weapon!");
						return 1;
					}
					else
					{
						arrGroupData[iGroupID][g_iBudget] -= arrGroupData[iGroupID][g_iLockerCost][listitem];
						new str[128], file[32];
						format(str, sizeof(str), "%s took a %s out of the %s locker at a cost of %$d.", GetPlayerNameEx(playerid), GetWeaponNameEx(iGunID), arrGroupData[iGroupID][g_szGroupName], arrGroupData[iGroupID][g_iLockerCost][listitem]);
						new month, day, year;
						getdate(year,month,day);
						format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
						Log(file, str);
					}
				}
				else if(arrGroupData[iGroupID][g_iLockerCostType] == 2)
				{
					if (GetPlayerCash(playerid) < arrGroupData[iGroupID][g_iLockerCost][listitem])
					{
						SendClientMessageEx(playerid, COLOR_WHITE, "You can't afford that weapon!");
						return 1;
					}
					else
					{
						GivePlayerCash(playerid, -arrGroupData[iGroupID][g_iLockerCost][listitem]);
					}
				}
				GivePlayerValidWeapon(playerid, iGunID, 960000);
			}
		}
		case G_LOCKER_UNIFORM: if(response)	{
			new skin = strval(inputtext), iGroupID = PlayerInfo[playerid][pMember];
			if(IsInvalidSkin(skin)) {
				return ShowPlayerDialog(playerid, G_LOCKER_UNIFORM, DIALOG_STYLE_INPUT, arrGroupData[iGroupID][g_szGroupName],"Invalid skin specified. Choose another.", "Select", "Cancel");
			}
			PlayerInfo[playerid][pModel] = skin;
			SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
		}
		case G_LOCKER_CLEARSUSPECT: if(response)
		{
			if(IsMDCPermitted(playerid))
			{
				new giveplayerid;
				new giveplayer[MAX_PLAYER_NAME];
				new iGroupID = PlayerInfo[playerid][pMember];
				giveplayerid = ReturnUser(inputtext);
				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* You cleared the records and wanted points of %s.", GetPlayerNameEx(giveplayerid));
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s %s has cleared your records and wanted points.", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid));
						SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s %s has cleared %s's records and wanted points.", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
						SendGroupMessage(1, RADIO, string);

						PlayerInfo[giveplayerid][pWantedLevel] = 0;
						SetPlayerToTeamColor(giveplayerid);
						SetPlayerWantedLevel(giveplayerid, 0);
						ClearCrimes(giveplayerid, playerid);
						
						PlayerInfo[giveplayerid][pWantedJailFine] = 0;
						PlayerInfo[giveplayerid][pWantedJailTime] = 0;
					}
					else
					{
						SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
					}
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You don't have sufficient clearance to do this");
		}
		case DIALOG_LISTGROUPS: if(response) {
			if (PlayerInfo[playerid][pAdmin] < 1337 && !PlayerInfo[playerid][pFactionModerator]) return 1;
			SetPVarInt(playerid, "Group_EditID", listitem);
			return Group_DisplayDialog(playerid, listitem);
		}
		case DIALOG_EDITGROUP: {
			if (PlayerInfo[playerid][pAdmin] < 1337 && !PlayerInfo[playerid][pFactionModerator]) return 1;
			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				szTitle[64 + GROUP_MAX_NAME_LEN];

			if(response) switch(listitem) {
				case 0: {
					format(szTitle, sizeof szTitle, "Edit Group Name {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_NAME, DIALOG_STYLE_INPUT, szTitle, "Specify a name for this group.", "Confirm", "Cancel");
				}
				case 1: {

					new
						szDialog[(32 + 2) * MAX_GROUP_TYPES];

					for(new i = 0; i != MAX_GROUP_TYPES; ++i)
						strcat(szDialog, "\n"), strcat(szDialog, Group_ReturnType(i));

					format(szTitle, sizeof szTitle, "Edit Group Type {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_TYPE, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 2: {

					new
						szDialog[(32 + 2) * MAX_GROUP_TYPES];

					for(new i = 0; i < MAX_GROUP_ALLEGIANCES; ++i)
						strcat(szDialog, "\n"), strcat(szDialog, Group_ReturnAllegiance(i));

					format(szTitle, sizeof szTitle, "Edit Group Allegiance {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_ALLEGIANCE, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 3:
				{
					if(arrGroupData[iGroupID][g_iJCount] == 0)
					{
						format(string, sizeof(string), "%s doesn't have any jurisdiction. Add it via /groupaddjurisdiction", arrGroupData[iGroupID][g_szGroupName]);
						SendClientMessage(playerid, COLOR_GRAD2, string);
						return Group_DisplayDialog(playerid, iGroupID);
					}
					else
					{
						new szDialog[2500];

						for(new i; i < arrGroupData[iGroupID][g_iJCount]; ++i)
						{
							strcat(szDialog, "\n"), strcat(szDialog, arrGroupJurisdictions[iGroupID][i][g_iAreaName]);
						}

						format(szTitle, sizeof szTitle, "Edit Group Jurisdiction {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
						ShowPlayerDialog(playerid, DIALOG_GROUP_JURISDICTION_LIST, DIALOG_STYLE_LIST, szTitle, szDialog, "Remove", "Go Back");
					}
				}
				case 4: {
					format(szTitle, sizeof szTitle, "Edit Group Duty Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_DUTYCOL, DIALOG_STYLE_INPUT, szTitle, "Enter a colour in hexadecimal format (for example, BCA3FF). This colour will be used to identify the group (i.e. name tag colour).", "Confirm", "Cancel");
				}
				case 5: {
					format(szTitle, sizeof szTitle, "Edit Group Radio Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_RADIOCOL, DIALOG_STYLE_INPUT, szTitle, "Enter a colour in hexadecimal format (for example, BCA3FF). This colour will be used for the group's in-character radio chat.", "Confirm", "Cancel");
				}
				case 6 .. 18: {

					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					strmid(szTitle, inputtext, 0, strfind(inputtext, ":", true));
					format(szTitle, sizeof szTitle, "Edit Group %s", szTitle);
					ShowPlayerDialog(playerid, DIALOG_GROUP_RADIOACC + (listitem - 6), DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 19: {
					format(szTitle, sizeof szTitle, "Edit Group Locker Stock {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_EDITSTOCK, DIALOG_STYLE_INPUT, szTitle, "Specify a value. Locker stock is used for weapons, and can be replenished using crates.", "Confirm", "Cancel");
				}
				case 20: {

					new
						szDialog[(32 + 8) * MAX_GROUP_WEAPONS];

					for(new i = 0; i != MAX_GROUP_WEAPONS; ++i) {
						if(arrGroupData[iGroupID][g_iLockerGuns][i]) format(szDialog, sizeof szDialog, "%s\n(%i) %s (cost: %i)", szDialog, arrGroupData[iGroupID][g_iLockerGuns][i], Weapon_ReturnName(arrGroupData[iGroupID][g_iLockerGuns][i]), arrGroupData[iGroupID][g_iLockerCost][i]);
						else strcat(szDialog, "\n(empty)");
					}

					format(szTitle, sizeof szTitle, "Edit Group Weapons {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_EDITWEPS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 21: {

					new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
						format(szDialog, sizeof szDialog, "%s\nRank %i (%s):    $%s", szDialog, i, arrGroupRanks[iGroupID][i], number_format(arrGroupData[iGroupID][g_iPaycheck][i]));
					}

					format(szTitle, sizeof szTitle, "Edit Group Paychecks {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_LISTPAY, DIALOG_STYLE_LIST, szTitle, szDialog, "Edit", "Cancel");
				}
				case 22: {

					new
						szDialog[(GROUP_MAX_DIV_LEN + 8) * MAX_GROUP_DIVS];

					for(new i = 0; i != MAX_GROUP_DIVS; ++i) {
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i + 1, ((arrGroupDivisions[iGroupID][i][0]) ? (arrGroupDivisions[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));
					}

					format(szTitle, sizeof szTitle, "Edit Group Divisions {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_EDITDIVS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 23: {

					new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));
					}

					format(szTitle, sizeof szTitle, "Edit Group Ranks {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_EDITRANKS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 24: {

					new
						szDialog[MAX_GROUP_LOCKERS * 32];

					for(new i = 0; i < MAX_GROUP_LOCKERS; ++i) {
						format(szDialog, sizeof szDialog, "%s%Locker %d %s ID:%d\n", szDialog, i+1, ( arrGroupLockers[iGroupID][i][g_fLockerPos][0] != 0.0 ) ? ("(edit)") : ("(undefined)"), arrGroupLockers[iGroupID][i]);
					}
					strcat(szDialog, "Delete All Lockers");
					format(szTitle, sizeof szTitle, "Edit Group Lockers {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_LOCKERS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 25: {
					format(szTitle, sizeof szTitle, "Edit Group Crate Delivery Position {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_CRATEPOS, DIALOG_STYLE_MSGBOX, szTitle, "Are you sure you want to move the crate delivery to your position?\n\nIf not, cancel and move to your desired location.", "Cancel", "Confirm");
				}
				case 26: {
					format(szTitle, sizeof szTitle, "Edit Group Locker Cost Type {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_COSTTYPE, DIALOG_STYLE_LIST, szTitle, "Locker Stock\nGroup Budget\nPlayer Money", "OK", "Cancel");
				}
				case 27: {
					format(szTitle, sizeof szTitle, "Edit the Garage Position {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_GARAGEPOS, DIALOG_STYLE_MSGBOX, szTitle, "Please click on 'Confirm' to change the garage location to your current position.\n\nIf you do not wish to move it to your position, click on 'Cancel'.", "Cancel", "Confirm");
				}
				case 28: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group Tackle Access");
					ShowPlayerDialog(playerid, DIALOG_GROUP_TACKLEACCESS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 29: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group Wheel Clamps Access {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_WHEELCLAMPS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 30: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group DoC Access {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_DOCACCESS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 31: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group Medic Access {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_MEDICACCESS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 32: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group DMV Access {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_DMVACCESS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 33: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group OOC Chat Access {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_OOCCHAT, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 34: {
					format(szTitle, sizeof szTitle, "Edit Group OOC Chat Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_OOCCOLOR, DIALOG_STYLE_INPUT, szTitle, "Enter a color in hexadecimal format (for example, BCA3FF). This color will be that of their OOC Chat.", "Confirm", "Cancel");
				}
				case 35: {
					new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
						format(szDialog, sizeof szDialog, "%s\nRank %i (%s): Skin ID:%i", szDialog, i, arrGroupRanks[iGroupID][i], arrGroupData[iGroupID][g_iClothes][i]);
					}

					format(szTitle, sizeof szTitle, "Edit Group Clothes {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_LISTCLOTHES, DIALOG_STYLE_LIST, szTitle, szDialog, "Edit", "Cancel");
				}
				case 36: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group Turf Cap Rank {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					
					ShowPlayerDialog(playerid, DIALOG_GROUP_TURFCAP, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 37: {
					new
						szDialog[((32 + 5) * MAX_GROUP_RANKS) + 24];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i)
						format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));

					strcat(szDialog, "\nRevoke from Group");

					format(szTitle, sizeof szTitle, "Edit Group Point Cap Rank {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_POINTCAP, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				default: {
					format(szTitle, sizeof szTitle, "{FF0000}Disband Group{FFFFFF} {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_GROUP_DISBAND, DIALOG_STYLE_MSGBOX, szTitle, "{FFFFFF}Are you absolutely sure you wish to {FF0000}disband this group?{FFFFFF}\n\n\
					This action will {FF0000}delete all group data and remove all members and leaders{FFFFFF} from the group, whether online or offline.", "Cancel", "Confirm");
				}
			}
			else if(GetPVarType(playerid, "Group_EditID")) { // They've made changes to a group setting - save it on exit!
				SaveGroup(GetPVarInt(playerid, "Group_EditID"));
				DeletePVar(playerid, "Group_EditID");
				return Group_ListGroups(playerid);
			}
		}
		case DIALOG_GROUP_NAME: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				if(!(2 < strlen(inputtext) < GROUP_MAX_NAME_LEN)) {
					format(szTitle, sizeof szTitle, "Edit Group {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_NAME, DIALOG_STYLE_INPUT, szTitle, "The specified name must be between 2 and "#GROUP_MAX_NAME_LEN" characters.\n\nSpecify a name for this group.", "Confirm", "Cancel");
				}
				format(string, sizeof(string), "%s has changed group %d's name from %s to %s", GetPlayerNameEx(playerid), iGroupID+1, arrGroupData[iGroupID][g_szGroupName], inputtext);
				Log("logs/editgroup.log", string);
				strcpy(arrGroupData[iGroupID][g_szGroupName], inputtext, GROUP_MAX_NAME_LEN);
			}
			return Group_DisplayDialog(playerid, GetPVarInt(playerid, "Group_EditID"));
		}
		case DIALOG_GROUP_TYPE: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				arrGroupData[iGroupID][g_iGroupType] = listitem;

				format(string, sizeof(string), "%s has changed group %d's type to %s", GetPlayerNameEx(playerid), iGroupID+1, Group_ReturnType(arrGroupData[iGroupID][g_iGroupType]));
				Log("logs/editgroup.log", string);

			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_ALLEGIANCE: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) arrGroupData[iGroupID][g_iAllegiance] = listitem;

			format(string, sizeof(string), "%s has changed group %d's allegiance to %s", GetPlayerNameEx(playerid), iGroupID+1, Group_ReturnAllegiance(arrGroupData[iGroupID][g_iAllegiance]));
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_JURISDICTION_LIST: {
			new iGroupID = GetPVarInt(playerid, "Group_EditID");
			if(response)
			{
				new szTitle[128], szDialog[128];
				format(szTitle, sizeof(szTitle), "%s's Jurisdiction", arrGroupData[iGroupID][g_szGroupName]);
				format(szDialog, sizeof(szDialog), "Are you sure you want to remove %s from the %s?", arrGroupJurisdictions[iGroupID][listitem][g_iAreaName], arrGroupData[iGroupID][g_szGroupName]);
				SetPVarInt(playerid, "JurisdictionRemoval", listitem);
				return ShowPlayerDialog(playerid, DIALOG_GROUP_JURISDICTION_REMOVE, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Confirm", "Cancel");
			}
			else return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_JURISDICTION_REMOVE: {
			new iGroupID = GetPVarInt(playerid, "Group_EditID");
			if(response)
			{
				new jurisdictionid = GetPVarInt(playerid, "JurisdictionRemoval");
				format(string, sizeof(string), "DELETE FROM `jurisdictions` WHERE `id` = %i", arrGroupJurisdictions[iGroupID][jurisdictionid][g_iJurisdictionSQLId]);
				mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
				mysql_function_query(MainPipeline, "SELECT * FROM `jurisdictions`", true, "Group_QueryFinish", "ii", GROUP_QUERY_JURISDICTIONS, 0);
				format(string, sizeof(string), "You have successfully removed %s from %s.", arrGroupJurisdictions[iGroupID][jurisdictionid][g_iAreaName], arrGroupData[iGroupID][g_szGroupName]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string, sizeof(string), "%s has removed %s from group %d's jurisdictions.", GetPlayerNameEx(playerid), arrGroupJurisdictions[iGroupID][jurisdictionid][g_iAreaName], iGroupID+1);
				Log("logs/editgroup.log", string);
			}
			DeletePVar(playerid, "JurisdictionRemoval");
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_RADIOACC: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iRadioAccess] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iRadioAccess] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for radio (/r) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iRadioAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iRadioAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_DEPTRADIOACC: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iDeptRadioAccess] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iDeptRadioAccess] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for dept radio (/dept) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iDeptRadioAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iDeptRadioAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_INTRADIOACC: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iIntRadioAccess] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iIntRadioAccess] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for int radio (/int) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iIntRadioAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iIntRadioAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_BUGACC: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iBugAccess] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iBugAccess] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for bug access (/bug) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iBugAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iBugAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_GOVACC: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iGovAccess] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iGovAccess] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for government announcement (/gov) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iGovAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iGovAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_FREENC: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iFreeNameChange] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iFreeNameChange] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for free name changes to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iFreeNameChange], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iFreeNameChange]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}

		case DIALOG_GROUP_SPIKES: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iSpikeStrips] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iSpikeStrips] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for spikes (/deploy spikes) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iSpikeStrips], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iSpikeStrips]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}

		case DIALOG_GROUP_CADES: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iBarricades] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iBarricades] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for cades (/deploy cades) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iBarricades], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iBarricades]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}

		case DIALOG_GROUP_CONES: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iCones] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iCones] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for cones (/deploy cone) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iCones], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iCones]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}

		case DIALOG_GROUP_FLARES: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iFlares] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iFlares] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for flares (/deploy flares) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iFlares], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iFlares]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}

		case DIALOG_GROUP_BARRELS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iBarrels] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iBarrels] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for barrels (/deploy barrel) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iBarrels], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iBarrels]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		
		case DIALOG_GROUP_LADDERS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iLadders] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iLadders] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for ladders (/deploy ladder) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iLadders], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iLadders]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_CRATE: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iCrateIsland] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iCrateIsland] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for Crate Island Control to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iCrateIsland], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iCrateIsland]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_DUTYCOL: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN],
					hColour;

				if(strlen(inputtext) > 6 || !ishex(inputtext)) {
					format(szTitle, sizeof szTitle, "Edit Group Duty Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_DUTYCOL, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nEnter a colour in hexadecimal format (for example, BCA3FF). This colour will be used to identify the group.", "Confirm", "Cancel");
				}
				sscanf(inputtext, "h", hColour);
				if (hColour == 0xFFFFFF) {
					format(szTitle, sizeof szTitle, "Edit Group Duty Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_DUTYCOL, DIALOG_STYLE_INPUT, szTitle, "You cannot use white as the value.\n\nEnter a colour in hexadecimal format (for example, BCA3FF). This colour will be used to identify the group.", "Confirm", "Cancel");
				}
				arrGroupData[iGroupID][g_hDutyColour] = hColour;
				foreach(new i: Player)
				{
					if (PlayerInfo[i][pMember] == iGroupID) SetPlayerToTeamColor(i);
				}

				format(string, sizeof(string), "%s has set the duty color to %x in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_hDutyColour], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);

			}

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_RADIOCOL: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN],
					hColour;

				if(strlen(inputtext) > 6 || !ishex(inputtext)) {
					format(szTitle, sizeof szTitle, "Edit Group Radio Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_RADIOCOL, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nEnter a colour in hexadecimal format (for example, BCA3FF). This colour will be used for the group's in-character radio chat.", "Confirm", "Cancel");
				}
				sscanf(inputtext, "h", hColour);
				arrGroupData[iGroupID][g_hRadioColour] = hColour;

				format(string, sizeof(string), "%s has set the radio color to %x in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_hRadioColour], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);

			}

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITSTOCK: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN],
					iValue = strval(inputtext);

				if(isnull(inputtext) || iValue <= -1) {
					format(szTitle, sizeof szTitle, "Edit Group Locker Stock {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITSTOCK, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nSpecify a value. Locker stock is used for weapons, and can be replenished using crates.", "Confirm", "Cancel");
				}
				arrGroupData[iGroupID][g_iLockerStock] = iValue;

				format(string, sizeof(string), "%s has set the locker stock to %d in %s (%d)", GetPlayerNameEx(playerid), strval(inputtext), arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);

			}

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITWEPS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				szTitle[32 + GROUP_MAX_NAME_LEN];

			if(response) {
				SetPVarInt(playerid, "Group_EditWep", listitem);
				format(szTitle, sizeof szTitle, "Edit Group Weapon (%i) {%s}(%s)", listitem + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITWEPID, DIALOG_STYLE_INPUT, szTitle, "Specify a weapon ID (zero to remove this weapon).", "Select", "Cancel");
			}
			else return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITWEPID: {

			new
				szTitle[32 + GROUP_MAX_NAME_LEN],
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				iWepID = GetPVarInt(playerid, "Group_EditWep");

			format(szTitle, sizeof szTitle, "Edit Group Weapon (%i) {%s}(%s)", iWepID + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
			if(response) {

				new
					iValue = strval(inputtext);

				if(isnull(inputtext) || !(0 <= iValue <= 46)) {
					return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITWEPID, DIALOG_STYLE_INPUT, szTitle, "Invalid weapon specified.\n\nSpecify a weapon ID (zero to remove this weapon).", "Select", "Cancel");
				}

				for (new i; i < MAX_GROUP_WEAPONS; i++) {
					if (arrGroupData[iGroupID][g_iLockerGuns][i] == iValue && iValue != 0)
					return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITWEPID, DIALOG_STYLE_INPUT, szTitle, "This weapon already exists in the locker.\n\nSpecify a weapon ID (zero to remove this weapon).", "Select", "Cancel");
				}

				arrGroupData[iGroupID][g_iLockerGuns][iWepID] = iValue;

				format(string, sizeof(string), "%s has changed the locker weapon (slot %d) to %d (%s) in %s (%d)", GetPlayerNameEx(playerid), iWepID, iValue, Weapon_ReturnName(iValue), arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);

				if(iValue >= 1) {
					return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITCOST, DIALOG_STYLE_INPUT, szTitle, "Specify an (optional) cost for this weapon. This value will be charged in locker stock (or cash, where specified).", "Select", "Back");
				}
			}

			new
				szDialog[(32 + 8) * MAX_GROUP_WEAPONS];

			arrGroupData[iGroupID][g_iLockerCost][iWepID] = 0;
			for(new i = 0; i != MAX_GROUP_WEAPONS; ++i) {
				if(arrGroupData[iGroupID][g_iLockerGuns][i]) format(szDialog, sizeof szDialog, "%s\n(%i) %s (cost: %i)", szDialog, arrGroupData[iGroupID][g_iLockerGuns][i], Weapon_ReturnName(arrGroupData[iGroupID][g_iLockerGuns][i]), arrGroupData[iGroupID][g_iLockerCost][i]);
				else strcat(szDialog, "\n(empty)");
			}
			DeletePVar(playerid, "Group_EditWep");
			format(szTitle, sizeof szTitle, "Edit Group Weapons {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
			return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITWEPS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
		}
		case DIALOG_GROUP_EDITCOST: {

			new
				szTitle[32 + GROUP_MAX_NAME_LEN],
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				iWepID = GetPVarInt(playerid, "Group_EditWep");

			DeletePVar(playerid, "Group_EditWep");

			if(response) {

				new
					iValue = strval(inputtext);

				if(isnull(inputtext) || iValue <= -1) {
					format(szTitle, sizeof szTitle, "Edit Group Weapon (%i) {%s}(%s)", iWepID + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITCOST, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nSpecify an (optional) cost for this weapon. This value will be charged in locker stock (or cash, where specified).", "Select", "Back");
				}
				arrGroupData[iGroupID][g_iLockerCost][iWepID] = iValue;

				format(string, sizeof(string), "%s has changed the weapon cost to %d in %s (%d)", GetPlayerNameEx(playerid), strval(inputtext));
				Log("logs/editgroup.log", string);

			}

			new
				szDialog[(32 + 8) * MAX_GROUP_WEAPONS];

			for(new i = 0; i != MAX_GROUP_WEAPONS; ++i) {
				if(arrGroupData[iGroupID][g_iLockerGuns][i]) format(szDialog, sizeof szDialog, "%s\n(%i) %s (cost: %i)", szDialog, arrGroupData[iGroupID][g_iLockerGuns][i], Weapon_ReturnName(arrGroupData[iGroupID][g_iLockerGuns][i]), arrGroupData[iGroupID][g_iLockerCost][i]);
				else strcat(szDialog, "\n(empty)");
			}
			format(szTitle, sizeof szTitle, "Edit Group Weapons {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
			return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITWEPS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
		}
		case DIALOG_GROUP_EDITDIVS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				SetPVarInt(playerid, "Group_EditDiv", listitem);
				format(szTitle, sizeof szTitle, "Edit Group Division (%i) {%s}(%s)", listitem + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITDIV, DIALOG_STYLE_INPUT, szTitle, "Specify a division name (or none to disable it).", "Confirm", "Cancel");
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITDIV: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				iDivID = GetPVarInt(playerid, "Group_EditDiv"),
				szTitle[32 + GROUP_MAX_NAME_LEN];

			if(response) {
				if(strlen(inputtext) >= GROUP_MAX_DIV_LEN) {
					format(szTitle, sizeof szTitle, "Edit Group Division (%i) {%s}(%s)", iDivID + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITDIV, DIALOG_STYLE_INPUT, szTitle, "The specified name must be less than "#GROUP_MAX_DIV_LEN" characters in length.\n\nSpecify a division name (or none to disable it).", "Confirm", "Cancel");
				}
				arrGroupDivisions[iGroupID][iDivID][0] = 0;
				if(!isnull(inputtext)) mysql_escape_string(inputtext, arrGroupDivisions[iGroupID][iDivID]);
			}

			new
				szDialog[(GROUP_MAX_DIV_LEN + 8) * MAX_GROUP_DIVS];

			for(new i = 0; i != MAX_GROUP_DIVS; ++i) {
				format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i + 1, ((arrGroupDivisions[iGroupID][i][0]) ? (arrGroupDivisions[iGroupID][i]) : ("{AAAAAA}(undefined){FFFFFF}")));
			}

			format(szTitle, sizeof szTitle, "Edit Group Divisions {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
			ShowPlayerDialog(playerid, DIALOG_GROUP_EDITDIVS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
			DeletePVar(playerid, "Group_EditDiv");
		}
		case DIALOG_GROUP_LOCKERS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				szTitle[32 + GROUP_MAX_NAME_LEN];

			if(response)
			{
				format(szTitle, sizeof szTitle, "Edit Group Locker Position {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				if (listitem == MAX_GROUP_LOCKERS)
				{
					ShowPlayerDialog(playerid, DIALOG_GROUP_LOCKERDELETECONF, DIALOG_STYLE_MSGBOX, szTitle, "{FFFFFF}Are you sure you want to delete ALL of the lockers for this group?", "Cancel", "Confirm");
					return 1;
				}
				else
				{
					SetPVarInt(playerid, "Group_EditLocker", listitem);
					ShowPlayerDialog(playerid, DIALOG_GROUP_LOCKERACTION, DIALOG_STYLE_LIST, szTitle, "Move Locker (to your current position)\nDelete Locker", "Select", "Cancel");
					return 1;
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_LOCKERACTION: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				iLocker = GetPVarInt(playerid, "Group_EditLocker");

			if(response)
			{
				if (listitem == 0)
				{
					GetPlayerPos(playerid, arrGroupLockers[iGroupID][iLocker][g_fLockerPos][0], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][1], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][2]);
					arrGroupLockers[iGroupID][iLocker][g_iLockerVW] = GetPlayerVirtualWorld(playerid);
					DestroyDynamic3DTextLabel(arrGroupLockers[iGroupID][iLocker][g_tLocker3DLabel]);
					new szResult[128];
					format(szResult, sizeof szResult, "%s Locker\n{1FBDFF}/locker{FFFF00} to use\n ID: %i", arrGroupData[iGroupID][g_szGroupName], arrGroupLockers[iGroupID][iLocker]);
					arrGroupLockers[iGroupID][iLocker][g_tLocker3DLabel] = CreateDynamic3DTextLabel(szResult, arrGroupData[iGroupID][g_hDutyColour] * 256 + 0xFF, arrGroupLockers[iGroupID][iLocker][g_fLockerPos][0], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][1], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][2], 15.0, .testlos = 1, .worldid = arrGroupLockers[iGroupID][iLocker][g_iLockerVW]);
				}
				else if (listitem == 1)
				{
					arrGroupLockers[iGroupID][iLocker][g_fLockerPos][0] = 0;
					arrGroupLockers[iGroupID][iLocker][g_fLockerPos][1] = 0;
					arrGroupLockers[iGroupID][iLocker][g_fLockerPos][2] = 0;
					arrGroupLockers[iGroupID][iLocker][g_iLockerVW] = 0;
					DestroyDynamic3DTextLabel(arrGroupLockers[iGroupID][iLocker][g_tLocker3DLabel]);
					format(string, sizeof(string), "You have deleted locker %d of %s", iLocker, arrGroupData[iGroupID][g_szGroupName]);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_LISTPAY: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				SetPVarInt(playerid, "Group_EditRank", listitem);
				format(szTitle, sizeof szTitle, "Edit Group Rank (%i) {%s}(%s)", listitem, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITPAY, DIALOG_STYLE_INPUT, szTitle, "Specify a paycheck amount for this rank.", "OK", "Cancel");
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITPAY: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				iRankID = GetPVarInt(playerid, "Group_EditRank");

			if(response) {
				new szTitle[128];
				arrGroupData[iGroupID][g_iPaycheck][iRankID] = strval(inputtext);
				new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

				for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
					format(szDialog, sizeof szDialog, "%s\nRank %i (%s):    $%s", szDialog, i, arrGroupRanks[iGroupID][i], number_format(arrGroupData[iGroupID][g_iPaycheck][i]));
				}

				format(szTitle, sizeof szTitle, "Edit Group Paychecks {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				ShowPlayerDialog(playerid, DIALOG_GROUP_LISTPAY, DIALOG_STYLE_LIST, szTitle, szDialog, "Edit", "Cancel");
				format(string, sizeof(string), "%s has changed the paycheck for rank %d (%s) to $%d in %s (%d)", GetPlayerNameEx(playerid), iRankID, arrGroupRanks[iGroupID][iRankID], strval(inputtext), iGroupID + 1);
				Log("logs/editgroup.log", string);
				return 1;
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITRANKS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				SetPVarInt(playerid, "Group_EditRank", listitem);
				format(szTitle, sizeof szTitle, "Edit Group Rank (%i) {%s}(%s)", listitem + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITRANK, DIALOG_STYLE_INPUT, szTitle, "Specify a rank name (or none to disable it).", "Confirm", "Cancel");
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITRANK: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				iRankID = GetPVarInt(playerid, "Group_EditRank"),
				szTitle[32 + GROUP_MAX_NAME_LEN];

			if(response) {
				if(strlen(inputtext) >= GROUP_MAX_RANK_LEN) {
					format(szTitle, sizeof szTitle, "Edit Group Rank (%i) {%s}(%s)", iRankID + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITRANK, DIALOG_STYLE_INPUT, szTitle, "The specified name must be less than "#GROUP_MAX_RANK_LEN" characters in length.\n\nSpecify a rank name (or none to disable it).", "Confirm", "Cancel");
				}
				arrGroupRanks[iGroupID][iRankID][0] = 0;
				if(!isnull(inputtext)) mysql_escape_string(inputtext, arrGroupRanks[iGroupID][iRankID]);
			}

			new
				szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

			for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
				format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i + 1, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));
			}

			format(szTitle, sizeof szTitle, "Edit Group Ranks {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
			ShowPlayerDialog(playerid, DIALOG_GROUP_EDITRANKS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
			DeletePVar(playerid, "Group_EditRank");
		}

		case DIALOG_GROUP_CRATEPOS: {
			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(!response) {

				new
					szText[64];

				GetPlayerPos(playerid, arrGroupData[iGroupID][g_fCratePos][0], arrGroupData[iGroupID][g_fCratePos][1], arrGroupData[iGroupID][g_fCratePos][2]);
				DestroyDynamic3DTextLabel(arrGroupData[iGroupID][g_tCrate3DLabel]);

				format(szText, sizeof szText, "%s Crate Delivery Point\n{1FBDFF}/delivercrate", arrGroupData[iGroupID][g_szGroupName]);
				arrGroupData[iGroupID][g_tCrate3DLabel] = CreateDynamic3DTextLabel(szText, arrGroupData[iGroupID][g_hDutyColour] * 256 + 0xFF, arrGroupData[iGroupID][g_fCratePos][0], arrGroupData[iGroupID][g_fCratePos][1], arrGroupData[iGroupID][g_fCratePos][2], 10.0, .testlos = 1, .streamdistance = 20.0);

				format(string, sizeof(string), "%s has changed the crate position to X:%f, Y:%f, Z:%f in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_fCratePos][0], arrGroupData[iGroupID][g_fCratePos][1], arrGroupData[iGroupID][g_fCratePos][2], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_COSTTYPE: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {
				format(string, sizeof(string), "%s has changed the locker cost type to %s in %s (%d)", GetPlayerNameEx(playerid), inputtext, arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);
				arrGroupData[iGroupID][g_iLockerCostType] = listitem;
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_DISBAND: {

			if(!response && PlayerInfo[playerid][pAdmin] >= 1337) {

				new
					iGroupID = GetPVarInt(playerid, "Group_EditID");
				format(string, sizeof(string), "%s has disbanded %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);
				Group_DisbandGroup(iGroupID);

			}
			return Group_ListGroups(playerid);
		}
		case DIALOG_GROUP_LOCKERDELETECONF: {

			if(!response) {

				new
					iGroupID = GetPVarInt(playerid, "Group_EditID");

				for (new i; i < MAX_GROUP_LOCKERS; i++)
				{
					arrGroupLockers[iGroupID][i][g_fLockerPos][0] = 0;
					arrGroupLockers[iGroupID][i][g_fLockerPos][1] = 0;
					arrGroupLockers[iGroupID][i][g_fLockerPos][2] = 0;
					DestroyDynamic3DTextLabel(arrGroupLockers[iGroupID][i][g_tLocker3DLabel]);
				}

				SendClientMessage(playerid, COLOR_WHITE, "You have deleted all lockers of this group.");
				format(string, sizeof(string), "%s has deleted all lockers of %s", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
				Log("logs/editgroup.log", string);

			}
			return Group_ListGroups(playerid);
		}
		case DIALOG_GROUP_JURISDICTION_ADD: {
			SetPVarInt(playerid, "Group_EditID", listitem);
			new iGroupID = GetPVarInt(playerid, "Group_EditID");
			if(response)
			{
				if(arrGroupData[iGroupID][g_iJCount] >= MAX_GROUP_JURISDICTIONS) return SendClientMessage(playerid, COLOR_GRAD2, "Error: Cannot add anymore jurisdictions.");
				new szTitle[128], szDialog[2500];

				for(new i = 0; i < 161; ++i)
				{
					strcat(szDialog, "\n"), strcat(szDialog, AreaName[i]);
				}

				format(szTitle, sizeof szTitle, "Add Group Jurisdiction {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				ShowPlayerDialog(playerid, DIALOG_GROUP_JURISDICTION_ADD2, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Go Back");
			}
			else return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_JURISDICTION_ADD2: {
			new iGroupID = GetPVarInt(playerid, "Group_EditID");
			if(response)
			{
				new query[256];
				format(query, sizeof(query), "INSERT INTO `jurisdictions` (`id`, `GroupID`, `JurisdictionID`, `AreaName`) VALUES (NULL, %d, %d, '%s')", iGroupID, listitem,AreaName[listitem]);
				mysql_function_query(MainPipeline, query, false, "OnQueryFinish", "i", SENDDATA_THREAD);
				mysql_function_query(MainPipeline, "SELECT * FROM `jurisdictions`", true, "Group_QueryFinish", "ii", GROUP_QUERY_JURISDICTIONS, 0);
				format(string, sizeof(string), "You have successfully assigned %s to %s.", AreaName[listitem], arrGroupData[iGroupID][g_szGroupName]);
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string, sizeof(string), "%s has assigned %s to %s", GetPlayerNameEx(playerid), AreaName[listitem], arrGroupData[iGroupID][g_szGroupName]);
				Log("logs/editgroup.log", string);
			}
			else return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_GARAGEPOS: {
			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(!response) {			
				GetPlayerPos(playerid, arrGroupData[iGroupID][g_fGaragePos][0], arrGroupData[iGroupID][g_fGaragePos][1], arrGroupData[iGroupID][g_fGaragePos][2]);		
				SendClientMessageEx(playerid, COLOR_WHITE, "You've changed the garage position to your current location.");
				format(string, sizeof(string), "%s has changed the garage position to X:%f, Y:%f, Z:%f in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_fGaragePos][0], arrGroupData[iGroupID][g_fGaragePos][1], arrGroupData[iGroupID][g_fGaragePos][2], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}	
		case DIALOG_GROUP_TACKLEACCESS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: arrGroupData[iGroupID][g_iTackleAccess] = INVALID_RANK;
				default: arrGroupData[iGroupID][g_iTackleAccess] = listitem;
			}

			format(string, sizeof(string), "%s has set the minimum rank for tackle (/tackle) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iTackleAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iTackleAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/editgroup.log", string);

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_WHEELCLAMPS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: {
					arrGroupData[iGroupID][g_iWheelClamps] = INVALID_RANK;
					format(string, sizeof(string), "%s has set the minimum rank for wheel clamps (/wheelclamp) to %d (Disabled) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iWheelClamps], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
				default: {
					arrGroupData[iGroupID][g_iWheelClamps] = listitem;
					format(string, sizeof(string), "%s has set the minimum rank for wheel clamps (/wheelclamp) to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iWheelClamps], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iWheelClamps]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
			}

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_DOCACCESS: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: {
					arrGroupData[iGroupID][g_iDoCAccess] = INVALID_RANK;
					format(string, sizeof(string), "%s has set the minimum rank for DoC Access to %d (Disabled) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iDoCAccess], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
				default: {
					arrGroupData[iGroupID][g_iDoCAccess] = listitem;
					format(string, sizeof(string), "%s has set the minimum rank for DoC Access to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iDoCAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iDoCAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_MEDICACCESS: {
			
			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: {
					arrGroupData[iGroupID][g_iMedicAccess] = INVALID_RANK;
					format(string, sizeof(string), "%s has set the minimum rank for Medic Access to %d (Disabled) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iMedicAccess], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
				default: {
					arrGroupData[iGroupID][g_iMedicAccess] = listitem;
					format(string, sizeof(string), "%s has set the minimum rank for Medic Access to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iMedicAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iMedicAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_DMVACCESS: {
			
			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: {
					arrGroupData[iGroupID][g_iDMVAccess] = INVALID_RANK;
					format(string, sizeof(string), "%s has set the minimum rank for DMV Access to %d (Disabled) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iDMVAccess], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
				default: {
					arrGroupData[iGroupID][g_iDMVAccess] = listitem;
					format(string, sizeof(string), "%s has set the minimum rank for DMV Access to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iDMVAccess], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iDMVAccess]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_OOCCHAT: {

			new 
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: {
					arrGroupData[iGroupID][g_iOOCChat] = INVALID_RANK;
					format(string, sizeof(string), "%s has set the minimum rank for OOC Chat Access to %d (Disabled) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iOOCChat], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
				default: {
					arrGroupData[iGroupID][g_iOOCChat] = listitem;
					format(string, sizeof(string), "%s has set the minimum rank for OOC Chat Access to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iOOCChat], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iOOCChat]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_OOCCOLOR: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN],
					hColour;

				if(strlen(inputtext) > 6 || !ishex(inputtext)) {
					format(szTitle, sizeof szTitle, "Edit Group OOC Chat Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialog(playerid, DIALOG_GROUP_RADIOCOL, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nEnter a color in hexadecimal format (for example, BCA3FF). This color will be that of their OOC Chat.", "Confirm", "Cancel");
				}
				sscanf(inputtext, "h", hColour);
				arrGroupData[iGroupID][g_hOOCColor] = hColour;

				format(string, sizeof(string), "%s has set the OOC Chat color to %x in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_hOOCColor], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgroup.log", string);
			}

			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_LISTCLOTHES: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				SetPVarInt(playerid, "Group_EditRank", listitem);
				format(szTitle, sizeof szTitle, "Edit Group Rank (%i) {%s}(%s)", listitem, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialog(playerid, DIALOG_GROUP_EDITCLOTHES, DIALOG_STYLE_INPUT, szTitle, "Specify a skin ID for this rank.", "OK", "Cancel");
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_EDITCLOTHES: {

			new
				iGroupID = GetPVarInt(playerid, "Group_EditID"),
				iRankID = GetPVarInt(playerid, "Group_EditRank");

			if(response) {
				new szTitle[128];
				arrGroupData[iGroupID][g_iClothes][iRankID] = strval(inputtext);
				new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

				for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
						format(szDialog, sizeof szDialog, "%s\nRank %i (%s): Skin ID:%i", szDialog, i, arrGroupRanks[iGroupID][i], arrGroupData[iGroupID][g_iClothes][i]);
				}

				format(szTitle, sizeof szTitle, "Edit Group Clothes {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				ShowPlayerDialog(playerid, DIALOG_GROUP_LISTCLOTHES, DIALOG_STYLE_LIST, szTitle, szDialog, "Edit", "Cancel");
				format(string, sizeof(string), "%s has changed the skin ID for rank %d (%s) to $%d in %s (%d)", GetPlayerNameEx(playerid), iRankID, arrGroupRanks[iGroupID][iRankID], strval(inputtext), iGroupID + 1);
				Log("logs/editgroup.log", string);

				return 1;
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_TURFCAP: {

			new 
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: {
					arrGroupData[iGroupID][g_iTurfCapRank] = INVALID_RANK;
					format(string, sizeof(string), "%s has set the minimum rank for turf capping to %d (Disabled) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iTurfCapRank], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
				default: {
					arrGroupData[iGroupID][g_iTurfCapRank] = listitem;
					format(string, sizeof(string), "%s has set the minimum rank for turf capping to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iTurfCapRank], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iTurfCapRank]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_POINTCAP: {

			new 
				iGroupID = GetPVarInt(playerid, "Group_EditID");

			if(response) switch(listitem) {
				case MAX_GROUP_RANKS: {
					arrGroupData[iGroupID][g_iPointCapRank] = INVALID_RANK;
					format(string, sizeof(string), "%s has set the minimum rank for point capping to %d (Disabled) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iPointCapRank], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
				default: {
					arrGroupData[iGroupID][g_iPointCapRank] = listitem;
					format(string, sizeof(string), "%s has set the minimum rank for point capping to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iPointCapRank], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iPointCapRank]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
					Log("logs/editgroup.log", string);
				}
			}
			return Group_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GROUP_SACTIONTYPE:
		{
			if(!response)
			{
				return cmd_locker(playerid, "");
			}
			switch(listitem)
			{
				case 0:
				{
					SetPVarInt(playerid, "GSafe_Action", 1);
					format(szMiscArray, sizeof(szMiscArray), "Please type an ammount to deposit.");
				}
				case 1:
				{
					if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iWithdrawRank])
					{
						SetPVarInt(playerid, "GSafe_Action", 2);
						format(szMiscArray, sizeof(szMiscArray), "Please type an ammount to withdraw.");
					}
					else 
					{
						DeletePVar(playerid, "GSafe_Opt");
						return SendClientMessageEx(playerid, COLOR_GREY, "You are not authorized to withdraw from the locker.");
					}
					
				}
			}
			return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", szMiscArray, "Input", "Cancel");
		}
		case DIALOG_GROUP_SACTIONEXEC:
		{
			new iGroupID = PlayerInfo[playerid][pMember];
			if(!response)
			{
				DeletePVar(playerid, "GSafe_Action");
				DeletePVar(playerid, "GSafe_Opt");
				return cmd_locker(playerid, "");
			}
			if(response)
			{
				if(strval(inputtext) <= 0) return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount cannot be less than or 0.", "Input", "Cancel");
				switch(GetPVarInt(playerid, "GSafe_Opt"))
				{
					case 2:
					{
						switch(GetPVarInt(playerid, "GSafe_Action"))
						{
							case 1:
							{
								if(strval(inputtext) <= PlayerInfo[playerid][pPot])
								{
									arrGroupData[iGroupID][g_iPot] += strval(inputtext);
									PlayerInfo[playerid][pPot] -= strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has deposited %i grams of pot into the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have deposited %i grams of pot into the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that that you have on you.\nPlease input another amount.", "Input", "Cancel");
							}
							case 2:
							{
								if(strval(inputtext) <= arrGroupData[iGroupID][g_iPot])
								{
									arrGroupData[iGroupID][g_iPot] -= strval(inputtext);
									PlayerInfo[playerid][pPot] += strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn %i grams of pot from the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have withdrawn %i grams of pot from the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that in the safe.\nPlease input another amount.", "Input", "Cancel");
							}
						}
					}
					case 3:
					{
						switch(GetPVarInt(playerid, "GSafe_Action"))
						{
							case 1:
							{
								if(strval(inputtext) <= PlayerInfo[playerid][pCrack])
								{
									arrGroupData[iGroupID][g_iCrack] += strval(inputtext);
									PlayerInfo[playerid][pCrack] -= strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has deposited %i grams of crack into the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have deposited %i grams of crack into the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that that you have on you.\nPlease input another amount.", "Input", "Cancel");
							}
							case 2:
							{
								if(strval(inputtext) <= arrGroupData[iGroupID][g_iCrack])
								{
									arrGroupData[iGroupID][g_iCrack] -= strval(inputtext);
									PlayerInfo[playerid][pCrack] += strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn %i grams of crack from the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have withdrawn %i grams of crack from the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that in the safe.\nPlease input another amount.", "Input", "Cancel");
							}
						}
					}
					case 4:
					{
						switch(GetPVarInt(playerid, "GSafe_Action"))
						{
							case 1:
							{
								if(strval(inputtext) <= PlayerInfo[playerid][pHeroin])
								{
									arrGroupData[iGroupID][g_iHeroin] += strval(inputtext);
									PlayerInfo[playerid][pHeroin] -= strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has deposited %i grams of heroin into the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have deposited %i grams of heroin into the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that that you have on you.\nPlease input another amount.", "Input", "Cancel");
							}
							case 2:
							{
								if(strval(inputtext) <= arrGroupData[iGroupID][g_iHeroin])
								{
									arrGroupData[iGroupID][g_iHeroin] -= strval(inputtext);
									PlayerInfo[playerid][pHeroin] += strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn %i grams of heroin from the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have withdrawn %i grams of heroin from the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that in the safe.\nPlease input another amount.", "Input", "Cancel");
							}
						}
					}
					case 5:
					{
						switch(GetPVarInt(playerid, "GSafe_Action"))
						{
							case 1:
							{
								if(strval(inputtext) <= PlayerInfo[playerid][pSyringes])
								{
									arrGroupData[iGroupID][g_iSyringes] += strval(inputtext);
									PlayerInfo[playerid][pSyringes] -= strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has deposited %i syringes into the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have deposited %i syringes into the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that that you have on you.\nPlease input another amount.", "Input", "Cancel");
							}
							case 2:
							{
								if(strval(inputtext) <= arrGroupData[iGroupID][g_iSyringes])
								{
									arrGroupData[iGroupID][g_iSyringes] -= strval(inputtext);
									PlayerInfo[playerid][pSyringes] += strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn %i syringes from the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have withdrawn %i syringes from the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that in the safe.\nPlease input another amount.", "Input", "Cancel");
							}
						}
					}
					case 6:
					{
						switch(GetPVarInt(playerid, "GSafe_Action"))
						{
							case 1:
							{
								if(strval(inputtext) <= PlayerInfo[playerid][pRawOpium])
								{
									arrGroupData[iGroupID][g_iOpium] += strval(inputtext);
									PlayerInfo[playerid][pRawOpium] -= strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has deposited %i grams of opium into the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have deposited %i grams of opium into the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that that you have on you.\nPlease input another amount.", "Input", "Cancel");
							}
							case 2:
							{
								if(strval(inputtext) <= arrGroupData[iGroupID][g_iOpium])
								{
									arrGroupData[iGroupID][g_iOpium] -= strval(inputtext);
									PlayerInfo[playerid][pRawOpium] += strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn %i grams of opium from the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have withdrawn %i grams of opium from the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that in the safe.\nPlease input another amount.", "Input", "Cancel");
							}
						}
					}
					case 7:
					{
						switch(GetPVarInt(playerid, "GSafe_Action"))
						{
							case 1:
							{
								if(strval(inputtext) <= PlayerInfo[playerid][pMats])
								{
									arrGroupData[iGroupID][g_iMaterials] += strval(inputtext);
									PlayerInfo[playerid][pMats] -= strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has deposited %i materials into the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have deposited %i materials into the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that that you have on you.\nPlease input another amount.", "Input", "Cancel");
							}
							case 2:
							{
								if(strval(inputtext) <= arrGroupData[iGroupID][g_iMaterials])
								{
									arrGroupData[iGroupID][g_iMaterials] -= strval(inputtext);
									PlayerInfo[playerid][pMats] += strval(inputtext);
									format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn %i materials from the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have withdrawn %i materials from the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that in the safe.\nPlease input another amount.", "Input", "Cancel");
							}
						}
					}
					case 8:
					{
						new amount = strval(inputtext);
						switch(GetPVarInt(playerid, "GSafe_Action"))
						{
							case 1:
							{
								if(strval(inputtext) <= GetPlayerCash(playerid))
								{
									arrGroupData[iGroupID][g_iBudget] += strval(inputtext);
									GivePlayerCash( playerid, -amount);
									format(szMiscArray, sizeof(szMiscArray), "%s has deposited $%i into the safe.", GetPlayerNameEx(playerid), strval(inputtext));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have deposited $%i into the safe.", strval(inputtext));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONEXEC, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that that you have on you.\nPlease input another amount.", "Input", "Cancel");
							}
							case 2:
							{
								if(strval(inputtext) <= arrGroupData[iGroupID][g_iBudget])
								{
									new iMoney = strval(inputtext);
									arrGroupData[iGroupID][g_iBudget] -= iMoney;
									GivePlayerCash(playerid, amount);
									format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn $%s from the safe.", GetPlayerNameEx(playerid), number_format(iMoney));
									GroupLog(iGroupID, szMiscArray);
									format(szMiscArray, sizeof(szMiscArray), "You have withdrawn $%s from the safe.", number_format(iMoney));
									SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
									DeletePVar(playerid, "GSafe_Action");
									DeletePVar(playerid, "GSafe_Opt");
								}
								else return ShowPlayerDialog(playerid, DIALOG_GROUP_SACTIONTYPE, DIALOG_STYLE_INPUT, "Gang Safe", "The amount specified exceeds that in the safe.\nPlease input another amount.", "Input", "Cancel");
							}
						}
					}
				}
			}
		}
		case DIALOG_GROUP_WEAPONSAFE:
		{
			new iGroupID = PlayerInfo[playerid][pMember];
			if(response)
			{
				if(strcmp(inputtext, "Deposit Weapon", true) == 0)
				{
					// log + GVIP / Famed + check on weapons
					for(new g = 0; g < 12; g++)	
					{
						if(PlayerInfo[playerid][pGuns][g] != 0 && PlayerInfo[playerid][pAGuns][g] == 0)
						{
							format(szMiscArray, sizeof(szMiscArray), "%s\n%s(%i)", szMiscArray, Weapon_ReturnName(PlayerInfo[playerid][pGuns][g]), PlayerInfo[playerid][pGuns][g]);
						}
					}
					ShowPlayerDialog(playerid, DIALOG_GROUP_WEAPONSAFE_DEPOSIT, DIALOG_STYLE_LIST, "Safe Weapon Deposit", szMiscArray, "Deposit", "Cancel");

				}
				else if(arrGroupData[iGroupID][g_iWeapons][listitem] == 0)
				{
					return SendClientMessageEx(playerid, COLOR_GREY, "There is no weapon in the slot you have attempted to access."), cmd_locker(playerid, "");
				}
				else
				{
					if(PlayerInfo[playerid][pRank] >= arrGroupData[iGroupID][g_iWithdrawRank])
					{
						GivePlayerValidWeapon(playerid, arrGroupData[iGroupID][g_iWeapons][listitem], 60000);
						format(szMiscArray, sizeof(szMiscArray), "%s has withdrawn a %s from the locker.", GetPlayerNameEx(playerid), Weapon_ReturnName(arrGroupData[iGroupID][g_iWeapons][listitem]));
						GroupLog(iGroupID, szMiscArray);
						format(szMiscArray, sizeof(szMiscArray), "You have withdrawn a %s from the locker.", Weapon_ReturnName(arrGroupData[iGroupID][g_iWeapons][listitem]));
						SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
						arrGroupData[iGroupID][g_iWeapons][listitem] = 0;
					}
					else SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot withdraw weapons at your current rank.");
				}
			}
		}
		case DIALOG_GROUP_WEAPONSAFE_DEPOSIT:
		{
			new iGroupID = PlayerInfo[playerid][pMember];
			if(response)
			{
				new stpos = strfind(inputtext, "(");
			    new fpos = strfind(inputtext, ")");
			    new str[4], id;
			    strmid(str, inputtext, stpos+1, fpos);
			    id = strval(str);

			    // dont disallow VIPs / Famed + from depositing any weapon, just those they can obtain from the lockers
			    if((PlayerInfo[playerid][pDonateRank] >= 3 || PlayerInfo[playerid][pFamed] >= 3) && (id == WEAPON_DEAGLE || id == WEAPON_SILENCED || id == WEAPON_MP5 || id == WEAPON_SHOTGUN))
			    	return SendClientMessageEx(playerid, COLOR_WHITE, "You cannot deposit these weapons as you have obtained them from the VIP Safe.");

				
				// finding whether there are any free slots to deposit the weapons into
				new x = -1;
				for(new g = 0; g != 50; g++)
				{
					if(arrGroupData[iGroupID][g_iWeapons][g] == 0)
					{
						x = g;
						break;
					}
				}
				if(x == -1)
					return SendClientMessageEx(playerid, COLOR_WHITE, "There is no free space available to deposit your weapons.");

				else
				{
					arrGroupData[iGroupID][g_iWeapons][x] = id;
					PlayerInfo[playerid][pGuns][Weapon_ReturnSlot(id)] = 0;
					SetPlayerWeaponsEx(playerid);
					format(szMiscArray, sizeof(szMiscArray), "%s has deposited a %s into the locker.", GetPlayerNameEx(playerid), Weapon_ReturnName(id));
					GroupLog(iGroupID, szMiscArray);
					format(szMiscArray, sizeof(szMiscArray), "You have deposited a %s into the locker.", Weapon_ReturnName(id));
					SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
				}
			}
		}
		// END DYNAMIC GROUP CODE
	}
	
	return 1;
}

CMD:clearbugs(playerid, params[])
{
	if(IsACop(playerid))
	{
		if(PlayerInfo[playerid][pLeader] == PlayerInfo[playerid][pMember] && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBugAccess]) // has leader flag
		{
			SendClientMessageEx(playerid, COLOR_GRAD2, "All agency bugs destroyed.");
			foreach(new i : Player)
			{
				if(PlayerInfo[i][pBugged] == PlayerInfo[playerid][pMember]){
					PlayerInfo[i][pBugged] = INVALID_GROUP_ID;
				}
			}	
			new query[256];
			format(query, sizeof(query), "UPDATE accounts SET `Bugged` = %d WHERE `Bugged` > %d AND `Online` = 0", INVALID_GROUP_ID, INVALID_GROUP_ID);
			mysql_function_query(MainPipeline, query, false, "OnQueryFinish", "i", SENDDATA_THREAD);
			return 1;
		}
	}
	return SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized to use this command.");
}

CMD:listbugs(playerid, params[])
{
	if(IsACop(playerid))
	{
		if(PlayerInfo[playerid][pLeader] == PlayerInfo[playerid][pMember] && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBugAccess]) // has leader flag
		{
			SendClientMessageEx(playerid, COLOR_GREEN, "List of deployed Bugs:");
			foreach(new i : Player)
			{
				if(PlayerInfo[i][pBugged] == PlayerInfo[playerid][pMember]){
					SendClientMessageEx(playerid, COLOR_GREEN, GetPlayerNameEx(i));
				}
			}	
			new query[256];
			format(query, sizeof(query), "SELECT `Username`, `Bugged` FROM `accounts`  WHERE `Bugged` = %d AND `Online` = 0", PlayerInfo[playerid][pMember]);
			mysql_function_query(MainPipeline, query, true, "OnQueryFinish", "iii", BUG_LIST_THREAD, playerid, g_arrQueryHandle{playerid});
			return 1;
		}
	}
	return SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized to use this command.");
}

CMD:online(playerid, params[]) {
	if(PlayerInfo[playerid][pLeader] >= 0 || PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 1 || IsACriminal(playerid))
	{
		if(PlayerInfo[playerid][pMember] == INVALID_GROUP_ID) return SendClientMessageEx(playerid, -1, "You are not a member of any group!");
		new
			badge[11],
			szDialog[1024];

		foreach(new i: Player)
		{
			if(strcmp(PlayerInfo[i][pBadge], "None", true) != 0) format(badge, sizeof(badge), "[%s] ", PlayerInfo[i][pBadge]);
			else format(badge, sizeof(badge), "");
			if(IsATaxiDriver(playerid) && IsATaxiDriver(i)) switch(TransportDuty[i]) {
				case 1: format(szDialog, sizeof(szDialog), "%s\n* %s%s (on duty), %i calls accepted", szDialog, badge, GetPlayerNameEx(i), PlayerInfo[i][pCallsAccepted]);
				default: format(szDialog, sizeof(szDialog), "%s\n* %s%s (off duty), %i calls accepted", szDialog, badge, GetPlayerNameEx(i), PlayerInfo[i][pCallsAccepted]);
			}
			else if(IsAMedic(playerid) && IsAMedic(i) && (arrGroupData[PlayerInfo[playerid][pMember]][g_iAllegiance] == arrGroupData[PlayerInfo[i][pMember]][g_iAllegiance])) switch(PlayerInfo[i][pDuty]) {
				case 1: format(szDialog, sizeof(szDialog), "%s\n* %s%s (on duty), %i calls accepted, %i patients delivered.", szDialog, badge, GetPlayerNameEx(i), PlayerInfo[i][pCallsAccepted], PlayerInfo[i][pPatientsDelivered]);
				default: format(szDialog, sizeof(szDialog), "%s\n* %s%s (off duty), %i calls accepted, %i patients delivered.", szDialog, badge, GetPlayerNameEx(i), PlayerInfo[i][pCallsAccepted], PlayerInfo[i][pPatientsDelivered]);
			}
			else if(PlayerInfo[i][pMember] == PlayerInfo[playerid][pMember]) switch(PlayerInfo[i][pDuty]) {
				case 1: format(szDialog, sizeof(szDialog), "%s\n* %s%s (on duty)", szDialog, badge, GetPlayerNameEx(i));
				default: format(szDialog, sizeof(szDialog), "%s\n* %s%s (off duty)", szDialog, badge, GetPlayerNameEx(i));
			}
			else if(IsACriminal(playerid)) {
				format(szDialog, sizeof(szDialog), "%s\n* %s (%d)", szDialog, GetPlayerNameEx(i), PlayerInfo[i][pRank]);
			}
		}	
		if(!isnull(szDialog)) {
		    strdel(szDialog, 0, 1);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "Online Members", szDialog, "Select", "Cancel");
		}
		else SendClientMessageEx(playerid, COLOR_GREY, "No members are online at this time.");

    }  else SendClientMessageEx(playerid, COLOR_GREY, "Only group leaders may use this command.");
    return 1;
}

CMD:badge(playerid, params[]) {
    if(PlayerInfo[playerid][pMember] >= 0 && arrGroupData[PlayerInfo[playerid][pMember]][g_hDutyColour] != 0xFFFFFF && arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] != GROUP_TYPE_CRIMINAL)
	{
		if(GetPVarInt(playerid, "IsInArena") >= 0 || PlayerInfo[playerid][pJailTime] > 0 || GetPVarInt(playerid, "EventToken") != 0)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "You can't use your badge now.");
			return 1;
		}
		#if defined zombiemode
		if(zombieevent == 1 && GetPVarType(playerid, "pIsZombie")) return SendClientMessageEx(playerid, COLOR_GREY, "Zombies can't use this.");
		#endif
		if(PlayerInfo[playerid][pDuty]) {
			PlayerInfo[playerid][pDuty] = 0;
			SetPlayerToTeamColor(playerid);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have hidden your badge, and will now be identified as being off-duty.");
			if(IsAMedic(playerid))
			{
				Medics -= 1;
			}
		}
		else {
			PlayerInfo[playerid][pDuty] = 1;
			SetPlayerToTeamColor(playerid);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have shown your badge, and will now be identified as being on-duty.");
			if(IsAMedic(playerid))
			{
				Medics += 1;
			}
		}
	}
	return 1;
}

CMD:dvsiren(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(DynVeh[GetPlayerVehicleID(playerid)] != -1)
		{
			for(new i = 0; i != MAX_DV_OBJECTS; i++)
			{
				if(DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] == 19420)
				{
					DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] = 19419;
					Streamer_SetIntData(STREAMER_TYPE_OBJECT, DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectID][i], E_STREAMER_MODEL_ID, 19419);
					SendClientMessageEx(playerid, COLOR_WHITE, "Siren enabled.");
				}
				else if(DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] == 19419)
				{
					DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] = 19420;
					Streamer_SetIntData(STREAMER_TYPE_OBJECT, DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectID][i], E_STREAMER_MODEL_ID, 19420);
					SendClientMessageEx(playerid, COLOR_WHITE, "Siren disabled.");
				}
				if(DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] == 19300)
				{
					DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] = 18646;
					Streamer_SetIntData(STREAMER_TYPE_OBJECT, DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectID][i], E_STREAMER_MODEL_ID, 18646);
					SendClientMessageEx(playerid, COLOR_WHITE, "Siren enabled.");
				}
				else if(DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] == 18646)
				{
					DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] = 19300;
					Streamer_SetIntData(STREAMER_TYPE_OBJECT, DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectID][i], E_STREAMER_MODEL_ID, 19300);
					SendClientMessageEx(playerid, COLOR_WHITE, "Siren disabled.");
				}
				if(DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] == 1899) // Hazard
				{
					DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] = 19294;
					Streamer_SetIntData(STREAMER_TYPE_OBJECT, DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectID][i], E_STREAMER_MODEL_ID, 19294);
					SendClientMessageEx(playerid, COLOR_WHITE, "Siren enabled.");
				}
				else if(DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] == 19294)
				{
					DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectModel][i] = 1899;
					Streamer_SetIntData(STREAMER_TYPE_OBJECT, DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_iAttachedObjectID][i], E_STREAMER_MODEL_ID, 1899);
					SendClientMessageEx(playerid, COLOR_WHITE, "Siren disabled.");
				}
			}
		    Streamer_Update(playerid);
		}
	}
	return 1;
}

CMD:viewbudget(playerid, params[])
{
	new i = PlayerInfo[playerid][pMember];
	new string[128];
	if(arrGroupData[i][g_iGroupType] == GROUP_TYPE_LEA || arrGroupData[i][g_iGroupType] == GROUP_TYPE_MEDIC || arrGroupData[i][g_iGroupType] == GROUP_TYPE_JUDICIAL || arrGroupData[i][g_iGroupType] == GROUP_TYPE_TAXI || arrGroupData[i][g_iGroupType] == GROUP_TYPE_NEWS || arrGroupData[i][g_iGroupType] == GROUP_TYPE_CONTRACT || arrGroupData[i][g_iGroupType] == GROUP_TYPE_TOWING)
	{
	    SendClientMessage(playerid, 0x008EFC00, "            BALANCE SHEET            ");
		if(arrGroupData[i][g_szGroupName][0] && arrGroupData[i][g_hDutyColour] != 0) format(string, sizeof(string), "{%6x}%s {AFAFAF} [Balance: $%s] [Hourly Payments: $%s]| ", arrGroupData[i][g_hDutyColour], arrGroupData[i][g_szGroupName], number_format(arrGroupData[i][g_iBudget]), number_format(arrGroupData[i][g_iBudgetPayment]));
		else if(arrGroupData[i][g_szGroupName][0]) format(string, sizeof(string), "%s [Balance: $%s] [Hourly Payments: $%s]| ", arrGroupData[i][g_szGroupName], number_format(arrGroupData[i][g_iBudget]), number_format(arrGroupData[i][g_iBudgetPayment]));
		SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "Your agency does not receive government payments.");
	return 1;
}

CMD:setbudget(playerid, params[])
{
	if(arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == GROUP_TYPE_GOV)
	{
	    if(PlayerInfo[playerid][pRank] == Group_GetMaxRank(PlayerInfo[playerid][pMember]))
	    {
		    new
				iGroupID,
				iBudgetAmt,
				string[128];

			if(sscanf(params, "iii", iGroupID, iBudgetAmt))
			{
				SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /setbudget [Group ID] [$ Per Budget Payment (Hourly)]");
				for(new i = 0; i < MAX_GROUPS; i++)
				{
				    if(arrGroupData[PlayerInfo[playerid][pMember]][g_iAllegiance] == arrGroupData[i][g_iAllegiance])
				    {
					    if(arrGroupData[i][g_iGroupType] == GROUP_TYPE_LEA || arrGroupData[i][g_iGroupType] == GROUP_TYPE_MEDIC || arrGroupData[i][g_iGroupType] == GROUP_TYPE_JUDICIAL || arrGroupData[i][g_iGroupType] == GROUP_TYPE_TAXI)
					    {
						    if(arrGroupData[i][g_szGroupName][0] && arrGroupData[i][g_hDutyColour] != 0) format(string, sizeof(string), "%d - {%6x}%s {AFAFAF} [Balance: $%s] [Current Budget: $%s]| ", i, arrGroupData[i][g_hDutyColour], arrGroupData[i][g_szGroupName], number_format(arrGroupData[i][g_iBudget]), number_format(arrGroupData[i][g_iBudgetPayment]));
							else if(arrGroupData[i][g_szGroupName][0]) format(string, sizeof(string), "%d - %s [Balance: $%s] [Current Budget: $%s]| ", i, arrGroupData[i][g_szGroupName], number_format(arrGroupData[i][g_iBudget]), number_format(arrGroupData[i][g_iBudgetPayment]));
							SendClientMessageEx(playerid, COLOR_GRAD2, string);
						}
					}
				}
				return 1;
			}
			if(0 <= iGroupID < MAX_GROUPS && (arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_LEA || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_MEDIC || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_JUDICIAL || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_TAXI))
			{
			    if(arrGroupData[PlayerInfo[playerid][pMember]][g_iAllegiance] == arrGroupData[iGroupID][g_iAllegiance])
			    {
					arrGroupData[iGroupID][g_iBudgetPayment] = iBudgetAmt;
					format(string, sizeof(string), "You have set %s's Budget Payment to $%d. This will be issued hourly to pay for their vehicles, weapons and staffing", arrGroupData[iGroupID][g_szGroupName], iBudgetAmt);
					SendClientMessage(playerid, COLOR_GRAD1, string);
				}
				else return SendClientMessage(playerid, COLOR_GRAD2, "This agency is not under your government.");
			}
			else return SendClientMessage(playerid, COLOR_GRAD2, "Invalid Group ID");

	    }
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You're not a Government Official!");
	return 1;
}

CMD:gwithdraw(playerid, params[])
{
	new iGroupID;
	new string[128], amount, reason[64];
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		if(sscanf(params, "dds[64]", iGroupID, amount, reason))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gwithdraw [groupid] [amount] [reason]");
			return 1;
		}
		if(!(-1 < iGroupID <= MAX_GROUPS))
		{
			SendClientMessageEx(playerid, COLOR_RED, "* Invalid Group ID");
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gwithdraw [groupid] [amount] [reason]");
			return 1;
		}
	}
	else if(-1 < PlayerInfo[playerid][pLeader] <= MAX_GROUPS)
	{
		iGroupID = PlayerInfo[playerid][pLeader];
		if(sscanf(params, "ds[64]", amount, reason))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gwithdraw [amount] [reason]");
			format(string, sizeof(string), "* VAULT BALANCE: $%d.", arrGroupData[iGroupID][g_iBudget]);
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
			return 1;
		}
	}
	else return SendClientMessage(playerid, COLOR_GRAD3, " You are not a group leader or an authorized admin. ");



	if(amount < 0)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Invalid amount specified.");
		return 1;
	}
	if( arrGroupData[iGroupID][g_iBudget] > amount )
	{
		arrGroupData[iGroupID][g_iBudget] -= amount;
    	new str[128], file[32];
        format(str, sizeof(str), "%s has withdrawn $%d from %s's Budget Fund - reason: %s", GetPlayerNameEx(playerid), amount, arrGroupData[iGroupID][g_szGroupName], reason);
        new month, day, year;
		getdate(year,month,day);
		format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
		Log(file, str);
        Misc_Save();
        SaveGroup(iGroupID);
		GivePlayerCash( playerid, amount );
		format( string, sizeof( string ), "You have withdrawn $%d from the group vault.", amount );
		SendClientMessageEx( playerid, COLOR_WHITE, string );
		format(string,sizeof(string),"{AA3333}AdmWarning{FFFF00}: %s has withdrawn $%d of the group money from their vault, reason: %s.",GetPlayerNameEx(playerid),amount,reason);
		ABroadCast( COLOR_YELLOW, string, 2);
 		format(string,sizeof(string),"%s(%d) has withdrawn $%s of the group money from %s's vault, reason: %s.",GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), number_format(amount),arrGroupData[iGroupID][g_szGroupName],reason);
		Log("logs/rpspecial.log", string);
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Insufficient funds are available.");
	}
	return 1;
}

CMD:gdonate(playerid, params[])
{
	new iGroupID = PlayerInfo[playerid][pMember];
	if((0 <= iGroupID <= MAX_GROUPS))
	{
		if(arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_LEA || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_MEDIC || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_JUDICIAL || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_TAXI || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_NEWS || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_TOWING || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_CONTRACT )
		{
			new string[128], moneys;
			if(sscanf(params, "d", moneys)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gdonate [amount]");

			if(moneys < 1)
			{
				SendClientMessageEx(playerid, COLOR_GRAD1, "That is not enough.");
				return 1;
			}
			if(GetPlayerCash(playerid) < moneys)
			{
				SendClientMessageEx(playerid, COLOR_GRAD1, "You don't have that much money.");
				return 1;
			}
			GivePlayerCash(playerid, -moneys);
			arrGroupData[iGroupID][g_iBudget] += moneys;
			new str[128], file[32];
            format(str, sizeof(str), "%s has donated $%s to %s budget fund.", GetPlayerNameEx(playerid), number_format(moneys), arrGroupData[iGroupID][g_szGroupName]);
            new month, day, year;
			getdate(year,month,day);
			format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
			Log(file, str);
			SaveGroup(iGroupID);
			OnPlayerStatsUpdate(playerid);
			format(string, sizeof(string), "%s, you have donated $%s to your agency's budget.",GetPlayerNameEx(playerid), number_format(moneys));
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			SendClientMessageEx(playerid, COLOR_GRAD1, string);
			format(string, sizeof(string), "%s(%d) has donated $%s to %s's budget vault.",GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), number_format(moneys), arrGroupData[iGroupID][g_szGroupName]);
			Log("logs/pay.log", string);
			return 1;
		}
		else
		{
		    SendClientMessageEx(playerid, COLOR_GRAD2,  "You're not in a government agency!");
		}
	}
	else
	{
	    SendClientMessageEx(playerid, COLOR_GRAD2, "You're not in a group.");
	}
	return 1;
}

CMD:dvtrackcar(playerid, params[])
{
    new iGroupID = PlayerInfo[playerid][pMember];

	if((0 <= iGroupID <= MAX_GROUPS))
	{
		new vstring[2500];
		for(new i; i < MAX_DYNAMIC_VEHICLES; i++) {
			new iModelID = DynVehicleInfo[i][gv_iModel];
			if(400 <= iModelID < 612 && DynVehicleInfo[i][gv_igID] == iGroupID) {
				if(DynVehicleInfo[i][gv_iDisabled] == 1) {
					format(vstring, sizeof(vstring), "%s\n(%d)%s (Upkeep: $%s) (repo'd)", vstring, i, VehicleName[iModelID - 400], number_format(DynVehicleInfo[i][gv_iUpkeep]));
				}
				else if(DynVehicleInfo[i][gv_iDisabled] == 2) {
					format(vstring, sizeof(vstring), "%s\n(%d)%s (Upkeep: $%s) (stored)", vstring, i, VehicleName[iModelID - 400], number_format(DynVehicleInfo[i][gv_iUpkeep]));
				}
				else if(DynVehicleInfo[i][gv_iSpawnedID] != INVALID_VEHICLE_ID) {
					format(vstring, sizeof(vstring), "%s\n(%d) %s (Upkeep: $%s) (VID: %d)", vstring, i, VehicleName[iModelID - 400], number_format(DynVehicleInfo[i][gv_iUpkeep]), DynVehicleInfo[i][gv_iSpawnedID]);
				}
			}
		}
		ShowPlayerDialog(playerid, DV_TRACKCAR, DIALOG_STYLE_LIST, "Vehicle GPS Tracking", vstring, "Track", "Cancel");
	}
	return 1;
}

CMD:grepocars(playerid, params[])
{
	new iGroupID = PlayerInfo[playerid][pMember], string[128];
	if((0 <= iGroupID <= MAX_GROUPS) && PlayerInfo[playerid][pRank] == Group_GetMaxRank(iGroupID))
	{
	    SendClientMessageEx(playerid, COLOR_GREEN, "Repossessed Agency Vehicles:");
	    SendClientMessageEx(playerid, COLOR_GRAD4, "NOTE: Type /gvbuyback to purchase these cars back when your agency can afford it.");
	    for(new iDvSlotID = 0; iDvSlotID < MAX_DYNAMIC_VEHICLES; iDvSlotID++)
		{
		    if(DynVehicleInfo[iDvSlotID][gv_igID] != INVALID_GROUP_ID && DynVehicleInfo[iDvSlotID][gv_igID] == iGroupID)
		    {
			    if(DynVehicleInfo[iDvSlotID][gv_iModel] != 0 && (400 < DynVehicleInfo[iDvSlotID][gv_iModel] < 612))
			    {
			        if(DynVehicleInfo[iDvSlotID][gv_iDisabled] == 1)
			        {
			            format(string, sizeof(string), "Vehicle ID: %d - %s - Buyback Cost $%d.", iDvSlotID, VehicleName[DynVehicleInfo[iDvSlotID][gv_iModel] - 400], floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2), floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] / 2));
			            SendClientMessageEx(playerid, COLOR_GRAD1, string);
					}
			    }
			}
		}
	}
	else SendClientMessage(playerid, COLOR_GRAD2, " You're not authorized to use this command.");
	return 1;
}

CMD:gvbuyback(playerid, params[])
{
	new iVehicle[6];
	new iGroupID = PlayerInfo[playerid][pLeader], string[128];
	if((0 <= iGroupID <= MAX_GROUPS) && PlayerInfo[playerid][pRank] == Group_GetMaxRank(iGroupID))
	{
		if(sscanf(params, "s[6]", iVehicle)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gvbuyback [ID/all] *You may buy an individual car back, or all of your repo'd cars.");
			return SendClientMessageEx(playerid, COLOR_GREY, "Note: ID is indicated under /grepocars");
		}
		if(strcmp(iVehicle, "all", true) == 0)
		{
			for(new iDvSlotID = 0; iDvSlotID < MAX_DYNAMIC_VEHICLES; iDvSlotID++)
			{
				if(DynVehicleInfo[iDvSlotID][gv_igID] != INVALID_GROUP_ID && DynVehicleInfo[iDvSlotID][gv_igID] == iGroupID)
				{
					if(DynVehicleInfo[iDvSlotID][gv_iModel] != 0 && (400 < DynVehicleInfo[iDvSlotID][gv_iModel] < 612))
					{
						if(DynVehicleInfo[iDvSlotID][gv_iDisabled] == 1)
						{
							if(arrGroupData[iGroupID][g_iBudget] > floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2))
							{
								arrGroupData[iGroupID][g_iBudget] -= floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2);
								SaveGroup(iGroupID);
								DynVehicleInfo[iDvSlotID][gv_iDisabled] = 0;
								DynVeh_Save(iDvSlotID);
								DynVeh_Spawn(iDvSlotID);
								format(string, sizeof(string), "You have bought back your %s with ID %d for $%d", VehicleName[DynVehicleInfo[iDvSlotID][gv_iModel]-400], iDvSlotID, floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2));
								SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
								new str[128], file[32];
								format(str, sizeof(str), "Vehicle Slot ID %d buyback fee cost $%d to %s's budget fund.",iDvSlotID, floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2), arrGroupData[iGroupID][g_szGroupName]);
								new month, day, year;
								getdate(year,month,day);
								format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
								Log(file, str);
							}
							else
							{
								format(string, sizeof(string), "Your agency could not afford to buy back your %s with ID %d for $%d", VehicleName[DynVehicleInfo[iDvSlotID][gv_iModel]-400], iDvSlotID, floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2));
								SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
								return 1;
							}
						}
				    }
				}
			}
			return 1;
		}
		else if((0 <= strval(iVehicle) <= MAX_DYNAMIC_VEHICLES))
		{
			new iDvSlotID = strval(iVehicle);
			if(DynVehicleInfo[iDvSlotID][gv_iDisabled] == 1 && DynVehicleInfo[iDvSlotID][gv_igID] == iGroupID)
			{
				if(arrGroupData[iGroupID][g_iBudget] > floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2))
				{
					arrGroupData[iGroupID][g_iBudget] -= floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2);
					SaveGroup(iGroupID);
					DynVehicleInfo[iDvSlotID][gv_iDisabled] = 0;
					DynVeh_Save(iDvSlotID);
					DynVeh_Spawn(iDvSlotID);
					format(string, sizeof(string), "You have bought back your %s with ID %d for $%d", VehicleName[DynVehicleInfo[iDvSlotID][gv_iModel]-400], iDvSlotID, floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
					new str[128], file[32];
					format(str, sizeof(str), "Vehicle Slot ID %d buyback fee cost $%d to %s's budget fund.",iDvSlotID, floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2), arrGroupData[iGroupID][g_szGroupName]);
					new month, day, year;
					getdate(year,month,day);
					format(file, sizeof(file), "grouppay/%d/%d-%d-%d.log", iGroupID, month, day, year);
					Log(file, str);
					return 1;
				}
				else
				{
					format(string, sizeof(string), "Your agency could not afford to buy back your %s with ID %d for $%d", VehicleName[DynVehicleInfo[iDvSlotID][gv_iModel]-400], iDvSlotID, floatround(DynVehicleInfo[iDvSlotID][gv_iUpkeep] * 2));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
					return 1;
				}
			}
			else return SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "That car has either not been repossessed or does not belong to your agency.");
		}
		else SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Invalid ID");
	}
	else SendClientMessage(playerid, COLOR_GRAD2, " You're not authorized to use this command.");
	return 1;
}

CMD:adjustdvrank(playerid, params[])
{
	if(gettime() < GetPVarInt(playerid, "DvAdjust_Time")) return SendClientMessageEx(playerid, COLOR_GREY, " You need to wait 10 seconds before using this command again !");
	if(PlayerInfo[playerid][pMember] == INVALID_GROUP_ID) return SendClientMessageEx(playerid, COLOR_GREY, "You are not part of a group!");
	if(PlayerInfo[playerid][pRank] != PlayerInfo[playerid][pLeader]) return SendClientMessageEx(playerid, COLOR_GREY, "You do not have leadership!");
	new vid, rank;
	if(sscanf(params, "dd", vid, rank))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Syntax: /adjustdvrank <vehicleid> <rank>");
		SendClientMessageEx(playerid, COLOR_GREY, "NOTE: Use /dl to get the vehicleid.");
		SendClientMessageEx(playerid, COLOR_GREY, "NOTE: Rank 0 = Disabled.");
		return 1;
	}	
	new iDvSlotID = DynVeh[vid];
	if(iDvSlotID == -1 || iDvSlotID > MAX_DYNAMIC_VEHICLES || DynVehicleInfo[iDvSlotID][gv_iSpawnedID] != vid) return SendClientMessageEx(playerid, COLOR_GRAD1, " Invalid Dynamic Vehicle ID Provided!");
	if(DynVehicleInfo[iDvSlotID][gv_igID] != PlayerInfo[playerid][pMember]) return SendClientMessageEx(playerid, COLOR_GRAD1, " This Vehicle is not owned by your group!");
	//if(DynVehicleInfo[iDvSlotID][gv_igID] != INVALID_GROUP_ID) return SendClientMessageEx(playerid, COLOR_GRAD1, "This Vehicle is owned by a faction!");
	if(rank > 9 || rank < 0) return SendClientMessageEx(playerid, COLOR_GREY, "Ranks can't go below 0 or above 9");
	new string[128];
	SetPVarInt(playerid, "DvAdjust_Time", gettime()+10);
	DynVehicleInfo[iDvSlotID][gv_irID] = rank;
	format(string, sizeof(string), "You have adjusted the rank of this vehicle to %d.", rank);
	SendClientMessageEx(playerid, COLOR_WHITE, string);
	DynVeh_Save(iDvSlotID);
	return 1;
}

CMD:dvpark(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid), iDvSlotID = DynVeh[vehicleid];
 		if(iDvSlotID == -1 || iDvSlotID > MAX_DYNAMIC_VEHICLES || DynVehicleInfo[iDvSlotID][gv_iSpawnedID] != vehicleid)
		{
			return SendClientMessageEx(playerid, COLOR_GRAD1, " Invalid Dynamic Vehicle ID Provided!" );
		}
		if(PlayerInfo[playerid][pAdmin] >= 4 || (PlayerInfo[playerid][pLeader] == DynVehicleInfo[iDvSlotID][gv_igID]) && DynVehicleInfo[iDvSlotID][gv_igID] != INVALID_GROUP_ID) {
			GetVehiclePos(vehicleid, DynVehicleInfo[iDvSlotID][gv_fX], DynVehicleInfo[iDvSlotID][gv_fY], DynVehicleInfo[iDvSlotID][gv_fZ]);
			GetVehicleZAngle(vehicleid, DynVehicleInfo[iDvSlotID][gv_fRotZ]);
			DynVehicleInfo[iDvSlotID][gv_iVW] = GetPlayerVirtualWorld(playerid);
			DynVehicleInfo[iDvSlotID][gv_iInt] = GetPlayerInterior(playerid);
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
		}
		else return SendClientMessageEx(playerid, COLOR_GREY, "You can't park this vehicle.");
	}
	return 1;
}

CMD:gotodv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new moneys;
		if(sscanf(params, "i", moneys)) {
			return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gotodv [slot ID]");
		}
		if(DynVeh[DynVehicleInfo[moneys][gv_iSpawnedID]] != -1 && (0 <= moneys < MAX_DYNAMIC_VEHICLES))
		{

			new Float:cwx2,Float:cwy2,Float:cwz2;
			GetVehiclePos(DynVehicleInfo[moneys][gv_iSpawnedID], cwx2, cwy2, cwz2);
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, cwx2, cwy2+1, cwz2);
				SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(DynVehicleInfo[moneys][gv_iSpawnedID]));
				SetPlayerInterior(playerid, DynVehicleInfo[moneys][gv_iInt]);
				fVehSpeed[playerid] = 0.0;
			}
			else
			{
				SetPlayerPos(playerid, cwx2, cwy2+1, cwz2);
				SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(DynVehicleInfo[moneys][gv_iSpawnedID]));
				SetPlayerInterior(playerid, DynVehicleInfo[moneys][gv_iInt]);
			}
			SendClientMessageEx(playerid, COLOR_GRAD1, "   You have been teleported!");
			SetPlayerInterior(playerid, 0);
			return 1;
		}
		else return SendClientMessage(playerid, COLOR_GRAD2, "That dynamic vehicle does not exist or is not spawned.");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You're not authorized to use this command.");
}

CMD:dvstatus(playerid, params[])
{
	new iDvSlotID, vehicleid;
	if(sscanf(params, "i", vehicleid))
	{
		SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /dvstatus [vehicleid]");
		return 1;
	}
	iDvSlotID = DynVeh[vehicleid];
	if (PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 2)
	{
	    if(iDvSlotID != -1)
	    {
			new string[128];
			format(string,sizeof(string),"|___________ Dynamic Vehicle Status (ID: %d | Slot ID: %d) ___________|", vehicleid, iDvSlotID);
			SendClientMessageEx(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), "X: %f | Y: %f | Z: %f | Model: %d | Upkeep: $%d | Maxhealth: %f", DynVehicleInfo[iDvSlotID][gv_fX], DynVehicleInfo[iDvSlotID][gv_fY], DynVehicleInfo[iDvSlotID][gv_fZ], DynVehicleInfo[iDvSlotID][gv_iModel], DynVehicleInfo[iDvSlotID][gv_iUpkeep], DynVehicleInfo[iDvSlotID][gv_fMaxHealth]);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			format(string, sizeof(string), "Group: %d | Division: %d | Rank: %d | Type: %d | Disabled: %d", DynVehicleInfo[iDvSlotID][gv_igID], DynVehicleInfo[iDvSlotID][gv_igDivID], DynVehicleInfo[iDvSlotID][gv_irID], DynVehicleInfo[iDvSlotID][gv_iType], DynVehicleInfo[iDvSlotID][gv_iDisabled]);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			format(string, sizeof(string), "Obj Model 1: %d | Obj Model 2: %d | VW: %d | Int: %d | LoadMax: %d", DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][0],DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][1], DynVehicleInfo[iDvSlotID][gv_iVW], DynVehicleInfo[iDvSlotID][gv_iInt], DynVehicleInfo[iDvSlotID][gv_iLoadMax]);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
		}
		else return SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid Dynamic Vehicle Slot ID.");
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	}
	return 1;
}

CMD:dvcreate(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 2 || PlayerInfo[playerid][pGangModerator] >= 2)
	{
		new
				iVehicle,
				iColors[2],
				string[128];

		if(sscanf(params, "iii", iVehicle, iColors[0], iColors[1])) {
			return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /dvcreate [model ID] [color 1] [color 2]");
		}
		if(!(400 < iVehicle < 612)) return SendClientMessage(playerid, COLOR_GRAD2, "Invalid Model ID");
		else if(IsATrain(iVehicle)) {
				SendClientMessageEx(playerid, COLOR_GREY, "Trains cannot be spawned during runtime.");
			}
		else if(!(0 <= iColors[0] <= 255 && 0 <= iColors[1] <= 255)) {
			SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid color specified (IDs start at 0, and end at 255).");
		}
		mysql_function_query(MainPipeline, "SELECT id from `groupvehs` WHERE vModel = 0 LIMIT 1;", true, "DynVeh_CreateDVQuery", "iiii", playerid, iVehicle, iColors[0], iColors[1]);
		format(string, sizeof(string), "%s has created a dynamic vehicle.", GetPlayerNameEx(playerid));
		Log("logs/dv.log", string);
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You're not authorized to use this command.");
	return 1;
}

CMD:dvrespawnall(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		if(GetPVarInt(playerid, "dvRespawnAll") == 0)
		{
			new
				szString[128];

			SendClientMessageEx(playerid, COLOR_WHITE, "Respawning all current dynamic vehicles...");
				
			for(new i = 0; i < MAX_DYNAMIC_VEHICLES; i++)
			{
				SetPVarInt(playerid, "dvRespawnAll", 1);
				DynVeh_Spawn(i);
			}
			
			format(szString, sizeof(szString), "{AA3333}AdmWarning{FFFF00}: %s has respawned all dynamic vehicles loaded on the server.", GetPlayerNameEx(playerid));
			ABroadCast(COLOR_YELLOW, szString, 2);
			format(szString, sizeof(szString), "Administrator %s has respawned all dynamic vehicles loaded on the server.", GetPlayerNameEx(playerid));
			Log("logs/admin.log", szString);
			SetPVarInt(playerid, "dvRespawnAll", 0);
		}
		else
			return SendClientMessageEx(playerid, COLOR_GREY, "There is already a dynamic vehicle respawn request in progress.");
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "You're not authorized to use this command!");
	return 1;
}

CMD:freedvrespawn(playerid, params[]) return cmd_dvrespawn(playerid, "1");
CMD:dvrespawn(playerid, params[])
{
	new szString[128],
		iGroupID = PlayerInfo[playerid][pMember];
	    
    if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 1 || PlayerInfo[playerid][pGangModerator] >= 1)
    {
		if((0 <= iGroupID <= MAX_GROUPS))
		{
			for(new i; i < MAX_DYNAMIC_VEHICLES; i++)
			{
			    new iModelID = DynVehicleInfo[i][gv_iModel];
			    if(400 <= iModelID < 612 && DynVehicleInfo[i][gv_igID] == iGroupID)
			    {
					if(!IsVehicleOccupied(DynVehicleInfo[i][gv_iSpawnedID]))
					{	
						if(strval(params) == 1) DynVeh_Spawn(i, 1); else DynVeh_Spawn(i);
					}	
			    }
			}
			format(szString, sizeof(szString), "** Respawning all dynamic group vehicles%s...",(strval(params) == 1)?(" at no charge"):(""));
			foreach(new i: Player)
			{
				if(PlayerInfo[i][pMember] == iGroupID) 
				{
					SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szString);
				}
			}	
            format(szString, sizeof(szString), "%s has respawned group ID %d dynamic group vehicles.", GetPlayerNameEx(playerid), iGroupID+1);
   			Log("logs/group.log", szString);
		}
	}
	return 1;
}

CMD:dvedit(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 2 || PlayerInfo[playerid][pGangModerator] >= 2)
	{
		new vehicleid, name[24], Float:value, slot, string[128];
		if(sscanf(params, "is[24]F(0)D(0)", vehicleid, name, value, slot)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /dvedit [vehicleid] [v parameter] [value] [slot] (if applicable - indicated by *)");
			SendClientMessageEx(playerid, COLOR_GREY, "Parameters: vmodel vcol1 vcol2 groupid divid loadmax maxhealth upkeep vtype vw delete");
			SendClientMessageEx(playerid, COLOR_GREY, "Parameters: disabled objmodel* objx* objy* objz* objrx* objry* objrz* (Object Offsets)");
			SendClientMessageEx(playerid, COLOR_GREY, "Parameters: rank");
			return 1;
		}
		new iDvSlotID = DynVeh[vehicleid];
		if(iDvSlotID == -1 || iDvSlotID > MAX_DYNAMIC_VEHICLES || DynVehicleInfo[iDvSlotID][gv_iSpawnedID] != vehicleid) return SendClientMessageEx(playerid, COLOR_GRAD1, " Invalid Dynamic Vehicle ID Provided " );
		format(string, sizeof(string), "%s has edited DV Slot %d - %s.", GetPlayerNameEx(playerid), iDvSlotID, params);
		Log("logs/dv.log", string);
		if(strcmp(name, "delete", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iModel] = 0;
			DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][0] = INVALID_OBJECT_ID;
			DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][1] = INVALID_OBJECT_ID;
			DynVehicleInfo[iDvSlotID][gv_igID] = INVALID_GROUP_ID;
			DynVehicleInfo[iDvSlotID][gv_igDivID] = 0;
			DynVehicleInfo[iDvSlotID][gv_fMaxHealth] = 1000;
			DynVehicleInfo[iDvSlotID][gv_iUpkeep] = 0;
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have deleted the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vw", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iVW] = floatround(value);
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the virtual world of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "disabled", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iDisabled] = floatround(value);
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have disabled the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vmodel", true) == 0)
		{
			if(!(400 < value < 612)) return SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid Model ID");
			DynVehicleInfo[iDvSlotID][gv_iModel] = floatround(value);
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the vehicle model of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vcol1", true) == 0)
		{
			if(!(0 <= value <= 255)) {
				return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid color specified (IDs start at 0, and end at 255).");
			}
			DynVehicleInfo[iDvSlotID][gv_iCol1] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the color (1) of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vcol2", true) == 0)
		{
			if(!(0 <= value <= 255)) {
				return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid color specified (IDs start at 0, and end at 255).");
			}
			DynVehicleInfo[iDvSlotID][gv_iCol2] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the color (2) of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "groupid", true) == 0)
		{
			if(value == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_igID] = INVALID_GROUP_ID;
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have removed the group id flag of the dynamic vehicle");
				return 1;
			}
			if(!(0 <= value < MAX_GROUPS)) return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid group specified (Start at 1, end at "#MAX_GROUPS")");
			DynVehicleInfo[iDvSlotID][gv_igID] = floatround(value-1);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the group id flag of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "divid", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_igDivID] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the division id of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "rank", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_irID] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the rank id of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "loadmax", true) == 0)
		{
			if(!(0 < value < 6)) return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid group specified (Start at 1, end at 6)");
			DynVehicleInfo[iDvSlotID][gv_iLoadMax] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the load max of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "maxhealth", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_fMaxHealth] = (value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the maximum health of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "upkeep", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iUpkeep] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the up keep of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vtype", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iType] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the vehicle type of the dynamic vehicle");
			return 1;
		}
		if(1 <= slot <= MAX_DV_OBJECTS)
		{
			if(strcmp(name, "objmodel", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][slot-1] = floatround(value);
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object model of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objx", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectX][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object position (X) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objy", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectY][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object position (Y) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objz", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectZ][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object position (Z) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objrx", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectRX][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object rotation (X) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objry", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectRY][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object rotation (Y) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objrz", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectRZ][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object rotation (Z) of the dynamic vehicle");
				return 1;
			}
		}
		else return SendClientMessageEx(playerid, COLOR_GRAD2, "Slot ID Must be between 1 and "#MAX_DV_OBJECTS"!");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You're not authorized to use this command.");
	return 1;
}

CMD:dveditslot(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 2 || PlayerInfo[playerid][pGangModerator] >= 2)
	{
		new iDvSlotID, name[24], Float:value, slot, string[128];
		if(sscanf(params, "is[24]F(0)D(0)", iDvSlotID, name, value, slot)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /dveditslot [dv slot id] [v parameter] [value] [slot] (if applicable - indicated by *)");
			SendClientMessageEx(playerid, COLOR_GREY, "Parameters: vmodel vcol1 vcol2 groupid divid loadmax maxhealth upkeep vtype vw delete");
			SendClientMessageEx(playerid, COLOR_GREY, "Parameters: disabled objmodel* objx* objy* objz* objrx* objry* objrz* (Object Offsets)");
			SendClientMessageEx(playerid, COLOR_GREY, "Parameters: rank");
			return 1;
		}
		if(iDvSlotID > MAX_DYNAMIC_VEHICLES || DynVehicleInfo[iDvSlotID][gv_iModel] == 0) return SendClientMessageEx(playerid, COLOR_GRAD1, " Invalid Dynamic Vehicle ID Provided " );
		format(string, sizeof(string), "%s has edited DV Slot %d - %s.", GetPlayerNameEx(playerid), iDvSlotID, params);
		Log("logs/dv.log", string);
		if(strcmp(name, "delete", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iModel] = 0;
			DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][0] = INVALID_OBJECT_ID;
			DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][1] = INVALID_OBJECT_ID;
			DynVehicleInfo[iDvSlotID][gv_igID] = INVALID_GROUP_ID;
			DynVehicleInfo[iDvSlotID][gv_igDivID] = 0;
			DynVehicleInfo[iDvSlotID][gv_fMaxHealth] = 1000;
			DynVehicleInfo[iDvSlotID][gv_iUpkeep] = 0;
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have deleted the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vw", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iVW] = floatround(value);
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the virtual world of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "disabled", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iDisabled] = floatround(value);
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have disabled the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vmodel", true) == 0)
		{
			if(!(400 < value < 612)) return SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid Model ID");
			DynVehicleInfo[iDvSlotID][gv_iModel] = floatround(value);
			DynVeh_Save(iDvSlotID);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the vehicle model of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vcol1", true) == 0)
		{
			if(!(0 <= value <= 255)) {
				return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid color specified (IDs start at 0, and end at 255).");
			}
			DynVehicleInfo[iDvSlotID][gv_iCol1] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the color (1) of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vcol2", true) == 0)
		{
			if(!(0 <= value <= 255)) {
				return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid color specified (IDs start at 0, and end at 255).");
			}
			DynVehicleInfo[iDvSlotID][gv_iCol2] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the color (2) of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "groupid", true) == 0)
		{
			if(value == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_igID] = INVALID_GROUP_ID;
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have removed the group id flag of the dynamic vehicle");
				return 1;
			}
			if(!(0 <= value < MAX_GROUPS)) return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid group specified (Start at 1, end at "#MAX_GROUPS")");
			DynVehicleInfo[iDvSlotID][gv_igID] = floatround(value-1);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the group id flag of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "divid", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_igDivID] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the division id of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "rank", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_irID] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the rank id of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "loadmax", true) == 0)
		{
			if(!(0 < value < 6)) return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid group specified (Start at 1, end at 6)");
			DynVehicleInfo[iDvSlotID][gv_iLoadMax] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the load max of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "maxhealth", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_fMaxHealth] = (value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the maximum health of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "upkeep", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iUpkeep] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the up keep of the dynamic vehicle");
			return 1;
		}
		if(strcmp(name, "vtype", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iType] = floatround(value);
			DynVeh_Save(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the vehicle type of the dynamic vehicle");
			return 1;
		}
		if(1 <= slot <= MAX_DV_OBJECTS)
		{
			if(strcmp(name, "objmodel", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_iAttachedObjectModel][slot-1] = floatround(value);
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object model of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objx", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectX][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object position (X) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objy", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectY][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object position (Y) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objz", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectZ][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object position (Z) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objrx", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectRX][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object rotation (X) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objry", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectRY][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object rotation (Y) of the dynamic vehicle");
				return 1;
			}
			if(strcmp(name, "objrz", true) == 0)
			{
				DynVehicleInfo[iDvSlotID][gv_fObjectRZ][slot-1] = value;
				DynVeh_Spawn(iDvSlotID);
				DynVeh_Save(iDvSlotID);
				SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the object rotation (Z) of the dynamic vehicle");
				return 1;
			}
		}
		else return SendClientMessageEx(playerid, COLOR_GRAD2, "Slot ID Must be between 1 and "#MAX_DV_OBJECTS"!");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You're not authorized to use this command.");
	return 1;
}

CMD:dvplate(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 2 || PlayerInfo[playerid][pGangModerator] >= 2)
	{
		new vehicleid, plate[32];
        if(sscanf(params, "ds[32]", vehicleid, plate))
		{
		    SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /dvplate [vehicleid] [plate/remove]");
		    SendClientMessageEx(playerid, COLOR_GREY, "COLORS: (black/white/blue/red/green/purple/yellow/lightblue/navy/beige/darkgreen/darkblue/darkgrey/gold/brown/darkbrown/darkred");
			SendClientMessageEx(playerid, COLOR_GREY, "/pink) USAGE: (red)Hi(white)how are you? NOTE: Each color counts for 8 characters");
			return 1;
		}
		new iDvSlotID = DynVeh[vehicleid];
		if(iDvSlotID == -1 || iDvSlotID > MAX_DYNAMIC_VEHICLES || DynVehicleInfo[iDvSlotID][gv_iSpawnedID] != vehicleid) return SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid Dynamic Vehicle ID provided!");

		format(plate, sizeof(plate), "%s", str_replace("(black)", "{000000}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(white)", "{FFFFFF}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(blue)", "{0000FF}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(red)", "{FF0000}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(green)", "{008000}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(purple)", "{800080}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(yellow)", "{FFFF00}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(lightblue)", "{ADD8E6}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(navy)", "{000080}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(beige)", "{F5F5DC}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(darkgreen)", "{006400}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(darkblue)", "{00008B}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(darkgrey)", "{A9A9A9}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(gold)", "{FFD700}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(brown)", "{A52A2A}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(darkbrown)", "{5C4033}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(darkred)", "{8B0000}", plate));
		format(plate, sizeof(plate), "%s", str_replace("(pink)", "{FF5B77}", plate));

		if(strcmp(plate, "remove", true) == 0)
		{
			DynVehicleInfo[iDvSlotID][gv_iPlate] = 0;
			SendClientMessageEx(playerid, COLOR_WHITE, "You have removed the custom plate of the dynamic vehicle");
		}
		else
		{
			format(DynVehicleInfo[iDvSlotID][gv_iPlate], 32, "%s", plate);
			DynVeh_Spawn(iDvSlotID);
			SendClientMessageEx(playerid, COLOR_WHITE, "You have modified the custom plate of the dynamic vehicle");
		}

		DynVeh_Save(iDvSlotID);
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	}
	return 1;
}

CMD:siren(playerid, params[])
{
	if(IsACop(playerid) || IsAHitman(playerid) || IsAGovernment(playerid) || IsAMedic(playerid))
	{
	    if(GetPVarType(playerid, "Siren"))
		{
			/* freeslot = FindFreeAttachedObjectSlot(playerid);
			if(freeslot == -1) { RemovePlayerAttachedObject(playerid, 8), freeslot = 8; } */
  			if(IsPlayerAttachedObjectSlotUsed(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3)) RemovePlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3);
    		if(IsPlayerAttachedObjectSlotUsed(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2)) RemovePlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2);
      		DeletePVar(playerid, "Siren");
      		SendClientMessageEx(playerid, COLOR_WHITE, "Siren disabled.");
			return 1;
		}
	    else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
			if(IsPlayerAttachedObjectSlotUsed(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3)) RemovePlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3);
			if(IsPlayerAttachedObjectSlotUsed(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2)) RemovePlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2);
			switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
			{
				case 415:
				{
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3, 18646, 10, -0.20, 0.30, 0.3, -90, -30, 0);
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2, 18646, 10, -0.20, 0.30, 0.3, -90, -30, 0);
				}
				case 402:
				{
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3, 18646, 10, -0.20, 0.5, 0.4, -90, -50, 0);
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2, 18646, 10, -0.20, 0.5, 0.4, -90, -50, 0);
				}
				case 541, 411:
				{
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3, 18646, 10, 0.0, 0.2, 0.4, -90, -30, 0);
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2, 18646, 10, 0.0, 0.2, 0.4, -90, -30, 0);
				}
				case 451: {
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3, 18646, 10, -0.30, 0.4, 0.6, -90, -50, 0);
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2, 18646, 10, -0.30, 0.4, 0.6, -90, -50, 0);
				}
				default:
				{
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 3, 18646, 10, -0.30, 0.4, 0.4, -90, -50, 0);
					SetPlayerAttachedObject(playerid, MAX_PLAYER_ATTACHED_OBJECTS - 2, 18646, 10, -0.30, 0.4, 0.4, -90, -50, 0);
				}
			}
			SetPVarInt(playerid, "Siren", 1);
			SendClientMessageEx(playerid, COLOR_WHITE, "Siren enabled.");
			return 1;
	    }
		SendClientMessage(playerid, COLOR_GRAD2, "This vehicle does not support mounted sirens.");
	}
	return 1;
}

CMD:deploy(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID)
	{
		if(GetPVarInt(playerid, "IsInArena") >= 0) return SendClientMessageEx(playerid, COLOR_WHITE, "You can't do this right now, you are in an arena!");
		new type, object[12], string[128];
		if(sscanf(params, "s[12]D(0)", object, type))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /deploy [object] [type (option for barricades)]");
			SendClientMessageEx(playerid, COLOR_GRAD1, "Objects: Cade, Spikes, Flare, Cone, Barrel, Ladder");
			return 1;
		}
		else if(IsPlayerInAnyVehicle(playerid)) return SendClientMessageEx(playerid, COLOR_GREY, "You must be on foot to use this command.");
		
		new iGroup = PlayerInfo[playerid][pMember];
		
		if(strcmp(object, "cade", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBarricades])
			{
				for(new i; i < MAX_BARRICADES; i++)
				{
					if(Barricades[iGroup][i][sX] == 0 && Barricades[iGroup][i][sY] == 0 && Barricades[iGroup][i][sZ] == 0)
					{
						new Float: f_TempAngle;

						GetPlayerPos(playerid, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ]);
						GetPlayerFacingAngle(playerid, f_TempAngle);
						switch(type)
						{
							case 0:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(981, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ], 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ] + 2);
							}
							case 1:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(4504, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] + 1.6996, 0.0, 0.0, f_TempAngle + 270);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 10, Barricades[iGroup][i][sY] + 10, Barricades[iGroup][i][sZ] + 5);
							}
							case 2:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(4505, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] + 1.6996, 0.0, 0.0, f_TempAngle + 270);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 10, Barricades[iGroup][i][sY] + 10, Barricades[iGroup][i][sZ] + 5);
							}
							case 3:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(4514, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] + 1.2394, 0.0, 0.0, f_TempAngle + 270);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 10, Barricades[iGroup][i][sY] + 10, Barricades[iGroup][i][sZ] + 5);
							}
							case 4:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(4526, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] + 0.7227, 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 10, Barricades[iGroup][i][sY] + 10, Barricades[iGroup][i][sZ] + 5);
							}
							case 5:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(978, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ], 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							case 6:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(979, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ], 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							case 7:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(3091, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] - 0.30, 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							case 8:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(1425, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] - 0.40, 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							case 9:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(1459, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] - 0.40, 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							case 10:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(1423, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] - 0.35, 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							case 11:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(1424, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] - 0.35, 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							case 12:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(8548, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ] + 1.00, 0.0, 0.0, f_TempAngle);
								SetDynamicObjectMaterial(Barricades[iGroup][i][sObjectID], 0, 967, "cj_barr_set_1", "Stop2_64", 0);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ]);
							}
							default:
							{
								Barricades[iGroup][i][sObjectID] = CreateDynamicObject(981, Barricades[iGroup][i][sX], Barricades[iGroup][i][sY], Barricades[iGroup][i][sZ], 0.0, 0.0, f_TempAngle);
								SetPlayerPos(playerid, Barricades[iGroup][i][sX] + 2, Barricades[iGroup][i][sY] + 2, Barricades[iGroup][i][sZ] + 2);
							}
						}
						GetPlayer3DZone(playerid, Barricades[iGroup][i][sDeployedAt], MAX_ZONE_NAME);
						Barricades[iGroup][i][sDeployedBy] = GetPlayerNameEx(playerid);
						if(PlayerInfo[playerid][pAdmin] > 1 && PlayerInfo[playerid][pTogReports] != 1) Barricades[iGroup][i][sDeployedByStatus] = 1;
						else Barricades[iGroup][i][sDeployedByStatus] = 0;
						format(string,sizeof(string),"Barricade ID: %d successfully created.", i);
						SendClientMessageEx(playerid, COLOR_WHITE, string);
						/*format(string, sizeof(string), "** HQ: A barricade has been deployed by %s at %s **", GetPlayerNameEx(playerid), Barricades[iGroup][i][sDeployedAt]);
						foreach(new x: Player)
						{
							if(GetPVarInt(x, "togRadio") == 0)
							{
								if(PlayerInfo[x][pMember] == iGroup) SendClientMessageEx(x, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, string);
								if(GetPVarInt(x, "BigEar") == 4 && GetPVarInt(x, "BigEarGroup") == iGroup)
								{
									new szBigEar[128];
									format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
									SendClientMessageEx(x, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, szBigEar);
								}
							}
						}*/
						return 1;
					}
				}
				SendClientMessageEx(playerid, COLOR_WHITE, "Unable to spawn more barricades, limit is " #MAX_BARRICADES# ".");
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "spikes", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iSpikeStrips])
			{
				for(new i; i < MAX_SPIKES; i++)
				{
					if(SpikeStrips[iGroup][i][sX] == 0 && SpikeStrips[iGroup][i][sY] == 0 && SpikeStrips[iGroup][i][sZ] == 0)
					{
						new Float: f_TempAngle;

						GetPlayerPos(playerid, SpikeStrips[iGroup][i][sX], SpikeStrips[iGroup][i][sY], SpikeStrips[iGroup][i][sZ]);
						GetPlayerFacingAngle(playerid, f_TempAngle);
						SpikeStrips[iGroup][i][sObjectID] = CreateDynamicObject(2899, SpikeStrips[iGroup][i][sX], SpikeStrips[iGroup][i][sY], SpikeStrips[iGroup][i][sZ]-0.8, 0.0, 0.0, f_TempAngle);
						SpikeStrips[iGroup][i][sPickupID] = CreateDynamicPickup(19300, 14, SpikeStrips[iGroup][i][sX], SpikeStrips[iGroup][i][sY], SpikeStrips[iGroup][i][sZ]);
						GetPlayer3DZone(playerid, SpikeStrips[iGroup][i][sDeployedAt], MAX_ZONE_NAME);
						SpikeStrips[iGroup][i][sDeployedBy] = GetPlayerNameEx(playerid);
						if(PlayerInfo[playerid][pAdmin] > 1 && PlayerInfo[playerid][pTogReports] != 1) SpikeStrips[iGroup][i][sDeployedByStatus] = 1;
						else SpikeStrips[iGroup][i][sDeployedByStatus] = 0;
						format(string,sizeof(string),"Spike ID: %d successfully created.", i);
						SendClientMessageEx(playerid, COLOR_WHITE, string);
						/*format(string, sizeof(string), "** HQ: A spike has been deployed by %s at %s **", GetPlayerNameEx(playerid), SpikeStrips[iGroup][i][sDeployedAt]);
						foreach(new x: Player)
						{
							if(GetPVarInt(x, "togRadio") == 0)
							{
								if(PlayerInfo[x][pMember] == iGroup) SendClientMessageEx(x, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, string);
								if(GetPVarInt(x, "BigEar") == 4 && GetPVarInt(x, "BigEarGroup") == iGroup)
								{
									new szBigEar[128];
									format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
									SendClientMessageEx(x, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, szBigEar);
								}
							}
						}*/
						return 1;
					}
				}
				SendClientMessageEx(playerid, COLOR_WHITE, "Unable to spawn more spike strips, limit is " #MAX_SPIKES# ".");
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "flare", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iFlares])
			{
				for(new i; i < MAX_FLARES; i++)
				{
					if(Flares[iGroup][i][sX] == 0 && Flares[iGroup][i][sY] == 0 && Flares[iGroup][i][sZ] == 0)
					{
						new Float: f_TempAngle;

						GetPlayerPos(playerid, Flares[iGroup][i][sX], Flares[iGroup][i][sY], Flares[iGroup][i][sZ]);
						GetPlayerFacingAngle(playerid, f_TempAngle);
						Flares[iGroup][i][sObjectID] = CreateDynamicObject(18728, Flares[iGroup][i][sX], Flares[iGroup][i][sY], Flares[iGroup][i][sZ]-2.4, 0.0, 0.0, f_TempAngle);
						GetPlayer3DZone(playerid, Flares[iGroup][i][sDeployedAt], MAX_ZONE_NAME);
						Flares[iGroup][i][sDeployedBy] = GetPlayerNameEx(playerid);
						if(PlayerInfo[playerid][pAdmin] > 1 && PlayerInfo[playerid][pTogReports] != 1) Flares[iGroup][i][sDeployedByStatus] = 1;
						else Flares[iGroup][i][sDeployedByStatus] = 0;
						format(string,sizeof(string),"Flare ID: %d successfully created.", i);
						SendClientMessageEx(playerid, COLOR_WHITE, string);
						return 1;
					}
				}
				SendClientMessageEx(playerid, COLOR_WHITE, "Unable to spawn more flares, limit is " #MAX_FLARES# ".");
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "cone", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iCones])
			{
				for(new i; i < MAX_CONES; i++)
				{
					if(Cones[iGroup][i][sX] == 0 && Cones[iGroup][i][sY] == 0 && Cones[iGroup][i][sZ] == 0)
					{
						new Float: f_TempAngle;

						GetPlayerPos(playerid, Cones[iGroup][i][sX], Cones[iGroup][i][sY], Cones[iGroup][i][sZ]);
						GetPlayerFacingAngle(playerid, f_TempAngle);
						Cones[iGroup][i][sObjectID] = CreateDynamicObject(1238, Cones[iGroup][i][sX], Cones[iGroup][i][sY], Cones[iGroup][i][sZ]-0.7, 0.0, 0.0, f_TempAngle);
						GetPlayer3DZone(playerid, Cones[iGroup][i][sDeployedAt], MAX_ZONE_NAME);
						Cones[iGroup][i][sDeployedBy] = GetPlayerNameEx(playerid);
						if(PlayerInfo[playerid][pAdmin] > 1 && PlayerInfo[playerid][pTogReports] != 1) Cones[iGroup][i][sDeployedByStatus] = 1;
						else Cones[iGroup][i][sDeployedByStatus] = 0;
						format(string,sizeof(string),"Cone ID: %d successfully created.", i);
						SendClientMessageEx(playerid, COLOR_WHITE, string);
						return 1;
					}
				}
				SendClientMessageEx(playerid, COLOR_WHITE, "Unable to spawn more cones, limit is " #MAX_CONES# ".");
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "barrel", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBarrels])
			{
				for(new i; i < MAX_BARRELS; i++)
				{
					if(Barrels[iGroup][i][sX] == 0 && Barrels[iGroup][i][sY] == 0 && Barrels[iGroup][i][sZ] == 0)
					{
						new Float: f_TempAngle;

						GetPlayerPos(playerid, Barrels[iGroup][i][sX], Barrels[iGroup][i][sY], Barrels[iGroup][i][sZ]);
						GetPlayerFacingAngle(playerid, f_TempAngle);
						Barrels[iGroup][i][sObjectID] = CreateDynamicObject(1237, Barrels[iGroup][i][sX], Barrels[iGroup][i][sY], Barrels[iGroup][i][sZ]-1, 0.0, 0.0, f_TempAngle);
						GetPlayer3DZone(playerid, Barrels[iGroup][i][sDeployedAt], MAX_ZONE_NAME);
						Barrels[iGroup][i][sDeployedBy] = GetPlayerNameEx(playerid);
						if(PlayerInfo[playerid][pAdmin] > 1 && PlayerInfo[playerid][pTogReports] != 1) Barrels[iGroup][i][sDeployedByStatus] = 1;
						else Barrels[iGroup][i][sDeployedByStatus] = 0;
						format(string,sizeof(string),"Barrel ID: %d successfully created.", i);
						SendClientMessageEx(playerid, COLOR_WHITE, string);
						return 1;
					}
				}
				SendClientMessageEx(playerid, COLOR_WHITE, "Unable to spawn more barrels limit is " #MAX_BARRELS# ".");
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "ladder", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iLadders])
			{
				for(new i; i < MAX_LADDERS; i++)
				{
					if(Ladders[iGroup][i][sX] == 0 && Ladders[iGroup][i][sY] == 0 && Ladders[iGroup][i][sZ] == 0)
					{
						new Float: f_TempAngle;

						GetPlayerPos(playerid, Ladders[iGroup][i][sX], Ladders[iGroup][i][sY], Ladders[iGroup][i][sZ]);
						GetPlayerFacingAngle(playerid, f_TempAngle);
						Ladders[iGroup][i][sObjectID] = CreateDynamicObject(1437, Ladders[iGroup][i][sX], Ladders[iGroup][i][sY], Ladders[iGroup][i][sZ] + 0.20, 340.0, 0.0, f_TempAngle);
						GetPlayer3DZone(playerid, Ladders[iGroup][i][sDeployedAt], MAX_ZONE_NAME);
						SetPlayerPos(playerid, Ladders[iGroup][i][sX], Ladders[iGroup][i][sY], Ladders[iGroup][i][sZ] + 0.50);
						Ladders[iGroup][i][sDeployedBy] = GetPlayerNameEx(playerid);
						if(PlayerInfo[playerid][pAdmin] > 1 && PlayerInfo[playerid][pTogReports] != 1) Ladders[iGroup][i][sDeployedByStatus] = 1;
						else Ladders[iGroup][i][sDeployedByStatus] = 0;
						format(string,sizeof(string),"Ladder ID: %d successfully created.", i);
						SendClientMessageEx(playerid, COLOR_WHITE, string);
						return 1;
					}
				}
				SendClientMessageEx(playerid, COLOR_WHITE, "Unable to spawn more ladders, limit is " #MAX_LADDERS# ".");
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
	}
	else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
	return 1;
}

CMD:destroy(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID)
	{
		new type, object[12];
		if(sscanf(params, "s[12]d", object, type))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /destroy [object] [ID]");
			SendClientMessageEx(playerid, COLOR_GRAD1, "Objects: Cade, Spikes, Flare, Cone, Barrel, Ladder");
			return 1;
		}
		else if(IsPlayerInAnyVehicle(playerid)) return SendClientMessageEx(playerid, COLOR_GREY, "You must be on foot to use this command.");
		
		new iGroup = PlayerInfo[playerid][pMember];
		
		if(strcmp(object, "cade", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBarricades])
			{
				if(!(0 <= type < sizeof(Barricades)) || (Barricades[iGroup][type][sX] == 0 && Barricades[iGroup][type][sY] == 0 && Barricades[iGroup][type][sZ] == 0)) return SendClientMessageEx(playerid, COLOR_WHITE, "Invalid barricade ID.");
				else if(PlayerInfo[playerid][pAdmin] < 2 && Barricades[iGroup][type][sDeployedByStatus] == 1) return SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot destroy a barricade that an Administrator deployed.");
				else
				{
					new string[43 + MAX_PLAYER_NAME + MAX_ZONE_NAME];
					DestroyDynamicObject(Barricades[iGroup][type][sObjectID]);
					Barricades[iGroup][type][sX] = 0;
					Barricades[iGroup][type][sY] = 0;
					Barricades[iGroup][type][sZ] = 0;
					Barricades[iGroup][type][sObjectID] = INVALID_OBJECT_ID;
					Barricades[iGroup][type][sDeployedBy] = INVALID_PLAYER_ID;
					Barricades[iGroup][type][sDeployedByStatus] = 0;
					format(string, sizeof(string), "Barricade ID: %d successfully deleted.", type);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "** HQ: A barricade has been destroyed by %s at %s **", GetPlayerNameEx(playerid), Barricades[iGroup][type][sDeployedAt]);
					foreach(new i: Player)
					{
						if(GetPVarInt(i, "togRadio") == 0)
						{
							if(PlayerInfo[i][pMember] == iGroup) SendClientMessageEx(i, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, string);
							if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == iGroup)
							{
								new szBigEar[128];
								format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
								SendClientMessageEx(i, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, szBigEar);
							}
						}
					}
					return 1;
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "spikes", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iSpikeStrips])
			{
				if(!(0 <= type < sizeof(SpikeStrips)) || (SpikeStrips[iGroup][type][sX] == 0 && SpikeStrips[iGroup][type][sY] == 0 && SpikeStrips[iGroup][type][sZ] == 0)) return SendClientMessageEx(playerid, COLOR_WHITE, "Invalid spike ID.");
				else if(PlayerInfo[playerid][pAdmin] < 2 && SpikeStrips[iGroup][type][sDeployedByStatus] == 1) return SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot destroy a spikestrip that an Administrator deployed.");
				else
				{
					new string[43 + MAX_PLAYER_NAME + MAX_ZONE_NAME];
					DestroyDynamicObject(SpikeStrips[iGroup][type][sObjectID]);
					DestroyDynamicPickup(SpikeStrips[iGroup][type][sPickupID]);
					SpikeStrips[iGroup][type][sX] = 0;
					SpikeStrips[iGroup][type][sY] = 0;
					SpikeStrips[iGroup][type][sZ] = 0;
					SpikeStrips[iGroup][type][sObjectID] = INVALID_OBJECT_ID;
					SpikeStrips[iGroup][type][sDeployedBy] = INVALID_PLAYER_ID;
					SpikeStrips[iGroup][type][sDeployedByStatus] = 0;
					format(string,sizeof(string),"Spike %d successfully deleted.", type);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
					/*format(string, sizeof(string), "** HQ: A spike has been destroyed by %s at %s **", GetPlayerNameEx(playerid), SpikeStrips[iGroup][type][sDeployedAt]);
					foreach(new i: Player)
					{
						if(GetPVarInt(i, "togRadio") == 0)
						{
							if(PlayerInfo[i][pMember] == iGroup) SendClientMessageEx(i, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, string);
							if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == iGroup)
							{
								new szBigEar[128];
								format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
								SendClientMessageEx(i, arrGroupData[iGroup][g_hRadioColour] * 256 + 255, szBigEar);
							}
						}
					}*/
					return 1;
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "flare", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iFlares])
			{
				if(!(0 <= type < sizeof(Flares)) || (Flares[iGroup][type][sX] == 0 && Flares[iGroup][type][sY] == 0 && Flares[iGroup][type][sZ] == 0)) return SendClientMessageEx(playerid, COLOR_WHITE, "Invalid flare ID.");
				else if(PlayerInfo[playerid][pAdmin] < 2 && Flares[iGroup][type][sDeployedByStatus] == 1) return SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot destroy a flare that an Administrator deployed.");
				else
				{
					new string[43 + MAX_PLAYER_NAME + MAX_ZONE_NAME];
					DestroyDynamicObject(Flares[iGroup][type][sObjectID]);
					Flares[iGroup][type][sX] = 0;
					Flares[iGroup][type][sY] = 0;
					Flares[iGroup][type][sZ] = 0;
					Flares[iGroup][type][sObjectID] = INVALID_OBJECT_ID;
					Flares[iGroup][type][sDeployedBy] = INVALID_PLAYER_ID;
					Flares[iGroup][type][sDeployedByStatus] = 0;
					format(string,sizeof(string),"Flare ID: %d successfully deleted.", type);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
					return 1;
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "cone", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iCones])
			{
				if(!(0 <= type < sizeof(Cones)) || (Cones[iGroup][type][sX] == 0 && Cones[iGroup][type][sY] == 0 && Cones[iGroup][type][sZ] == 0)) return SendClientMessageEx(playerid, COLOR_WHITE, "Invalid cone ID.");
				else if(PlayerInfo[playerid][pAdmin] < 2 && Cones[iGroup][type][sDeployedByStatus] == 1) return SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot destroy a cone that an Administrator deployed.");
				else
				{
					new string[43 + MAX_PLAYER_NAME + MAX_ZONE_NAME];
					DestroyDynamicObject(Cones[iGroup][type][sObjectID]);
					Cones[iGroup][type][sX] = 0;
					Cones[iGroup][type][sY] = 0;
					Cones[iGroup][type][sZ] = 0;
					Cones[iGroup][type][sObjectID] = INVALID_OBJECT_ID;
					Cones[iGroup][type][sDeployedBy] = INVALID_PLAYER_ID;
					Cones[iGroup][type][sDeployedByStatus] = 0;
					format(string,sizeof(string),"Cone ID: %d successfully deleted.", type);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
					return 1;
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "barrel", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBarrels])
			{
				if(!(0 <= type < sizeof(Barrels)) || (Barrels[iGroup][type][sX] == 0 && Barrels[iGroup][type][sY] == 0 && Barrels[iGroup][type][sZ] == 0)) return SendClientMessageEx(playerid, COLOR_WHITE, "Invalid barrel ID.");
				else if(PlayerInfo[playerid][pAdmin] < 2 && Barrels[iGroup][type][sDeployedByStatus] == 1) return SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot destroy a barrel that an Administrator deployed.");
				else
				{
					new string[43 + MAX_PLAYER_NAME + MAX_ZONE_NAME];
					DestroyDynamicObject(Barrels[iGroup][type][sObjectID]);
					Barrels[iGroup][type][sX] = 0;
					Barrels[iGroup][type][sY] = 0;
					Barrels[iGroup][type][sZ] = 0;
					Barrels[iGroup][type][sObjectID] = INVALID_OBJECT_ID;
					Barrels[iGroup][type][sDeployedBy] = INVALID_PLAYER_ID;
					Barrels[iGroup][type][sDeployedByStatus] = 0;
					format(string,sizeof(string),"Barrel ID: %d successfully deleted.", type);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
					return 1;
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
		else if(strcmp(object, "ladder", true) == 0)
		{
			if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iLadders])
			{
				if(!(0 <= type < sizeof(Ladders)) || (Ladders[iGroup][type][sX] == 0 && Ladders[iGroup][type][sY] == 0 && Ladders[iGroup][type][sZ] == 0)) return SendClientMessageEx(playerid, COLOR_WHITE, "Invalid ladder ID.");
				else if(PlayerInfo[playerid][pAdmin] < 2 && Barrels[iGroup][type][sDeployedByStatus] == 1) return SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot destroy a ladder that an Administrator deployed.");
				else
				{
					new string[43 + MAX_PLAYER_NAME + MAX_ZONE_NAME];
					DestroyDynamicObject(Ladders[iGroup][type][sObjectID]);
					Ladders[iGroup][type][sX] = 0;
					Ladders[iGroup][type][sY] = 0;
					Ladders[iGroup][type][sZ] = 0;
					Ladders[iGroup][type][sObjectID] = INVALID_OBJECT_ID;
					Ladders[iGroup][type][sDeployedBy] = INVALID_PLAYER_ID;
					Ladders[iGroup][type][sDeployedByStatus] = 0;
					format(string,sizeof(string),"Ladder ID: %d successfully deleted.", type);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
					return 1;
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
		}
	}
	else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
	return 1;
}

CMD:cades(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && arrGroupData[PlayerInfo[playerid][pMember]][g_iBarricades] != -1 && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBarricades])
	{
		new iGroup = PlayerInfo[playerid][pMember];
		SendClientMessageEx(playerid, COLOR_WHITE, "Current deployed barricades:");
		for(new i, string[56 + MAX_ZONE_NAME + MAX_PLAYER_NAME]; i < MAX_BARRICADES; i++)
		{
			if(Barricades[iGroup][i][sX] != 0 && Barricades[iGroup][i][sY] != 0 && Barricades[iGroup][i][sZ] != 0) // Checking for next available ID.
			{
				format(string, sizeof(string), "HQ: Barricade #%d | Deployed location: %s | Deployed by: %s", i, Barricades[iGroup][i][sDeployedAt], Barricades[iGroup][i][sDeployedBy]);
				SendClientMessageEx(playerid, COLOR_GRAD2, string);
			}
		}
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized.");
	}
	return 1;
}

CMD:spikes(playerid, params[])
{
	if (PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iSpikeStrips])
	{
		new iGroup = PlayerInfo[playerid][pMember];
		SendClientMessageEx(playerid, COLOR_WHITE, "Current deployed spikes:");
		for(new i, string[56 + MAX_ZONE_NAME + MAX_PLAYER_NAME]; i < MAX_SPIKES; i++)
		{
			if(SpikeStrips[iGroup][i][sX] != 0 && SpikeStrips[iGroup][i][sY] != 0 && SpikeStrips[iGroup][i][sZ] != 0) // Checking for next available ID.
			{
				format(string, sizeof(string), "HQ: Spike ID: %d | Deployed location: %s | Deployed by: %s", i, SpikeStrips[iGroup][i][sDeployedAt], SpikeStrips[iGroup][i][sDeployedBy]);
				SendClientMessageEx(playerid, COLOR_GRAD2, string);
			}
		}
	} else SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
	return 1;
}

CMD:flares(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iFlares])
	{
		new iGroup = PlayerInfo[playerid][pMember];
		SendClientMessageEx(playerid, COLOR_WHITE, "Current deployed flares:");
		for(new i, string[58 + MAX_ZONE_NAME + MAX_PLAYER_NAME]; i < MAX_FLARES; i++)
		{
			if(Flares[iGroup][i][sX] != 0 && Flares[iGroup][i][sY] != 0 && Flares[iGroup][i][sZ] != 0) // Checking for next available ID.
			{
				format(string, sizeof(string), "HQ: Flare ID: %d | Deployed location: %s | Deployed by: %s", i, Flares[iGroup][i][sDeployedAt], Flares[iGroup][i][sDeployedBy]);
				SendClientMessageEx(playerid, COLOR_GRAD2, string);
			}
		}
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized.");
	}
	return 1;
}

CMD:cones(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iCones])
	{
		new iGroup = PlayerInfo[playerid][pMember];
		SendClientMessageEx(playerid, COLOR_WHITE, "Current deployed cones:");
		for(new i, string[56 + MAX_ZONE_NAME + MAX_PLAYER_NAME]; i < MAX_CONES; i++)
		{
			if(Cones[iGroup][i][sX] != 0 && Cones[iGroup][i][sY] != 0 && Cones[iGroup][i][sZ] != 0) // Checking for next available ID.
			{
				format(string, sizeof(string), "HQ: Cone ID: %d | Deployed location: %s | Deployed by: %s", i, Cones[iGroup][i][sDeployedAt], Cones[iGroup][i][sDeployedBy]);
				SendClientMessageEx(playerid, COLOR_GRAD2, string);
			}
		}
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized.");
	}
	return 1;
}

CMD:barrels(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBarrels])
	{
		new iGroup = PlayerInfo[playerid][pMember];
		SendClientMessageEx(playerid, COLOR_WHITE, "Current deployed barrels:");
		for(new i, string[56 + MAX_ZONE_NAME + MAX_PLAYER_NAME]; i < MAX_BARRELS; i++)
		{
			if(Barrels[iGroup][i][sX] != 0 && Barrels[iGroup][i][sY] != 0 && Barrels[iGroup][i][sZ] != 0) // Checking for next available ID.
			{
				format(string, sizeof(string), "HQ: Barrel ID: %d | Deployed location: %s | Deployed by: %s", i, Barrels[iGroup][i][sDeployedAt], Barrels[iGroup][i][sDeployedBy]);
				SendClientMessageEx(playerid, COLOR_GRAD2, string);
			}
		}
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized.");
	}
	return 1;
}

CMD:ladders(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iLadders])
	{
		new iGroup = PlayerInfo[playerid][pMember];
		SendClientMessageEx(playerid, COLOR_WHITE, "Current deployed ladders:");
		for(new i, string[56 + MAX_ZONE_NAME + MAX_PLAYER_NAME]; i < MAX_LADDERS; i++)
		{
			if(Ladders[iGroup][i][sX] != 0 && Ladders[iGroup][i][sY] != 0 && Ladders[iGroup][i][sZ] != 0) // Checking for next available ID.
			{
				format(string, sizeof(string), "HQ: Ladder ID: %d | Deployed location: %s | Deployed by: %s", i, Ladders[iGroup][i][sDeployedAt], Ladders[iGroup][i][sDeployedBy]);
				SendClientMessageEx(playerid, COLOR_GRAD2, string);
			}
		}
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized.");
	}
	return 1;
}

CMD:quitgroup(playerid, params[])
{
    if(PlayerInfo[playerid][pMember] >= 0 || PlayerInfo[playerid][pLeader] >= 0)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE,"* You have quit your group, you are now a civilian again.");
		new string[128];
		format(string, sizeof(string), "%s (%d) has quit the %s as a rank %i", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), arrGroupData[PlayerInfo[playerid][pMember]][g_szGroupName], PlayerInfo[playerid][pRank]);
		GroupLog(PlayerInfo[playerid][pMember], string);
		PlayerInfo[playerid][pMember] = INVALID_GROUP_ID;
		PlayerInfo[playerid][pRank] = INVALID_RANK;
		PlayerInfo[playerid][pDuty] = 0;
		PlayerInfo[playerid][pLeader] = INVALID_GROUP_ID;
		PlayerInfo[playerid][pDivision] = INVALID_DIVISION;
		strcpy(PlayerInfo[playerid][pBadge], "None", 9);
		if(!IsValidSkin(GetPlayerSkin(playerid)))
		{
  			new rand = random(sizeof(CIV));
			SetPlayerSkin(playerid,CIV[rand]);
			PlayerInfo[playerid][pModel] = CIV[rand];
		}
		SetPlayerToTeamColor(playerid);
		player_remove_vip_toys(playerid);
		ResetPlayerWeaponsEx(playerid);
   		pTazer{playerid} = 0;
		DeletePVar(playerid, "HidingKnife");
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD1, "You're not in a group.");
	}
	return 1;
}

CMD:dvstorage(playerid, params[])
{
	new iGroupID = PlayerInfo[playerid][pMember];
	if((0 <= iGroupID <= MAX_GROUPS))
	{
		if(PlayerInfo[playerid][pLeader] == iGroupID)
		{
			if(IsPlayerInRangeOfPoint(playerid, 100.0, arrGroupData[iGroupID][g_fGaragePos][0], arrGroupData[iGroupID][g_fGaragePos][1], arrGroupData[iGroupID][g_fGaragePos][2]))
			{		
				new vstring[3000];
				for(new i; i < MAX_DYNAMIC_VEHICLES; i++)
				{
					new iModelID = DynVehicleInfo[i][gv_iModel];
					if(400 <= iModelID < 612 && DynVehicleInfo[i][gv_igID] == iGroupID)
					{
						if(DynVehicleInfo[i][gv_iDisabled] == 1) {
							format(vstring, sizeof(vstring), "%s\n(%d)%s (Disabled)", vstring, i, VehicleName[iModelID - 400]);
						}
						else if(DynVehicleInfo[i][gv_iDisabled] == 2) {
							format(vstring, sizeof(vstring), "%s\n(%d) %s (Stored)", vstring, i, VehicleName[iModelID - 400], DynVehicleInfo[i][gv_iSpawnedID]);
						}
						else if(DynVehicleInfo[i][gv_iSpawnedID] != INVALID_VEHICLE_ID) {
							format(vstring, sizeof(vstring), "%s\n(%d) %s (Spawned) [VehicleID : %d]", vstring, i, VehicleName[iModelID - 400], DynVehicleInfo[i][gv_iSpawnedID]);
						}
					}
				}
				ShowPlayerDialog(playerid, DV_STORAGE, DIALOG_STYLE_LIST, "Dynamic Group Vehicle Storage", vstring, "Track", "Cancel");	
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD1, "You're not in range of your group garage!");	
		}
		else return SendClientMessageEx(playerid, COLOR_GRAD1, "You're not a group leader!");
	}
	else return SendClientMessageEx(playerid, COLOR_GRAD1, "You're not in a group!");
	return 1;
}

CMD:bug(playerid, params[])
{
	if (PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBugAccess])
	{
        new
			iTargetID;

        if(sscanf(params, "u", iTargetID)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /bug [player]");
		}
        else if(PlayerInfo[iTargetID][pAdmin] >= 2) {
			SendClientMessageEx(playerid, COLOR_GREY, "You cannot place bugs on admins.");
		}
		else if(GetPVarInt(iTargetID, "AdvisorDuty") == 1) {
    		SendClientMessageEx(playerid, COLOR_GREY, "You cannot place bugs on advisors while they are on duty.");
		}
  		else if(PlayerInfo[iTargetID][pBugged] != INVALID_GROUP_ID) {

			new
				szMessage[32 + MAX_PLAYER_NAME];

    		PlayerInfo[iTargetID][pBugged] = INVALID_GROUP_ID;
     		format(szMessage,sizeof(szMessage),"The bug on %s has been disabled.", GetPlayerNameEx(iTargetID));
       		SendClientMessageEx(playerid, COLOR_GRAD1, szMessage);
		}
		else if(ProxDetectorS(4.0, playerid, iTargetID)) {

			new
				szMessage[28 + MAX_PLAYER_NAME];

			PlayerInfo[iTargetID][pBugged] = PlayerInfo[playerid][pMember];
	    	format(szMessage,sizeof(szMessage),"You have placed a bug on %s.",GetPlayerNameEx(iTargetID));
		    SendClientMessageEx(playerid, COLOR_GRAD1, szMessage);
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "You need to be close to the person.");
	} else SendClientMessageEx(playerid, COLOR_GREY, "You do not have access to this radio frequency.");
	return 1;
}

CMD:gov(playerid, params[])
{
	new
		iGroupID = PlayerInfo[playerid][pLeader],
	 	iRank = PlayerInfo[playerid][pRank];

	if ((0 <= iGroupID < MAX_GROUPS) && iRank >= arrGroupData[iGroupID][g_iGovAccess]) {
		if(!isnull(params)) {
			new string[128];
			format(string, sizeof(string), "** %s %s %s: %s **", arrGroupData[iGroupID][g_szGroupName], arrGroupRanks[iGroupID][iRank], GetPlayerNameEx(playerid), params);
   			SendClientMessageToAllEx(COLOR_WHITE, "|___________ Government News Announcement ___________|");
			SendClientMessageToAllEx(arrGroupData[iGroupID][g_hDutyColour] * 256 + 255, string);
			format(string, sizeof(string), "** %s %s %s(%d): %s **", arrGroupData[iGroupID][g_szGroupName], arrGroupRanks[iGroupID][iRank], GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), params);
			Log("logs/gov.log", string);
		} else SendClientMessageEx(playerid, COLOR_GREY, "USAGE: (/gov)ernment [text]");
	} else SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use this command.");
	return 1;
}

CMD:switchgroup(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] || PlayerInfo[playerid][pFactionModerator] >= 4) {
		Group_ListGroups(playerid, DIALOG_SWITCHGROUP);
	}
	else SendClientMessageEx(playerid, COLOR_GREY, "You are not authorized.");
	return 1;
}

CMD:groupcsfban(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /groupcsfban [player]");

		if(IsPlayerConnected(giveplayerid))
		{
			if( PlayerInfo[giveplayerid][pMember] >= 0 || PlayerInfo[giveplayerid][pLeader] >= 0 )
			{
				PlayerInfo[giveplayerid][pCSFBanned] = 1;
				format(string, sizeof(string), "You have been group-banned, by %s, from ALL Civil Service Groups.", GetPlayerNameEx( playerid ));
				SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
				PlayerInfo[giveplayerid][pMember] = INVALID_GROUP_ID;
				PlayerInfo[giveplayerid][pLeader] = INVALID_GROUP_ID;
				PlayerInfo[giveplayerid][pDivision] = INVALID_DIVISION;
				strcpy(PlayerInfo[giveplayerid][pBadge], "None", 9);
				PlayerInfo[giveplayerid][pRank] = INVALID_RANK;
				PlayerInfo[giveplayerid][pDuty] = 0;
				PlayerInfo[giveplayerid][pModel] = NOOB_SKIN;
				SetPlayerToTeamColor(giveplayerid);
				SetPlayerSkin(giveplayerid, NOOB_SKIN);
				format(string, sizeof(string), "You have faction-banned %s from all CSF groups.", GetPlayerNameEx(giveplayerid));
				SendClientMessageEx(playerid, COLOR_WHITE, string);
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_WHITE, "You can't kick someone from a faction if they're not a leader / member.");
			}
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Player not connected.");
		}
	}
	return 1;
}

CMD:groupunban(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		new giveplayerid, group;
		if(sscanf(params, "ud", giveplayerid, group)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /groupunban [player] [groupid]");

		if(IsPlayerConnected(giveplayerid))
		{
			new string[256];
			SetPVarInt(playerid, "GroupUnBanningPlayer", giveplayerid);
			SetPVarInt(playerid, "GroupUnBanningGroup", group);
			format(string,sizeof(string),"DELETE FROM `groupbans` WHERE  `PlayerID` = %d AND `GroupBan` = %d", GetPlayerSQLId(giveplayerid), group);
			mysql_function_query(MainPipeline, string, false, "Group_QueryFinish", "ii", GROUP_QUERY_UNBAN, playerid);
			format(string, sizeof(string), "Attempting to unban %s from group %d...", GetPlayerNameEx(giveplayerid), group);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Player not connected.");
		}
	}
	return 1;
}


CMD:groupcsfunban(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /faccsfunban [player]");

		if(IsPlayerConnected(giveplayerid))
		{
			if( PlayerInfo[giveplayerid][pCSFBanned] == 0 ) return SendClientMessageEx( playerid, COLOR_WHITE, "That person isn't banned from Civil Service Groups." );
			PlayerInfo[giveplayerid][pCSFBanned] = 0;
			format(string, sizeof(string), "You have unbanned person %s from all Civil Service Groups.", GetPlayerNameEx(giveplayerid));
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			format(string, sizeof(string), "You have been unbanned from Civil Service Groups, by %s.", GetPlayerNameEx(playerid));
			SendClientMessageEx(giveplayerid, COLOR_WHITE, string);
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Player not connected.");
		}
	}
	return 1;
}

CMD:groupban(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new giveplayerid, group , reason[64];
		if(sscanf(params, "uds[64]", giveplayerid, group, reason))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /groupban [player] [group id] [reason]");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
			if( group >= 0 && group < MAX_GROUPS )
			{
				SetPVarInt(playerid, "GroupBanningPlayer", giveplayerid);
				SetPVarInt(playerid, "GroupBanningGroup", group);
				new string[256];
				format(string,sizeof(string),"INSERT INTO `groupbans` (`PlayerID`, `GroupBan`, `BanReason`, `BanDate`) VALUES (%d, %d, '%s', NOW())", GetPlayerSQLId(giveplayerid), group, g_mysql_ReturnEscaped(reason, MainPipeline));
				mysql_function_query(MainPipeline, string, false, "Group_QueryFinish", "ii", GROUP_QUERY_ADDBAN, playerid);
				format(string, sizeof(string), "Attempting to ban %s from group %d...", GetPlayerNameEx(giveplayerid), group);
			    SendClientMessageEx(playerid, COLOR_WHITE, string);
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_GREY, "Invalid group id.");
			}
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Player not connected.");
		}
	}
	return 1;
}

CMD:hshowbadge(playerid, params[])
{
	if(IsAHitman(playerid))
	{
		new giveplayerid, rank, faction, division, badge[8], oldbadge[8];
		if(sscanf(params, "uiiiS(None)[8]", giveplayerid, faction, rank, division, badge))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /hshowbadge [player] [faction] [rank] [division] [badge (optional)]");
			return 1;
		}
		new oldfaction = PlayerInfo[playerid][pMember];
		new oldrank = PlayerInfo[playerid][pRank];
		new olddivision = PlayerInfo[playerid][pDivision];
		strcpy(oldbadge, PlayerInfo[playerid][pBadge], 9);
		PlayerInfo[playerid][pMember] = faction;
		PlayerInfo[playerid][pRank] = rank;
		PlayerInfo[playerid][pDivision] = division;
		strcpy(PlayerInfo[playerid][pBadge], badge, sizeof(badge));
		cmd_showbadge(playerid, params);
		PlayerInfo[playerid][pMember] = oldfaction;
		PlayerInfo[playerid][pRank] = oldrank;
		PlayerInfo[playerid][pDivision] = olddivision;
		strcpy(PlayerInfo[playerid][pBadge], oldbadge, sizeof(oldbadge));
	}
	return 1;
}

CMD:showbadge(playerid, params[])
{
	if(0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS && (arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] != GROUP_TYPE_CRIMINAL && arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] != GROUP_TYPE_RACE))
	{
		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /showbadge [player]");

		if(giveplayerid != INVALID_PLAYER_ID) {
			if(ProxDetectorS(5.0, playerid, giveplayerid)) {

				new	infoArrays[3][GROUP_MAX_NAME_LEN], badge[11];

				GetPlayerGroupInfo(playerid, infoArrays[0], infoArrays[1], infoArrays[2]);
				if(strcmp(PlayerInfo[playerid][pBadge], "None", true) != 0) format(badge, sizeof(badge), "[%s] ", PlayerInfo[playerid][pBadge]);

				SendClientMessageEx(giveplayerid, COLOR_GRAD2, "----------------------------------------------------------------------------------------------------");
				format(string, sizeof(string), "%s%s %s is a duly sworn member of the %s.", badge, infoArrays[0], GetPlayerNameEx(playerid), infoArrays[2]);
				SendClientMessageEx(giveplayerid, COLOR_WHITE, string);
				format(string, sizeof(string), "Current Assignment: %s.", infoArrays[1]);
				SendClientMessageEx(giveplayerid, COLOR_WHITE, string);
				switch(arrGroupData[PlayerInfo[playerid][pMember]][g_iAllegiance]) {
					case 1: SendClientMessageEx(giveplayerid, COLOR_WHITE, "Under the Authority of the San Andreas Government.");
					case 2: SendClientMessageEx(giveplayerid, COLOR_WHITE, "Under the Authority of the Nation of Tierra Robada.");
				}
				if(IsACop(playerid)) SendClientMessageEx(giveplayerid, COLOR_WHITE, "Official has the authority to arrest.");
				else if(arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] != 2) SendClientMessageEx(giveplayerid, COLOR_WHITE, "Official has the authority to assist in arrests.");
				SendClientMessageEx(giveplayerid, COLOR_GRAD2, "----------------------------------------------------------------------------------------------------");
				format(string, sizeof(string), "* %s shows their badge to %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			} else SendClientMessageEx(playerid, COLOR_GREY, "That person isn't near you.");
		} else SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
	} else SendClientMessageEx(playerid, COLOR_WHITE, "You are not in a civil service group.");
	return 1;
}

CMD:groupkick(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /groupkick [player]");

		if(IsPlayerConnected(giveplayerid))
		{
			if(PlayerInfo[giveplayerid][pMember] >= 0 || PlayerInfo[giveplayerid][pLeader] >= 0)
			{
				format(string, sizeof(string), "Administrator %s has group-kicked %s (%d) from %s (%d)", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid), GetPlayerSQLId(giveplayerid), arrGroupData[PlayerInfo[giveplayerid][pMember]][g_szGroupName], PlayerInfo[giveplayerid][pMember]+1);
				GroupLog(PlayerInfo[giveplayerid][pMember], string);
				format(string, sizeof(string), "You have been faction-kicked, by %s.", GetPlayerNameEx( playerid ));
				SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
				PlayerInfo[giveplayerid][pDuty] = 0;
				PlayerInfo[giveplayerid][pMember] = INVALID_GROUP_ID;
				PlayerInfo[giveplayerid][pRank] = INVALID_RANK;
				PlayerInfo[giveplayerid][pLeader] = INVALID_GROUP_ID;
				PlayerInfo[giveplayerid][pDivision] = INVALID_DIVISION;
				strcpy(PlayerInfo[giveplayerid][pBadge], "None", 9);
				if(!IsValidSkin(GetPlayerSkin(giveplayerid)))
				{
					new rand = random(sizeof(CIV));
					SetPlayerSkin(giveplayerid,CIV[rand]);
					PlayerInfo[giveplayerid][pModel] = CIV[rand];
				}
				player_remove_vip_toys(giveplayerid);
				pTazer{giveplayerid} = 0;
				DeletePVar(giveplayerid, "HidingKnife");
				SetPlayerToTeamColor(giveplayerid);
				format(string, sizeof(string), "You have group-kicked %s.", GetPlayerNameEx(giveplayerid));
				SendClientMessageEx(playerid, COLOR_WHITE, string);
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_WHITE, "You can't kick someone from a group if they're not a member.");
			}
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		}
	}
	return 1;
}

CMD:m(playerid, params[]) {
	if(PlayerInfo[playerid][pJailTime] && strfind(PlayerInfo[playerid][pPrisonReason], "[OOC]", true) != -1) return SendClientMessageEx(playerid, COLOR_GREY, "OOC prisoners are restricted to only speak in /b");
	if(!isnull(params))
	{
		if(IsACop(playerid) || IsAMedic(playerid) || IsAHitman(playerid) || IsAGovernment(playerid) || IsAJudge(playerid))
		{
			new
				szMessage[128];

			format(szMessage, sizeof(szMessage), "(megaphone) %s: %s", GetPlayerNameEx(playerid), params);
			ProxDetector(60.0, playerid, szMessage, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW,1);
		}
		else SendClientMessageEx(playerid, COLOR_GRAD2, "   You do not have authority to use the megaphone.");
	}
	else SendClientMessageEx(playerid, COLOR_GREY, "USAGE: (/m)egaphone [megaphone chat]");
	return 1;
}

CMD:radio(playerid, params[]) {
	return cmd_r(playerid, params);
}

CMD:r(playerid, params[]) {
	if(PlayerInfo[playerid][pJailTime] && strfind(PlayerInfo[playerid][pPrisonReason], "[OOC]", true) != -1) return SendClientMessageEx(playerid, COLOR_GREY, "OOC prisoners are restricted to only speak in /b");
	new
		iGroupID = PlayerInfo[playerid][pMember],
		iRank = PlayerInfo[playerid][pRank];

	if (0 <= iGroupID < MAX_GROUPS) {
 		if (iRank >= arrGroupData[iGroupID][g_iRadioAccess]) {
			if(GetPVarInt(playerid, "togRadio") == 0) {
				if(!isnull(params))
				{
					new string[128], employer[GROUP_MAX_NAME_LEN], rank[GROUP_MAX_RANK_LEN], division[GROUP_MAX_DIV_LEN];
					format(string, sizeof(string), "(radio) %s", params);
					SetPlayerChatBubble(playerid, string, COLOR_WHITE, 15.0, 5000);
					GetPlayerGroupInfo(playerid, rank, division, employer);
					if(strcmp(PlayerInfo[playerid][pBadge], "None", true) != 0) format(string, sizeof(string), "** [%s] %s %s: %s **", PlayerInfo[playerid][pBadge], rank, GetPlayerNameEx(playerid), params);
					else format(string, sizeof(string), "** %s (%s) %s: %s **", rank, division, GetPlayerNameEx(playerid), params);
					//foreach(new i: Player)
					foreach(new i: Player)
					{
						if(GetPVarInt(i, "togRadio") == 0)
						{
							if(PlayerInfo[i][pMember] == iGroupID && iRank >= arrGroupData[iGroupID][g_iRadioAccess]) {
								SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, string);
							}
							if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == iGroupID) {
								new szBigEar[128];
								format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
								SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szBigEar);
							}
						}
					}	
				}
				else return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: (/r)adio [radio chat]");
			}
			else return SendClientMessageEx(playerid, COLOR_GREY, "Your radio is currently turned off, type /togradio to turn it back on.");	
		}
		else return SendClientMessageEx(playerid, COLOR_GREY, "You do not have access to this radio frequency.");
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "You are not in a group.");
	return 1;
}

CMD:int(playerid, params[])
{
	return cmd_international(playerid, params);
}

CMD:international(playerid, params[])
{
	new iGroupID = PlayerInfo[playerid][pMember],
	    iRank = PlayerInfo[playerid][pRank];

	if(0 <= iGroupID < MAX_GROUPS)
	{
	    if(iRank >= arrGroupData[iGroupID][g_iIntRadioAccess])
	    {
	        if(!isnull(params))
	        {
	            new szRadio[128], szEmployer[GROUP_MAX_NAME_LEN], szRank[GROUP_MAX_RANK_LEN], szDivision[GROUP_MAX_DIV_LEN];
	            GetPlayerGroupInfo(playerid, szRank, szDivision, szEmployer);
	            format(szRadio, sizeof(szRadio), "** %s %s (%s) %s: %s **", szEmployer, szRank, szDivision, GetPlayerNameEx(playerid), params);
	            foreach(new i: Player)
				{				
					if((0 <= PlayerInfo[i][pMember] < MAX_GROUPS) && PlayerInfo[i][pRank] >= arrGroupData[PlayerInfo[i][pMember]][g_iIntRadioAccess])
					{
						SendClientMessageEx(i, 0x869688FF, szRadio);
					}
				}	
	            format(szRadio, sizeof(szRadio), "(radio) %s", params);
             	SetPlayerChatBubble(playerid, szRadio, COLOR_WHITE, 15.0, 5000);
             }
             else return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: (/int(ernational) [text]");
		}
		else return SendClientMessageEx(playerid, COLOR_GREY, "You do not have access to this radio frequency!");
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "You're not in a group!");
	return 1;
}

CMD:togdept(playerid, params[])
{
    if(GetPVarInt(playerid, "togDept") == 0)
    {
        SendClientMessageEx(playerid, COLOR_GRAD2, "You have toggled off your department radio, you may re-enable it by typing this command again.");
        SetPVarInt(playerid, "togDept", 1);
    }
    else {
        SendClientMessageEx(playerid, COLOR_GRAD2, "You have toggled on your department radio.");
        SetPVarInt(playerid, "togDept", 0);
	} return 1;
}

CMD:dept(playerid, params[])
{
	new
		iGroupID = PlayerInfo[playerid][pMember],
		iRank = PlayerInfo[playerid][pRank];

	if(0 <= iGroupID < MAX_GROUPS)
	{
		if(iRank >= arrGroupData[iGroupID][g_iDeptRadioAccess])
		{
			if(GetPVarInt(playerid, "togDept") == 0)
			{
				if(!isnull(params))
				{
					new szRadio[128], RadioBubble[128], szEmployer[GROUP_MAX_NAME_LEN], szRank[GROUP_MAX_RANK_LEN], szDivision[GROUP_MAX_DIV_LEN];
					GetPlayerGroupInfo(playerid, szRank, szDivision, szEmployer);
					if(strcmp(PlayerInfo[playerid][pBadge], "None", true) != 0) format(szRadio, sizeof(szRadio), "** [%s] %s %s %s: %s **", PlayerInfo[playerid][pBadge], szEmployer, szRank, GetPlayerNameEx(playerid), params);
					else format(szRadio, sizeof(szRadio), "** %s %s (%s) %s: %s **", szEmployer, szRank, szDivision, GetPlayerNameEx(playerid), params);
					format(RadioBubble, sizeof(RadioBubble), "(radio) %s",params);
					SetPlayerChatBubble(playerid, RadioBubble, COLOR_WHITE, 15.0, 5000);
					foreach(new i: Player)
					{
						if(GetPVarInt(i, "togDept") == 0)
						{
							if((0 <= PlayerInfo[i][pMember] < MAX_GROUPS) && PlayerInfo[i][pRank] >= arrGroupData[PlayerInfo[i][pMember]][g_iDeptRadioAccess] && arrGroupData[iGroupID][g_iAllegiance] == arrGroupData[PlayerInfo[i][pMember]][g_iAllegiance])
							{
								SendClientMessageEx(i, DEPTRADIO, szRadio);
							}
							else if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == iGroupID)
							{
								new szBigEar[128];
								format(szBigEar, sizeof(szBigEar), "(BE) %s", szRadio);
								SendClientMessageEx(i, iGroupID, szBigEar);
							}
							else if((PlayerInfo[i][pMember] == INVALID_GROUP_ID || (0 <= PlayerInfo[i][pMember] < MAX_GROUPS) && PlayerInfo[i][pRank] < arrGroupData[PlayerInfo[i][pMember]][g_iDeptRadioAccess]) && PlayerInfo[i][pReceiver] > 0)
							{
								if(GetPVarType(i, "pReceiverOn"))
								{
									if(GetPVarInt(i, "pReceiverMLeft") > 0)
									{
										format(szRadio, sizeof(szRadio), "** (receiver) %s: %s", GetPlayerNameEx(playerid), params);
										SendClientMessageEx(i, DEPTRADIO, szRadio);
										SetPVarInt(i, "pReceiverMLeft", GetPVarInt(i, "pReceiverMLeft") - 1);
									}
									else
									{
										PlayerInfo[i][pReceiver]--;
										SetPVarInt(i, "pReceiverMLeft", 4);
										return SendClientMessageEx(i, DEPTRADIO, "Your receiver ran out of batteries!");
									}
								}
							}
						}
					}	
				}
				else return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: (/dept) [department chat]");
			}
			else return SendClientMessageEx(playerid, COLOR_GREY, "Your department radio is currently turned off, turn it on by typing /togdept.");
		}
		else return SendClientMessageEx(playerid, COLOR_GREY, "You do not have access to this radio frequency.");
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "You are not in a group.");
	return 1;
}

CMD:togradio(playerid, params[])
{
    if(GetPVarInt(playerid, "togRadio") == 0)
    {
        SendClientMessageEx(playerid, COLOR_GRAD2, "You have toggled off your radio, you may re-enable it by typing this command again.");
        SetPVarInt(playerid, "togRadio", 1);
    }
    else {
        SendClientMessageEx(playerid, COLOR_GRAD2, "You have toggled on your radio.");
        SetPVarInt(playerid, "togRadio", 0);
	} return 1;
}

CMD:makeleader(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pFactionModerator] >= 2)
	{
		new giveplayerid;
		if(sscanf(params, "u", giveplayerid)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /makeleader [player]");
		}
		else {
			if(IsPlayerConnected(giveplayerid))	{
   				SetPVarInt(playerid, "MakingLeader", giveplayerid);
   				SetPVarInt(playerid, "MakingLeaderSQL", GetPlayerSQLId(giveplayerid));
				Group_ListGroups(playerid, DIALOG_MAKELEADER);
			}
			else SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");

	return 1;
}

CMD:leaders(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pFactionModerator] >= 1) {
		SendClientMessageEx(playerid, COLOR_WHITE, "Group leaders online:");

		new	string[128], sz_FacInfo[3][64];

		foreach(new i: Player)
		{
			if(PlayerInfo[i][pLeader] >= 0) {
				GetPlayerGroupInfo(i, sz_FacInfo[0], sz_FacInfo[1], sz_FacInfo[2]);
				format(string, sizeof(string), "(%s) %s %s", sz_FacInfo[2], sz_FacInfo[0], GetPlayerNameEx(i));
				SendClientMessageEx(playerid, COLOR_GRAD2, string);
			}
		}	
	} else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	return 1;
}

CMD:hfind(playerid, params[])
{
	if (IsAHitman(playerid) || (PlayerInfo[playerid][pMember] != INVALID_GROUP_ID && PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBugAccess]) || (PlayerInfo[playerid][pAdmin] >= 2 && PlayerInfo[playerid][pTogReports] != 1))
	{
	    if(GetPVarType(playerid, "hFind")) {
	   		SendClientMessageEx(playerid, COLOR_GRAD2, "Stopped Updating");
	        DeletePVar(playerid, "hFind");
	        DisablePlayerCheckpoint(playerid);
		}
		else
		{
			new	iTargetID;

			if(CheckPointCheck(playerid)) {
				return SendClientMessageEx(playerid, COLOR_GREY, "You cannot use this command as of this moment!");
			}
			if(sscanf(params, "u", iTargetID)) {
				return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /hfind [player]");
			}
			else if(iTargetID == playerid) {
				return SendClientMessageEx(playerid, COLOR_GREY, "You can't use this command on yourself.");
			}

			else if(!IsPlayerConnected(iTargetID)) {
				return SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
			}
			else if(GetPlayerInterior(iTargetID) != 0) {
				return SendClientMessageEx(playerid, COLOR_GREY, "That person is inside an interior.");
			}
			else if((PlayerInfo[iTargetID][pAdmin] >= 2 || PlayerInfo[iTargetID][pWatchdog] >= 2) && PlayerInfo[iTargetID][pTogReports] != 1) {
				return SendClientMessageEx(playerid, COLOR_GREY, "You are unable to find this person.");
			}
			else if (GetPVarInt(playerid, "_SwimmingActivity") >= 1) {
				return SendClientMessageEx(playerid, COLOR_GRAD2, "You are unable to find people while swimming.");
			}
			if (GetPVarInt(playerid, "_SwimmingActivity") >= 1)
			{
				SendClientMessageEx(playerid, COLOR_GRAD2, "  You must stop swimming first! (/stopswimming)");
				return 1;
			}
			if(PhoneOnline[iTargetID] == 0 && PlayerInfo[iTargetID][pPnumber] != 0 || (PlayerInfo[iTargetID][pBugged] == PlayerInfo[playerid][pMember] || (PlayerInfo[playerid][pAdmin] >= 2 && PlayerInfo[playerid][pTogReports] != 1)))
			{


				new
					szZone[MAX_ZONE_NAME],
					szMessage[108];

				new Float:X, Float:Y, Float:Z;
			    GetPlayerPos(iTargetID, X, Y, Z);
			    DisablePlayerCheckpoint(playerid);
			    SetPlayerCheckpoint(playerid, X, Y, Z, 4.0);
				GetPlayer3DZone(iTargetID, szZone, sizeof(szZone));
				format(szMessage, sizeof(szMessage), "Tracking on %s, last seen at %s.", GetPlayerNameEx(iTargetID), szZone);
				SendClientMessageEx(playerid, COLOR_GRAD2, szMessage);
				SendClientMessageEx(playerid, COLOR_GRAD2, "Type /hfind again to stop tracking.");
				SetPVarInt(playerid, "hFind", iTargetID);
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "You are unable to get a trace on this person.");
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	return 1;
}

CMD:g(playerid, params[])
{

	new
		string[128],
		iGroupID = PlayerInfo[playerid][pMember],
		iRank = PlayerInfo[playerid][pRank];

	if(isnull(params)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: (/g)roup [group chat]");
	if (iGroupID == INVALID_GROUP_ID) return SendClientMessageEx(playerid, COLOR_GRAD2, "You're not a part of a group!");
	if(iRank >= arrGroupData[iGroupID][g_iOOCChat])
	{
		format(string, sizeof(string), "** (%d) %s %s: %s **", iRank, arrGroupRanks[iGroupID][iRank], GetPlayerNameEx(playerid), params);
		foreach(new i: Player) {
	    	if (PlayerInfo[playerid][pMember] == iGroupID) SendClientMessageEx(i, arrGroupData[iGroupID][g_hOOCColor] * 256 + 255, string);
		}
	}
	else SendClientMessageEx(playerid, COLOR_GREY, "You cannot use this command.");

	return 1;
}

CMD:locker(playerid, params[]) {

	new
		iGroupID = PlayerInfo[playerid][pMember],
		szTitle[18 + GROUP_MAX_NAME_LEN],
		szDialog[128];
		
	if(PlayerInfo[playerid][pWRestricted] != 0 || PlayerInfo[playerid][pConnectHours] < 2) return SendClientMessageEx(playerid, COLOR_GRAD1, "You cannot use this command while having a weapon restriction.");
	if(HungerPlayerInfo[playerid][hgInEvent] != 0) return SendClientMessageEx(playerid, COLOR_GREY, "   You cannot do this while being in the Hunger Games Event!");
	if(zombieevent && GetPVarType(playerid, "pIsZombie")) return SendClientMessageEx(playerid, COLOR_GREY, "You cannot use this as a Zombie.");
	if(0 <= iGroupID < MAX_GROUPS)
	{
		for(new i; i < MAX_GROUPS; i++)
		{
			for(new j; j < MAX_GROUP_LOCKERS; j++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 3.0, arrGroupLockers[i][j][g_fLockerPos][0], arrGroupLockers[i][j][g_fLockerPos][1], arrGroupLockers[i][j][g_fLockerPos][2]) && arrGroupLockers[i][j][g_iLockerVW] == GetPlayerVirtualWorld(playerid))
				{
					if(i == iGroupID || (arrGroupData[i][g_iGroupType] == arrGroupData[iGroupID][g_iGroupType] && arrGroupLockers[i][j][g_iLockerShare]))
					{
					    format(szTitle, sizeof(szTitle), "%s Locker Menu", arrGroupData[iGroupID][g_szGroupName]);
					    if(arrGroupData[iGroupID][g_iLockerCostType] == 0) {
					        if(arrGroupData[iGroupID][g_iLockerStock] > 100)
					        {
					        	format(szTitle, sizeof(szTitle), "%s - Locker Stock: %d", szTitle, arrGroupData[iGroupID][g_iLockerStock]);
							}
							else
							{
							    format(szTitle, sizeof(szTitle), "%s - {AA3333}Locker Stock: %d", szTitle, arrGroupData[iGroupID][g_iLockerStock]);
							}
					    }
					    if(arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_CRIMINAL)
					    {
					    	format(szDialog, sizeof(szDialog), "Clothes\nWeapons\nPot (%i)\nCrack (%i)\nHeroin (%i)\nSyringes (%i)\nOpium (%i)\nMaterials (%i)\nVault ($%s)",\
					    		arrGroupData[iGroupID][g_iPot],
					    		arrGroupData[iGroupID][g_iCrack],
					    		arrGroupData[iGroupID][g_iHeroin],
					    		arrGroupData[iGroupID][g_iSyringes],
					    		arrGroupData[iGroupID][g_iOpium],
					    		arrGroupData[iGroupID][g_iMaterials],
					    		number_format(arrGroupData[iGroupID][g_iBudget])
					    	);
					    	return ShowPlayerDialog(playerid, G_LOCKER_MAIN, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
					    }
					    if(PlayerInfo[playerid][pRank] >= arrGroupData[iGroupID][g_iFreeNameChange]) // name-change point in faction lockers for free namechange factions
						{
							format(szDialog, sizeof(szDialog), "Duty\nEquipment\nUniform%s", (arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_LEA) ? ("\nClear Suspect\nFirst Aid & Kevlar\nPortable Medkit & Vest Kit\nTazer & Cuffs\nName Change") : ((arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_MEDIC || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_GOV) ? ("\nPortable Medkit & Vest Kit\nFirst Aid & Kevlar") : ("")));
						}
						else
						{
							format(szDialog, sizeof(szDialog), "Duty\nEquipment\nUniform%s", (arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_LEA) ? ("\nClear Suspect\nFirst Aid & Kevlar\nPortable Medkit & Vest Kit\nTazer & Cuffs") : ((arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_MEDIC || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_GOV || arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_TOWING) ? ("\nPortable Medkit & Vest Kit\nFirst Aid & Kevlar") : ("")));
						}
						ShowPlayerDialog(playerid, G_LOCKER_MAIN, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
						return 1;
					}
					else
					{
					    SendClientMessageEx(playerid, COLOR_GREY, "You can't access this locker.");
						return 1;
					}
				}
			}
		}
	}
	SendClientMessageEx(playerid, COLOR_GREY, "You're not near a locker!");
	return 1;
}

CMD:editgroup(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pFactionModerator] >= 2)
	{
		Group_ListGroups(playerid);
	}
	return 1;
}

CMD:groupaddjurisdiction(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pFactionModerator] >= 2) Group_ListGroups(playerid, DIALOG_GROUP_JURISDICTION_ADD);
	return 1;
}

CMD:uninvite(playerid, params[]) {
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) {

		new
			iTargetID,
			iGroupID = PlayerInfo[playerid][pLeader];

		if(sscanf(params, "u", iTargetID)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /uninvite [player]");
		}
		else if(IsPlayerConnected(iTargetID)) {
			if(iGroupID == PlayerInfo[iTargetID][pMember]) {
				if(playerid == iTargetID) {
					SendClientMessageEx(playerid, COLOR_GREY, "You can't uninvite yourself.");
				}
				else if(PlayerInfo[playerid][pRank] > PlayerInfo[iTargetID][pRank] || PlayerInfo[playerid][pRank] >= Group_GetMaxRank(iGroupID)) {

					new
						szMessage[128],
						iRank = PlayerInfo[playerid][pRank];

					format(szMessage, sizeof szMessage, "%s %s has kicked you out of %s.", arrGroupRanks[iGroupID][iRank], GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
					SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);
					SendClientMessageEx(iTargetID, COLOR_WHITE, "You are now a civilian again.");

					format(szMessage, sizeof szMessage, "You have kicked %s out of the group.", GetPlayerNameEx(iTargetID));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);

					format(szMessage, sizeof szMessage, "%s %s (%d) (rank %i) has uninvited %s (%d) (rank %i) from %s (%i).", arrGroupRanks[iGroupID][iRank], GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), iRank, GetPlayerNameEx(iTargetID), GetPlayerSQLId(iTargetID), PlayerInfo[iTargetID][pRank], arrGroupData[iGroupID][g_szGroupName], iGroupID + 1);
					GroupLog(iGroupID, szMessage);

					PlayerInfo[iTargetID][pMember] = INVALID_GROUP_ID;
					PlayerInfo[iTargetID][pDivision] = -1;
					strcpy(PlayerInfo[iTargetID][pBadge], "None", 9);
					PlayerInfo[iTargetID][pLeader] = INVALID_GROUP_ID;
					PlayerInfo[iTargetID][pDuty] = 0;
					PlayerInfo[iTargetID][pRank] = INVALID_RANK;
					PlayerInfo[iTargetID][pModel] = NOOB_SKIN;
					SetPlayerSkin(iTargetID, NOOB_SKIN);

					SetPlayerToTeamColor(iTargetID);
					pTazer{iTargetID} = 0;
				}
				else SendClientMessageEx(playerid, COLOR_GREY, "You can't do this to a person of equal or higher rank.");
			}
			else SendClientMessageEx(playerid, COLOR_GRAD1, "That person is not in your group.");
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "Only group leaders may use this command.");
	return 1;
}

CMD:ouninvite(playerid, params[]) {
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) {
		if(!isnull(params)) {

			if (IsPlayerConnected(ReturnUser(params)))
			{
				return SendClientMessageEx(playerid, COLOR_GREY, "That person is currently online - use /uninvite.");
			}
			new
				szQuery[96],
				szName[MAX_PLAYER_NAME],
				iPos;

			mysql_escape_string(params, szName);
			format(szQuery, sizeof szQuery, "SELECT `Member`, `Rank`, `id` FROM `accounts` WHERE `Username` = '%s'", szName);
			mysql_function_query(MainPipeline, szQuery, true, "Group_QueryFinish", "ii", GROUP_QUERY_UNCHECK, playerid);

			while((iPos = strfind(szName, "_", false, iPos)) != -1) szName[iPos] = ' ';
			SetPVarString(playerid, "Group_Uninv", szName);

			format(szQuery, sizeof szQuery, "Attempting to remove %s from the group, please wait...", szName);
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szQuery);
		}
		else SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /ouninvite [account name]");
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "Only group leaders may use this command.");
	return 1;
}

CMD:giverank(playerid, params[]) {
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) {

		new
			iTargetID,
			iRank,
			iGroupID = PlayerInfo[playerid][pLeader],
            szMessage[128];

		if(sscanf(params, "ui", iTargetID, iRank)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /giverank [player] [rank]");
		}
		else if(!(0 <= iRank <= Group_GetMaxRank(iGroupID))) {
		    format(szMessage, sizeof(szMessage), "Invalid rank specified (must be between 0 and %d)", Group_GetMaxRank(iGroupID));
			SendClientMessageEx(playerid, COLOR_GREY, szMessage);
		}
		else if(IsPlayerConnected(iTargetID)) {
			if(iGroupID == PlayerInfo[iTargetID][pMember]) {
				if(iRank == PlayerInfo[iTargetID][pRank]) {
					SendClientMessageEx(playerid, COLOR_GREY, "That person is already of that rank.");
				}
				else if(playerid == iTargetID) {
					SendClientMessageEx(playerid, COLOR_GREY, "You can't change your own rank!");
				}
				if(PlayerInfo[iTargetID][pRank] > PlayerInfo[playerid][pRank])
		    	{
			        SendClientMessageEx(playerid, COLOR_GRAD1, "You cannot perform this command on a higher rank than you!");
			        return 1;
		    	}
				else if(PlayerInfo[playerid][pRank] > PlayerInfo[iTargetID][pRank] || PlayerInfo[playerid][pRank] >= Group_GetMaxRank(iGroupID) || PlayerInfo[playerid][pAdmin] >= 4) {

					format(szMessage, sizeof szMessage, "%s %s has %s you to the rank of %s.", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid), ((iRank > PlayerInfo[iTargetID][pRank]) ? ("promoted") : ("demoted")), arrGroupRanks[iGroupID][iRank]);
					SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);

					format(szMessage, sizeof szMessage, "You have %s %s to the rank of %s.", ((iRank > PlayerInfo[iTargetID][pRank]) ? ("promoted") : ("demoted")), GetPlayerNameEx(iTargetID), arrGroupRanks[iGroupID][iRank]);
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);

					format(szMessage, sizeof szMessage, "%s %s (%d) (rank %i) has given %s (%d) rank %i (%s) in %s (%i).", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), PlayerInfo[playerid][pRank], GetPlayerNameEx(iTargetID), GetPlayerSQLId(iTargetID), iRank, arrGroupRanks[iGroupID][iRank], arrGroupData[iGroupID][g_szGroupName], iGroupID + 1);
					GroupLog(iGroupID, szMessage);

					PlayerInfo[iTargetID][pRank] = iRank;
				}
				else SendClientMessageEx(playerid, COLOR_GREY, "You can't do this to a person of equal or higher rank.");
			}
			else SendClientMessageEx(playerid, COLOR_GRAD1, "That person is not in your group.");
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "Only group leaders may use this command.");
	return 1;
}

CMD:setdivname(playerid, params[])
{
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS)
	{
		new
			iDiv,
			iName[8],
			iGroupID = PlayerInfo[playerid][pLeader],
			szMessage[128];

		if(sscanf(params, "is[8]", iDiv, iName))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /setdivname [division] [name] -- Use 'none' as name to remove division");
			format(szMessage, sizeof(szMessage), "%s", "0 (None), ");
			for(new i; i < MAX_GROUP_DIVS; i++)
			{
			    if(arrGroupDivisions[iGroupID][i][0]) format(szMessage, sizeof(szMessage), "%s%d (%s), ", szMessage, i+1, arrGroupDivisions[iGroupID][i]);
				if(strlen(szMessage) > 64 || i == (MAX_GROUP_DIVS -1) && strlen(szMessage)) { SendClientMessageEx(playerid, COLOR_GRAD2, szMessage); szMessage[0] = 0; }

			}
		}
		else if(!(0 <= iDiv <= Group_GetMaxDiv(iGroupID)+1))
		{
		    format(szMessage, sizeof(szMessage), "Invalid division specified! Must be between 0 and %d.", Group_GetMaxDiv(iGroupID) + 1);
			return SendClientMessageEx(playerid, COLOR_GREY, szMessage);
		}
		else if(strlen(iName) > sizeof(iName))
		{
			format(szMessage, sizeof(szMessage), "Division name must be less than %d characters!", sizeof(iName));
			return SendClientMessageEx(playerid, COLOR_GREY, szMessage);
		}
		else
		{
			iDiv = iDiv - 1;
			if(strcmp(iName, "none", true) == 0)
			{
				format(szMessage, sizeof(szMessage), "** %s has removed the %s division (#%i) **", GetPlayerNameEx(playerid), arrGroupDivisions[iGroupID][iDiv], iDiv + 1);
				foreach(new i: Player)
				{
					if(GetPVarInt(i, "togRadio") == 0)
					{
						if(PlayerInfo[i][pMember] == iGroupID) SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szMessage);
						if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == iGroupID)
						{
							new szBigEar[128];
							format(szBigEar, sizeof(szBigEar), "(BE) %s", szMessage);
							SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szBigEar);
						}
					}
				}
				format(szMessage, sizeof szMessage, "%s (%d) has removed the %s division (#%i)", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), arrGroupDivisions[iGroupID][iDiv], iDiv + 1);
				GroupLog(iGroupID, szMessage);
			}
			else
			{
				format(szMessage, sizeof(szMessage), "** %s has renamed division %s (#%i) to %s **", GetPlayerNameEx(playerid), arrGroupDivisions[iGroupID][iDiv], iDiv + 1, iName);
				foreach(new i: Player)
				{
					if(GetPVarInt(i, "togRadio") == 0)
					{
						if(PlayerInfo[i][pMember] == iGroupID) SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szMessage);
						if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == iGroupID)
						{
							new szBigEar[128];
							format(szBigEar, sizeof(szBigEar), "(BE) %s", szMessage);
							SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szBigEar);
						}
					}
				}
				format(szMessage, sizeof szMessage, "%s (%d) has renamed the %s division (#%i) to %s", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), arrGroupDivisions[iGroupID][iDiv], iDiv + 1, iName);
				GroupLog(iGroupID, szMessage);
			}
			mysql_escape_string(iName, arrGroupDivisions[iGroupID][iDiv]);
		}
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "You're not authorized to use this command!");
	return 1;
}

CMD:setdiv(playerid, params[]) {
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) {

		new
			iTargetID,
			iDiv,
			iGroupID = PlayerInfo[playerid][pLeader],
			szMessage[128];

		if(sscanf(params, "ui", iTargetID, iDiv)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /setdiv [player] [div]");
			format(szMessage, sizeof(szMessage), "%s", "0 (None), ");
			for(new i; i < MAX_GROUP_DIVS; i++)
			{
			    if(arrGroupDivisions[iGroupID][i][0]) format(szMessage, sizeof(szMessage), "%s%d (%s), ", szMessage, i+1, arrGroupDivisions[iGroupID][i]);
				if(strlen(szMessage) > 64 || i == (MAX_GROUP_DIVS -1) && strlen(szMessage)) { SendClientMessageEx(playerid, COLOR_GRAD2, szMessage); szMessage[0] = 0; }

			}
		}
		else if(!(0 <= iDiv <= Group_GetMaxDiv(iGroupID)+1)) {
		    format(szMessage, sizeof(szMessage), "Invalid division specified (must be between 0 and %d)", Group_GetMaxDiv(iGroupID) + 1);
			SendClientMessageEx(playerid, COLOR_GREY, szMessage);
		}
		else if(IsPlayerConnected(iTargetID)) {
			if(iGroupID == PlayerInfo[iTargetID][pMember]) {
				if(iDiv - 1 == PlayerInfo[iTargetID][pDivision]) {
					if (iDiv == 0) SendClientMessageEx(playerid, COLOR_GREY, "That person already has no division.");
					else SendClientMessageEx(playerid, COLOR_GREY, "That person is already in that division.");
				}
				else if(PlayerInfo[playerid][pLeader] == iGroupID || PlayerInfo[playerid][pDivision] == PlayerInfo[iTargetID][pDivision] || PlayerInfo[playerid][pRank] >= (Group_GetMaxRank(iGroupID) - 3)) {

					if(iDiv == 0)
					{
						format(szMessage, sizeof(szMessage), "You have been kicked out of your current division by %s.", GetPlayerNameEx(playerid));
						SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);
						format(szMessage, sizeof(szMessage), "You have kicked %s from their division.", GetPlayerNameEx(iTargetID));
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);
						format(szMessage, sizeof szMessage, "%s %s (%d) has kicked %s (%d) out of their division in %s (%d).", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), GetPlayerNameEx(iTargetID), GetPlayerSQLId(iTargetID), arrGroupData[iGroupID][g_szGroupName], iGroupID + 1);
						GroupLog(iGroupID, szMessage);
					}
					else
					{
						format(szMessage, sizeof szMessage, "%s %s has set you to the %s division.", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid), arrGroupDivisions[iGroupID][iDiv-1]);
						SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);
						format(szMessage, sizeof szMessage, "You have set %s to the %s division.", GetPlayerNameEx(iTargetID), arrGroupDivisions[iGroupID][iDiv-1]);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);
						format(szMessage, sizeof szMessage, "%s %s (%d) has set %s's (%d) division to %s in %s (%d).", arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), GetPlayerNameEx(iTargetID), GetPlayerSQLId(iTargetID), arrGroupDivisions[iGroupID][iDiv-1], arrGroupData[iGroupID][g_szGroupName], iGroupID + 1);
						GroupLog(iGroupID, szMessage);
					}
					PlayerInfo[iTargetID][pDivision] = iDiv-1;
				}
				else SendClientMessageEx(playerid, COLOR_GREY, "You're not authorized to make that division change.");
			}
			else SendClientMessageEx(playerid, COLOR_GRAD1, "That person is not in your group.");
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
	}
	else
	    return SendClientMessageEx(playerid, COLOR_GREY, "You're not authorized to use this command!");
	return 1;
}

CMD:setbadge(playerid, params[])
{
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS)
	{
		new
			iTargetID,
			iBadge[9],
			iGroupID = PlayerInfo[playerid][pLeader],
			szMessage[128],
			tmp[9];

		if(sscanf(params, "us[8]", iTargetID, iBadge)) SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /setbadge [player] [number] -- Use 'none' as number to remove badge");
		else if(IsPlayerConnected(iTargetID))
		{
			if(iGroupID == PlayerInfo[iTargetID][pMember])
			{
				if(strcmp(iBadge, "none", true) == 0)
				{
					format(szMessage, sizeof(szMessage), "Your badge has been removed by %s.", GetPlayerNameEx(playerid));
					SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);
					format(szMessage, sizeof(szMessage), "You have removed %s's badge.", GetPlayerNameEx(iTargetID));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);
					format(szMessage, sizeof(szMessage), "%s (%d) has removed %s's (%d) badge.", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), GetPlayerNameEx(iTargetID), GetPlayerSQLId(iTargetID));
					GroupLog(iGroupID, szMessage);
				}
				else
				{
					format(szMessage, sizeof(szMessage), "Your badge has been set to %s by %s.", iBadge, GetPlayerNameEx(playerid));
					SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);
					format(szMessage, sizeof(szMessage), "You have set %s's badge to %s.", GetPlayerNameEx(iTargetID), iBadge);
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);
					format(szMessage, sizeof(szMessage), "%s (%d) has set %s's (%d) badge to %s.", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), GetPlayerNameEx(iTargetID), GetPlayerSQLId(iTargetID), iBadge);
					GroupLog(iGroupID, szMessage);
				}
				mysql_escape_string(iBadge, tmp);
				strcat((PlayerInfo[iTargetID][pBadge][0] = 0, PlayerInfo[iTargetID][pBadge]), tmp, 9);
			}
			else SendClientMessageEx(playerid, COLOR_GRAD1, "That person is not in your group.");
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "You're not authorized to use this command!");
	return 1;
}

CMD:invite(playerid, params[]) {
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) {

		new
			iTargetID;

		if(sscanf(params, "u", iTargetID)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /invite [player]");
		}
		else if(IsPlayerConnected(iTargetID)) {
		    if (iTargetID != playerid) {
				if(!(0 <= PlayerInfo[iTargetID][pLeader] < MAX_GROUPS) && !(0 <= PlayerInfo[iTargetID][pMember] < MAX_GROUPS)) {

					new
						szQuery[128],
						iGroupID = PlayerInfo[playerid][pLeader];

					format(szQuery, sizeof szQuery, "SELECT `TypeBan` FROM `groupbans` WHERE `PlayerID` = %i AND (`TypeBan` = %i OR `GroupBan` = %i)", GetPlayerSQLId(iTargetID), arrGroupData[iGroupID][g_iGroupType], iGroupID);
					mysql_function_query(MainPipeline, szQuery, true, "Group_QueryFinish", "ii", GROUP_QUERY_INVITE, playerid);

					SendClientMessage(playerid, COLOR_WHITE, "Checking group ban list, please wait...");
					SetPVarInt(playerid, "Group_Invited", iTargetID);
				}
				else SendClientMessageEx(playerid, COLOR_GREY, "The person you're trying to invite is already in another group.");
			}
			else SendClientMessageEx(playerid, COLOR_GREY, "You cannot use this command on yourself.");
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "Only group leaders may use this command.");
	return 1;
}
 
CMD:lastdriver(playerid, params[])
{
	new vehid, string[128];
	if(sscanf(params, "d", vehid)) return SendClientMessageEx(playerid, COLOR_GRAD2, "USAGE: /lastdriver [vehicle id]");
	if(!CrateVehicleLoad[vehid][vLastDriver][0]) format(CrateVehicleLoad[vehid][vLastDriver], MAX_PLAYER_NAME, "{AA3333}Unoccupied");
	if(GetVehicleModel(vehid) != 0)
	{
		if(PlayerInfo[playerid][pAdmin] > 1)
		{
			format(string, sizeof(string), "Vehicle %d's last known driver was %s", vehid, CrateVehicleLoad[vehid][vLastDriver]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		else if(PlayerInfo[playerid][pLeader] != INVALID_GROUP_ID)
		{
			if(DynVeh[vehid] != -1)
			{
				if(DynVehicleInfo[DynVeh[vehid]][gv_igID] == PlayerInfo[playerid][pLeader])
				{
					format(string, sizeof(string), "Vehicle %d's last known driver was %s", vehid, CrateVehicleLoad[vehid][vLastDriver]);
					SendClientMessage(playerid, COLOR_YELLOW, string);				
				}
			}
			else return SendClientMessageEx(playerid, COLOR_GRAD2, "That vehicle does not belong to your group");
			
		}
		else return SendClientMessageEx(playerid, COLOR_GRAD2, "You're not authorized to use this command!");
	}
	else return SendClientMessageEx(playerid, COLOR_GRAD2, "Invalid Vehicle ID");
	return 1;
}

CMD:togbr(playerid, params[])
{
	if(PlayerInfo[playerid][pRank] >= arrGroupData[PlayerInfo[playerid][pMember]][g_iBugAccess]) {
		if (gBug{playerid} == 0)
		{
			gBug{playerid} = 1;
			SendClientMessageEx(playerid, COLOR_GRAD2, "Bug chat channel enabled. You will now be able to hear transmissions from all active bugs.");
		}
		else
		{
			gBug{playerid} = 0;
			SendClientMessageEx(playerid, COLOR_GRAD2, "Bug chat channel disabled.");
		}
	}
	return 1;
}

CMD:adjustwithdrawrank(playerid, params[])
{
	new 
		iGroupID = PlayerInfo[playerid][pMember];

	szMiscArray[0] = 0;

	if(arrGroupData[iGroupID][g_iGroupType] != GROUP_TYPE_CRIMINAL) return SendClientMessageEx(playerid, COLOR_GREY, "You are not authorized to use this command.");
	if(PlayerInfo[playerid][pLeader] == iGroupID)
	{
		new iRank;
		if(sscanf(params, "d", iRank)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /adjustwithdrawrank [rank]");
		else
		{
			if(0 <= iRank <= MAX_GROUP_RANKS-1 || iRank == INVALID_RANK)
			{
				arrGroupData[iGroupID][g_iWithdrawRank] = iRank;
				format(szMiscArray, sizeof(szMiscArray), "You have adjusted the withdraw rank to %i.", iRank);
				SendClientMessageEx(playerid, COLOR_GREY, szMiscArray); 
				format(szMiscArray, sizeof(szMiscArray), "%s has adjusted the withdraw rank to %i.", iRank);
				GroupLog(iGroupID, szMiscArray);
			}
			else SendClientMessage(playerid, COLOR_GREY, "Please specify a valid rank");
		}
	}
	else SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
	return 1;
}

CMD:orgs(playerid, params[])
{
	szMiscArray[0] = 0;
	for(new i = 0; i < MAX_GROUPS; i++)
	{
		if(arrGroupData[i][g_iGroupType] == GROUP_TYPE_CRIMINAL)
		{
			new iMemberCount = 0;
			foreach(new x: Player)
			{
				if(PlayerInfo[x][pMember] == i) iMemberCount++;
			}
			format(szMiscArray, sizeof(szMiscArray), "** %s | Members Online: %i", arrGroupData[i][g_szGroupName]);
			SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
		}
	}
	return 1;
}

CMD:f(playerid, params[])
{
	return cmd_g(playerid, params);
}

CMD:clothes(playerid, params[])
{
	new biz = InBusiness(playerid);
	if(!IsACriminal(playerid)) return SendClientMessageEx(playerid, COLOR_GRAD1, "You're not in a Family/Gang!");
	if (biz != INVALID_BUSINESS_ID && Businesses[biz][bType] == BUSINESS_TYPE_CLOTHING)
	{
		new fSkin[MAX_GROUP_RANKS];
		for(new i = 0; i < MAX_GROUP_RANKS; i++)
		{
			fSkin[i] = arrGroupData[PlayerInfo[playerid][pMember]][g_iClothes][i];
		}
		ShowModelSelectionMenuEx(playerid, fSkin, 8, "Change your clothes.", DYNAMIC_FAMILY_CLOTHES, 0.0, 0.0, -55.0);
	}
	else return SendClientMessageEx(playerid, COLOR_GRAD2, "You're not in a clothing shop.");
	return true;
}