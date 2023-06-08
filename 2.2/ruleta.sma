#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <cromchat>

#define tag "[RULETA]"

new userbet = 100

new bool:won = false

stock const messages[][] = {
	"[RULETA] Pentru a paria banii la ruleta scrie /ruleta",
	"[RULETA] Poti paria doar o singura data pe runda daca ai castigat",
	"[RULETA] Daca ai ales numarul corect,te asteapta premi in bani 2X si 10X bet-ul tau",
	"[RULETA] Versiunea acestui plugin este 2.2"
}


public plugin_init() {
	register_plugin("RULETA", "2.1", "B&B")
	
	register_clcmd("say /ruleta", "ruleta")
	
	set_task ( 45.0, "sendMessage", _, _, _,"b" );
	
	
	register_event("HLTV", "Event_NewRound", "a", "1=0", "2=0");
}

public sendMessage(id) {
	new Buffer[256];
	formatex(Buffer, sizeof Buffer - 1, "^x04%s", messages[random(sizeof messages)]);
	
	new players[32], num, id;
	get_players(players, num);
	
	for(new i = 0 ; i < num ; i++)
	{
		id = players[i]
	
		message_begin(MSG_ONE, get_user_msgid("SayText"), _, id);
		write_byte(id);
		write_string(Buffer);
		message_end();
	}
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
						set_hudmessage(127, 255, 85, -1.0, 0.29, 0, 6.0, 20.0)
						show_hudmessage(id, "Felicitari ai castigat %i$ la ruleta!", win)
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
						set_hudmessage(127, 255, 85, -1.0, 0.29, 0, 6.0, 20.0)
						show_hudmessage(id, "Felicitari ai castigat %i$ la ruleta!", win)
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
						set_hudmessage(127, 255, 85, -1.0, 0.29, 0, 6.0, 20.0)
						show_hudmessage(id, "Felicitari ai castigat %i$ la ruleta!", win)
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
