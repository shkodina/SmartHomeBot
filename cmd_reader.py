import os
import subprocess



script_weather="bash/get_weater_t.sh"
script_actor="bash/test_actor.sh"



def select_action (message):
    all_words = message.split()
    match all_words[0].lower() :
        case 'погода':
            return show_weather(message)
        case 'время' | 'time':
            arg = "time"
            return subprocess.check_output("'%s' '%s'" % (script_actor, arg), shell=True)
        case 'помоги' | 'помощь' | 'help':
            return 'погода\nвремя[time]\nпомощь[help]'
        case _:
            return message
        


def show_weather (message):
    all_words = message.split()
    if len(all_words) < 2:
        return 'погода  обнинск[обн] | малый[мал] | киреевск[кир]'
    
    match all_words[1].lower()[0:3] :
        case 'обн':
            arg = 'to'
            return subprocess.check_output("'%s' '%s'" % (script_weather, arg), shell=True)
        case 'мал':
            arg = 'tm'
            return subprocess.check_output("'%s' '%s'" % (script_weather, arg), shell=True)
        case 'кир':
            arg = 'tk'
            return subprocess.check_output("'%s' '%s'" % (script_weather, arg), shell=True)
        
    return "😈это плохой город.. не надо тебе про него знать😈"
