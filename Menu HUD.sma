#include <amxmodx>
#include <amxmisc>
#include <codmod>
#include <colorchat>
 
#define PLUGIN "Menu"
#define VERSION "1.0"
#define AUTHOR ".minD"

new opcja, gracz_id[33], wybrany;
new ilosc[33], name[33], nazwa_perku[256], nazwa_klasy[256];
 
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	register_clcmd("ile","pobierz");
	
	register_clcmd("say /menu", "COD_Menu");
	register_clcmd("say menu", "COD_Menu");
	register_clcmd("say /cennik", "cennik");
	register_clcmd("say /admin", "admin");
	register_clcmd("say /premium", "premium");
	register_clcmd("say /exp", "exp");
	register_clcmd("say /vip", "vip");
	register_clcmd("say /lvl", "lvl");
}

public COD_Menu(id) 
{
	if(is_user_connected(id))
	{
	
	new menu = menu_create("\r[COD 101 LVL] \yMenu Glowne \dby RETTEVER", "cod_menu_2");
 
	menu_additem(menu, "\yKomendy klienta \d[Wszystkie dostepne komendy na serwerze]");
	menu_additem(menu, "\yCennik Uslug \d[Cennik wszystkich uslug na serwerze]");
	if(get_user_flags(id) & ADMIN_BAN)
	menu_additem(menu, "\yAdmin Menu \r(Tylko dla adminow)");
	
	menu_display(id, menu);
	}
}
 
public cod_menu_2(id, menu, item) {
	switch(item) {
		case 0:{
			menu_l2q(id);
		}
		case 1:{
			menu_l2u(id);
		}
		case 2:{
			admin_menu(id);
		}
	}
	menu_destroy(menu);
	return PLUGIN_HANDLED
}
stock menu_l2q(id)
{
	new menu = menu_create("\r[COD 101 LVL] \yKomendy", "menu_l2q_q");
	menu_additem(menu, "Opisy klas \d/klasy");			//2
	menu_additem(menu, "Opis perka \d/perk");			//3
	menu_additem(menu, "Rozdaj statystyki \d/staty");		//4
	menu_additem(menu, "Resetuj statystyki \d/reset");		//5
	menu_additem(menu, "Wyrzuc perk \d/drop");			//6
	menu_additem(menu, "Oddaj perk \d/daj");			//7
	menu_additem(menu, "Sklep \d/sklep");				//8
	menu_additem(menu, "Powrot do glownego menu \d/menu");		//9
	menu_display(id, menu);
}
public menu_l2q_q(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return;
	}
	switch(item)
	{
		case 0:
		{
			client_cmd(id, "say /klasy");
		}
		case 1:
		{
			client_cmd(id, "say /perk");
		}
		case 2:
		{
			client_cmd(id, "say /staty");
		}
		case 3:
		{
			client_cmd(id, "say /reset");
		}
		case 4:
		{
			client_cmd(id, "say /drop");
		}
		case 5:
		{
			client_cmd(id, "say /daj");
		}
		case 6:
		{
			client_cmd(id, "say /sklep");
		}
		case 7:
		{
			client_cmd(id, "say /menu");
		}
	}
	
	//menu_destroy(menu);
}
public admin(id)
{
	show_motd(id,"admin.txt","Admin") 
}
public vip(id)
{
	show_motd(id,"vip.txt","Vip") 
}
public premium(id)
{
	show_motd(id,"premium.txt","Premium") 
}
public exp(id)
{
	show_motd(id,"exp.txt","Exp") 
}
public lvl(id)
{
	show_motd(id,"lvl.txt","Lvl") 
}
public cennik(id)
{
	menu_l2u(id)
}

stock menu_l2u(id)
{
	new menu = menu_create("\r[COD 101 LVL] \yCennik uslug:", "menu_l2u_h");
	menu_additem(menu, "Admin");					//1
	menu_additem(menu, "Vip");					//2
	menu_additem(menu, "Klasy Premium");				//3
	menu_additem(menu, "Exp");					//4
	menu_additem(menu, "Przeniesienie poziomu");			//5
	menu_display(id, menu);
}
public menu_l2u_h(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return;
	}
	switch(item)
	{
		case 0:
		{
			show_motd(id,"admin.txt","Admin") 
			
		}
		case 1:
		{
			show_motd(id,"vip.txt","Vip") 
			
		}
		case 2:
		{
			show_motd(id,"premium.txt","Premium") 
			 
		}
		case 3:
		{
			show_motd(id,"exp.txt","Exp")  
			 
		}
		case 4:
		{
			show_motd(id,"lvl.txt","Lvl")  
			 
		}
	}
	
	menu_destroy(menu);
}

stock admin_menu(id)
{
	new menu = menu_create("\y[COD 101 LVL] \rAdmin Menu \yby RETTEVER", "menu_cod");
	menu_additem(menu, "Funkcje \yCOD 101 LVL \r(Only Admin)");								//6
	menu_additem(menu, "\yWlacz Exp Event \d[Maksymalnie 5x na dzien !");			//7	

	menu_display(id, menu);
}
public menu_cod(id, menu, item)
{
	if(!is_user_connected(id))
		return PLUGIN_CONTINUE;
		
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	
	switch(item)
	{
		case 0:
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				new menu = menu_create("\r[COD 101 LVL] \yFunkcje ExpMod'a:", "funkcje_codmw");					//1
				menu_additem(menu, "Dodaj \yEXP");										//1
				menu_additem(menu, "Ustaw \yLEVEL");										//2
				menu_additem(menu, "Daj \yPERK \d[Slot Pierwszy]");								//3
				menu_additem(menu, "Daj \yPERK \d[Slot Drugi]");								//3
				menu_additem(menu, "Przenies \yLEVEL");										//4
				menu_additem(menu, "Zamien \yLEVEL");										//5
				menu_additem(menu, "Zsumuj \yLEVEL");		
				menu_display(id, menu);
			}
			else
			ColorChat(wybrany, RED, "!z[INFO]!n Ta opcja jest dostepna tylko dla !cH@ !");
		}
		case 1:
		{
			client_cmd(id, "say /event");
		}
	}
	
	return PLUGIN_CONTINUE;
}

public funkcje_codmw(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return;
	}
	switch(item)
	{
		case 0:
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				Gracz(id);
				opcja = 1;
			}
		}
		case 1:	
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				Gracz(id);
				opcja = 2;
			}
			else
			ColorChat(wybrany, RED, "!z[INFO]!n Ta opcja jest dostepna tylko dla !cH@ !");
		}
		case 2:	
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				Gracz(id);
				opcja = 3;
			}
			else
			ColorChat(wybrany, RED, "!z[INFO]!n Ta opcja jest dostepna tylko dla !cH@ !");
		}
		case 3:
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				Gracz(id);
				opcja = 4;
			}
			else
			ColorChat(wybrany, RED, "!z[INFO]!n Ta opcja jest dostepna tylko dla !cH@ !");
		}
		case 4:
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				Gracz(id);
				opcja = 5;
			}
			else
			ColorChat(wybrany, RED, "!z[INFO]!n Ta opcja jest dostepna tylko dla !cH@ !");
		}
		case 5:
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				Gracz(id);
				opcja = 6;
			}
			else
			ColorChat(wybrany, RED, "!z[INFO]!n Ta opcja jest dostepna tylko dla !cH@ !");
		}
		case 6:
		{
			if(get_user_flags(id) & ADMIN_IMMUNITY)
			{
				Gracz(id);
				opcja = 7;
			}
			else
			ColorChat(wybrany, RED, "!z[INFO]!n Ta opcja jest dostepna tylko dla !cH@ !");
		}
	}
	
	menu_destroy(menu);
}

public Gracz(id)
{
	new menu = menu_create("Wybierz gracza:", "Gracz_handler");
	
	for(new i=0, n=0; i<=32; i++)
	{
		if(!is_user_connected(i))
			continue;
		gracz_id[n++] = i;
		new nazwa_gracza[64];
		get_user_name(i, nazwa_gracza, 63)
		menu_additem(menu, nazwa_gracza, "0", 0);
	}
	menu_display(id, menu);
}

public Gracz_handler(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	
	wybrany = gracz_id[item];
	get_user_name(wybrany, name, 32);
	
	if(opcja == 1)
		console_cmd(id, "messagemode ile");
	else if(opcja == 2)
		console_cmd(id, "messagemode ile");
	else if(opcja == 3)
		wybierz_perk(id);
	else if(opcja == 4)
		wybierz_perk_2(id);
	else if(opcja == 5 || opcja == 6 || opcja == 7)
		wybierz_klase(id);
		
	return PLUGIN_HANDLED;
}

public pobierz(id)
{
	new text[192]
	read_argv(1,text,191)
	format(ilosc, charsmax(ilosc), "%s", text);
	dawaj(id)
}
	
public dawaj(id)
{
	if(opcja == 1)
	{
		new vName[32]
		get_user_name(id, vName, 31)
		
		cod_set_user_xp(wybrany, cod_get_user_xp(wybrany)+str_to_num(ilosc));
		
		ColorChat(id, RED, "!z[COD 101 LVL]!n Dodales graczowi !z%s !c%i !nEXPa", name, str_to_num(ilosc));
		ColorChat(wybrany, RED, "!z[COD 101 LVL]!n Admin !z%s !ndodal Tobie  !c%i !nExpa !", vName, str_to_num(ilosc));
	}
	if(opcja == 2)
	{
		new potrzeba, vName[32];
		potrzeba = cod_get_level_xp(str_to_num(ilosc)-1);
		cod_set_user_xp(wybrany, potrzeba);
		get_user_name(id, vName, 31)
		
		ColorChat(id, RED, "!z[COD 101 LVL]!n Ustawiles graczowi !z%s !c%i !nLevel", name, str_to_num(ilosc));
		ColorChat(wybrany, RED, "!z[COD 101 LVL]!n Admin !z%s !nustawil Tobie  !c%i !nLevel !", vName, str_to_num(ilosc));
	}
}

public wybierz_klase(id)
{
	new tytul[64];
	format(tytul, sizeof(tytul), "\rNa jaka klase :");
	new menu = menu_create(tytul, "wybierz_klase_handler");
	for(new i=1; i<=cod_get_classes_num(); i++)
	{
		cod_get_class_name(i, nazwa_klasy, 255)
		menu_additem(menu, nazwa_klasy)
	}
	
	menu_display(id, menu);
}

public wybierz_klase_handler(id, menu, item)
{
	if(item++ == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_CONTINUE;
	}
	new klasa[2][65];
	
	if(opcja == 5)
	{
		new vName[32]
		get_user_name(id, vName, 31)
		

		new exp = cod_get_user_xp(wybrany);
		cod_get_class_name(cod_get_user_class(wybrany), klasa[0], 64);
		cod_set_user_xp(wybrany, 0);
		cod_set_user_class(wybrany, item, 1);
		cod_get_class_name(cod_get_user_class(wybrany), klasa[1], 64);
		cod_set_user_xp(wybrany, exp);
		
		ColorChat(id, RED, "!z[COD 101 LVL]!n Przeniosles Level graczowi !z%s !nz klasy !c%s !nna klase !c%s", name, klasa[0], klasa[1]);
		ColorChat(wybrany, RED, "!z[COD 101 LVL]!n Admin !z%s !nprzenisol Tobie Level z klasy !c%s !nna klase !c%s !", vName, klasa[0], klasa[1]);
		
	}
	if(opcja == 6)
	{
		new vName[32]
		get_user_name(id, vName, 31)
		
		new exp = cod_get_user_xp(wybrany);
		new oldclass = cod_get_user_class(wybrany)
		cod_get_class_name(cod_get_user_class(wybrany), klasa[0], 64);
		cod_set_user_class(wybrany, item, 1);
		new exp2 = cod_get_user_xp(wybrany);
		cod_set_user_xp(wybrany, exp);
		cod_get_class_name(cod_get_user_class(wybrany), klasa[1], 64);
		cod_set_user_class(wybrany, oldclass, 1);
		cod_set_user_xp(wybrany, exp2);
		cod_set_user_class(wybrany, item, 1);
		
		ColorChat(id, RED, "!z[COD 101 LVL]!n Zamieniles Level graczowi !z%s !nmiedzy klasa !c%s !na klasa !c%s", name, klasa[0], klasa[1]);
		ColorChat(wybrany, RED, "!z[COD 101 LVL]!n Admin !z%s !nzamienil Tobie Level z klasy !c%s !nna klase !c%s !", vName, klasa[0], klasa[1]);
	}
	if(opcja == 7)
	{
		new vName[32]
		get_user_name(id, vName, 31)
		
		new exp = cod_get_user_xp(wybrany);
		cod_set_user_xp(wybrany, 0);
		cod_get_class_name(cod_get_user_class(wybrany), klasa[0], 64);
		cod_set_user_class(wybrany, item, 1);
		cod_get_class_name(cod_get_user_class(wybrany), klasa[1], 64);
		cod_set_user_xp(wybrany, cod_get_user_xp(wybrany)+exp);
		
		ColorChat(id, RED, "!z[COD 101 LVL]!n Zsumowales Level graczowi !z%s !nz klasy !c%s !nna klase !c%s", name, klasa[0], klasa[1]);
		ColorChat(wybrany, RED, "!z[COD 101 LVL]!n Admin !z%s !nzsumowal Tobie Level z klasy !c%s !nna klase !c%s !", vName, klasa[0], klasa[1]);
	}
	return PLUGIN_CONTINUE;
}

public wybierz_perk(id)
{
	new tytul[64];
	format(tytul, 63, "\rWybierz perk :");
	new menu = menu_create(tytul, "wybierz_perk_handler");
	for(new i=1; i<=cod_get_perks_num(); i++)
	{
		cod_get_perk_name(i, nazwa_perku, 255)
		menu_additem(menu, nazwa_perku);
	}
	
	menu_display(id, menu);
}

public wybierz_perk_handler(id, menu, item)
{
	if(item++ == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	
	cod_set_user_perk(wybrany, item, 0, 0);
	cod_get_perk_name(item++, nazwa_perku, 255);
	
	ColorChat(id, RED, "!z[COD 101 LVL]!nDales graczowi !c%s !nperk !z%s", name, nazwa_perku);
	
	return PLUGIN_HANDLED;
}

public wybierz_perk_2(id)
{
	new tytul[64];
	format(tytul, 63, "\rWybierz perk :");
	new menu = menu_create(tytul, "wybierz_perk_handler_2");
	for(new i=1; i<=cod_get_perks_num(); i++)
	{
		cod_get_perk_name(i, nazwa_perku, 255)
		menu_additem(menu, nazwa_perku);
	}
	
	menu_display(id, menu);
}

public wybierz_perk_handler_2(id, menu, item)
{
	if(item++ == MENU_EXIT)
	{
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}
	
	cod_set_user_perk(wybrany, item, 0, 0);
	cod_get_perk_name(item++, nazwa_perku, 255);
	
	ColorChat(id, RED, "!z[COD 101 LVL]!nDales graczowi !c%s !nperk !z%s", name, nazwa_perku);
	
	return PLUGIN_HANDLED;
}