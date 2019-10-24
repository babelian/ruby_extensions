# frozen_string_literal: true

require 'pry'
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

Pry.config.history.should_save = true
Pry.config.history.should_load = true
Pry.config.editor = 'nano'
