all:

updatedeps:
git submodule update --init
git submodule foreach git pull
wget https://prosody-modules.googlecode.com/hg/mod_smacks/mod_smacks.lua -O 
wget https://prosody-modules.googlecode.com/hg/mod_carbons/mod_carbons.lua -O
wget https://prosody-modules.googlecode.com/hg/mod_block_registrations/mod_block_registrations.lua -O
wget https://prosody-modules.googlecode.com/hg/mod_roster_command/mod_roster_command.lua -O
wget https://prosody-modules.googlecode.com/hg/mod_blocking/mod_blocking.lua -O
