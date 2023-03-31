#!/usr/bin/env python3


import cmd_reader as cm



import os
import subprocess
from aiogram import Bot, Dispatcher, executor, types



TELEBOT_TOKEN_API = os.getenv('TELEBOT_TOKEN_API')
bot = Bot(token=TELEBOT_TOKEN_API)
dp = Dispatcher(bot)



def wrap_message (message):
   print (message)
   try:
      message = message.decode("utf-8")
   except AttributeError as ae:
      print(ae.name)
   print (message)
   return message
 


@dp.message_handler(commands=['start'])
async def send_welcome(message: types.Message):
   await message.reply("/tm - Temperature of Maloyaroslavec\n/to - Temperature of Obninsk\n/tk - Temperature of Keereyevsk\n")
 


@dp.message_handler(commands=['tm']) 
async def echo(message: types.Message):
   arg = "tm"
   replay = wrap_message(subprocess.check_output("'%s' '%s'" % (cm.script_weather, arg), shell=True))
   await message.answer(text=replay)  # , parse_mode='Markdown')
 


@dp.message_handler(commands=['tk']) 
async def echo(message: types.Message):
   arg = "tk"
   replay = wrap_message(subprocess.check_output("'%s' '%s'" % (cm.script_weather, arg), shell=True))
   await message.answer(text=replay)  # , parse_mode='Markdown')
 


@dp.message_handler(commands=['to']) 
async def echo(message: types.Message):
   arg = "to"
   replay = wrap_message(subprocess.check_output("'%s' '%s'" % (cm.script_weather, arg), shell=True))
   await message.answer(text=replay)  # , parse_mode='Markdown')
 


@dp.message_handler(commands=['echo']) 
async def echo(message: types.Message):
   await message.reply(text=message.text.removeprefix("/echo "))  # , parse_mode='Markdown'), parse_mode='Markdown')
 


@dp.message_handler()
async def echo(message: types.Message):
   await message.answer(wrap_message(cm.select_action(message.text)))



if __name__ == '__main__':
   executor.start_polling(dp, skip_updates=True)


