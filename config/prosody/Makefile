updatedeps:
	git submodule update --init
	git submodule foreach git pull
	wget https://prosody-modules.googlecode.com/hg/mod_smacks/mod_smacks.lua -O config/prosody/usr/lib/prosody/modules/mod_smacks.lua
	wget https://prosody-modules.googlecode.com/hg/mod_carbons/mod_carbons.lua -O config/prosody/usr/lib/prosody/modules/mod_carbons.lua
	wget https://prosody-modules.googlecode.com/hg/mod_block_registrations/mod_block_registrations.lua -O config/prosody/usr/lib/prosody/modules/mod_block_registrations.lua
	wget https://prosody-modules.googlecode.com/hg/mod_roster_command/mod_roster_command.lua -O config/prosody/usr/lib/prosody/modules/mod_roster_command.lua
	wget https://prosody-modules.googlecode.com/hg/mod_blocking/mod_blocking.lua -O config/prosody/usr/lib/prosody/modules/mod_blocking.lua
