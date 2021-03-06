register_command('cloneself', 
    array(
        'description': 'Power',
        'permission': 'powers.cloneself',
        'noPermMsg': 'Sorry you don\'t have permission to use this command.',
        'executor': closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @player = player()

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@player)            
            @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
            @hero = yml_decode(@contents)
            @sig = @hero['sig']
            @val = @hero['val']

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            if(_coolDown('cloneSelf',1,@player)){
                return()
            }

            @mobUUIDs = spawn_mob('villager',1)
            set_timeout(50,closure(
                runas('~console',"/disguiseplayer ".@mobUUIDs[0].' player '.@player.' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
            ))
            
        }
    )
)
