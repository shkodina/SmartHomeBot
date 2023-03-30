#!/usr/bin/env python3

import os
import subprocess
from aiogram import Bot, Dispatcher, executor, types

script="bash/get_weater_t.sh"


TELEBOT_TOKEN_API = os.getenv('TELEBOT_TOKEN_API')
bot = Bot(token=TELEBOT_TOKEN_API)
dp = Dispatcher(bot)



def wrap_md_cmd_result_to_answer_message (message):
   wraped = message.decode("utf-8")
   print (wraped)
   return wraped
 


@dp.message_handler(commands=['start'])
async def send_welcome(message: types.Message):
   await message.reply("/tm - Temperature of Maloyaroslavec\n/to - Temperature of Obninsk\n/tk - Temperature of Keereyevsk\n")
 


@dp.message_handler(commands=['tm']) 
async def echo(message: types.Message):
   arg = "tm"
   replay = wrap_md_cmd_result_to_answer_message(subprocess.check_output("'%s' '%s'" % (script, arg), shell=True))
   await message.answer(text=replay, parse_mode='Markdown')
 


if __name__ == '__main__':
   executor.start_polling(dp, skip_updates=True)


