#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <cromchat>

#define tag "[RULETA]"

new userbet = 100

new bool:won = false

public plugin_init() {
	register_plugin("RULETA", "2.1", "B&B")
	
	register_clcmd("say /ruleta", "ruleta")
	register_event("HLTV", "Event_NewRound", "a", "1=0", "2=0");
}

public ruleta(id) {
	new balance[128]
	new ubet[128]
	
	new user_money = cs_get_user_money(id)
	
	formatex(balance, charsmax(balance), "\yGAMBLE \r[%i]", user_money)
	new menu = menu_create(balance, "handle")
	
	menu_additem(menu, "\yUNDER \w48 \r[X2]", "1")
	menu_additem(menu, "\yOVER \w53 \r[X2]", "2")
	menu_additem(menu, "\yBETWEEN \w48 \yand \w53 \r[X10]", "3")
	menu_addblank(menu, 4)
	formatex(ubet, charsmax(ubet), "\yBET \r[%i]", userbet)
	
	menu_additem(menu, ubet, "5")
	
	menu_display(id, menu)
}

public Event_NewRound(id)
{
	won = false
	
}

public handle(id, menu, item) {
	new chance = random_num(1,100)
	new money = cs_get_user_money(id)
	switch(item) {
		case 0:
		{
			if(money >= userbet) {
				if(won == false) {
					if(chance >= 48) {
						new win = userbet*2
						CC_SendMessage(id, "&x04%s&x07 Felicitari ai castigat &x03%i$ &x07 la ruleta!", tag, win)
						cs_set_user_money(id, money + win)
						won = true
					}
					else {
						CC_SendMessage(id, "&x04%s&x07 Ai pierdut,numarul extras a fost &x03%i&x07!", tag, chance)
						cs_set_user_money(id, money - userbet)
						ruleta(id)
					}
				}
				else {
					CC_SendMessage(id, "&x04%s&x07 Ruleta poate fi folosita doar runda urmatoare deoarece ai castigat runda aceasta!", tag)
				}
			}
			else {
				new sum = userbet - cs_get_user_money(id)
				CC_SendMessage(id, "&x04%s&x07 Nu ai suficienti bani,mai ai nevoie de &x03%i$", tag, sum)
			}
		}
		case 1:
		{
			if(money >= userbet) {
				if(won == false) {
					if(chance <= 53) {
						new win = userbet*2
						CC_SendMessage(id, "&x04%s&x07 Felicitari ai castigat &x03%i$ &x07 la ruleta!", tag, win)
						cs_set_user_money(id, money + win)
						won = true
					}
					else {
						CC_SendMessage(id, "&x04%s&x07 Ai pierdut,numarul extras a fost &x03%i&x07!", tag, chance)
						cs_set_user_money(id, money - userbet)
						ruleta(id)
					}
				}
				else {
					CC_SendMessage(id, "&x04%s&x07 Ruleta poate fi folosita doar runda urmatoare deoarece ai castigat runda aceasta!", tag)
				}
			}
			else {
				new sum = userbet - cs_get_user_money(id)
				CC_SendMessage(id, "&x04%s&x07 Nu ai suficienti bani,mai ai nevoie de &x03%i$", tag, sum)
			}
		}
		case 2:
		{
			if(money >= userbet) {
				if(won == false) {
					if(48 <= chance <= 53) {
					
						new win = userbet*2
						CC_SendMessage(id, "&x04%s&x07 Felicitari ai castigat &x03%i$ &x07 la ruleta!", tag, win)
						cs_set_user_money(id, money + win)
						won = true
					}
					else {
						CC_SendMessage(id, "&x04%s&x07 Ai pierdut,numarul extras a fost &x03%i&x07!", tag, chance)
						cs_set_user_money(id, money - userbet)
						ruleta(id)
					}
				}
				else {
					CC_SendMessage(id, "&x04%s&x07 Ruleta poate fi folosita doar runda urmatoare deoarece ai castigat runda aceasta!", tag)
				}
			}
			else {
				new sum = userbet - cs_get_user_money(id)
				CC_SendMessage(id, "&x04%s&x07 Nu ai suficienti bani,mai ai nevoie de &x03%i$", tag, sum)
			}
		}
		case 3:
		{
			userbet = userbet * 2
			if(userbet > 12800) {
				userbet = 100
				CC_SendMessage(id, "&x04%s&x07 Nu poti paria mai mult de 12800$", tag)
			}
			ruleta(id)
		}
	}
		
}
	
	
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1048\\ f0\\ fs16 \n\\ par }
*/
